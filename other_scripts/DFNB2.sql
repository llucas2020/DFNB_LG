/*****************************************************************************************************************
NAME:    DFNB2.sql
PURPOSE: Create Schema of DFNB2 with the Data created.
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created Schema for class Ensign IT 240

RUNTIME: 
Approx. 1 min
NOTES: This shows all tables and Views on the Database

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO
/****** Object:  Table [dbo].[tblAccountDim]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountDim](
	[acct_id] [int] NOT NULL,
	[cust_id] [smallint] NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[prod_id] [smallint] NOT NULL,
	[open_date] [date] NOT NULL,
	[close_date] [date] NOT NULL,
	[open_close_code] [varchar](1) NOT NULL,
	[loan_amt] [decimal](20, 4) NOT NULL,
 CONSTRAINT [PK_tblAccountDim] PRIMARY KEY CLUSTERED 
(
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_AccountLoan]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_AccountLoan] AS
SELECT YEAR(open_date) as 'Open Date Year'
, SUM(loan_amt) as 'Total Loan Amount'
FROM dbo.tblAccountDim
WHERE YEAR(open_date) >= 2016 and YEAR(open_date) <= 2019
GROUP BY YEAR(open_date)
GO
/****** Object:  View [dbo].[v_AccountDim]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_AccountDim] AS
SELECT YEAR(open_date) as 'Open Date Year'
, count(acct_id) as 'Count of Accounts'
FROM dbo.tblAccountDim
WHERE YEAR(open_date) >= 2016 and YEAR(open_date) <= 2019
GROUP BY YEAR(open_date)
GO
/****** Object:  Table [dbo].[tblAccountFact]    Script Date: 12/9/2020 6:30:28 PM ******/
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
/****** Object:  View [dbo].[v_AccountCurBal]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_AccountCurBal] AS
SELECT YEAR(as_of_date) as 'As of'
, SUM(cur_bal) as 'Balance'
FROM dbo.tblAccountFact
WHERE YEAR(as_of_date) >= 2016 and YEAR(as_of_date) <= 2019
GROUP BY YEAR(as_of_date)
GO
/****** Object:  View [dbo].[v_OpenCloseCode]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[v_OpenCloseCode] AS
SELECT count(branch_id) as 'Accounts'
, branch_id as 'Branch'
, open_close_code as 'Open/Closed'
from dbo.tblAccountDim
Group By open_close_code, branch_id
GO
/****** Object:  Table [dbo].[tblBranchLocationsDim]    Script Date: 12/9/2020 6:30:28 PM ******/
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
/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 12/9/2020 6:30:28 PM ******/
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
/****** Object:  View [dbo].[v_CustomerperRegion]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[v_CustomerperRegion] AS
SELECT b.acct_region_id as 'Region Code'
, COUNT(c.cust_id) as 'Customer per Region'
FROM dbo.tblCustomerDim as c
INNER JOIN dbo.tblBranchLocationsDim as b ON b.branch_id = c.pri_branch_id
GROUP BY b.acct_region_id;
GO
/****** Object:  View [dbo].[v_CustomerperArea]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[v_CustomerperArea] AS
SELECT b.acct_area_id as 'Area Code'
, COUNT(c.cust_id) as 'Customer per Area'
FROM dbo.tblCustomerDim as c
INNER JOIN dbo.tblBranchLocationsDim as b ON b.branch_id = c.pri_branch_id
GROUP BY b.acct_area_id;
GO
/****** Object:  Table [dbo].[tblAddressDim]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAddressDim](
	[cust_add_id] [int] NOT NULL,
	[cust_add_lat] [decimal](16, 12) NOT NULL,
	[cust_add_lon] [decimal](16, 12) NOT NULL,
	[cust_add_type] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tblAddressDim] PRIMARY KEY CLUSTERED 
(
	[cust_add_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAreaDim]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAreaDim](
	[acct_area_id] [int] NOT NULL,
	[area_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblAreaDim] PRIMARY KEY CLUSTERED 
(
	[acct_area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerAccountDim]    Script Date: 12/9/2020 6:30:28 PM ******/
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
/****** Object:  Table [dbo].[tblCustomerRoleDim]    Script Date: 12/9/2020 6:30:28 PM ******/
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
/****** Object:  Table [dbo].[tblProductDim]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductDim](
	[prod_id] [smallint] NOT NULL,
	[prod_name] [varchar](50) NULL,
 CONSTRAINT [PK_tblProductDim] PRIMARY KEY CLUSTERED 
(
	[prod_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRegionDim]    Script Date: 12/9/2020 6:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRegionDim](
	[acct_region_id] [int] NOT NULL,
	[acc_region_name] [varchar](50) NULL,
 CONSTRAINT [PK_tblRegionDim] PRIMARY KEY CLUSTERED 
(
	[acct_region_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountDim_tblBranchLocationsDim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tblBranchLocationsDim] ([branch_id])
GO
ALTER TABLE [dbo].[tblAccountDim] CHECK CONSTRAINT [FK_tblAccountDim_tblBranchLocationsDim]
GO
ALTER TABLE [dbo].[tblAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountDim_tblCustomerDim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tblCustomerDim] ([cust_id])
GO
ALTER TABLE [dbo].[tblAccountDim] CHECK CONSTRAINT [FK_tblAccountDim_tblCustomerDim]
GO
ALTER TABLE [dbo].[tblAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountDim_tblProductDim] FOREIGN KEY([prod_id])
REFERENCES [dbo].[tblProductDim] ([prod_id])
GO
ALTER TABLE [dbo].[tblAccountDim] CHECK CONSTRAINT [FK_tblAccountDim_tblProductDim]
GO
ALTER TABLE [dbo].[tblAccountFact]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountFact_tblAccountDim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tblAccountDim] ([acct_id])
GO
ALTER TABLE [dbo].[tblAccountFact] CHECK CONSTRAINT [FK_tblAccountFact_tblAccountDim]
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
ALTER TABLE [dbo].[tblCustomerDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDim_tblBranchLocationsDim] FOREIGN KEY([pri_branch_id])
REFERENCES [dbo].[tblBranchLocationsDim] ([branch_id])
GO
ALTER TABLE [dbo].[tblCustomerDim] CHECK CONSTRAINT [FK_tblCustomerDim_tblBranchLocationsDim]
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
