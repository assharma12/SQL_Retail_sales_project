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













































































