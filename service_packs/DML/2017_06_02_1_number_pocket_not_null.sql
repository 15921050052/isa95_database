﻿SET NUMERIC_ROUNDABORT OFF;
GO

SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON;
GO

  delete from [dbo].[KEP_logger]
  where [NUMBER_POCKET] is null;
  GO
  