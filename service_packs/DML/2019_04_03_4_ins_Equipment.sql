SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
SET NOCOUNT ON
GO

IF Object_ID('tempdb..#tmp_mat2') is not null
drop table #tmp_mat2

IF Object_ID('tempdb..#tmp_mat3') is not null
drop table #tmp_mat3

IF Object_ID('tempdb..#tmp_mat4') is not null
drop table #tmp_mat4

IF Object_ID('tempdb..#tmp_mat5') is not null
drop table #tmp_mat5

IF Object_ID('tempdb..#tmp_mat6') is not null
drop table #tmp_mat6

IF Object_ID('tempdb..#tmp_mat7') is not null
drop table #tmp_mat7

IF Object_ID('tempdb..#tmp_mat8') is not null
drop table #tmp_mat8

IF Object_ID('tempdb..#tmp_mat9') is not null
drop table #tmp_mat9

IF Object_ID('tempdb..#tmp_mat10') is not null
drop table #tmp_mat10

declare @ecid int;
declare @ecid2 int;
declare @equ int;

set @ecid = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��������������� ������������' and [EquipmentLevel] = N'Site'); 
set @equ = (SELECT top 1 [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[EquipmentClass] where [Description] = N'����');
set @ecid2 = (SELECT [ID] FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[EquipmentClass]
		where [EquipmentLevel] = N'Process Cell' and [Description] = N'���������������� �������');

IF @ecid is NULL or @equ is NULL or @ecid2 is NULL 
RETURN;

select
	 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
into #tmp_mat2
from (values
		(N'��������������� ������������ (���)','Area',@ecid ,@equ)
		,(N'��� ����������� (�� ���)','Area',@ecid ,@equ)
		,(N'�������������������� ��� (��� ���)','Area',@ecid ,@equ)
		,(N'��� ����������� (��� ���)','Area',@ecid ,@equ)
		,(N'��������������� ��� (�� ���)','Area',@ecid ,@equ)
		,(N'�����','Area',@ecid ,@equ)
		,(N'��� ���','Area',@ecid ,@equ)
		,(N'��� ���','Area',@ecid ,@equ)		
) as T([Description] ,[EquipmentLevel],[Equipment]  ,[EquipmentClassID])

-- select * from #tmp_mat2

-- insert Equipment-Area (��������������� ������������)
 		merge [dbo].[Equipment]  as trg 
		using
		(select  [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
			from  #tmp_mat2) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


	-- insert property SAP_CODE for Equipment-Area (��������������� ������������)
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join #tmp_mat2 as T
			on MD.[Description] = T.[Description]
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE') as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);


	-- insert property CONSIGNER for Equipment-Area (��������������� ������������)
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N'true'							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join #tmp_mat2 as T
			on MD.[Description] = T.[Description]
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'CONSIGNER') as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);

		-- insert property CONSIGNEE for Equipment-Area (��������������� ������������)
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N'true'							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join #tmp_mat2 as T
			on MD.[Description] = T.[Description]
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'CONSIGNEE') as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);

-----------------------------------------------Process cell------------------------------------------------------------

--insert Equipment-ProcessCell (��������������� ������������ (���))
		declare @ecid4 int;
		set @ecid4 = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��������������� ������������ (���)' and [EquipmentLevel] = N'Area') ; 

		select
			 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
		into #tmp_mat3
		from (values
		(N'��������������� ������������ (���)', N'Process Cell', @ecid2, @ecid4 )
		,(N'�������������������� ��� (��� ���)', N'Process Cell', @ecid2, @ecid4 )
		,(N'�������������������� ��� (��� ���)', N'Process Cell', @ecid2, @ecid4 )
		,(N'��� ����������� (�� ���)', N'Process Cell', @ecid2, @ecid4 )
		,(N'��� ����������� (��� ���)', N'Process Cell', @ecid2, @ecid4 )
		,(N'��������������� ��� (�� ���)', N'Process Cell', @ecid2, @ecid4 )
		,(N'�����', N'Process Cell', @ecid2, @ecid4 )
		,(N'��� ���', N'Process Cell', @ecid2, @ecid4 )
		,(N'��� ���', N'Process Cell', @ecid2, @ecid4 )	
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment] )

		-- select * from #tmp_mat3
		-- drop table #tmp_mat3

		merge [dbo].[Equipment]  as trg 
		using
		(select  #tmp_mat3.[Description] , #tmp_mat3.[EquipmentLevel] , @ecid2 [EquipmentClassID], @ecid4 [Equipment] from  #tmp_mat3 ) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


		-- insert property SAP_CODE for Equipment-ProcessCell (��������������� ������������ (���))
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select 	#tmp_mat3.[Description] , N'Process Cell' [EquipmentLevel] , @ecid2 [EquipmentClassID] , eq.[id] [Equipment]
						from  #tmp_mat3 
						join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
						on #tmp_mat3.[Description] = eq.[Description]
						where eq.EquipmentClassID = @ecid2) as T
			on MD.[Description] = T.[Description] 
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid2) as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);


