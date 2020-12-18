/*****************************************************************************************************************
NAME:    DFNB2.sql
PURPOSE: Create Schema of DFNB2 with the Data created.
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created Schema for class Ensign IT 240
2.0     12/13/2020   LLUCAS2020      2. Added Version 2 enhancements for LDSBC IT 240 - Project 1.6: DFNB - Analyze History
3.0     12/14/2020   LLUCAS2020      3. Added enhancements for LDSBC IT 240 - Project 2.4: DFNB - Evaluate Current Performance - Create v1 of Script Repository
4.0     12/16/2020   LLUCAS2020      4. Added enhancements for LDSBC IT 240 - Project 2.5: DFNB - Evaluate Current Performance - Data analysis views
5.0     12/16/2020   LLUCAS2020      5. Added enhancements for LDSBC IT 240 - Project 3.4: DFNB - Predict and Prescribe Future Performance - Create v1 of Script Repository
6.0     12/16/2020   LLUCAS2020      6. Added Version 2 enhancements for LDSBC IT 240 - Project 3.6: DFNB - Predict and Prescribe Future Performance

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
/****** Object:  Table [dbo].[tblAccountDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  Table [dbo].[tblBranchLocationsDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_FutureByRegion]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_FutureByRegion] AS (
 SELECT b.acct_region_id AS 'Region ID'
     , YEAR(a.open_date) AS 'Year'
     , SUM(a.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS a
       JOIN
       dbo.tblBranchLocationsDim AS b ON a.branch_id = b.branch_id
 WHERE YEAR(a.open_date) IN
                            (
                             2017
                           , 2018
                           , 2019
                            )
 GROUP BY b.acct_region_id
        , YEAR(a.open_date));
GO
/****** Object:  View [dbo].[v_FutureByBranch]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_FutureByBranch] AS (
SELECT a.branch_id AS 'Branch ID'
     , b.acct_branch_desc AS 'Branch Name'
     , YEAR(a.open_date) AS 'Year'
     , SUM(a.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS a
       JOIN
       dbo.tblBranchLocationsDim AS b ON a.branch_id = b.branch_id
 WHERE YEAR(a.open_date) IN
                            (
                             2017
                           , 2018
                           , 2019
                            )
 GROUP BY a.branch_id
        , b.acct_branch_desc
        , YEAR(a.open_date))
GO
/****** Object:  View [dbo].[v_FutureByArea]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_FutureByArea] AS (
SELECT b.acct_area_id AS 'Area ID'
, YEAR(a.open_date) AS 'Year'
, SUM(a.loan_amt) AS 'Total Loan Amount'
FROM dbo.tblAccountDim AS a
JOIN
dbo.tblBranchLocationsDim AS b ON a.branch_id = b.branch_id
WHERE YEAR(a.open_date) IN
            (
             2017
             , 2018
           , 2019
         )
GROUP BY b.acct_area_id
, YEAR(a.open_date))
GO
/****** Object:  View [dbo].[v_AccountLoan]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_AccountDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  Table [dbo].[tblAccountFact]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_AccountCurBal]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_OpenCloseCode]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_CustomerperRegion]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_CustomerperArea]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_TopBranchPerCust]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[v_TopBranchPerCust] as
Select branch_id as Branch
, count(acct_id) as Account
from tblaccountdim
Group by branch_id
GO
/****** Object:  View [dbo].[v_TopOldestCust]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[v_TopOldestCust] as
select cust_id
, last_name + ', ' +  first_name as 'Full Name'
, gender
, cust_since_date
from tblcustomerdim
GO
/****** Object:  View [dbo].[v_TopOldestCustMale]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[v_TopOldestCustMale] as
select cust_id
, last_name + ', ' +  first_name as 'Full Name'
, gender
, cust_since_date
from tblcustomerdim
where gender = 'm'
GO
/****** Object:  View [dbo].[v_TopBranchByLoan]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[v_TopBranchByLoan] as
select branch_id
, sum(loan_amt) as 'Loan Amount'
from tblaccountdim
group by branch_id
GO
/****** Object:  View [dbo].[v_TopOldestCustAge]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[v_TopOldestCustAge] as
select cust_id
, last_name + ', ' +  first_name as 'Full Name'
, gender
, birth_date
from tblcustomerdim
GO
/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_TotalFeeAmount]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TotalFeeAmount] AS
SELECT b.acct_branch_desc As 'Branch'
, SUM(tran_fee_amt) As 'Total Fee Amount'
FROM tblBranchLocationsDim As b
INNER JOIN tblTransactionFact as t ON b.branch_id = t.branch_id
GROUP BY b.acct_branch_desc;
GO
/****** Object:  View [dbo].[v_TotalTransactions]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TotalTransactions] AS
SELECT b.acct_branch_desc As 'Branch'
, COUNT(tran_fee_amt) As 'Total Transactions'
FROM tblBranchLocationsDim As b
INNER JOIN tblTransactionFact as t ON b.branch_id = t.branch_id
GROUP BY b.acct_branch_desc;
GO
/****** Object:  Table [dbo].[tblTransactionTypeDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  View [dbo].[v_TransactionType]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TransactionType] AS
SELECT tt.tran_type_desc As 'Transaction Type'
, SUM(t.tran_type_id) As 'Total Transactions'
FROM tblTransactionTypeDim As tt
INNER JOIN tblTransactionFact as t ON tt.tran_type_id = t.tran_type_id 
GROUP BY tt.tran_type_desc;
GO
/****** Object:  View [dbo].[v_TransactionFees]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TransactionFees] AS
SELECT tt.tran_type_desc As 'Transaction Type'
, SUM(tt.tran_fee_prct) As 'Total Transactions'
FROM tblTransactionTypeDim As tt
INNER JOIN tblTransactionFact as t ON tt.tran_type_id = t.tran_type_id 
GROUP BY tt.tran_type_desc;
GO
/****** Object:  View [dbo].[v_TransactionCustomer]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TransactionCustomer] AS
SELECT TOP 10 c.last_name + ', ' + c.first_name AS 'Full Name'
, COUNT(t.tran_date) AS 'Total Transactions'
FROM dbo.tblTransactionFact AS t
JOIN dbo.tblAccountDim AS a ON t.acct_id = a.acct_id
JOIN dbo.tblCustomerDim AS c ON a.cust_id = c.cust_id
JOIN dbo.tblBranchLocationsDim AS b ON a.branch_id = b.branch_id
GROUP BY c.last_name + ', ' + c.first_name
ORDER BY COUNT(t.tran_date) DESC;
GO
/****** Object:  View [dbo].[v_TransactionYear]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TransactionYear] AS
SELECT b.acct_branch_desc AS 'Branch'
, tt.tran_type_desc As 'Transaction Type'
, COUNT(t.tran_date) AS 'Total Transactions'
, YEAR(t.tran_date) AS 'Year'
FROM dbo.tblTransactionFact AS t
JOIN dbo.tblBranchLocationsDim AS b ON b.branch_id = t.branch_id
JOIN dbo.tblTransactionTypeDim AS tt ON t.tran_type_id = tt.tran_type_id
GROUP BY b.acct_branch_desc
, tt.tran_type_desc
, YEAR(t.tran_date)
GO
/****** Object:  Table [dbo].[tblAddressDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  Table [dbo].[tblAreaDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  Table [dbo].[tblBranchGoal]    Script Date: 12/18/2020 12:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBranchGoal](
	[branch_goal_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[acct_branch_desc] [varchar](100) NOT NULL,
	[goal_amt] [decimal](20, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[branch_goal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerAccountDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  Table [dbo].[tblCustomerRoleDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  Table [dbo].[tblProductDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
/****** Object:  Table [dbo].[tblRegionDim]    Script Date: 12/18/2020 12:03:34 AM ******/
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
