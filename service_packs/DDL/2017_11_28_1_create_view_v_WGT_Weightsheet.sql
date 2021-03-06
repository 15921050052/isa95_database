﻿
IF OBJECT_ID ('dbo.v_WGT_Weightsheet',N'V') IS NOT NULL
  DROP VIEW [dbo].[v_WGT_Weightsheet];
GO

/*
   View: v_WGT_Weightsheet
   Возвращает взвешивания вагонов для отвесной
*/
create view [dbo].[v_WGT_Weightsheet] as 

select
	 WO.[ID]
	,WO.[DocumentationsID]		as [WeightsheetID]
	,PUD.[PackagingUnitsID]		as [WagonID]
	,WO.[Description]			as [WagonNumber]
	,DP.[DocumentationsID]		as [WaybillID]
	,DP.[Value]					as [WaybillNumber]
	,PUP.[Description]			as [Carrying]
	,WO.[MaterialDefinitionID]	as [CargoTypeID]
	,MD.[Description]			as [CargoType]
	--,[OperationTime]
	--,WO.[EquipmentID]			as [WeighbridgeID]
	--,[PackagingUnitsDocsID]
	,WO.[Brutto]
	,WO.[Tara]
	,WO.[Netto]
	--,[OperationType]
	--,[TaringTime]
	,WO.[Status]
	--,PUDP.*
	--,D.*
	--,PUD.*
	--,DP.*
FROM [dbo].[WeightingOperations] WO
left join 
	(select
		 [PackagingUnitsDocsID]
		,[Путевая]		as [WaybillID]
		,[Род груза]	as [CargoTypeID]
	from (
		select
			 [PackagingUnitsDocsID]
			,[Description]
			,[Value]
		from [dbo].[PackagingUnitsDocsProperty] PUDP) as T
	pivot( max([Value]) for [Description] in ([Путевая], [Род груза])) as pvt) as PUDP
on PUDP.[PackagingUnitsDocsID] = WO.[PackagingUnitsDocsID]
left join [dbo].[MaterialDefinition] MD
on PUDP.[CargoTypeID] = MD.[ID]
left join [dbo].[DocumentationsProperty] DP
on DP.[DocumentationsID] = PUDP.[WaybillID] and DP.[Description] = N'Номер путевой'
left join [dbo].[PackagingUnitsDocs] PUD
on PUD.ID = WO.[PackagingUnitsDocsID]
left join [dbo].[PackagingUnitsProperty] PUP
on PUP.[PackagingUnitsID] = PUD.[PackagingUnitsID] and PUP.[Description] = N'Грузоподъемность'

GO