


SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
SET NOCOUNT ON
GO

IF Object_ID('tempdb..#tmp_mat1') is not null
drop table #tmp_mat1

IF Object_ID('tempdb..#tmp_mat2') is not null
drop table #tmp_mat2

IF Object_ID('tempdb..#tmp_mat3') is not null
drop table #tmp_mat1

IF Object_ID('tempdb..#tmp_mat4') is not null
drop table #tmp_mat2

IF Object_ID('tempdb..#tmp_mat5') is not null
drop table #tmp_mat1

IF Object_ID('tempdb..#tmp_mat6') is not null
drop table #tmp_mat2

IF Object_ID('tempdb..#tmp_mat7') is not null
drop table #tmp_mat1

IF Object_ID('tempdb..#tmp_mat8') is not null
drop table #tmp_mat2

IF Object_ID('tempdb..#tmp_mat9') is not null
drop table #tmp_mat1


declare @ecid1 int,@ecid2 int,@ecid3 int,@ecid4 int,@ecid5 int,@ecid6 int,@ecid7 int;


set @ecid1 = (SELECT [ID] FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[EquipmentClass]	where [EquipmentLevel] = N'Area' and [Description] = N'����');
set @ecid2 = (SELECT  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��������� �����������'
					and [EquipmentLevel] = N'Site'); 
set @ecid3 = (SELECT [ID] FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[EquipmentClass]
				where [EquipmentLevel] = N'Process Cell' and [Description] = N'���������������� �������');
set @ecid4 = (SELECT  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��������� ����������� (��)'
					and [EquipmentLevel] = N'Area');
set @ecid5 = (SELECT  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'�������'
					and [EquipmentLevel] = N'Area'); 
set @ecid6 = (SELECT  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'���'
					and [EquipmentLevel] = N'Area');
set @ecid7 = (SELECT  [ID]  FROM [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] where [Description] = N'��-3' and [EquipmentLevel] = N'Area');  


IF @ecid1 is NULL or @ecid2 is NULL or @ecid3 is NULL or @ecid4 is NULL or @ecid5 is NULL or @ecid6 is NULL or @ecid7 is NULL
RETURN;

