/*****************************************************************************************************************
NAME:    dbo.v_AccountLoan
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created view dbo.v_AccountLoan

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

/****** Object:  View [dbo].[v_AccountLoan]    Script Date: 12/9/2020 6:24:54 PM ******/
DROP VIEW [dbo].[v_AccountLoan]
GO

/****** Object:  View [dbo].[v_AccountLoan]    Script Date: 12/9/2020 6:24:54 PM ******/
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


