use north
go
select 
	c.CategoryName,
	avg(p.unitprice) as [Average product price],
	case 
		when avg(p.unitprice) >50 then 'Expensive'
		when avg(p.unitprice) >30 then 'Normal'
		else 'Cheap'
		end as [Product price status],
	CAST(GETDATE() AS date) as [current date]

from dbo.Products p
	join dbo.Categories c
		on c.CategoryID = p.CategoryID
group by c.CategoryName
having avg(p.unitprice) > (
	select AVG(UnitPrice)
	from dbo.Products
)
order by 2 desc
