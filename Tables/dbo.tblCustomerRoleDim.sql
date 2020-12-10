USE [DFNB2]
GO

ALTER TABLE [dbo].[tblCustomerRoleDim] DROP CONSTRAINT [FK_tblCustomerRoleDim_tblCustomerDim]
GO

ALTER TABLE [dbo].[tblCustomerRoleDim] DROP CONSTRAINT [FK_tblCustomerRoleDim_tblAccountDim]
GO

/****** Object:  Table [dbo].[tblCustomerRoleDim]    Script Date: 12/9/2020 5:40:03 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCustomerRoleDim]') AND type in (N'U'))
DROP TABLE [dbo].[tblCustomerRoleDim]
GO

/****** Object:  Table [dbo].[tblCustomerRoleDim]    Script Date: 12/9/2020 5:40:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCustomerRoleDim](
	[cust_id2] [smallint] NOT NULL,
	[acct_cust_role_id] [smallint] NOT NULL,
	[acct_id] [int] NOT NULL,
	[cust_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblCustomerRoleDim] PRIMARY KEY CLUSTERED 
(
	[cust_id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCustomerRoleDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerRoleDim_tblAccountDim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tblAccountDim] ([acct_id])
GO

ALTER TABLE [dbo].[tblCustomerRoleDim] CHECK CONSTRAINT [FK_tblCustomerRoleDim_tblAccountDim]
GO

ALTER TABLE [dbo].[tblCustomerRoleDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerRoleDim_tblCustomerDim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tblCustomerDim] ([cust_id])
GO

ALTER TABLE [dbo].[tblCustomerRoleDim] CHECK CONSTRAINT [FK_tblCustomerRoleDim_tblCustomerDim]
GO


