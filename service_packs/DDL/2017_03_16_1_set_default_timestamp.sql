﻿SET NUMERIC_ROUNDABORT OFF;
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON;
GO

ALTER TABLE dbo.kep_logger ADD CONSTRAINT [DF_KEP_logger_TIMESTAMP] DEFAULT (getdate()) FOR [TIMESTAMP];
GO