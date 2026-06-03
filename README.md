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

# Business Questions

## Generic Questions

- How many unique cities are present in the dataset?
- Which city does each branch belong to?

---

## Product Analysis

- How many unique product lines are there?
- What is the most common payment method?
- Which product line sells the most?
- Which month generated the highest revenue?
- Which month had the highest COGS?
- Which product line generated the highest revenue?
- Which city generated the highest revenue?
- Which product line had the highest VAT?
- Which branch sold more products than average?
- What is the most common product line by gender?
- What is the average rating of each product line?

---

## Sales Analysis

- Number of sales made during each time of day
- Which customer type generates the most revenue?
- Which city has the highest VAT percentage?
- Which customer type pays the most VAT?

---

## Customer Analysis

- How many unique customer types exist?
- How many unique payment methods exist?
- What is the most common customer type?
- Which customer type purchases the most?
- What is the gender distribution of customers?
- What is the gender distribution per branch?
- Which time of day receives the highest customer ratings?
- Which time of day receives the highest ratings per branch?
- Which day of the week has the best average ratings?
- Which branch has the best average ratings by weekday?

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
