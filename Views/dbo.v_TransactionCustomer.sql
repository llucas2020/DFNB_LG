/*****************************************************************************************************************
NAME:    dbo.v_TransactionCustomer
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     12/16/2020   LLUCAS2020      1. Created view dbo.v_TransactionCustomer

RUNTIME: 
Approx. 1 min
NOTES: Saving the data on how the views were created.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_TransactionCustomer]    Script Date: 12/16/2020 2:46:54 PM ******/
DROP VIEW [dbo].[v_TransactionCustomer]
GO

/****** Object:  View [dbo].[v_TransactionCustomer]    Script Date: 12/16/2020 2:46:54 PM ******/
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


