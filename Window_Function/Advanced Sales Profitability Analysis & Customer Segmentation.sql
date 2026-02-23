-- STEP 1: Data cleaning, date formatting, and shipping cost ratio calculation
with dat as 
(
	select
		salesorderid,
		totaldue,
		orderdate:: date as date,
		coalesce(shipdate::date,(orderdate+interval '7 days'):: date) as shipdate,
		coalesce(shipdate::date,(orderdate+interval '7 days'):: date) - orderdate:: date as difference_days,
		date_part('year',orderdate)as year,
		to_char(orderdate,'Month')as month,
		case 
				when date_part('day',orderdate) > 16 then  'Second half'
				else 'First half'
		end as "Half of the month",
		round(freight/totaldue *100 ,2) as ratio,
		territoryid 
	from sales.salesorderheader  
) ,
-- STEP 2: Delivery performance classification (Fast, Standard, Delayed)
next as 
(
	select
		*,
		case
			when difference_days <= 2 then 'Fast'
			when difference_days between 3 and 5 then 'Standard'
			else 'Delayed'
		end as flagstatus
		
	from dat 
) , 
-- STEP 3: Customer data joining and historical trend analysis (Previous Order Value)
 fre as 
(
  	select
  		n.*,
  		case 
  			when p.middlename is null then concat(p.firstname,' ',p.lastname) 
  			else concat(p.firstname,' ',p.middlename,' ',p.lastname)
  		end as customer_name,
  		p.businessentityid,
  		soh.subtotal,
  		lag(soh.subtotal) over (partition by p.businessentityid order by n.date) as prev_ord_for_same_customer
 	from sales.salesorderheader soh
 	left join sales.customer c 
 		on c.customerid = soh.customerid 
 	left join person.person p 
  		on p.businessentityid = c.personid
  	left join next n
  		on n.salesorderid = soh.salesorderid
),
-- STEP 4: Monthly aggregation of sales per customer
 win as
(
	 select  
		*,
		concat(year,' ',month) as ym,
		sum(subtotal)over (partition by businessentityid,concat(year,' ',month)  ) as total_sum_each_customer_monthly
 	from fre
	
), 
-- STEP 5: Customer ranking based on monthly spending
 ran as
(
 	select 
 		*,
 		dense_rank ()over (partition by ym order by total_sum_each_customer_monthly desc)as customerrank
 	from win
),
-- STEP 6: Territorial analysis and yearly running total calculation
 teri as
(
 	select
 		r.*,
 		concat(st."Name",' - ',st.countryregioncode) as territory,
 		sum(subtotal)over (partition by year, r.territoryid order by date, salesorderid) as subtotal_running_total_for_territory
 	from ran r
 	join sales.salesterritory st 
		on r.territoryid = st.territoryid
 )
-- FINAL OUTPUT: Global segmentation (NTILE) and business rule filtering
 	select 
 		*,
 		ntile(10) over ( order by totaldue desc) as "Biggest_whales"
 	from teri
 	where ratio >2 and flagstatus!='Fast'
 	limit 1000
