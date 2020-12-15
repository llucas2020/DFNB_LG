/*****************************************************************************************************************
NAME:    dbo.tblTransactionFact
PURPOSE: Process for the creation of the tables.
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     12/14/2020   LLUCAS2020      1. Created table dbo.tblTransactionFact
2.0     12/14/2020   LLUCAS2020      2. Added enhancements for LDSBC IT 240 - Project 2.4: DFNB - Evaluate Current Performance - Create v1 of Script Repository

RUNTIME: 
Approx. 1 min
NOTES: This shows all tables.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

ALTER TABLE [dbo].[tblTransactionFact] DROP CONSTRAINT [FK_tblTransactionFact_tblTransactionTypeDim]
GO

ALTER TABLE [dbo].[tblTransactionFact] DROP CONSTRAINT [FK_tblTransactionFact_tblBranchLocationsDim]
GO

/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 12/14/2020 9:10:53 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTransactionFact]') AND type in (N'U'))
DROP TABLE [dbo].[tblTransactionFact]
GO

/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 12/14/2020 9:10:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTransactionFact](
	[tran_id] [int] IDENTITY(1,1) NOT NULL,
	[tran_date] [date] NOT NULL,
	[tran_time] [time](7) NOT NULL,
	[tran_type_id] [smallint] NOT NULL,
	[tran_amt] [int] NOT NULL,
	[tran_fee_amt] [decimal](15, 3) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[acct_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tran_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblTransactionFact]  WITH CHECK ADD  CONSTRAINT [FK_tblTransactionFact_tblBranchLocationsDim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tblBranchLocationsDim] ([branch_id])
GO

ALTER TABLE [dbo].[tblTransactionFact] CHECK CONSTRAINT [FK_tblTransactionFact_tblBranchLocationsDim]
GO

ALTER TABLE [dbo].[tblTransactionFact]  WITH CHECK ADD  CONSTRAINT [FK_tblTransactionFact_tblTransactionTypeDim] FOREIGN KEY([tran_type_id])
REFERENCES [dbo].[tblTransactionTypeDim] ([tran_type_id])
GO

ALTER TABLE [dbo].[tblTransactionFact] CHECK CONSTRAINT [FK_tblTransactionFact_tblTransactionTypeDim]
GO


