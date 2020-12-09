/*****************************************************************************************************************
NAME:    LoadDFNB_p1
PURPOSE: Process for the creation of the tables
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created all the tables necessary for the 'Analyze History' assigment for IT240

RUNTIME: 
Approx. 1 min
NOTES: Saving the data on how the tables were created.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/
-- create dbo.tblCustomerDim
--TRUNCATE TABLE dbo.tblCustomerDim;
--INSERT INTO dbo.tblCustomerDim

SELECT distinct sp.cust_id
, sp.first_name
, sp.last_name
, sp.birth_date
, sp.cust_since_date
, sp.pri_branch_id
, sp.gender
--INTO dbo.tblCustomerDim
FROM dbo.stg_p1 sp

-- create dbo.tblCustomerAccountDim
--TRUNCATE TABLE dbo.tblCustomerAccountDim
--INSERT INTO dbo.tblCustomerAccountDim

SELECT DISTINCT sp.acct_id2
, sp.acct_id
, sp.cust_id
--INTO dbo.tblCustomerAccountDim
FROM dbo.stg_p1 sp

--create dbo.tblAccountDim
--TRUNCATE TABLE dbo.tblAccountDim
--INSERT INTO dbo.tblAccountDim

SELECT DISTINCT sp.acct_id
, sp.cust_id
, sp.branch_id
, sp.prod_id
, sp.open_date
, sp.close_date
, sp.open_close_code
, sp.loan_amt
--INTO dbo.tblAccountDim
FROM dbo.stg_p1 sp


--create bo.tblAccountFact
--TRUNCATE TABLE dbo.tblAccountFact
--INSERT INTO dbo.tblAccountFact

SELECT DISTINCT sp.acct_id3
, sp.acct_id
, sp.cur_bal
, sp.as_of_date
--INTO dbo.tblAccountFact
FROM dbo.stg_p1 sp

-- create dbo.tblProductDim
--TRUNCATE TABLE dbo.tblProductDim
--INSERT INTO dbo.tblProductDim

SELECT DISTINCT sp.prod_id
--, sp.prod_name
FROM dbo.stg_p1 sp

-- create dbo.tblAddressDim
--TRUNCATE TABLE dbo.tblAddressDim
--INSERT INTO dbo.tblAddressDim

SELECT DISTINCT sp.cust_add_id
, sp.cust_add_lat
, sp.cust_add_lon
, sp.cust_add_type
--INTO dbo.tblAddressDim
FROM dbo.stg_p1 sp

-- create dbo.tblAreaDim
--TRUNCATE TABLE dbo.tblAreaDim
--INSERT INTO dbo.tblAreaDim

SELECT DISTINCT sp.acct_area_id
--,sp.area_name
--INTO dbo.tblAreaDim
FROM dbo.stg_p1 sp

-- create dbo.tblRegionDim
--TRUNCATE TABLE dbo.tblRegionDim
--INSERT INTO dbo.tblRegionDim

SELECT DISTINCT sp.acct_region_id
--, sp.region_name
FROM dbo.stg_p1 sp

-- create dbo.tblBranchLocationsDim
--TRUNCATE TABLE dbo.tblBranchLocationsDim
--INSERT INTO dbo.tblBranchLocationsDim

SELECT DISTINCT sp.branch_id
, sp.acct_branch_add_id
, sp.acct_area_id
, sp.acct_region_id
, sp.acct_branch_code
, sp.acct_branch_desc
--INTO dbo.tblBranchLocationsDim
FROM dbo.stg_p1 sp

-- create dbo.tblCustomerRoleDim
--TRUNCATE TABLE dbo.tblCustomerRoleDim
--INSERT INTO dbo.tblCustomerRoleDim

SELECT DISTINCT sp.acct_cust_role_id
, sp.acct_id
, sp.cust_id
--INTO dbo.tblCustomerRoleDim
FROM dbo.stg_p1 sp

