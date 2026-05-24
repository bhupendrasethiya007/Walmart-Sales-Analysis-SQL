
CREATE TABLE sales (
    invoice_id VARCHAR(30) PRIMARY KEY,
    branch VARCHAR(5),
    city VARCHAR(30),
    customer_type VARCHAR(30),
    gender VARCHAR(10),
    product_line VARCHAR(100),

    unit_price DECIMAL(10,2),
    quantity INT,
    tax_pct DECIMAL(10,2),

    total DECIMAL(12,2),

    date DATE,
    time TIME,

    payment VARCHAR(20),

    cogs DECIMAL(12,2),

    gross_margin_pct DECIMAL(12,9),
    gross_income DECIMAL(12,2),

    rating DECIMAL(3,1)
);


--------------------IMPORTING FILE---------------------------
COPY sales
FROM 'D:\SQL PROJECT\WALMART ANALYSIS\WalmartSalesData.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM SALES
------------------------------------------------------------

-------------------------FEATURE ENGINNERING----------------

-------------------------------------------------------------


--------------------DATA CLEANING---------------------------

-------------ADD NEW COLUMN TIME_OF_DAY---------------------

ALTER TABLE sales
ADD COLUMN time_of_day CHAR(50)

UPDATE sales
SET time_of_day =
CASE 
WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
WHEN time BETWEEN '12:00:00' AND '16:00:00' THEN 'Afternoon'
ELSE 'Evening'
END 

----------------ADD NEW COLUMN DAY_NAME ----------------------

ALTER TABLE sales
ADD COLUMN day_name CHAR(30)

UPDATE sales
set day_name=TO_CHAR(date ,'day')

------------------ADD NEW COLUMN MONTH_NAME---------------------

ALTER TABLE sales
ADD COLUMN month_name CHAR(20)

UPDATE sales
SET month_name =TO_CHAR(date,'Month')

-------------------------------------------------------------------

--------------------GENERIC QUESTIONS-----------------------------

-------------------------------------------------------------------


---Q How many the unique cities the data have---

SELECT DISTINCT(city)
FROM sales

---Q In which city is each branch

SELECT DISTINCT(city),branch
FROM sales

--------------------------------------------------------------------------

-----------------------PRODUCTS BASED QUESTIONS--------------------------

--------------------------------------------------------------------------


----Q How many unique product lines does the data have?

      SELECT DISTINCT(product_line) 
	  FROM sales

----Q What is the most common payment method?
      SELECT payment,
	  COUNT(payment)  AS total_payment
	  FROM sales
	  GROUP BY payment
	  ORDER BY total_payment desc

-----Q What is the most selling product line?
       SELECT product_line ,SUM(total)
	   FROM sales
	   GROUP BY product_line
	   ORDER BY SUM(total) DESC

-----Q What is the total revenue by month?
       SELECT month_name,SUM(total)
	   FROM sales
	   GROUP BY month_name 

-----Q What month had the largest COGS?
       SELECT month_name, SUM(cogs) 
	   FROM sales
	   GROUP BY month_name
	   ORDER BY SUM(cogs) DESC

-----Q What product line had the largest revenue?  
        SELECT product_line, SUM(total) as total_sales
		 FROM sales
		 GROUP BY product_line 
		 ORDER BY total_sales DESC

-----Q What is the city with the largest revenue?
        SELECT city,SUM(total) as total_sales
		FROM sales
		GROUP BY city
		ORDER BY total_sales DESC
		
-----Q What product line had the largest VAT?
        SELECT product_line, AVG(tax_pct) as largest_tax
		FROM sales
		GROUP BY product_line 
		ORDER BY largest_tax DESC
	

-----Q Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
		SELECT product_line, 
		AVG(total) as AVG_total,
		CASE
		WHEN AVG(total)>SUM(total) THEN 'GOOD'
		ELSE 'BAD'
		END
		FROM sales
		GROUP BY product_line
	  
-----Q Which branch sold more products than average product sold?
      SELECT 
	   branch, 
       SUM(quantity) AS qnty
       FROM sales
        GROUP BY branch
        HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);
	 
	   
-----Q What is the most common product line by gender?
       SELECT  gender,count(gender),
	   product_line     
	   FROM sales
	   GROUP BY gender ,product_line
	   ORDER BY count(gender) DESC

	   
-----Q What is the average rating of each product line?
        SELECT product_line ,ROUND(AVG(rating),2) AS rating 
		FROM sales
		GROUP BY  product_line

---------------------------------------------------------------------------

---------------------------SALES-------------------------------------------

---------------------------------------------------------------------------

----Q Number of sales made in each time of the day per weekday
      SELECT time_of_day,
	  COUNT(*) FROM sales
	  WHERE day_name in ('monday')
	  GROUP BY time_of_day
	  
----Q Which of the customer types brings the most revenue?
       SELECT customer_type ,sum(total)
	   FROM sales
	   GROUP BY customer_type
	   ORDER BY sum(total)DESC

----Q Which city has the largest tax percent/ VAT (Value Added Tax)?
      SELECT city,AVG(tax_pct)
	  FROM sales
	  GROUP BY city
	  ORDER BY AVG(tax_pct) DESC

----Q Which customer type pays the most in VAT?
       SELECT customer_type, SUM(tax_pct) 
	   FROM sales
	   GROUP BY customer_type 
	   ORDER BY sum(tax_pct) DESC


------------------------------------------------------------------------

-------------------CUSTOMER BASED QUESTIONS---------------------------	   

-----------------------------------------------------------------------

----Q How many unique customer types does the data have?
      SELECT DISTINCT(customer_type)
	  FROM sales
	  
----Q How many unique payment methods does the data have?
       SELECT DISTINCT(payment) 
	   FROM sales
	   
----Q What is the most common customer type?
--------------SAME AS BELOW-----
      
----Q Which customer type buys the most?
        SELECT customer_type, COUNT(*) 
		FROM sales
		GROUP BY customer_type
		ORDER BY count(*) DESC
		
----Q What is the gender of most of the customers?
      SELECT gender,
	  COUNT(*)
	  FROM sales
	  GROUP BY gender
----Q What is the gender distribution per branch?

   SELECT 
    branch,
    COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS male,
    COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS female
   FROM sales
    GROUP BY branch
     ORDER BY branch;
	 
----Q Which time of the day do customers give most ratings?
      SELECT time_of_day,count(rating)
	  from sales
	  GROUP BY time_of_day
      ORDER BY count(rating) DESC
	   
----Q Which time of the day do customers give most ratings per branch?

      SELECT time_of_day,
	  ROUND(AVG(rating) FILTER (WHERE branch='A'),2) AS branch_a,
	  ROUND(AVG(rating) FILTER (WHERE branch='B'),2) AS branch_b,
	  ROUND(AVG(rating) FILTER (WHERE branch='C'),2) AS branch_c
	  FROM sales
	  GROUP BY time_of_day
	  ORDER BY time_of_day	 

----Q Which day fo the week has the best avg ratings?
      select day_name ,ROUND(avg(rating),2)  AS best_rating
	  from sales
	  GROUP BY day_name
	  ORDER BY best_rating DESC
      
----Q Which day of the week has the best average ratings per branch?
     
   SELECT
	time_of_day,
	AVG(rating) AS avg_rating
    FROM sales
   WHERE branch = 'A'
   GROUP BY time_of_day
  ORDER BY avg_rating DESC;


	