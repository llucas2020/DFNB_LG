USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblAreaDim]    Script Date: 12/9/2020 5:37:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAreaDim]') AND type in (N'U'))
DROP TABLE [dbo].[tblAreaDim]
GO

/****** Object:  Table [dbo].[tblAreaDim]    Script Date: 12/9/2020 5:37:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAreaDim](
	[acct_area_id] [int] NOT NULL,
	[area_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblAreaDim] PRIMARY KEY CLUSTERED 
(
	[acct_area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


