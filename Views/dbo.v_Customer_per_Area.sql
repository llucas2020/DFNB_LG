/*****************************************************************************************************************
NAME:    dbo.v_Customer_per_Area
PURPOSE: Create View [dbo].[v_Customer_per_Area]
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created View [dbo].[v_Customer_per_Area]

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

/****** Object:  View [dbo].[v_Customer_per_Area]    Script Date: 11/30/2020 4:15:39 PM ******/
DROP VIEW [dbo].[v_Customer_per_Area]
GO

/****** Object:  View [dbo].[v_Customer_per_Area]    Script Date: 11/30/2020 4:15:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[v_Customer_per_Area] AS
SELECT b.acct_area_id
, COUNT(c.cust_id) as 'Customer per Area'
FROM dbo.tlb_Customer_Dim as c
INNER JOIN dbo.tlb_Branch_locations_Dim as b ON b.branch_id = c.pri_branch_id
GROUP BY b.acct_area_id;
GO