--insert Equipment-ProcessCell (�������������������� ��� (��� ���))
		declare @ecid5 int;
		set @ecid5 = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'�������������������� ��� (��� ���)' and [EquipmentLevel] = N'Area') ; 

		select
			 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
		into #tmp_mat4
		from (values
		(N'�������������������� ��� (��� ���)', N'Process Cell', @ecid2, @ecid5 )
		,(N'��-5 (��-5)', N'Process Cell', @ecid2, @ecid5 )
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment] )

		-- select * from #tmp_mat4
		-- drop table #tmp_mat4

		merge [dbo].[Equipment]  as trg 
		using
		(select  #tmp_mat4.[Description] , #tmp_mat4.[EquipmentLevel] , @ecid2 [EquipmentClassID], @ecid5 [Equipment] from  #tmp_mat4 ) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


		-- insert property SAP_CODE for Equipment-ProcessCell (�������������������� ��� (��� ���))
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select 	#tmp_mat4.[Description] , N'Process Cell' [EquipmentLevel] , @ecid2 [EquipmentClassID] , eq.[id] [Equipment]
						from  #tmp_mat4 
						join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
						on #tmp_mat4.[Description] = eq.[Description]
						where eq.EquipmentClassID = @ecid2) as T
			on MD.[Description] = T.[Description] 
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid2) as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);

--insert Equipment-ProcessCell (��� ����������� (�� ���))
		declare @ecid6 int;
		set @ecid6 = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��� ����������� (�� ���)' and [EquipmentLevel] = N'Area') ; 

		select
			 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
		into #tmp_mat5
		from (values
		(N'��� ����������� (�� ���)', N'Process Cell', @ecid2, @ecid6 )
		,(N'����� ������� ��������� ���� �����������', N'Process Cell', @ecid2, @ecid6 )
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment] )

		-- select * from #tmp_mat5
		-- drop table #tmp_mat5

		merge [dbo].[Equipment]  as trg 
		using
		(select  #tmp_mat5.[Description] , #tmp_mat5.[EquipmentLevel] , @ecid2 [EquipmentClassID], @ecid6 [Equipment] from  #tmp_mat5 ) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


		-- insert property SAP_CODE for Equipment-ProcessCell (��� ����������� (�� ���))
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select 	#tmp_mat5.[Description] , N'Process Cell' [EquipmentLevel] , @ecid2 [EquipmentClassID] , eq.[id] [Equipment]
						from  #tmp_mat5 
						join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
						on #tmp_mat5.[Description] = eq.[Description]
						where eq.EquipmentClassID = @ecid2) as T
			on MD.[Description] = T.[Description] 
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid2) as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);

--insert Equipment-ProcessCell (��� ����������� (��� ���))
		declare @ecid7 int;
		set @ecid7 = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��� ����������� (��� ���)' and [EquipmentLevel] = N'Area') ; 

		select
			 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
		into #tmp_mat6
		from (values
		(N'��� ����������� (��� ���)', N'Process Cell', @ecid2, @ecid7 )
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment] )

		-- select * from #tmp_mat5
		-- drop table #tmp_mat5

		merge [dbo].[Equipment]  as trg 
		using
		(select  #tmp_mat6.[Description] , #tmp_mat6.[EquipmentLevel] , @ecid2 [EquipmentClassID], @ecid7 [Equipment] from  #tmp_mat6 ) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


		-- insert property SAP_CODE for Equipment-ProcessCell (��� ����������� (��� ���))
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select 	#tmp_mat6.[Description] , N'Process Cell' [EquipmentLevel] , @ecid2 [EquipmentClassID] , eq.[id] [Equipment]
						from  #tmp_mat6 
						join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
						on #tmp_mat6.[Description] = eq.[Description]
						where eq.EquipmentClassID = @ecid2) as T
			on MD.[Description] = T.[Description] 
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid2) as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);



