/*****************************************************************************************************************
NAME:    dbo.v_TotalFeeAmount
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     12/16/2020   LLUCAS2020      1. Created view dbo.v_TotalFeeAmount

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

/****** Object:  View [dbo].[v_TotalFeeAmount]    Script Date: 12/16/2020 2:48:23 PM ******/
DROP VIEW [dbo].[v_TotalFeeAmount]
GO

/****** Object:  View [dbo].[v_TotalFeeAmount]    Script Date: 12/16/2020 2:48:23 PM ******/
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


