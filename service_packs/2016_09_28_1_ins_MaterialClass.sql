--------------------------------------------------------------
/*
���������� ������ MaterialClass 
������� �� ������� ������� ��������� ���������� ����
*/

INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [Code]) VALUES(N'���',100000, N'Measuring instruments')
INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'������������ ������������� �������',100001,100000, N'Measuring device')
	
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'����',100002,100001, N'Scales')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���� ������������',100003,100002, N'Laboratory scales')
	
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������',100004,100001, N'Manometer')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'����������',100005,100004, N'Vacuum gauge')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������',100006,100004, N'Barometer')	
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'����������������� ��������',100007,100004, N'Electric contact manometer')
	
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������-�������',100008,100001, N'Linear-angular')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'����������',100009,100008, N'Depth gauge')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�����������������',100015,100009, N'Depth gauge')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������',100010,100008, N'Measuring staff')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������',100011,100008, N'Micrometer')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'����� �����',100012,100008, N'Set of feeler gauges')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'������� �������������',100013,100008, N'Roulette')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������',100014,100008, N'Calipers')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������',100016,100008, N'Protractor')
	
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������������',100017,100001, N'�lectric')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������',100018,100017, N'ammeter')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������',100019,100018, N'amperevoltmeter')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������',100020,100018, N'microammeter')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������',100021,100018, N'milliammeter')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������',100022,100017, N'voltmeter')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������',100023,100022, N'voltamperemeter')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������� ��������',100024,100022, N'voltmeter digital')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'������������������',100025,100022, N'Voltphasemeter')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�����������',100026,100017, N'oscillograph')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������� �������������',100027,100017, N'resistance')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'����������',100028,100027, N'megohmmeter')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'������',100029,100027, N'ohmmeter')
	
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������',100030,100001, N'�reometer')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������� ��� �����',100031,100030, N'�reometer-oil')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������� ��� ������',100032,100030, N'�reometer-milk')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������� ��� ������',100033,100030, N'�reometer-ethanol')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������� ��� �����������',100034,100030, N'�reometer-electrolyte')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������-���������',100035,100030, N'�reometer-sugar')
	
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������������',100036,100001, N'Gas analyzers')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������� ��������� �����',100037,100036, N'Gas analyzers exhausts')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������� ����������� ���������� �2',100038,100036, N'Gas analyzers O2')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'���������',100039,100036, N'hygrometer')
			INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������� �����������������',100040,100039, N'psychrometric hygrometer')	
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������������� �����������',100041,100036, N'Gas analyzers electronik')
	
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'������������',100042,100001, N'viscometer')

INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������������� ������������� �������',100043,100000, N'Registered device')
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'��������',100044,100043, N'meter')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������� ����',100045,100044, N'Water meter')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������� ��.�������',100046,100044, N'electricity meter')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������-��������',100047,100044, N'meter liquid')
		INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�������-������� ��������� ���������� ',100048,100044, N'wattmeter counter')			
	
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'�����������',100049,100043, N'Recording')
	INSERT INTO [dbo].[MaterialClass] ([Description],[ID], [ParentID], [Code]) VALUES(N'����������',100050,100043, N'printing')