--insert Equipment-ProcessCell (��������������� ��� (�� ���))
		declare @ecid8 int;
		set @ecid8 = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��������������� ��� (�� ���)' and [EquipmentLevel] = N'Area') ; 

		select
			 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
		into #tmp_mat7
		from (values
		(N'��������������� ��� (�� ���)', N'Process Cell', @ecid2, @ecid8 )
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment] )

		-- select * from #tmp_mat7
		-- drop table #tmp_mat7

		merge [dbo].[Equipment]  as trg 
		using
		(select  #tmp_mat7.[Description] , #tmp_mat7.[EquipmentLevel] , @ecid2 [EquipmentClassID], @ecid8 [Equipment] from  #tmp_mat7 ) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


		-- insert property SAP_CODE for Equipment-ProcessCell (��������������� ��� (�� ���))
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select 	#tmp_mat7.[Description] , N'Process Cell' [EquipmentLevel] , @ecid2 [EquipmentClassID] , eq.[id] [Equipment]
						from  #tmp_mat7 
						join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
						on #tmp_mat7.[Description] = eq.[Description]
						where eq.EquipmentClassID = @ecid2) as T
			on MD.[Description] = T.[Description] 
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid2) as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);


--insert Equipment-ProcessCell (�����)
		declare @ecid9 int;
		set @ecid9 = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'�����' and [EquipmentLevel] = N'Area') ; 

		select
			 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
		into #tmp_mat8
		from (values
		(N'�����', N'Process Cell', @ecid2, @ecid9 )
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment] )

		-- select * from #tmp_mat8
		-- drop table #tmp_mat8

		merge [dbo].[Equipment]  as trg 
		using
		(select  #tmp_mat8.[Description] , #tmp_mat8.[EquipmentLevel] , @ecid2 [EquipmentClassID], @ecid9 [Equipment] from  #tmp_mat8 ) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


		-- insert property SAP_CODE for Equipment-ProcessCell (�����)
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select 	#tmp_mat8.[Description] , N'Process Cell' [EquipmentLevel] , @ecid2 [EquipmentClassID] , eq.[id] [Equipment]
						from  #tmp_mat8 
						join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
						on #tmp_mat8.[Description] = eq.[Description]
						where eq.EquipmentClassID = @ecid2) as T
			on MD.[Description] = T.[Description] 
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid2) as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);

--insert Equipment-ProcessCell (��� ���)
		declare @ecid10 int;
		set @ecid10 = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��� ���' and [EquipmentLevel] = N'Area') ; 

		select
			 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
		into #tmp_mat9
		from (values
		(N'��� ���', N'Process Cell', @ecid2, @ecid10 )
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment] )

		-- select * from #tmp_mat9
		-- drop table #tmp_mat9

		merge [dbo].[Equipment]  as trg 
		using
		(select  #tmp_mat9.[Description] , #tmp_mat9.[EquipmentLevel] , @ecid2 [EquipmentClassID], @ecid10 [Equipment] from  #tmp_mat9 ) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


		-- insert property SAP_CODE for Equipment-ProcessCell (��� ���)
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select 	#tmp_mat9.[Description] , N'Process Cell' [EquipmentLevel] , @ecid2 [EquipmentClassID] , eq.[id] [Equipment]
						from  #tmp_mat9 
						join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
						on #tmp_mat9.[Description] = eq.[Description]
						where eq.EquipmentClassID = @ecid2) as T
			on MD.[Description] = T.[Description] 
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid2) as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);







--insert Equipment-ProcessCell (��� ���)
		declare @ecid11 int;
		set @ecid11 = (SELECT  top 1  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��� ���' and [EquipmentLevel] = N'Area') ; 

		select
			 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
		into #tmp_mat10
		from (values
		(N'��� ���', N'Process Cell', @ecid2, @ecid11 )
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment] )

		-- select * from #tmp_mat10
		-- drop table #tmp_mat10

		merge [dbo].[Equipment]  as trg 
		using
		(select  #tmp_mat10.[Description] , #tmp_mat10.[EquipmentLevel] , @ecid2 [EquipmentClassID], @ecid11 [Equipment] from  #tmp_mat10 ) as t2
		on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
				VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


		-- insert property SAP_CODE for Equipment-ProcessCell (��� ���)
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select 	#tmp_mat10.[Description] , N'Process Cell' [EquipmentLevel] , @ecid2 [EquipmentClassID] , eq.[id] [Equipment]
						from  #tmp_mat10 
						join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
						on #tmp_mat10.[Description] = eq.[Description]
						where eq.EquipmentClassID = @ecid2) as T
			on MD.[Description] = T.[Description] 
			join [dbo].[EquipmentClassProperty] MCP
			on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
			where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid2) as t2
		on (trg.[Description]=t2.[Description] and trg.[Value]=t2.[Value] and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);

GO