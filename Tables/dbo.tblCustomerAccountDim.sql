/*****************************************************************************************************************
NAME:    dbo.tblCustomerAccountDim
PURPOSE: Process for the creation of the tables
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created table dbo.tblCustomerAccountDim

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

ALTER TABLE [dbo].[tblCustomerAccountDim] DROP CONSTRAINT [FK_tblCustomerAccountDim_tblCustomerDim]
GO

ALTER TABLE [dbo].[tblCustomerAccountDim] DROP CONSTRAINT [FK_tblCustomerAccountDim_tblAccountDim]
GO

/****** Object:  Table [dbo].[tblCustomerAccountDim]    Script Date: 12/9/2020 5:38:33 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCustomerAccountDim]') AND type in (N'U'))
DROP TABLE [dbo].[tblCustomerAccountDim]
GO

/****** Object:  Table [dbo].[tblCustomerAccountDim]    Script Date: 12/9/2020 5:38:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCustomerAccountDim](
	[acct_id2] [int] NOT NULL,
	[acct_id] [int] NOT NULL,
	[cust_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblCustomerAccountDim] PRIMARY KEY CLUSTERED 
(
	[acct_id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCustomerAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerAccountDim_tblAccountDim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tblAccountDim] ([acct_id])
GO

ALTER TABLE [dbo].[tblCustomerAccountDim] CHECK CONSTRAINT [FK_tblCustomerAccountDim_tblAccountDim]
GO

ALTER TABLE [dbo].[tblCustomerAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerAccountDim_tblCustomerDim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tblCustomerDim] ([cust_id])
GO

ALTER TABLE [dbo].[tblCustomerAccountDim] CHECK CONSTRAINT [FK_tblCustomerAccountDim_tblCustomerDim]
GO


