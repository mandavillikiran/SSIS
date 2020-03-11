# SSIS
The following are considered to build the solution:

1. AdventureWorks2017 Database is considered.
From the following tables data is sourced
a. [Sales].[SalesOrderDetail]
b. [Production].[Product]
c. [Sales].[SalesOrderHeader]

Source Query: 
 Select 
 sum([UnitPrice]*OrderQty) as TotalSales,
 sum(OrderQty) OrderQty,datepart(yy,slot.[OrderDate]) [Year],
 ISNULL(prodtab.Color,'NoColor') [Color]
 from [Sales].[SalesOrderDetail] SLO 
      join [Production].[Product] ProdTab on SLO.ProductID=Prodtab.ProductID 
	  join [Sales].[SalesOrderHeader] SLOT on slo.SalesOrderid=slot.SalesOrderID
	  --join [Sales].[SalesTerritory] SLT on SLOT.TerritoryID = SLT.TerritoryID
  Group by datepart(yy,slot.[OrderDate]),prodtab.Color 
  order by year
  

2. Target table creation on AdventureWorksDW2017

CREATE TABLE [dbo].[FactSalesTable_NZD_Currency](
	[TotalSales] [decimal](25,2) NULL,
	[Year] [smallint] NULL,
	[Color] [nvarchar](25) NULL,
	[OrderQty] [decimal](25,2) NULL,
	[TotalSAlesByNewZealand] [decimal](25,2) NULL
) ON [PRIMARY]
GO

3. The exchange rate file is downloaded from https://exchangeratesapi.io/ and saved on local system
   Exchange Rate File : eurofxref.csv
4. The exchange file is read and the data is loaded into AdventureWorksDW2017.dbo.ExchangeRate table
   CREATE TABLE [dbo].[ExchangeRate](
	[NZD] [decimal](25, 2) NULL
    ) ON [PRIMARY]
5. The target table FactSalesTable_NZD_Currency will be loaded and the column TotalSAlesByNewZealand will be null.
6. The target table is then updated to populate TotalSAlesByNewZealand field.
     UPDATE [dbo].[FactSalesTable_NZD_Currency] 
  SET TotalSAlesByNewZealand=[OrderQty]*[dbo].[ExchangeRate].NZD 
  FROM [dbo].[ExchangeRate] 
  JOIN [FactSalesTable_NZD_Currency]
  ON 1=1
  
Here the exchange NZD currency exchange rate is 1.80 as of the date the file was downloaded.

Registration: If we can register to the exchange rate api, directly the exchange rates can be sourced from the url https://exchangeratesapi.io/

