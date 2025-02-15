-- Here is where I document my solutions to the SQL View exercises on W3resource

-- 1. From the following table, create a view for those salespeople who belong to the city of New York. 

CREATE VIEW newyorksalespeople AS
SELECT *
FROM salesman
WHERE city = 'New York';

-- 2. From the following table, create a view for all salespersons. Return salesperson ID, name, and city.  
-- Creating a VIEW named 'salesperson'
CREATE VIEW salesperson
-- Selecting specific columns (salesman_id, name, city) from the 'salesman' table
AS SELECT salesman_id, name, city
-- Retrieving data from the 'salesman' table and storing it in the VIEW
FROM salesman;


-- 3. From the following table, create a view to locate the salespeople in the city 'New York'.
CREATE VIEW salesman_nyc
AS SELECT *
FROM salesman
WHERE city = 'New York';

-- 4. From the following table, create a view that counts the number of customers in each grade. 

CREATE VIEW numofcust (grade, number)
AS SELECT grade, COUNT(customer_id)
FROM customer
GROUP BY grade;


-- 5. From the following table, create a view to count the number of unique customers, compute the average and the total purchase amount of customer orders by each date.
CREATE VIEW numcustomers
AS SELECT ord_date, COUNT(DISTINCT customer_id), AVG(purch_amt), SUM(purch_amt)
FROM orders
GROUP BY ord_date;


-- 6. From the following tables, create a view to get the salesperson and customer by name. Return order name, purchase amount, salesperson ID, name, customer name.

-- First attempt:
CREATE VIEW salesandcust (ord_no, purch_amt, salesman_id, name, cust_name)
AS SELECT o.ord_no, o.purch_amt, s.salesman_id, s.name, c.cust_name
FROM salesman s
JOIN customer c ON (salesman_id)
JOIN orders o ON (customer_id)

-- More practice:
