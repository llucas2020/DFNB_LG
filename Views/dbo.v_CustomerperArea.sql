USE [DFNB2]
GO

/****** Object:  View [dbo].[v_CustomerperArea]    Script Date: 12/9/2020 6:25:16 PM ******/
DROP VIEW [dbo].[v_CustomerperArea]
GO

/****** Object:  View [dbo].[v_CustomerperArea]    Script Date: 12/9/2020 6:25:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[v_CustomerperArea] AS
SELECT b.acct_area_id as 'Area Code'
, COUNT(c.cust_id) as 'Customer per Area'
FROM dbo.tblCustomerDim as c
INNER JOIN dbo.tblBranchLocationsDim as b ON b.branch_id = c.pri_branch_id
GROUP BY b.acct_area_id;
GO


