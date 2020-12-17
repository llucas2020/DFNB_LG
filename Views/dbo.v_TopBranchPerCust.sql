/*****************************************************************************************************************
NAME:    dbo.v_TopBranchPerCust
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created view dbo.v_TopBranchPerCust
2.0     12/17/2020   LLUCAS2020      2. Added Version 2 enhancements for LDSBC IT 240 - Project 2.6: DFNB - Evaluate Current Performance

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

/****** Object:  View [dbo].[v_TopBranchPerCust]    Script Date: 12/17/2020 3:48:21 PM ******/
DROP VIEW [dbo].[v_TopBranchPerCust]
GO

/****** Object:  View [dbo].[v_TopBranchPerCust]    Script Date: 12/17/2020 3:48:21 PM ******/
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


