USE [DFNB2]
GO

/****** Object:  View [dbo].[v_AccountCurBal]    Script Date: 12/9/2020 6:23:53 PM ******/
DROP VIEW [dbo].[v_AccountCurBal]
GO

/****** Object:  View [dbo].[v_AccountCurBal]    Script Date: 12/9/2020 6:23:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_AccountCurBal] AS
SELECT YEAR(as_of_date) as 'As of'
, SUM(cur_bal) as 'Balance'
FROM dbo.tblAccountFact
WHERE YEAR(as_of_date) >= 2016 and YEAR(as_of_date) <= 2019
GROUP BY YEAR(as_of_date)
GO