--select @ecid1
--select @ecid2
--select @ecid3 , @ecid2

	-- insert Equipment-Site (��������� ����������� (��))
	select
		 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
	into #tmp_mat1
	from (values
				 (N'��������� ����������� (��)',  N'Area',  @ecid1,  @ecid2)
				,(N'�������',  N'Area',  @ecid1,  @ecid2)
				,(N'��������� ��������� ���������',  N'Area',  @ecid1,  @ecid2)
				,(N'������� ���������� ��������������',  N'Area',  @ecid1,  @ecid2)
	) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment])

	/* drop table #tmp_mat1 
	 drop table #tmp_mat2
	 drop table #tmp_mat3
	 drop table #tmp_mat4
	 drop table #tmp_mat5
	 drop table #tmp_mat6
	 drop table #tmp_mat7
	 drop table #tmp_mat8
	 drop table #tmp_mat9 */

	-- insert Equipment-Area (��������� ����������� (��))
 			merge [dbo].[Equipment]  as trg 
			using
			(select  [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
				from  #tmp_mat1) as t2
			on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
			WHEN NOT MATCHED THEN
			INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
					VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


	-- insert Equipment-ProcessCell (��������� ����������� (��)-��������� ����������� (��))
	select
		 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
	into #tmp_mat2
	from (values
				 (N'��������� ����������� (��)', N'Process Cell', @ecid3, @ecid4)
				,(N'�������������� ���-1 (��)', N'Process Cell', @ecid3, @ecid4)
				,(N'�������������� ���-2 (��)', N'Process Cell', @ecid3, @ecid4)
				,(N'��������� ��� �3 (��)', N'Process Cell', @ecid3, @ecid4)
				,(N'�������', N'Process Cell', @ecid3, @ecid4)
				,(N'��� ���������� ���������������� (��� (����))', N'Process Cell', @ecid3, @ecid4)
				,(N'��������� ��������� ���������', N'Process Cell', @ecid3, @ecid4)
				,(N'������� ���������� ��������������', N'Process Cell', @ecid3, @ecid4)
				,(N'�������������� ���', N'Process Cell', @ecid3, @ecid4)
	) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment]);

	 		merge [dbo].[Equipment]  as trg 
			using
			(select  [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
				from  #tmp_mat2) as t2
			on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
			WHEN NOT MATCHED THEN
			INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
					VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


	-- insert Equipment-ProcessCell (��������� ����������� (��)-�������)
	select
		 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
	into #tmp_mat3
	from (values
				 (N'�������', N'Process Cell', @ecid3, @ecid5)
				,(N'����1250', N'Process Cell', @ecid3, @ecid5)
				,(N'���.��1300��1250', N'Process Cell', @ecid3, @ecid5)
				,(N'���.��1250��1300', N'Process Cell', @ecid3, @ecid5)
				,(N'��� �ֹ3 ���1300', N'Process Cell', @ecid3, @ecid5)
				,(N'��� �ֹ3 ���1250', N'Process Cell', @ecid3, @ecid5)
				,(N'���� 1300', N'Process Cell', @ecid3, @ecid5)
	) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment]);

	 		merge [dbo].[Equipment]  as trg 
			using
			(select  [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
				from  #tmp_mat3) as t2
			on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
			WHEN NOT MATCHED THEN
			INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
					VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);

	-- insert Equipment-ProcessCell (��������� ����������� (��)-��� ���������� ���������������� (��� (����)))
	select
		 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
	into #tmp_mat4
	from (values
				 (N'��� ���������� ���������������� (��� (����))', N'Process Cell', @ecid3, @ecid6)
				,(N'5 �����', N'Process Cell', @ecid3, @ecid6)
	) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment]);

	 		merge [dbo].[Equipment]  as trg 
			using
			(select  [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
				from  #tmp_mat4) as t2
			on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
			WHEN NOT MATCHED THEN
			INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
					VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);

	-- insert Equipment-ProcessCell (��������� ����������� (��)-��������� ��� �3 (��-3))
	select
		 [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
	into #tmp_mat5
	from (values
				 (N'��������� ��� �3 (��-3)', N'Process Cell', @ecid3, @ecid7)
				,(N'��-6 (��-3 (��-6))', N'Process Cell', @ecid3, @ecid7)
	) as T([Description] ,[EquipmentLevel],[EquipmentClassID],[Equipment]);

	 		merge [dbo].[Equipment]  as trg 
			using
			(select  [Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]
				from  #tmp_mat5) as t2
			on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
			WHEN NOT MATCHED THEN
			INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
					VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


	-- insert Equipment-ProcessCell (��������� ����������� (��)) ��� = �������������
	select
		 [Description] ,[EquipmentLevel] ,[EquipmentClassID]
	into #tmp_mat6
	from (values
				 (N'���-1', N'Process Cell', @ecid3)
				,(N'���-2', N'Process Cell', @ecid3)
				,(N'��������� ��������� ���������', N'Process Cell', @ecid3)
				,(N'������� ���������� ��������������', N'Process Cell', @ecid3)
				,(N'�������������� ���', N'Process Cell', @ecid3)
	) as T([Description] ,[EquipmentLevel],[EquipmentClassID]);

	 		merge [dbo].[Equipment]  as trg 
			using
			(select  #tmp_mat6.[Description] ,#tmp_mat6.[EquipmentLevel] ,#tmp_mat6.[EquipmentClassID], eq.[id] [Equipment] from  #tmp_mat6
				join [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment] eq
				on #tmp_mat6.[Description] = eq.[Description]
				where  eq.[EquipmentClassID] = @ecid1
			) as t2
			on (trg.[Description]=t2.[Description] and trg.[EquipmentLevel]=t2.[EquipmentLevel] and trg.[EquipmentClassID]=t2.[EquipmentClassID] and trg.[Equipment]=t2.[Equipment])
			WHEN NOT MATCHED THEN
			INSERT   ([Description] ,[EquipmentLevel] ,[EquipmentClassID],[Equipment]) 
					VALUES (t2.[Description], t2.[EquipmentLevel], t2.[EquipmentClassID], t2.[Equipment]);


	-- property SAP_CODE for Equipment-Area (��������� ����������� (��))
	select
		 [Description] ,[EquipmentLevel] ,[EquipmentClassID]
	into #tmp_mat7
	from (values
				 (N'��������� ����������� (��)', N'Area', @ecid1) 
				,(N'���-1', N'Area', @ecid1)
				,(N'���-2', N'Area', @ecid1)
				,(N'��-3', N'Area', @ecid1)
				,(N'�������', N'Area', @ecid1)
				,(N'���', N'Area', @ecid1)
				,(N'��������� ��������� ���������', N'Area', @ecid1)
				,(N'������� ���������� ��������������', N'Area', @ecid1)
				,(N'�������������� ���', N'Area', @ecid1)
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID]);


		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select  [Description] ,[EquipmentLevel] ,[EquipmentClassID] from  #tmp_mat7) as T
						on MD.[Description] = T.[Description] 
						join [dbo].[EquipmentClassProperty] MCP
						on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
						where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid1) as t2
				on (trg.[Description]=t2.[Description]  and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]); 

		-- property CONSIGNER for Equipment-Area (��������� ����������� (��))
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N'true'						as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select  [Description] ,[EquipmentLevel] ,[EquipmentClassID] from  #tmp_mat7) as T
						on MD.[Description] = T.[Description] 
						join [dbo].[EquipmentClassProperty] MCP
						on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
						where MCP.[Value] = N'CONSIGNER' and MD.EquipmentClassID = @ecid1) as t2
				on (trg.[Description]=t2.[Description]  and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);

		-- property CONSIGNEE for Equipment-Area (��������� ����������� (��))
		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N'true'						as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select  [Description] ,[EquipmentLevel] ,[EquipmentClassID] from  #tmp_mat7) as T
						on MD.[Description] = T.[Description] 
						join [dbo].[EquipmentClassProperty] MCP
						on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
						where MCP.[Value] = N'CONSIGNEE' and MD.EquipmentClassID = @ecid1) as t2
				on (trg.[Description]=t2.[Description]  and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]);


	-- property SAP_CODE for Equipment-ProcessCell (��������� ����������� (��))
	select
		 [Description] ,[EquipmentLevel] ,[EquipmentClassID]
	into #tmp_mat8
	from (values				
				 (N'��������� ����������� (��)',  N'Process Cell' , @ecid3)
				,(N'�������������� ���-1 (��)',   N'Process Cell' , @ecid3)
				,(N'�������������� ���-2 (��)',   N'Process Cell' , @ecid3)
				,(N'��������� ��� �3 (��)',   N'Process Cell' , @ecid3)
				,(N'�������',   N'Process Cell' , @ecid3)
				,(N'��� ���������� ���������������� (��� (����))',   N'Process Cell' , @ecid3)
				,(N'��������� ��������� ���������',   N'Process Cell' , @ecid3)
				,(N'������� ���������� ��������������',   N'Process Cell' , @ecid3)
				,(N'�������������� ���',   N'Process Cell' , @ecid3)
				,(N'���-1',   N'Process Cell' , @ecid3)
				,(N'���-2',   N'Process Cell' , @ecid3)
				,(N'��������� ��� �3 (��-3)',   N'Process Cell' , @ecid3)
				,(N'��-6 (��-3 (��-6))',   N'Process Cell' , @ecid3)
				,(N'�������',   N'Process Cell' , @ecid3)
				,(N'����1250',   N'Process Cell' , @ecid3)
				,(N'���.��1300��1250',   N'Process Cell' , @ecid3)
				,(N'���.��1250��1300',   N'Process Cell' , @ecid3)
				,(N'��� �ֹ3 ���1300',   N'Process Cell' , @ecid3)
				,(N'��� �ֹ3 ���1250',   N'Process Cell' , @ecid3)
				,(N'���� 1300',   N'Process Cell' , @ecid3)
				,(N'���)',   N'Process Cell' , @ecid3)
				,(N'5 �����',   N'Process Cell' , @ecid3)
				,(N'��������� ��������� ���������',   N'Process Cell' , @ecid3)
				,(N'������� ���������� ��������������',   N'Process Cell' , @ecid3)
				,(N'�������������� ���',   N'Process Cell' , @ecid3)
		) as T([Description] ,[EquipmentLevel],[EquipmentClassID]);


		merge [dbo].[EquipmentProperty]  as trg 
		using
		(select distinct
				 MCP.[Description]				as [Description]
				,N''							as [Value]
				,MD.[ID]						as [EquipmentID]
				,MCP.[ID]						as [ClassPropertyID]
			from [dbo].[Equipment] MD
			join (select  [Description] ,[EquipmentLevel] ,[EquipmentClassID] from  #tmp_mat8) as T
						on MD.[Description] = T.[Description] -- and 
						join [dbo].[EquipmentClassProperty] MCP
						on MCP.[EquipmentClassID] = MD.[EquipmentClassID]
						where MCP.[Value] = N'SAP_CODE' and MD.EquipmentClassID = @ecid3) as t2
				on (trg.[Description]=t2.[Description]  and  trg.[EquipmentID]=t2.[EquipmentID]
				and trg.[ClassPropertyID]=t2.[ClassPropertyID])
		WHEN NOT MATCHED THEN
		INSERT   ([Description] , [Value] ,[EquipmentID] ,[ClassPropertyID]) 
			VALUES (t2.[Description], t2.[Value], t2.[EquipmentID] ,t2.[ClassPropertyID]); 
		

GO