/*****************************************************************************************************************
NAME:    dbo.v_TopOldestCustMale
PURPOSE: Process for the creation of the views
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created view dbo.v_TopOldestCustMale

RUNTIME: 
Approx. 1 min
NOTES: Saving the data on how the views were created to help on the vizualization of data.

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_TopOldestCustMale]    Script Date: 12/12/2020 12:55:04 AM ******/
DROP VIEW [dbo].[v_TopOldestCustMale]
GO

/****** Object:  View [dbo].[v_TopOldestCustMale]    Script Date: 12/12/2020 12:55:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view  [dbo].[v_TopOldestCustMale] as
select cust_id
, last_name + ', ' +  first_name as 'Full Name'
, gender
, cust_since_date
from tblcustomerdim
where gender = 'm'
GO


