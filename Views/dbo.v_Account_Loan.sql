/*****************************************************************************************************************
NAME:    dbo.v_Account_Loan
PURPOSE: Create View [dbo].[v_Account_Loan]
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created View [dbo].[v_Account_Loan]

RUNTIME: 
Approx. 1 min
NOTES: This view was creates in order to help us see which branches had the most closures of accounts.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_Account_Loan]    Script Date: 11/30/2020 4:16:52 PM ******/
DROP VIEW [dbo].[v_Account_Loan]
GO

/****** Object:  View [dbo].[v_Account_Loan]    Script Date: 11/30/2020 4:16:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_Account_Loan] AS
SELECT SUM(loan_amt) as 'Total Loan Amount'
FROM [dbo].[tlb_Account_Dim]
GO


