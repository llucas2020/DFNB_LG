/*****************************************************************************************************************
NAME:    dbo.v_TransactionType
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     12/16/2020   LLUCAS2020      1. Created view dbo.v_TransactionType

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

/****** Object:  View [dbo].[v_TransactionType]    Script Date: 12/16/2020 2:45:12 PM ******/
DROP VIEW [dbo].[v_TransactionType]
GO

/****** Object:  View [dbo].[v_TransactionType]    Script Date: 12/16/2020 2:45:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_TransactionType] AS
SELECT tt.tran_type_desc As 'Transaction Type'
, SUM(t.tran_type_id) As 'Total Transactions'
FROM tblTransactionTypeDim As tt
INNER JOIN tblTransactionFact as t ON tt.tran_type_id = t.tran_type_id 
GROUP BY tt.tran_type_desc;
GO


