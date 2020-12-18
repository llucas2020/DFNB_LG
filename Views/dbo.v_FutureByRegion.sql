/*****************************************************************************************************************
NAME:    dbo.v_FutureByRegion
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     12/17/2020   LLUCAS2020      1. Created view dbo.v_FutureByRegion
2.0     12/17/2020   LLUCAS2020      2. Added Version 2 enhancements for LDSBC IT 240 - Project 3.6: DFNB - Predict and Prescribe Future Performance

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

/****** Object:  View [dbo].[v_FutureByRegion]    Script Date: 12/17/2020 11:56:47 PM ******/
DROP VIEW [dbo].[v_FutureByRegion]
GO

/****** Object:  View [dbo].[v_FutureByRegion]    Script Date: 12/17/2020 11:56:47 PM ******/
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


