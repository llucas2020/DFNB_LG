USE [DFNB2]
GO

/****** Object:  View [dbo].[v_OpenCloseCode]    Script Date: 12/9/2020 6:25:50 PM ******/
DROP VIEW [dbo].[v_OpenCloseCode]
GO

/****** Object:  View [dbo].[v_OpenCloseCode]    Script Date: 12/9/2020 6:25:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[v_OpenCloseCode] AS
SELECT count(branch_id) as 'Accounts'
, branch_id as 'Branch'
, open_close_code as 'Open/Closed'
from dbo.tblAccountDim
Group By open_close_code, branch_id
GO


