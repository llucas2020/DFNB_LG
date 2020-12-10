/*****************************************************************************************************************
NAME:    dbo.v_CustomerperRegion
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created view dbo.v_CustomerperRegion

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

/****** Object:  View [dbo].[v_CustomerperRegion]    Script Date: 12/9/2020 6:25:32 PM ******/
DROP VIEW [dbo].[v_CustomerperRegion]
GO

/****** Object:  View [dbo].[v_CustomerperRegion]    Script Date: 12/9/2020 6:25:32 PM ******/
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


