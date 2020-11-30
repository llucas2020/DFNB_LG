/*****************************************************************************************************************
NAME:    DFNB2.sql
PURPOSE: Create Schema of DFNB2 with the Data created.
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/30/2020   LLUCAS2020      1. Created Schema for class Ensign IT 240

RUNTIME: 
Approx. 1 min
NOTES: This shows all tables on the Database

These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO
/****** Object:  Table [dbo].[tlb_Account_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Account_Dim](
	[acct_id] [int] NOT NULL,
	[cust_id] [smallint] NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[prod_id] [smallint] NOT NULL,
	[open_date] [date] NOT NULL,
	[close_date] [date] NOT NULL,
	[open_close_code] [varchar](1) NOT NULL,
	[loan_amt] [decimal](20, 4) NOT NULL,
 CONSTRAINT [PK_tlb_Account_Dim] PRIMARY KEY CLUSTERED 
(
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Account_Fact_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Account_Fact_Dim](
	[acct_id] [int] NOT NULL,
	[cur_bal] [decimal](20, 4) NOT NULL,
	[as_of_date] [date] NOT NULL,
 CONSTRAINT [PK_tlb_Account_Fact_Dim] PRIMARY KEY CLUSTERED 
(
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Address_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Address_Dim](
	[cust_add_id] [int] NOT NULL,
	[cust_add_lat] [decimal](16, 12) NOT NULL,
	[cust_add_lon] [decimal](16, 12) NOT NULL,
	[cust_add_type] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tlb_Address_Dim] PRIMARY KEY CLUSTERED 
(
	[cust_add_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Area_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Area_Dim](
	[acct_area_id] [int] NOT NULL,
	[acc_area_name] [varchar](50) NULL,
 CONSTRAINT [PK_tlb_Area_Dim] PRIMARY KEY CLUSTERED 
(
	[acct_area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Branch_Locations_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Branch_Locations_Dim](
	[branch_id] [smallint] NOT NULL,
	[acct_branch_add_id] [int] NOT NULL,
	[acct_area_id] [int] NOT NULL,
	[acct_region_id] [int] NOT NULL,
	[acct_branch_code] [varchar](5) NOT NULL,
	[acct_branch_desc] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tlb_Branch_Locations_Dim] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Customer_Account_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Customer_Account_Dim](
	[acct_id2] [int] NOT NULL,
	[acct_id] [int] NOT NULL,
	[cust_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tlb_Customer_Account_Dim] PRIMARY KEY CLUSTERED 
(
	[acct_id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Customer_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Customer_Dim](
	[cust_id] [smallint] NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[birth_date] [date] NOT NULL,
	[cust_since_date] [date] NOT NULL,
	[pri_branch_id] [smallint] NOT NULL,
	[gender] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tlb_Customer_Dim] PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Customer_Role_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Customer_Role_Dim](
	[acct_cust_role_id] [smallint] NOT NULL,
	[acc_cust_role_name] [varchar](50) NULL,
 CONSTRAINT [PK_tlb_Customer_Role_Dim] PRIMARY KEY CLUSTERED 
(
	[acct_cust_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Product_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Product_Dim](
	[prod_id] [smallint] NOT NULL,
	[prod_name] [varchar](50) NULL,
 CONSTRAINT [PK_tlb_Product_Dim] PRIMARY KEY CLUSTERED 
(
	[prod_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Region_Dim]    Script Date: 11/30/2020 3:36:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Region_Dim](
	[acct_region_id] [int] NOT NULL,
	[acc_region_name] [varchar](50) NULL,
 CONSTRAINT [PK_tlb_Region_Dim] PRIMARY KEY CLUSTERED 
(
	[acct_region_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tlb_Account_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Account_Dim_tlb_Branch_Locations_Dim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tlb_Branch_Locations_Dim] ([branch_id])
GO
ALTER TABLE [dbo].[tlb_Account_Dim] CHECK CONSTRAINT [FK_tlb_Account_Dim_tlb_Branch_Locations_Dim]
GO
ALTER TABLE [dbo].[tlb_Account_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Account_Dim_tlb_Customer_Dim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tlb_Customer_Dim] ([cust_id])
GO
ALTER TABLE [dbo].[tlb_Account_Dim] CHECK CONSTRAINT [FK_tlb_Account_Dim_tlb_Customer_Dim]
GO
ALTER TABLE [dbo].[tlb_Account_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Account_Dim_tlb_Product_Dim] FOREIGN KEY([prod_id])
REFERENCES [dbo].[tlb_Product_Dim] ([prod_id])
GO
ALTER TABLE [dbo].[tlb_Account_Dim] CHECK CONSTRAINT [FK_tlb_Account_Dim_tlb_Product_Dim]
GO
ALTER TABLE [dbo].[tlb_Branch_Locations_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Branch_Locations_Dim_tlb_Area_Dim] FOREIGN KEY([acct_area_id])
REFERENCES [dbo].[tlb_Area_Dim] ([acct_area_id])
GO
ALTER TABLE [dbo].[tlb_Branch_Locations_Dim] CHECK CONSTRAINT [FK_tlb_Branch_Locations_Dim_tlb_Area_Dim]
GO
ALTER TABLE [dbo].[tlb_Branch_Locations_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Branch_Locations_Dim_tlb_Branch_Locations_Dim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tlb_Branch_Locations_Dim] ([branch_id])
GO
ALTER TABLE [dbo].[tlb_Branch_Locations_Dim] CHECK CONSTRAINT [FK_tlb_Branch_Locations_Dim_tlb_Branch_Locations_Dim]
GO
ALTER TABLE [dbo].[tlb_Branch_Locations_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Branch_Locations_Dim_tlb_Region_Dim] FOREIGN KEY([acct_region_id])
REFERENCES [dbo].[tlb_Region_Dim] ([acct_region_id])
GO
ALTER TABLE [dbo].[tlb_Branch_Locations_Dim] CHECK CONSTRAINT [FK_tlb_Branch_Locations_Dim_tlb_Region_Dim]
GO
ALTER TABLE [dbo].[tlb_Customer_Account_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Customer_Account_Dim_tlb_Account_Dim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tlb_Account_Dim] ([acct_id])
GO
ALTER TABLE [dbo].[tlb_Customer_Account_Dim] CHECK CONSTRAINT [FK_tlb_Customer_Account_Dim_tlb_Account_Dim]
GO
ALTER TABLE [dbo].[tlb_Customer_Account_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Customer_Account_Dim_tlb_Customer_Dim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tlb_Customer_Dim] ([cust_id])
GO
ALTER TABLE [dbo].[tlb_Customer_Account_Dim] CHECK CONSTRAINT [FK_tlb_Customer_Account_Dim_tlb_Customer_Dim]
GO
ALTER TABLE [dbo].[tlb_Customer_Dim]  WITH CHECK ADD  CONSTRAINT [FK_tlb_Customer_Dim_tlb_Branch_Locations_Dim] FOREIGN KEY([pri_branch_id])
REFERENCES [dbo].[tlb_Branch_Locations_Dim] ([branch_id])
GO
ALTER TABLE [dbo].[tlb_Customer_Dim] CHECK CONSTRAINT [FK_tlb_Customer_Dim_tlb_Branch_Locations_Dim]
GO
