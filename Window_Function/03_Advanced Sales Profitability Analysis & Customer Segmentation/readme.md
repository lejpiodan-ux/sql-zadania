# English

# Title
  Advanced Sales Profitability Analysis & Customer Segmentation



# Description

This query provides an end-to-end sales and logistics audit. 

List of tasks realized in this query

* 1. Unique Order List: Extract orders with three custom date columns: Full Year, Month Name, and Month Half (Day 1-15: "First Half", 16+: "Second Half").
* 2. Missing ShipDate Handling: If the ship date is null, assume shipping occurred 7 days after the order date.
* 3. Lead Time Calculation: Calculate the number of days between the order date and the shipping date.
* 4. Delivery Performance: Categorize lead time: ≤ 2 days as "Fast", 3-5 days as "Standard", and > 5 days as "Delayed".
* 5. Freight Ratio: Calculate the ratio of Freight to TotalDue as a percentage, rounded to two decimal places.
* 6. Monthly Customer Ranking: Within each year and month, rank customers (starting from 1) based on their total SubTotal spending for that specific month.
* 7. Sales Stability: For each order, display the value (SubTotal) of the customer's previous order (chronologically).
* 8. Cumulative Territorial Sales: Calculate a running total of SubTotal for each territory, resetting the sum at the beginning of each year.
* 9. Whale Segmentation (N-tile): Divide all orders into 10 equal groups based on TotalDue to identify the top 10% ("Whales").
* 10. Final Filtering: Retain only records where the Freight ratio is greater than 2% and the delivery status is NOT "Fast".

# Techniques used in this query:
#### - CTE'S 
  Each CTE represents a transformation stage:
  * Data cleaning and preprocessing
  * Business rule classification
  * Customer-level enrichment
  * Monthly aggregation
  * Ranking
  * Territorial running totals
  
  
#### - COALESCE
  If shipdate is missing, it is replaced with orderdate + 7 days
  This ensures shipping delay analysis remains consistent.
  Prevents null-based calculation errors. It improves data quality and analytical reliability

#### - INTERVAL
  Example use case:
  Estimating expected shipping date (orderdate + interval '7 days').
  Calculating delivery time differences.
  This allows time-based performance analysis (delivery speed classification).
  
#### - TO_CHART
  In this query it is used to Extract month names
  
#### - CASE

 * Delivery performance classification
   
    Fast (≤ 2 days)
    Standard (3–5 days)
    Delayed (> 5 days)

* Half-month segmentation

    First half
    Second half
  
#### - ::DATE (DATA TYPE FORMATING)

  In this query, it is used to:
  Remove the time component from orderdate and shipdate

# Used Window functions:

#### - LAG

 * Retrieves the previous order value per customer
 * Enables historical trend analysis
 * Allows comparison between current and previous purchase behavior
  
#### - SUM (OVER)
  Used for:
 * Monthly customer spending
 * Territory-level yearly running revenue totals
  
#### - DENSE_RANK

  Ranks customers based on monthly spending.
  Used for:Identifying top-performing customers per month.

  * No gaps in ranking numbers

  * Customers with equal spending share the same rank


  
#### - NTILE

  Groups whole query to 10 groups 
  Customers are segmented by total order value

# Result 
The query calculates order values and evaluates delivery performance by handling missing shipping data and categorizing lead times. It tracks customer loyalty by comparing current purchases with their transaction history and creates monthly performance rankings. Finally, the analysis includes a territorial growth report through running totals and segments the entire dataset to identify the highest-value orders for strategic business review.

##### Used sql language: Postgres
##### Used database: Adventureworks2017
##### Used application: Dbeaver
##### Author: Piotr Leja
As a part of Junior Data Analyst Portfolio
  
