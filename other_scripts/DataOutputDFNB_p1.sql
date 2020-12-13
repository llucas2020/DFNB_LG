/*****************************************************************************************************************
NAME:    DataOutputDFNB_p1.sql
PURPOSE: Create Schema of output.
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created Schema for class Ensign IT 240
2.0     12/13/2020   LLUCAS2020      2. Added Version 2 enhancements for LDSBC IT 240 - Project 1.6: DFNB - Analyze History

RUNTIME: 
Approx. 1 min
NOTES: This shows all Views on the Database to help create vizualization.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO
/****** Object:  View [dbo].[v_AccountCurBal]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_AccountDim]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_AccountLoan]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_CustomerperArea]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_CustomerperRegion]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_OpenCloseCode]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_TopBranchByLoan]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_TopBranchPerCust]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_TopOldestCust]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_TopOldestCustAge]    Script Date: 12/13/2020 12:27:24 PM ******/
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
/****** Object:  View [dbo].[v_TopOldestCustMale]    Script Date: 12/13/2020 12:27:24 PM ******/
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
