﻿SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
BEGIN TRANSACTION;

INSERT INTO [dbo].[PropertyTypes]([Value],[Description]) VALUES (N'NEMERA',N'Признак "Немера"');

COMMIT;
GO

