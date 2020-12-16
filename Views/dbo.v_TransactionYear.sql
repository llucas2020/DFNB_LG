/*****************************************************************************************************************
NAME:    dbo.v_TransactionYear
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     12/16/2020   LLUCAS2020      1. Created view dbo.v_TransactionYear

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

/****** Object:  View [dbo].[v_TransactionYear]    Script Date: 12/16/2020 2:44:06 PM ******/
DROP VIEW [dbo].[v_TransactionYear]
GO

/****** Object:  View [dbo].[v_TransactionYear]    Script Date: 12/16/2020 2:44:06 PM ******/
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


