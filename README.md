# SQL_Retail_sales_project

## Project Overview

**Project Title** Retail sales Analysis
**Database** 'SQL_Project_p1'

In this project i used Sql and SQL skills and techniques to explore,
clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), 
and answering specific business questions through SQL queries.

## Objectives
1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project structure

### 1. Database setup 
- **Database Creation**:  The project starts by creating a database named 'SQL_Project_p1'.
-**Table Creation**: A table named 'retail_sales' is created to store the sales data.
  The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category,
  quantity sold, price per unit,
  cost of goods sold (COGS), and total sale amount.

``` SQL

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
```           

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

``` Sql
 
SELECT COUNT(*) as total_sale FROM retail_sales
SELECT COUNT(DISTINCT customer_id) as total_customers FROM retail_sales
SELECT DISTINCT category FROM retail_sales

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

```
### 3. Data Analysis & Business Key Problems & Answers

The following SQL queries were developed to answer specific business questions:

```sql
 ** Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'**:
 select * 
     from retail_sales 
      where  sale_date = '2022-11-05'
```
```Sql
 ** Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022:

 
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >=4
  AND EXTRACT(YEAR FROM sale_date) = 2022
  AND EXTRACT(MONTH FROM sale_date) = 11;
```

```Sql
 Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

   select category,
   concat(sum(total_sale),'Rs') as Total_sales_per_category
  from retail_sales
  group by category
```
```Sql
  Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

  select round(avg(age),2) as avg_age 
    from retail_sales
       where category = 'Beauty'
```
```Sql
 Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

     select *
	    from retail_sales
		where total_sale > 1000
```

```Sql
  Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

   select count(*) as num_of_transaction,
          gender, 
		     category
     from retail_sales
	   group by gender,category
```

```Sql
  Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

with avg_sales as (
 select avg(total_sale) as avg_sale,
          extract(year from sale_date) as years,
		   extract(month from sale_date) as months,
		   dense_rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
		   from retail_sales
		   group by 2,3)
		        select years,months,round(avg_sale::decimal,2) as best_selling_months
                    from avg_sales where rank = 1
```

```Sql				
  Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
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
```
```Sql
  Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
 
   SELECT 
    category,    
    COUNT(DISTINCT customer_id) as  count_unique_customers
FROM retail_sales
GROUP BY category
```

  ```Sql
  Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

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
```
 
## Findings
-**Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across 
different categories such as Clothing and Beauty.
-**High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
-**Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.(month like 7,2 inth year 2022 and 2023 respectively have highest 
avg sales amount)
-**Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.
## Reports
-**Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
-**Trend Analysis**: Insights into sales trends across different months and shifts.
-**Customer Insights**: Reports on top customers and unique customer counts per category.
## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, 
and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, 
customer behavior, and product performance.

## Author - Abhishek Sharma
This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, 
or would like to collaborate, feel free to get in touch!

-**Linkedin**: [My Linkedin](https://www.linkedin.com/in/abhishek-sharma-36b33b260/)




































































