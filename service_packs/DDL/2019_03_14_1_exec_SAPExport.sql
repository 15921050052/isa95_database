﻿SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.exec_SAPExport',N'P') IS NOT NULL
   DROP PROCEDURE dbo.exec_SAPExport;
GO
--------------------------------------------------------------
/*
	Procedure: exec_SAPExport
	Используется для выполнения экспорта бирок в САП.
*/

CREATE PROCEDURE [dbo].[exec_SAPExport]
AS
BEGIN

	IF dbo.get_GlobalOption(N'PRINT_SYSTEM_ENABLED')=N'false'
		NOTHING_TODO:
	ELSE
		BEGIN

            BEGIN TRAN T1;

			DECLARE @MaterialLotID int, @JobOrderID int, @LinkedServer NVARCHAR(50), @RNUM bigint;

			DECLARE @myid uniqueidentifier;
			SET @myid = NEWID();


			DECLARE selMaterialLots CURSOR
			FOR SELECT ROW_NUMBER() OVER (ORDER BY o.ID) rnum, p.[Value], o.ID, o.CommandRule
				FROM [dbo].JobOrder AS o WITH (UPDLOCK), [dbo].[Parameter] AS p, [dbo].[PropertyTypes] AS pt
				WHERE o.ID = p.JobOrder AND 
					  p.PropertyType = pt.ID AND 
					  pt.[Value] = N'MaterialLotID' AND 
					  o.WorkType = N'SAPExport' AND
					  o.DispatchStatus = N'TODO';
			OPEN selMaterialLots;
			FETCH NEXT FROM selMaterialLots INTO @RNUM,@MaterialLotID, @JobOrderID, @LinkedServer;
			WHILE @@FETCH_STATUS = 0
			BEGIN
				BEGIN TRY
					EXEC DBO.[ins_ExportMaterialLotToSAP] @MaterialLotID = @MaterialLotID, @LinkedServer = @LinkedServer;
					update [dbo].JobOrder set DispatchStatus=N'Done',EndTime=CURRENT_TIMESTAMP where id=@JobOrderID;

                    INSERT INTO [dbo].[ErrorLog]([error_details],[error_message]) VALUES
						 (N'Send to SAP: MaterialLotID='+Cast(@MaterialLotID AS NVARCHAR),
						  N'ROWNUM='+Cast(@RNUM AS NVARCHAR)+' UUID='+Cast(@myid AS char(36))+' SessionID/TransactionID='+Cast(@@spid AS NVARCHAR)+'/'+Cast(CURRENT_TRANSACTION_ID() AS NVARCHAR)+' LinkedServer='+Cast(@LinkedServer AS NVARCHAR)+' JobOrderID='+Cast(@JobOrderID AS NVARCHAR)+' CURRENT_TIMESTAMP='+Cast(CURRENT_TIMESTAMP AS NVARCHAR));
				END TRY
				BEGIN CATCH

					EXEC [dbo].[ins_ErrorLog];
				END CATCH;

				FETCH NEXT FROM selMaterialLots INTO @MaterialLotID, @JobOrderID, @LinkedServer;
			END;

            COMMIT TRAN T1;

			CLOSE selMaterialLots;
			DEALLOCATE selMaterialLots;

	END;
END;

GO

