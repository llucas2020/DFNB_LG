/*****************************************************************************************************************
NAME:    SQLServerCodeHeader.sql
PURPOSE: Create Table [dbo].[tlb_Region_Dim]
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created Table [dbo].[tlb_Region_Dim]

RUNTIME: 
Approx. 1 min
NOTES: This is one of the tables I created which will be used to provide analysys for Businesses.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  Table [dbo].[tlb_Region_Dim]    Script Date: 11/30/2020 3:59:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tlb_Region_Dim]') AND type in (N'U'))
DROP TABLE [dbo].[tlb_Region_Dim]
GO

/****** Object:  Table [dbo].[tlb_Region_Dim]    Script Date: 11/30/2020 3:59:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlb_Region_Dim](
	[acct_region_id] [int] NOT NULL,
	[acc_region_name] [varchar](50) NULL,
 CONSTRAINT [PK_tlb_Region_Dim] PRIMARY KEY CLUSTERED 
(
	[acct_region_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


