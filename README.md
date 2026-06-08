
<p align="center">
  <img src="images/Walmart_logo" alt="Walmart Sales Analysis" width="60%">
</p>



# Walmart Sales Data Analysis using SQL

## About the Project

This project focuses on exploring Walmart sales data to analyze top-performing branches and product lines, understand sales trends, and study customer purchasing behavior.

The main objective of this project is to generate actionable business insights that can help improve sales strategies, optimize operations, and enhance customer satisfaction using SQL-based Exploratory Data Analysis (EDA).

The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition.

---

# Project Objectives

The major objectives of this project are:

- Analyze sales performance across different Walmart branches
- Identify best-selling product lines
- Understand customer purchasing behavior
- Evaluate sales trends and profitability
- Generate business recommendations using SQL analysis

---

# About the Dataset

The dataset contains sales transactions from three Walmart branches located in:

- Yangon
- Mandalay
- Naypyidaw

### Dataset Information

- Total Rows: **1000**
- Total Columns: **17**

---

# Dataset Schema

| Column Name | Description | Data Type |
|---|---|---|
| `invoice_id` | Invoice ID of the sales transaction | `VARCHAR(30)` |
| `branch` | Branch where sales were made | `VARCHAR(5)` |
| `city` | Location of the branch | `VARCHAR(30)` |
| `customer_type` | Type of customer | `VARCHAR(30)` |
| `gender` | Gender of the customer | `VARCHAR(10)` |
| `product_line` | Product category purchased | `VARCHAR(100)` |
| `unit_price` | Price of each product | `DECIMAL(10,2)` |
| `quantity` | Quantity of products sold | `INT` |
| `VAT` | Tax amount applied to the purchase | `DECIMAL(10,2)` |
| `total` | Total transaction amount | `DECIMAL(12,2)` |
| `date` | Date of transaction | `DATE` |
| `time` | Time of transaction | `TIME` |
| `payment_method` | Payment method used by customer | `VARCHAR(20)` |
| `cogs` | Cost of Goods Sold | `DECIMAL(12,2)` |
| `gross_margin_percentage` | Gross profit margin percentage | `DECIMAL(12,9)` |
| `gross_income` | Gross profit earned | `DECIMAL(12,2)` |
| `rating` | Customer rating | `DECIMAL(3,1)` |

---

# Approach Used

## 1. Data Wrangling

Data cleaning and preprocessing steps performed:

- Checked for NULL and missing values
- Corrected data types
- Removed inconsistencies
- Imported CSV data into PostgreSQL database

---

## 2. Feature Engineering

New columns were created from existing columns to improve analysis.

### Added Columns

| Column | Purpose |
|---|---|
| `time_of_day` | Categorizes sales into Morning, Afternoon, and Evening |
| `day_name` | Extracted weekday name from transaction date |
| `month_name` | Extracted month name from transaction date |

These columns helped analyze:

- Peak sales periods
- Busiest weekdays
- Monthly sales trends

---

## 3. Exploratory Data Analysis (EDA)

EDA was performed using SQL queries to answer important business questions and generate insights.

---

# SQL Analysis Questions & Queries

## Generic Analysis

### 1. How many unique cities are present in the dataset?

```sql
SELECT DISTINCT city
FROM sales;
```

---

### 2. Which branch operates in which city?

```sql
SELECT DISTINCT city, branch
FROM sales;
```

---

# Product Analysis

### 3. How many unique product lines does the dataset contain?

```sql
SELECT DISTINCT product_line
FROM sales;
```

---

### 4. What is the most common payment method?

```sql
SELECT payment,
       COUNT(*) AS total_transactions
FROM sales
GROUP BY payment
ORDER BY total_transactions DESC;
```

---

### 5. Which product line generates the highest sales revenue?

```sql
SELECT product_line,
       SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;
```

---

### 6. What is the total revenue generated each month?

```sql
SELECT month_name,
       SUM(total) AS total_revenue
FROM sales
GROUP BY month_name;
```

---

### 7. Which month recorded the highest Cost of Goods Sold (COGS)?

```sql
SELECT month_name,
       SUM(cogs) AS total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC;
```

---

### 8. Which product line generated the highest revenue?

```sql
SELECT product_line,
       SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;
```

---

### 9. Which city generated the highest revenue?

```sql
SELECT city,
       SUM(total) AS total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;
```

---

### 10. Which product line has the highest average VAT?

```sql
SELECT product_line,
       AVG(tax_pct) AS average_vat
FROM sales
GROUP BY product_line
ORDER BY average_vat DESC;
```

