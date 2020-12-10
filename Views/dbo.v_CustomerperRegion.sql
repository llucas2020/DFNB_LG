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


