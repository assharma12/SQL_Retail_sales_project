CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            ); 
			
select * from retail_sales

select count(*) from retail_sales

--Data Cleaning(checking if there is any null)

select * from retail_sales
where transaction_id is null
or
sale_date is null 
or 
sale_time is null 
or
customer_id is null 
or
gender  is null 
or
age is null 
or
category is null 
or
quantity is null 
or
price_per_unit is null 
or
cogs is null 
or
total_sale is null  

--Deleting the nulls 

delete from retail_sales
where  transaction_id is null
or
sale_date is null 
or 
sale_time is null 
or
customer_id is null 
or
gender  is null 
or
age is null 
or
category is null 
or
quantity is null 
or
price_per_unit is null 
or
cogs is null 
or
total_sale is null  

--Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_customers FROM retail_sales

-- How many uniuque category  we have ?

SELECT DISTINCT category FROM retail_sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

   select * 
     from retail_sales 
      where  sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

 
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >=4
  AND EXTRACT(YEAR FROM sale_date) = 2022
  AND EXTRACT(MONTH FROM sale_date) = 11;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

   select category,
   concat(sum(total_sale),'Rs') as Total_sales_per_category
  from retail_sales
  group by category


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

  select round(avg(age),2) as avg_age 
    from retail_sales
       where category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

     select *
	    from retail_sales
		where total_sale > 1000



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

   select count(*) as num_of_transaction,
          gender, 
		     category
     from retail_sales
	   group by gender,category


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

with avg_sales as (
 select avg(total_sale) as avg_sale,
          extract(year from sale_date) as years,
		   extract(month from sale_date) as months,
		   dense_rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
		   from retail_sales
		   group by 2,3)
		        select years,months,round(avg_sale::decimal,2) as best_selling_months
                    from avg_sales where rank = 1
					
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
---type 1 
with cte as (
SELECT 
    customer_id,
    SUM(total_sale) as total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(total_sale) DESC) AS sales_rank
FROM retail_sales
GROUP BY customer_id
 )
 select * from cte where sales_rank <= 5 order by sales_rank 
 

--type 2   

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
 
   SELECT 
    category,    
    COUNT(DISTINCT customer_id) as  count_unique_customers
FROM retail_sales
GROUP BY category
	 
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with Hourly_shift as(
  SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales)
    select shift,
	 count(*) as total_number_of_orders
	   from Hourly_shift
	   group by shift 
	   order by 2 desc














































































































































































































































































