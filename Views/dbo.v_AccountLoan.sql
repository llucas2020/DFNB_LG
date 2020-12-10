USE [DFNB2]
GO

/****** Object:  View [dbo].[v_AccountLoan]    Script Date: 12/9/2020 6:24:54 PM ******/
DROP VIEW [dbo].[v_AccountLoan]
GO

/****** Object:  View [dbo].[v_AccountLoan]    Script Date: 12/9/2020 6:24:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_AccountLoan] AS
SELECT YEAR(open_date) as 'Open Date Year'
, SUM(loan_amt) as 'Total Loan Amount'
FROM dbo.tblAccountDim
WHERE YEAR(open_date) >= 2016 and YEAR(open_date) <= 2019
GROUP BY YEAR(open_date)
GO


