/*****************************************************************************************************************
NAME:    dbo.v_TopBranchByLoan
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created view dbo.v_TopBranchByLoan

RUNTIME: 
Approx. 1 min
NOTES: Saving the data on how the views were created to help on the vizualization of data.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_TopBranchByLoan]    Script Date: 12/12/2020 12:50:43 AM ******/
DROP VIEW [dbo].[v_TopBranchByLoan]
GO

/****** Object:  View [dbo].[v_TopBranchByLoan]    Script Date: 12/12/2020 12:50:43 AM ******/
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


