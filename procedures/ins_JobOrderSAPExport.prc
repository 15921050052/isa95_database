﻿SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.ins_JobOrderSAPExport',N'P') IS NOT NULL
   DROP PROCEDURE dbo.ins_JobOrderSAPExport;
GO
--------------------------------------------------------------

/*
	Procedure: ins_JobOrderSAPExport
	Используется для создания задания на отправку бирки в САП.

	Parameters:

		MaterialLotID  - MaterialLot ID,
		WorkRequestID  - WorkRequest ID

	
*/
CREATE PROCEDURE [dbo].[ins_JobOrderSAPExport]
@MaterialLotID   INT,
@WorkRequestID   INT = NULL
AS
BEGIN

	IF dbo.get_GlobalOption(N'PRINT_SYSTEM_ENABLED')=N'false'
		NOTHING_TODO:
	ELSE
		BEGIN

		   DECLARE @JobOrderID    INT,
				   @err_message   NVARCHAR(255),
				   @SideID		  INT,
				   @SideEnabled	  NVARCHAR(50),
				   @LinkedServer  NVARCHAR(50);

		   SET @SideID = dbo.get_SideIdByMaterialLotID(@MaterialLotID);
		   SET @SideEnabled = dbo.get_EquipmentPropertyValue(@SideID,N'SIDE_ENABLED');

		   IF @SideEnabled =N'1'
		   BEGIN
			   --SET @LinkedServer=(SELECT top 1 Parameter from WorkDefinition where WORKType='SAPExport' order by ID desc);
			   SET @LinkedServer=dbo.get_EquipmentPropertyValue(@SideID,N'SAP_LINKED_SERVER');

			   IF @LinkedServer IS NOT NULL
				BEGIN

				   SET @JobOrderID=NEXT VALUE FOR [dbo].[gen_JobOrder];
				   INSERT INTO [dbo].[JobOrder] ([ID],[WorkType],[DispatchStatus],[StartTime],[WorkRequest],CommandRule)
				   VALUES (@JobOrderID,N'SAPExport',N'TODO',CURRENT_TIMESTAMP,@WorkRequestID,@LinkedServer);
 
				   INSERT INTO [dbo].[Parameter] ([Value],[JobOrder],[PropertyType])
				   SELECT @MaterialLotID,@JobOrderID,pt.[ID]
				   FROM [dbo].[PropertyTypes] pt
				   WHERE pt.[Value]=N'MaterialLotID';
				END;
			END;

		END;

END;

GO

