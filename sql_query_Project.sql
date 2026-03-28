create database sql_project_p2;



create table retail_sales
(
transaction_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(11),
age int,
category varchar(15),
quantity int,
price_per_unit float,
cogs float,
total_sales float
);



select count(*) as total_sales from retail_sales



select* from retail_sales
where
transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity  is null
or
price_per_unit  is null
or
cogs  is null
or
total_sales  is null



delete from retail_sales
where
transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity  is null
or
price_per_unit  is null
or
cogs  is null
or
total_sales  is null


--data exploration


-- HOW MANY UNIQUE CUSTOMERS DO WE HAVE
select count (distinct customer_id)
 from retail_sales


--HOW MANY SALES WE HAVE
select count (*) total_sales
 from retail_sales


--DATA ANALYSIS OR KEY BUSINESS PROBLEMS & ANSWERS

 1. Retrieve all columns for sales made on '2022-11-05'
 2. Write a SQL query to retrieve all transactions where the category
 3. Calculate total sales for each category
 4. Find average age of customers who purchased from 'Beauty' category
 5. Find all transactions where total_sales > 1000
 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 7. Calculate average sale per month and find best selling month in each year
 8. Write a SQL query to find the top 5 customers based on the highest total sales
 9. Write a SQL query to find the number of unique customers who purchased items from each category
10. Write a SQL query to create each shift and number of orders (Example: Morning <12, Afternoon Between 12 & 17, Evening >17)



 1. --Retrieve all columns for sales made on '2022-11-05'

 SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
 


 2. --Write a SQL query to retrieve all transactions where the category

 SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity >= 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';



 3. --Calculate total sales for each category

 SELECT category, SUM(total_sales) AS net_sales,
count(*) as total_sales
FROM retail_sales
GROUP BY category;



 4. --Find average age of customers who purchased from 'Beauty' category

 select  round(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty'



 5. --Find all transactions where total_sales > 1000

 select * from retail_sales
where total_sales > 1000



 6. --Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category, gender, count(*) as total_transc
from retail_sales
group by category, gender
order by category, total_transc;



 7. --Calculate average sale per month and find best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1


 8. --Write a SQL query to find the top 5 customers based on the highest total sales

 select customer_id, sum (total_sales) as total_sales
from retail_sales
group by customer_id
order by 1, 2 desc
limit 5;



 9. --Write a SQL query to find the number of unique customers who purchased items from each category

SELECT category, COUNT( distinct customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;



10. --Write a SQL query to create each shift and number of orders (Example: Morning <12, Afternoon Between 12 & 17, Evening >17)

 WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

--END OF PROJECT
