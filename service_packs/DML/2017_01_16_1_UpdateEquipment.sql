﻿USE [KRR-PA-ISA95_PRODUCTION]
GO
SET NOCOUNT ON
GO
SET QUOTED_IDENTIFIER ON
GO


	UPDATE [dbo].[Equipment]
	SET    [Equipment]=100
	WHERE  [Equipment] in (101,102,103)

	DELETE   FROM  [dbo].[Equipment] 
	WHERE ID in (101,102,103)



GO
