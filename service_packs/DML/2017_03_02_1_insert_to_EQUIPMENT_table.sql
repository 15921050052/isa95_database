
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

USE [KRR-PA-ISA95_PRODUCTION]

  insert into [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment]
  ( [id], [Description]  ,[EquipmentLevel]      ,[Equipment]           ,[EquipmentClassID])
  values
   (367, N'������ �����������' , N'Site' , 100 , 21)
  ,(368, N'���' , N'Site' , 100 , 20)
 
GO

    insert into [KRR-PA-ISA95_PRODUCTION].[dbo].[Equipment]
  (   [Description]  ,[EquipmentLevel]      ,[Equipment]           ,[EquipmentClassID])
  values
   (N'���-1' , N'Area' , 350 , 9)
  ,(N'���-2' , N'Area' , 350 , 9)
  ,(N'���-3' , N'Area' , 350 , 9)
  ,(N'���-3' , N'Area' , 350 , 9)
  ,(N'�������� ���' , N'Area' , 368 , 9)
  ,(N'����������' , N'Area' , 368 , 9)
  ,(N'��������������' , N'Area' , 368 , 9)
  ,(N'���-1' , N'Area' , 367 , 9)
  ,(N'���-2' , N'Area' , 367 , 9)
  ,(N'��-1' , N'Area' , 367 , 9)
  ,(N'��-2' , N'Area' , 367 , 9)
  ,(N'���������� 1 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� 2 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� 3 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� 4 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� 5 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� 6 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� ��1 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� ��2 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� ��3 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� ��4 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� ��5 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'���������� ��6 ��-1' , N'Production Unit' , 105 , 11)
  ,(N'�������� ��1-1 ��-1' , N'Unit' , 105 , 11)
  ,(N'�������� ��1-2 ��-1' , N'Unit' , 105 , 11)
  ,(N'�������� ��1-3 ��-1' , N'Unit' , 105 , 11)
  ,(N'�������� ��1-4 ��-1' , N'Unit' , 105 , 11)
  ,(N'���������� 1 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� 2 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� 3 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� 4 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� 5 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� 6 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� ��1 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� ��2 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� ��3 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� ��4 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� ��5 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'���������� ��6 ��-2' , N'Production Unit' , 106 , 11)
  ,(N'�������� ��2-1 ��-2' , N'Unit' , 106 , 11)
  ,(N'�������� ��2-2 ��-2' , N'Unit' , 106 , 11)
  ,(N'�������� ��2-3 ��-2' , N'Unit' , 106 , 11)
  ,(N'�������� ��2-4 ��-2' , N'Unit' , 106 , 11)
  ,(N'�������� ��-1 ��-2' , N'Unit' , 106 , 11)
  ,(N'�������� ��-2 ��-2' , N'Unit' , 106 , 11)
  ,(N'���������� 1 ����' , N'Production Unit' , 110 , 11)
  ,(N'���������� 2 ����' , N'Production Unit' , 110 , 11)
  ,(N'���������� 3 ����' , N'Production Unit' , 110 , 11)
  ,(N'���������� 4 ����' , N'Production Unit' , 110 , 11)
  ,(N'���������� 5 ����' , N'Production Unit' , 110 , 11)
  ,(N'�������� �15 ��-3' , N'Unit' , 107 , 11)
  ,(N'�������� �16 ��-3' , N'Unit' , 107 , 11)
  ,(N'�������� �17 ��-3' , N'Unit' , 107 , 11)
  ,(N'�������� �18 ��-3' , N'Unit' , 107 , 11)
  ,(N'�������� ��-1 ��-3' , N'Unit' , 107 , 11)
  ,(N'�������� ��-3 ��-3' , N'Unit' , 107 , 11)
  ,(N'�������� ��-4 ��-3' , N'Unit' , 107 , 11)
  ,(N'�������� ��-1 ��-3' , N'Unit' , 107 , 11)
  ,(N'�������� ��-2 ��-3' , N'Unit' , 107 , 11)
  ,(N'������� ���������� 1' , N'Production Unit' , 134 , 11)
  ,(N'������� ���������� 2' , N'Production Unit' , 134 , 11)
  ,(N'������� ���������� 3' , N'Production Unit' , 134 , 11)
  ,(N'������� ���������� 4' , N'Production Unit' , 135 , 11)
  ,(N'������� ���������� 5' , N'Production Unit' , 135 , 11)
  ,(N'������� ���������� 6' , N'Production Unit' , 135 , 11)

GO