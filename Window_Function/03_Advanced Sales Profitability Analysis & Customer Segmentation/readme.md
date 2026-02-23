1.Unique Order List: Extract orders with three custom date columns: Full Year, Month Name, and Month Half (Day 1-15: "First Half", 16+: "Second Half").
2.Missing ShipDate Handling: If the ship date is null, assume shipping occurred 7 days after the order date.
3.Lead Time Calculation: Calculate the number of days between the order date and the shipping date.
4.Delivery Performance: Categorize lead time: ≤ 2 days as "Fast", 3-5 days as "Standard", and > 5 days as "Delayed".
5.Freight Ratio: Calculate the ratio of Freight to TotalDue as a percentage, rounded to two decimal places.
6.Monthly Customer Ranking: Within each year and month, rank customers (starting from 1) based on their total SubTotal spending for that specific month.
7.Sales Stability: For each order, display the value (SubTotal) of the customer's previous order (chronologically).
8.Cumulative Territorial Sales: Calculate a running total of SubTotal for each territory, resetting the sum at the beginning of each year.
9.Whale Segmentation (N-tile): Divide all orders into 10 equal groups based on TotalDue to identify the top 10% ("Whales").
10.Final Filtering: Retain only records where the Freight ratio is greater than 2% and the delivery status is NOT "Fast".

Techniques used in this query:
*CTE'S
*COALESCE
*INTERVAL
*TO_CHART
*CASE
*::DATE (DATA TYPE FORMATING)

Used Window functions:

*LAG
*SUM
*DENSE_RANK
*NTILE
