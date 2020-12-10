USE [DFNB2]
GO

ALTER TABLE [dbo].[tblCustomerDim] DROP CONSTRAINT [FK_tblCustomerDim_tblBranchLocationsDim]
GO

/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 12/9/2020 5:39:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCustomerDim]') AND type in (N'U'))
DROP TABLE [dbo].[tblCustomerDim]
GO

/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 12/9/2020 5:39:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCustomerDim](
	[cust_id] [smallint] NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[birth_date] [date] NOT NULL,
	[cust_since_date] [date] NOT NULL,
	[pri_branch_id] [smallint] NOT NULL,
	[gender] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tblCustomerDim] PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCustomerDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDim_tblBranchLocationsDim] FOREIGN KEY([pri_branch_id])
REFERENCES [dbo].[tblBranchLocationsDim] ([branch_id])
GO

ALTER TABLE [dbo].[tblCustomerDim] CHECK CONSTRAINT [FK_tblCustomerDim_tblBranchLocationsDim]
GO


