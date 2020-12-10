USE [DFNB2]
GO

/****** Object:  View [dbo].[v_AccountDim]    Script Date: 12/9/2020 6:24:34 PM ******/
DROP VIEW [dbo].[v_AccountDim]
GO

/****** Object:  View [dbo].[v_AccountDim]    Script Date: 12/9/2020 6:24:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_AccountDim] AS
SELECT YEAR(open_date) as 'Open Date Year'
, count(acct_id) as 'Count of Accounts'
FROM dbo.tblAccountDim
WHERE YEAR(open_date) >= 2016 and YEAR(open_date) <= 2019
GROUP BY YEAR(open_date)
GO


