/*****************************************************************************************************************
NAME:    dbo.tblBranchLocationsDim
PURPOSE: Process for the creation of the tables
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created table dbo.tblBranchLocationsDim

RUNTIME: 
Approx. 1 min
NOTES: Saving the data on how the tables were created.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

ALTER TABLE [dbo].[tblBranchLocationsDim] DROP CONSTRAINT [FK_tblBranchLocationsDim_tblRegionDim]
GO

ALTER TABLE [dbo].[tblBranchLocationsDim] DROP CONSTRAINT [FK_tblBranchLocationsDim_tblAreaDim]
GO

/****** Object:  Table [dbo].[tblBranchLocationsDim]    Script Date: 12/9/2020 5:42:50 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblBranchLocationsDim]') AND type in (N'U'))
DROP TABLE [dbo].[tblBranchLocationsDim]
GO

/****** Object:  Table [dbo].[tblBranchLocationsDim]    Script Date: 12/9/2020 5:42:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblBranchLocationsDim](
	[branch_id] [smallint] NOT NULL,
	[acct_branch_add_id] [int] NOT NULL,
	[acct_area_id] [int] NOT NULL,
	[acct_region_id] [int] NOT NULL,
	[acct_branch_code] [varchar](5) NOT NULL,
	[acct_branch_desc] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tblBranchLocationsDim] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblBranchLocationsDim]  WITH CHECK ADD  CONSTRAINT [FK_tblBranchLocationsDim_tblAreaDim] FOREIGN KEY([acct_area_id])
REFERENCES [dbo].[tblAreaDim] ([acct_area_id])
GO

ALTER TABLE [dbo].[tblBranchLocationsDim] CHECK CONSTRAINT [FK_tblBranchLocationsDim_tblAreaDim]
GO

ALTER TABLE [dbo].[tblBranchLocationsDim]  WITH CHECK ADD  CONSTRAINT [FK_tblBranchLocationsDim_tblRegionDim] FOREIGN KEY([acct_region_id])
REFERENCES [dbo].[tblRegionDim] ([acct_region_id])
GO

ALTER TABLE [dbo].[tblBranchLocationsDim] CHECK CONSTRAINT [FK_tblBranchLocationsDim_tblRegionDim]
GO


