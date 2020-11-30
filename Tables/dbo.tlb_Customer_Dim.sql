/*****************************************************************************************************************
NAME:    SQLServerCodeHeader.sql
PURPOSE: Create Table [dbo].[tlb_Customer_Dim]
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created Table [dbo].[tlb_Customer_Dim]

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

ALTER TABLE [dbo].[tlb_Customer_Dim] DROP CONSTRAINT [FK_tlb_Customer_Dim_tlb_Branch_Locations_Dim]
GO

/****** Object:  Table [dbo].[tlb_Customer_Dim]    Script Date: 11/30/2020 3:55:23 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tlb_Customer_Dim]') AND type in (N'U'))
DROP TABLE [dbo].[tlb_Customer_Dim]
GO

/****** Object:  Table [dbo].[tlb_Customer_Dim]    Script Date: 11/30/2020 3:55:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlb_Customer_Dim](
	[cust_id] [smallint] NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[birth_date] [date] NOT NULL,
	[cust_since_date] [date] NOT NULL,
	[pri_branch_id] [smallint] NOT NULL,
	[gender] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tlb_Customer_Dim] PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tlb_Customer_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Customer_Dim_tlb_Branch_Locations_Dim] FOREIGN KEY([pri_branch_id])
REFERENCES [dbo].[tlb_Branch_Locations_Dim] ([branch_id])
GO

ALTER TABLE [dbo].[tlb_Customer_Dim] CHECK CONSTRAINT [FK_tlb_Customer_Dim_tlb_Branch_Locations_Dim]
GO


