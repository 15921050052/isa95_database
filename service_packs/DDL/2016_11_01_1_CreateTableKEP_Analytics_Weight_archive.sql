﻿SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.KEP_Analytics_Weight_archive',N'U') IS NOT NULL
  DROP TABLE dbo.KEP_Analytics_Weight_archive;
GO
--------------------------------------------------------------


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KEP_Analytics_Weight_archive](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Scales] [int] NOT NULL,
	[DT] [datetime] NULL CONSTRAINT [DF_KEP_Analytics_Weight_archive_DT]  DEFAULT (getdate()),
	[Lafet] [varchar](20) NULL,
	[Wagon] [varchar](20) NULL,
	[Weight] [int] NULL,
	[Weight_platform_1] [int] NULL,
	[Weight_platform_2] [int] NULL,
	[L_bias_weight] [int] NULL,
	[H_bias_weight] [int] NULL,
	[Weight_OK] [bit] NULL,
	[Tara_OK] [bit] NULL,
	[trace_sensor_1] [bit] NULL,
	[trace_sensor_2] [bit] NULL,
	[trace_sensor_3] [bit] NULL,
	[trace_sensor_4] [bit] NULL,
	[trace_sensor_5] [bit] NULL,
	[trace_sensor_6] [bit] NULL,
	[trace_sensor_7] [bit] NULL,
	[trace_sensor_8] [bit] NULL,
	[load_sensor_1] [int] NULL,
	[load_sensor_2] [int] NULL,
	[load_sensor_3] [int] NULL,
	[load_sensor_4] [int] NULL,
	[load_sensor_5] [int] NULL,
	[load_sensor_6] [int] NULL,
	[load_sensor_7] [int] NULL,
	[load_sensor_8] [int] NULL,
	[stabilizing_weight] [bit] NULL,
 CONSTRAINT [PK_KEP_Analytics_Weight_archive] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


