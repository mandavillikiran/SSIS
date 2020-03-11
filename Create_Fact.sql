drop table [dbo].[FactSalesTable_NZD_Currency]

/****** Object:  Table [dbo].[FactTablePordByColorAndYear1]    Script Date: 3/11/2020 4:52:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	CREATE TABLE [dbo].[FactSalesTable_NZD_Currency](
		[TotalSales] [decimal](25,2) NULL,
		[Year] [smallint] NULL,
		[Color] [nvarchar](25) NULL,
		[OrderQty] [decimal](25,2) NULL,
		[TotalSAlesByNewZealand] [decimal](25,2) NULL
	) ON [PRIMARY]
	GO


