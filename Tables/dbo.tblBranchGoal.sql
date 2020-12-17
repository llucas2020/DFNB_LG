/*****************************************************************************************************************
NAME:    dbo.tblBranchGoal
PURPOSE: Process for the creation of the tables
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created table dbo.tblBranchGoal

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

/****** Object:  Table [dbo].[tblBranchGoal]    Script Date: 12/16/2020 9:46:30 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblBranchGoal]') AND type in (N'U'))
DROP TABLE [dbo].[tblBranchGoal]
GO

/****** Object:  Table [dbo].[tblBranchGoal]    Script Date: 12/16/2020 9:46:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblBranchGoal](
	[branch_goal_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[acct_branch_desc] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[branch_goal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


