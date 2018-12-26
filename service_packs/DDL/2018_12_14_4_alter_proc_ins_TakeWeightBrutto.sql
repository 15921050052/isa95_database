﻿
IF OBJECT_ID ('dbo.ins_TakeWeightBrutto',N'P') IS NOT NULL
  DROP PROCEDURE dbo.ins_TakeWeightBrutto;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Procedure: ins_TakeWeightBrutto
	Процедура регистрации веса брутто в отвесную при контроле брутто
*/


/* take brutto */
create PROCEDURE [dbo].[ins_TakeWeightBrutto] 
	 @WeightsheetID int			-- weightsheet
	--,@WaybillID int				-- waybill
	,@ScalesID int				-- scales
	,@WeightBrutto real			-- brutto
	,@PackagingUnitsID int		-- wagon
	,@MaterialDefinitionID int	-- cargo type
as
begin

declare 
	-- @PackagingUnitsID int		-- wagon
	--,@MaterialDefinitionID int	-- cargo type
	--,@SenderID int				-- sender shop
	--,@ReceiverID int			-- receiver shop
	 @PackagingUnitsDocsID int
	,@WeightTare real
	,@PersonID int


-- get Tare (is not necessary in Brutting!)
select top 1 @WeightTare = Value
from [PackagingUnitsProperty] PUP
where	PUP.[PackagingUnitsID] = @PackagingUnitsID
	and PUP.[Description] = N'Вес тары'
order by ID desc

-- get current Person
select @PersonID = [PersonID] 
from [dbo].[PersonProperty] 
where UPPER([Value]) = UPPER(SYSTEM_USER)

-- check validations
if(@WeightSheetID is null)
	THROW 60001, N'WeightSheetID param required', 1;
--if(@WaybillID is null)
--	THROW 60001, N'WaybillID param required', 1;
if(@ScalesID is null)
	THROW 60001, N'ScalesID param required', 1;
if(@MaterialDefinitionID is null)
	THROW 60001, N'MaterialDefinitionID param required', 1;
if(@PackagingUnitsID is null)
	THROW 60001, N'PackagingUnitsID param required', 1;
--if(@SenderID is null)
--	THROW 60001, N'PackagingUnitsID param required', 1;
--if(@ReceiverID is null)
--	THROW 60001, N'PackagingUnitsID param required', 1;
if(@WeightBrutto is null or @WeightBrutto <= 0)
	THROW 60001, N'WeightBrutto param required', 1;
if(@PersonID is null)
	THROW 60001, N'Person does not exist!', 1;

/* add checking Weightsheet type and Brutto */
if not exists
(	select D.ID
	from [dbo].[Documentations] D
	join [dbo].[DocumentationsClass] DC
	on DC.ID = [DocumentationsClassID]
	where DC.[Description] = N'Контроль брутто' and D.ID = @WeightSheetID)
	THROW 60001, N'Documentation type error', 1;

--/* add checking of equal sender and receiver properties of waybill and weightsheet*/
--if (
--	select count(Prop.[Description])
--	from (values
--	(N'Цех отправления'),
--	(N'Цех получения')
--	) as Prop ([Description])
--	left join [dbo].[v_WGT_WaybillProperty] wWP_WB
--	on wWP_WB.[Description] = Prop.[Description] and wWP_WB.[DocumentationsID] = @WaybillID
--	left join [dbo].[v_WGT_WaybillProperty] wWP_WS
--	on wWP_WS.[Description] = Prop.[Description] and wWP_WS.[DocumentationsID] = @WeightSheetID
--	where isnull(wWP_WB.[Value],'') != isnull(wWP_WS.[Value],'')
--) > 0
--	THROW 60001, N'Sender or Receiver in Weightsheet and Waybill are not equal!', 1;


BEGIN TRANSACTION ins_TakeWeightBrutto;
BEGIN TRY

--select 
--	 @PackagingUnitsID		as [PackagingUnitsID]
--	,@MaterialDefinitionID	as [MaterialDefinitionID]
--	,@SenderID				as [SenderID]
--	,@ReceiverID			as [ReceiverID]
--	,@WeightTare			as [WeightTare]
--	,@WeightBrutto			as [WeightBrutto]


-- если для документа вагона не существует - вставляем вагон
-- если запись этого вагона уже есть - обновляем статус и дату
-- inserting or updating wagon in [PackagingUnitsDocs]
declare @out_id_table table ([ID] int)

MERGE INTO [PackagingUnitsDocs]	as trg
USING  
	(select top 1
		 PU.[Description]			as [Description]
		,@WeightSheetID				as [DocumentationsID]
		,PU.ID						as [PackagingUnitsID]
		,null						as [Status]
		,getdate()					as [StartTime]
	from [dbo].[PackagingUnits] PU
	join [dbo].[Documentations] D
	on D.ID = @WeightSheetID and D.[Status] = 'active'
	where PU.ID = @PackagingUnitsID
) as src
ON		trg.[DocumentationsID] = src.[DocumentationsID]
	and trg.[PackagingUnitsID] = src.[PackagingUnitsID]
