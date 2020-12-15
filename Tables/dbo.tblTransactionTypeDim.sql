/*****************************************************************************************************************
NAME:    dbo.tblTransactionTypeDim
PURPOSE: Process for the creation of the tables.
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     12/14/2020   LLUCAS2020      1. Created table dbo.tblTransactionTypeDim
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

/****** Object:  Table [dbo].[tblTransactionTypeDim]    Script Date: 12/14/2020 9:14:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTransactionTypeDim]') AND type in (N'U'))
DROP TABLE [dbo].[tblTransactionTypeDim]
GO

/****** Object:  Table [dbo].[tblTransactionTypeDim]    Script Date: 12/14/2020 9:14:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTransactionTypeDim](
	[tran_type_id] [smallint] NOT NULL,
	[tran_type_code] [varchar](5) NOT NULL,
	[tran_type_desc] [varchar](100) NOT NULL,
	[tran_fee_prct] [decimal](4, 3) NOT NULL,
	[cur_cust_req_ind] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tblTransactionTypeDim] PRIMARY KEY CLUSTERED 
(
	[tran_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


