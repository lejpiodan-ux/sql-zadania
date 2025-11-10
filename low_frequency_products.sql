use north
go

select
	p.ProductName,
	c.ContactName,
	count(ord.orderid) as [Total orders]
from dbo.Products p
	inner join dbo.[Order Details] ord
		on p.ProductID = ord.ProductID
	inner join dbo.orders o
		on ord.OrderID = o.OrderID
	inner join dbo.Customers c
		on o.CustomerID = c.CustomerID
group by p.ProductName, c.ContactName
having count(ord.orderid) < (
	select AVG(sub.[Order count])
	from (
		select ProductID, COUNT(distinct OrderID)as [Order count]
		from dbo.[Order Details] 
		group by ProductID 
			) as sub
	)
order by count(ord.orderid) desc
offset 0 rows fetch next 100 rows only






