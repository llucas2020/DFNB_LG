/*****************************************************************************************************************
NAME:    dbo.tblAccountFact
PURPOSE: Process for the creation of the tables
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created table dbo.tblAccountFact
2.0     12/13/2020   LLUCAS2020      2. Added Version 2 enhancements for LDSBC IT 240 - Project 1.6: DFNB - Analyze History

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

ALTER TABLE [dbo].[tblAccountFact] DROP CONSTRAINT [FK_tblAccountFact_tblAccountDim]
GO

/****** Object:  Table [dbo].[tblAccountFact]    Script Date: 12/9/2020 5:34:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAccountFact]') AND type in (N'U'))
DROP TABLE [dbo].[tblAccountFact]
GO

/****** Object:  Table [dbo].[tblAccountFact]    Script Date: 12/9/2020 5:34:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAccountFact](
	[acct_id3] [int] NOT NULL,
	[acct_id] [int] NOT NULL,
	[cur_bal] [decimal](20, 4) NOT NULL,
	[as_of_date] [date] NOT NULL,
 CONSTRAINT [PK_tblAccountFact] PRIMARY KEY CLUSTERED 
(
	[acct_id3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblAccountFact]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountFact_tblAccountDim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tblAccountDim] ([acct_id])
GO

ALTER TABLE [dbo].[tblAccountFact] CHECK CONSTRAINT [FK_tblAccountFact_tblAccountDim]
GO