-- если есть сопоставление строки trg со строкой из источника src
WHEN MATCHED  THEN 
	UPDATE SET
		 trg.[Status] = src.[Status]
		,trg.[StartTime] = src.[StartTime]
-- если строка не найдена в trg, но есть в src
WHEN NOT MATCHED THEN 
	INSERT
		([Description]
		,[DocumentationsID]
		,[PackagingUnitsID]
		,[Status]
		,[StartTime])
	VALUES
		(src.[Description]
		,src.[DocumentationsID]
		,src.[PackagingUnitsID]
		,src.[Status]
		,src.[StartTime])
-- output
OUTPUT
	ISNULL(INSERTED.[ID], DELETED.[ID])		AS [ID]
INTO @out_id_table;
select @PackagingUnitsDocsID = ID from @out_id_table



-- если св-во 'Путевая' и 'Род груза' для вагона существует - обновляем значение и дату
-- если св-во не существует - вставляем его
-- updating Properties in [PackagingUnitsDocsProperty]
MERGE INTO [PackagingUnitsDocsProperty]	as trg
USING  
(	select
		 @PackagingUnitsDocsID	as [PackagingUnitsDocsID]
		,T1.[Description]
		,T1.[Value]
		,getdate()				as [ValueTime]
	from (values
	--(N'Путевая',	cast(@WaybillID as nvarchar)),
	(N'Род груза',  cast(@MaterialDefinitionID as nvarchar))
	) as T1 ([Description], [Value])
) as src
ON		trg.[PackagingUnitsDocsID] = src.[PackagingUnitsDocsID] 
	and trg.[Description] = src.[Description]
-- если есть сопоставление строки trg со строкой из источника src
WHEN MATCHED THEN 
	UPDATE SET
		 trg.[Value] = src.[Value]
		,trg.[ValueTime] = src.[ValueTime]	  	  		  
-- если строка не найдена в trg, но есть в src
WHEN NOT MATCHED BY TARGET THEN 
	INSERT
		([Description]
		,[Value]
		,[PackagingUnitsDocsID]
		,[ValueTime])
	VALUES
		(src.[Description]
		,src.[Value]
		,src.[PackagingUnitsDocsID]
		,src.[ValueTime])
-- output
OUTPUT 
	'[PackagingUnitsDocsProperty]'												as [Table]
	,$ACTION
	,ISNULL(INSERTED.[Description], DELETED.[Description])						AS [Description] 
	,ISNULL(INSERTED.[Value], DELETED.[Value])									AS [Value] 
	,ISNULL(INSERTED.[PackagingUnitsDocsID], DELETED.[PackagingUnitsDocsID])	AS [PackagingUnitsDocsID]
	,ISNULL(INSERTED.[ValueTime], DELETED.[ValueTime])							AS [ValueTime] 
;



-- запись операции взвешивания
-- если для документа запись вагона уже есть - забраковываем предыдущие записи для этого вагона, а новую - вставляем
-- если для документа вагона записи еще нет - вставляем.

-- update status for repeating wagons in this document
update WO
	set WO.[Status] = 'reject'
from [dbo].[Documentations] D
join [dbo].[DocumentationsClass] DC
on D.DocumentationsClassID = DC.ID
join [dbo].[PackagingUnits] PU
on PU.ID = @PackagingUnitsID
join [WeightingOperations] WO
on WO.DocumentationsID = D.ID and WO.PackagingUnitsDocsID = @PackagingUnitsDocsID
where	D.ID = @WeightSheetID and D.[Status] = 'active' and WO.OperationTime < getdate()


-- insert new weighting operation in [WeightingOperations]
insert into [dbo].[WeightingOperations]
	([Description]
	,[OperationTime]
	,[Status]
	,[EquipmentID]
	,[PackagingUnitsDocsID]
	,[DocumentationsID]
	,[Brutto]
	,[Tara]
	,[Netto]
	,[OperationType]
	,[MaterialDefinitionID]
	,[TaringTime]
	,[PersonID])
select top 1
	 PU.[Description]		as [Description]
	,getdate()				as [OperationTime]
	,null					as [Status]
	,@ScalesID				as [EquipmentID]
	,@PackagingUnitsDocsID	as [PackagingUnitsDocsID]
	,D.ID					as [DocumentationsID]
	,@WeightBrutto			as [Brutto]
	--,@WeightTare			as [Tara]
	,null					as [Tara]
	,null					as [Netto]
	,DC.[Description]		as [OperationType]
	,@MaterialDefinitionID	as [MaterialDefinitionID]
	,null					as [TaringTime]
	,@PersonID				as [PersonID]
from [dbo].[Documentations] D
join [dbo].[DocumentationsClass] DC
on D.DocumentationsClassID = DC.ID
join [dbo].[PackagingUnits] PU
on PU.ID = @PackagingUnitsID
where D.ID = @WeightSheetID and D.[Status] = 'active'


COMMIT TRANSACTION  ins_TakeWeightBrutto; 
END TRY
	
BEGIN CATCH
	ROLLBACK TRANSACTION ins_TakeWeightBrutto;
	THROW 60020,'Error transaction ins_TakeWeightBrutto',1;	
END CATCH
end



GO