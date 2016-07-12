﻿--------------------------------------------------------------
-- Процедура ins_ExportMaterialLotToSAP
IF OBJECT_ID ('dbo.ins_ExportMaterialLotToSAP',N'P') IS NOT NULL
   DROP PROCEDURE dbo.ins_ExportMaterialLotToSAP;
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ins_ExportMaterialLotToSAP]
@MaterialLotID INT
AS
BEGIN

   SET NOCOUNT ON;

   IF @MaterialLotID IS NULL
      RETURN;

   DECLARE @FactoryNumber NVARCHAR(250),
           @Quantity      INT,
           @Status        NVARCHAR(250);

   DECLARE @tblProperty   TABLE(ID          INT,
                                Description NVARCHAR(50),
                                Value       NVARCHAR(50));

   SELECT @FactoryNumber=[FactoryNumber],
          @Quantity=[Quantity],
          @Status=[Status]
   FROM [dbo].[MaterialLot]
   WHERE [ID]=@MaterialLotID;

   IF ISNULL(@Quantity,0)=0
      RETURN;

   INSERT @tblProperty
   SELECT mlp.PropertyType,pt.[Value],mlp.[Value]
   FROM [dbo].[MaterialLotProperty] mlp INNER JOIN [dbo].[PropertyTypes] pt ON (pt.ID = mlp.PropertyType)
   WHERE MaterialLotID=@MaterialLotID;

   INSERT OPENQUERY ([KRR-SQL23-ZPP],'SELECT AUFNR,MATNR,DATE_P,N_BIR,NSMEN,NBRIG,PARTY,BUNT,MAS,PLAVK,OLD_BIR,AUART,EO,N_ORDER,DT,EO_OLD,REZIM FROM ZPP.ZPP_WEIGHT_PROKAT')
   VALUES ((SELECT t.[Value] FROM @tblProperty t WHERE t.[Description]=N'COMM_ORDER'), --AUFNR
           (SELECT t.[Value] FROM @tblProperty t WHERE t.[Description]=N'MATERIAL_NO'), --MATNR
           (SELECT CONVERT(DATE,t.[Value],104) FROM @tblProperty t WHERE t.[Description]=N'PROD_DATE' AND ISDATE(t.[Value])=1), --DATE_P
            CAST(SUBSTRING(@FactoryNumber,9,12) AS NUMERIC(10,0)), --N_BIR
           (SELECT CAST(t.[Value] AS NUMERIC(10,0)) FROM @tblProperty t WHERE t.[Description]=N'CHANGE_NO' AND ISNUMERIC(t.[Value])=1), --NSMEN
           (SELECT CAST(t.[Value] AS NUMERIC(10,0)) FROM @tblProperty t WHERE t.[Description]=N'BRIGADE_NO' AND ISNUMERIC(t.[Value])=1), --NBRIG
           (SELECT t.[Value] FROM @tblProperty t WHERE [Description]=N'PART_NO'), --PARTY
           (SELECT CAST(t.[Value] AS NUMERIC(10,0)) FROM @tblProperty t WHERE t.[Description]=N'BUNT_NO' AND ISNUMERIC(t.[Value])=1), --BUNT
            @Quantity, --MAS
           (SELECT t.[Value] FROM @tblProperty t WHERE t.[Description]=N'MELT_NO'), --PLAVK
            @Status, --OLD_BIR
           (SELECT t.[Value] FROM @tblProperty t WHERE t.[Description]=N'MILL_ID'), --AUART
            @FactoryNumber, --EO
           (SELECT CAST(t.[Value] AS NUMERIC(9,0)) FROM @tblProperty t WHERE t.[Description]=N'LEAVE_NO' AND ISNUMERIC(t.[Value])=1), --N_ORDER,
           (SELECT CONVERT(DATETIME,t.[Value],121) FROM @tblProperty t WHERE t.[Description]=N'MEASURE_TIME' AND ISDATE(t.[Value])=1), --DT,
           (SELECT TOP 1 mm.[FactoryNumber]
            FROM [dbo].[MaterialLotLinks] ml INNER JOIN [dbo].[MaterialLot] mm ON (mm.[ID]=ml.[MaterialLot1])
            WHERE (ml.[MaterialLot2]=@MaterialLotID)), --EO_OLD,
           (SELECT CAST(t.[Value] AS NUMERIC) FROM @tblProperty t WHERE t.[Description]=N'AUTO_MANU_VALUE' AND ISNUMERIC(t.[Value])=1) --REZIM
          );

END;
GO