---

### 11. Which branches sold more products than the overall average quantity sold?

```sql
SELECT branch,
       SUM(quantity) AS total_quantity
FROM sales
GROUP BY branch
HAVING SUM(quantity) >
(
    SELECT AVG(quantity)
    FROM sales
);
```

---

### 12. Which product line is most frequently purchased by each gender?

```sql
SELECT gender,
       product_line,
       COUNT(*) AS total_orders
FROM sales
GROUP BY gender, product_line
ORDER BY total_orders DESC;
```

---

### 13. What is the average rating for each product line?

```sql
SELECT product_line,
       ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY product_line;
```

---

# Sales Analysis

### 14. How many sales occur during each time of day on Mondays?

```sql
SELECT time_of_day,
       COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'monday'
GROUP BY time_of_day;
```

---

### 15. Which customer type generates the most revenue?

```sql
SELECT customer_type,
       SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;
```

---

### 16. Which city has the highest average VAT percentage?

```sql
SELECT city,
       AVG(tax_pct) AS average_vat
FROM sales
GROUP BY city
ORDER BY average_vat DESC;
```

---

### 17. Which customer type pays the most VAT?

```sql
SELECT customer_type,
       SUM(tax_pct) AS total_vat
FROM sales
GROUP BY customer_type
ORDER BY total_vat DESC;
```

---

# Customer Analysis

### 18. How many unique customer types are present?

```sql
SELECT DISTINCT customer_type
FROM sales;
```

---

### 19. How many unique payment methods are available?

```sql
SELECT DISTINCT payment
FROM sales;
```

---

### 20. Which customer type appears most frequently?

```sql
SELECT customer_type,
       COUNT(*) AS total_customers
FROM sales
GROUP BY customer_type
ORDER BY total_customers DESC;
```

---

### 21. What is the gender distribution of customers?

```sql
SELECT gender,
       COUNT(*) AS total_customers
FROM sales
GROUP BY gender;
```

---

### 22. What is the gender distribution across branches?

```sql
SELECT branch,
       COUNT(CASE WHEN gender='Male' THEN 1 END) AS male_customers,
       COUNT(CASE WHEN gender='Female' THEN 1 END) AS female_customers
FROM sales
GROUP BY branch
ORDER BY branch;
```

---

### 23. During which time of day do customers give the most ratings?

```sql
SELECT time_of_day,
       COUNT(rating) AS total_ratings
FROM sales
GROUP BY time_of_day
ORDER BY total_ratings DESC;
```

---

### 24. What is the average customer rating by branch and time of day?

```sql
SELECT time_of_day,
       ROUND(AVG(rating) FILTER (WHERE branch='A'),2) AS branch_a,
       ROUND(AVG(rating) FILTER (WHERE branch='B'),2) AS branch_b,
       ROUND(AVG(rating) FILTER (WHERE branch='C'),2) AS branch_c
FROM sales
GROUP BY time_of_day;
```

---

### 25. Which day of the week has the highest average customer rating?

```sql
SELECT day_name,
       ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY day_name
ORDER BY average_rating DESC;
```

---

### 26. Which day and branch combination receives the highest ratings?

```sql
SELECT branch,
       day_name,
       ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY branch, day_name
ORDER BY average_rating DESC;
```

---

# SQL Concepts Used

- SELECT Statements
- GROUP BY
- ORDER BY
- Aggregate Functions
- CASE WHEN
- HAVING Clause
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Conditional Aggregation using FILTER
- Date & Time Functions

---

# Key Insights

- Female customers contributed **51%** of total purchases.
- Member customers contributed **55%** of total purchases.
- E-wallet was the most preferred payment method with **34.5%** usage.
- Evening hours recorded the highest sales activity.
  

---

# Business Recommendations

- Increase inventory for top-selling products
- Improve strategies for low-performing branches
- Optimize staffing during peak shopping hours
- Focus marketing on profitable product lines
- Improve customer experience in low-rated categories

---

# Project Workflow

```text
CSV Dataset
    ↓
PostgreSQL Database
    ↓
Data Cleaning
    ↓
Feature Engineering
    ↓
EDA using SQL
    ↓
Business Insights
```

---

# Conclusion

This project successfully utilized SQL to analyze Walmart sales data and uncover valuable insights related to sales performance, customer behavior, product trends, and profitability. The analysis demonstrates practical SQL and business analytics skills applicable to real-world retail data analysis.

---

# Author

## Bhupendra Sethiya

Aspiring Data Analyst | SQL | PostgreSQL
