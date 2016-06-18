﻿--------------------------------------------------------------
-- Процедура ins_JobOrderInit
IF OBJECT_ID ('dbo.ins_JobOrderInit',N'P') IS NOT NULL
   DROP PROCEDURE dbo.ins_JobOrderInit;
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ins_JobOrderInit]
@WorkRequestID   INT,
@EquipmentID     INT,
@ProfileID       INT,
@COMM_ORDER      NVARCHAR(50),
@LENGTH          NVARCHAR(50),
@BAR_WEIGHT      NVARCHAR(50),
@BAR_QUANTITY    NVARCHAR(50),
@MAX_WEIGHT      NVARCHAR(50),
@MIN_WEIGHT      NVARCHAR(50),
@SAMPLE_WEIGHT   NVARCHAR(50),
@SAMPLE_LENGTH   NVARCHAR(50),
@DEVIATION       NVARCHAR(50)

AS
BEGIN

   DECLARE @JobOrderID  INT;

   SET @JobOrderID=NEXT VALUE FOR [dbo].[gen_JobOrder];
   INSERT INTO [dbo].[JobOrder] ([ID], [WorkType], [StartTime], [WorkRequest])
   VALUES (@JobOrderID,N'INIT',CURRENT_TIMESTAMP,@WorkRequestID);

   INSERT INTO [dbo].[OpMaterialRequirement] ([MaterialClassID],[MaterialDefinitionID]/*,[SegmenRequirementID]*/)
   SELECT md.[MaterialClassID],md.[ID]
   FROM [dbo].[MaterialDefinition] md
   WHERE md.[ID]=@ProfileID;

   INSERT INTO [dbo].[OpEquipmentRequirement] ([EquipmentClassID],[EquipmentID],[JobOrderID])
   SELECT eq.[EquipmentClassID],eq.[ID],@JobOrderID
   FROM [dbo].[Equipment] eq 
   WHERE eq.[ID]=@EquipmentID;

   DECLARE @tblParams TABLE(ID    NVARCHAR(50),
                            Value NVARCHAR(50));

   INSERT @tblParams
   SELECT N'COMM_ORDER',@COMM_ORDER WHERE @COMM_ORDER IS NOT NULL
   UNION ALL
   SELECT N'LENGTH',@LENGTH WHERE @LENGTH IS NOT NULL
   UNION ALL
   SELECT N'BAR_WEIGHT',@BAR_WEIGHT WHERE @BAR_WEIGHT IS NOT NULL
   UNION ALL
   SELECT N'BAR_QUANTITY',@BAR_QUANTITY WHERE @BAR_QUANTITY IS NOT NULL
   UNION ALL
   SELECT N'MAX_WEIGHT',@MAX_WEIGHT WHERE @MAX_WEIGHT IS NOT NULL
   UNION ALL
   SELECT N'MIN_WEIGHT',@MIN_WEIGHT WHERE @MIN_WEIGHT IS NOT NULL
   UNION ALL
   SELECT N'SAMPLE_WEIGHT',@SAMPLE_WEIGHT WHERE @SAMPLE_WEIGHT IS NOT NULL
   UNION ALL
   SELECT N'SAMPLE_LENGTH',@SAMPLE_LENGTH WHERE @SAMPLE_LENGTH IS NOT NULL
   UNION ALL
   SELECT N'DEVIATION',@DEVIATION WHERE @DEVIATION IS NOT NULL;

   INSERT INTO [dbo].[Parameter] ([Value],[JobOrder],[PropertyType])
   SELECT t.value,@JobOrderID,pt.ID
   FROM @tblParams t INNER JOIN [dbo].[PropertyTypes] pt ON (pt.value=t.ID);

END;
GO
