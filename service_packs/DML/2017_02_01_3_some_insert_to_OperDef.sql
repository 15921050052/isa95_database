

 USE [KRR-PA-ISA95_PRODUCTION] 
 GO 
 SET NOCOUNT ON 
 GO 
 SET QUOTED_IDENTIFIER ON 
 GO 

   insert into [ISA95_OPERATION_DEFINITION].[OperationsDefinition]
  ([ID] , [Description], [OperationsType])  values
  (1 , N'������������ ����������' , N'Production'),  (2 , N'������������ �����', N'Production')
  ,(3 , N'������������ ������' , N'Production')  ,(4 , N'������������ �����' , N'Production')
  ,(5 , N'������������ �������', N'Production'), (6 , N'������������ ���������' , N'Production')
  ,(7 , N'����������� ����', N'Production'),  (8 , N'������������ ��������', N'Production')
  GO