--------------------------------------------------------------
-- Процедура ins_ExportJobOrderToSAP
IF OBJECT_ID ('dbo.ins_ExportJobOrderToSAP',N'P') IS NOT NULL
   DROP PROCEDURE dbo.ins_ExportJobOrderToSAP;
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ins_ExportJobOrderToSAP]
@JobOrderID INT
AS
BEGIN

   SET NOCOUNT ON;

   DECLARE @MaterialLotID INT;

   SET @MaterialLotID=CAST(dbo.get_JobOrderPropertyValue(@JobOrderID,N'MaterialLotID') AS INT);

   EXEC [dbo].[ins_ExportMaterialLotToSAP] @MaterialLotID=@MaterialLotID;

END;
GO


IF OBJECT_ID ('dbo.UpdJobOrder',N'TR') IS NOT NULL
   DROP TRIGGER [dbo].[UpdJobOrder];
GO

CREATE TRIGGER [dbo].[UpdJobOrder] ON [dbo].[JobOrder]
AFTER UPDATE
AS
BEGIN

   SET NOCOUNT ON;

   DECLARE @JobOrderID        INT,
           @WorkType          NVARCHAR(50),
           @Command           NVARCHAR(50),
           @DispatchStatus    NVARCHAR(50),
           @OldDispatchStatus NVARCHAR(50);

   SELECT @JobOrderID=[ID],
          @WorkType=[WorkType],
          @Command=[Command],
          @DispatchStatus=[DispatchStatus]
   FROM INSERTED;

   SELECT @OldDispatchStatus=[DispatchStatus]
   FROM DELETED

   IF @WorkType=N'Print' AND @Command=N'Print' AND (@OldDispatchStatus<>N'Done' AND @DispatchStatus=N'Done')
      EXEC [KRR-SQL-PACLX02-PALBP].[KRR-PA-ISA95_PRODUCTION].[dbo].[ins_ExportJobOrderToSAP] @JobOrderID=@JobOrderID;
END
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[UpdJobOrder]', @order=N'Last', @stmttype=N'UPDATE'
GO

--------------------------------------------------------------
-- Процедура upd_MaterialLotProdOrder
IF OBJECT_ID ('dbo.upd_MaterialLotProdOrder',N'P') IS NOT NULL
   DROP PROCEDURE dbo.upd_MaterialLotProdOrder;
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[upd_MaterialLotProdOrder]
@MaterialLotIDs   NVARCHAR(MAX),
@PROD_ORDER       NVARCHAR(50)
AS
BEGIN

SET NOCOUNT ON;

IF @MaterialLotIDs IS NULL
   RETURN;

DECLARE @MaterialLotID     INT,
        @LinkMaterialLotID INT;

DECLARE selMaterialLots CURSOR FOR SELECT ml.[ID]
                                   FROM [dbo].[MaterialLot] ml INNER JOIN dbo.get_TableInteger(@MaterialLotIDs,DEFAULT) t ON (t.[ID]=ml.ID);

OPEN selMaterialLots

FETCH NEXT FROM selMaterialLots INTO @MaterialLotID
WHILE @@FETCH_STATUS = 0
BEGIN

   SET @LinkMaterialLotID=NEXT VALUE FOR [dbo].[gen_MaterialLot];
   INSERT INTO [dbo].[MaterialLot] ([ID],[FactoryNumber],[Status],[Quantity])
   (SELECT @LinkMaterialLotID,[FactoryNumber],N'1',[Quantity]
    FROM [dbo].[MaterialLot] ml
    WHERE ml.[ID]=@MaterialLotID);

   INSERT INTO [dbo].[MaterialLotLinks] ([MaterialLot1],[MaterialLot2],[LinkType])
   VALUES (@MaterialLotID,@LinkMaterialLotID,1);

   INSERT INTO [dbo].[MaterialLotProperty] ([Value],[MaterialLotID],[PropertyType])
   SELECT mlp.[Value],@LinkMaterialLotID,mlp.[PropertyType]
   FROM [dbo].[MaterialLotProperty] mlp
   WHERE mlp.[MaterialLotID]=@MaterialLotID

   MERGE [dbo].[MaterialLotProperty] mlp
   USING (SELECT pt.ID
          FROM [dbo].[PropertyTypes] pt 
          WHERE (pt.value=N'PROD_ORDER')) pt
   ON (mlp.[MaterialLotID]=@LinkMaterialLotID AND pt.[ID]=mlp.[PropertyType])
   WHEN MATCHED THEN
      UPDATE SET mlp.[Value]=@PROD_ORDER
   WHEN NOT MATCHED THEN
      INSERT ([Value],[MaterialLotID],[PropertyType])
      VALUES (@PROD_ORDER,@LinkMaterialLotID,pt.[ID]);

   EXEC [dbo].[ins_ExportMaterialLotToSAP] @MaterialLotID=@LinkMaterialLotID;

   FETCH NEXT FROM selMaterialLots INTO @MaterialLotID;
END

CLOSE selMaterialLots;

DEALLOCATE selMaterialLots;

END;
GO
