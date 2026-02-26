use orders;
create table df_orders (
order_id int primary key,
order_date date, 
ship_mode varchar(20), 
segment varchar(20), 
country varchar(20),
city varchar(20), 
state varchar(20),  
postal_code  varchar(20),  
region  varchar(20),
 category  varchar(20), 
 sub_category  varchar(20), 
 product_id  varchar(50), 
 quantity  int, 
 discount_price  decimal(7,2),
 sale_price  decimal(7,2),  
 profit  decimal(7,2));
 select * 
 from df_orders;
 -- Find the 10 highest revenue generating products
 select 
 product_id,sum(sale_price) as sales
 from df_orders
 group by 
 product_id
 order by 
 sales desc 
 limit 10;
 -- Find the 10 lowest revenue generating products 
 select 
 product_id,sum(sale_price) as sales
 from df_orders
 group by 
 product_id
 order by 
 sales 
 limit 10;
 -- Show revenue sales of each category 
 select 
 category, sum(sale_price) as revenue_sales 
 from 
 df_orders
 group by 
 category;
 -- show revenue sales of each region 
select 
region, sum(sale_price) as sales 
 from 
 df_orders
 group by 
 region;
 -- find top 5 highest selling products in each region
with cte as (
select 
region, product_id , sum(sale_price) as sales 
from 
df_orders
group by 
region,product_id)
select * 
from (
select * 
, row_number() 
over(partition by region 
order by sales desc) 
as rn
from cte) A 
where rn <=5;
-- “First, I aggregate sales per product per region. 
-- Then I rank products within each region using a window function, and 
-- finally filter the top 5 per region.”
-- find month over month growth comparsion for 2022 and 2023 sales 
with cte as (
select 
year(order_date) as order_year, month(order_date) as order_month,
sum(sale_price) as sales 
from 
df_orders
group by 
year(order_date), 
month(order_date)
)
select order_month
, sum(case when order_year = 2022 then sales else 0 end) as sales_2022
, sum(case when order_year = 2023 then sales else 0 end) as sales_2023
from cte
group by 
order_month
order by 
order_month;
-- I first aggregate sales at a Year–Month level using a CTE. 
-- Then I pivot the data using conditional aggregation so that 2022 and 2023 sales appear as separate columns.
-- This enables straightforward Year-over-Year monthly comparison and can easily be extended to calculate growth percentages.
-- For each category which month had highest sales 
WITH cte AS (
    SELECT 
        category,
        YEAR(order_date) * 100 + MONTH(order_date) AS order_year_month,
        SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY 
        category,
        YEAR(order_date) * 100 + MONTH(order_date)
)

SELECT *
FROM (
    SELECT 
        category,
        order_year_month,
        sales,
        ROW_NUMBER() OVER (
            PARTITION BY category 
            ORDER BY sales DESC
        ) AS rn
    FROM cte
) ranked
WHERE rn = 1;
-- which sub category had highest growth by profit in 2023 compare to 2022 
WITH yearly_sales AS (
    SELECT 
        sub_category,
        YEAR(order_date) AS order_year,
        SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY 
        sub_category,
        YEAR(order_date)
),
sales_pivot AS (
    SELECT
        sub_category,
        SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
        SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
    FROM yearly_sales
    GROUP BY sub_category
)
SELECT
    sub_category,sales_2022,sales_2023,
    ROUND(((sales_2023 - sales_2022) * 100.0) / sales_2022, 2) AS growth_percentage
FROM sales_pivot
ORDER BY growth_percentage DESC limit 1;