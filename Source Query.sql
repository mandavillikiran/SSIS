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