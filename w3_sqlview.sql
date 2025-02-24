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
CREATE VIEW ordnum
AS SELECT ord_no, purch_amt, o.salesman_id, name, cust_name
FROM salesman s, customer c, orders o
WHERE s.salesman_id = o.salesman_id
AND c.customer_id = o.customer_id;


-- 7. From the following table, create a view to find the salesperson who handles a customer who makes the highest order of the day. Return order date, salesperson ID, name.

CREATE VIEW highestorder
AS SELECT o.ord_date, s.salesman_id, s.name
FROM salesman s, orders o
WHERE s.salesman_id = o.salesman_id
  AND purch_amt = ANY (
  SELECT MAX(purch_amt)
  FROM orders a
  WHERE o.ord_date = a.ord_date
  GROUP BY ord_date
);


-- 8. From the following table, create a view to find the salesperson who deals with the customer with the highest order at least three times per day. Return salesperson ID and name.

CREATE VIEW incentive
AS SELECT DISTINCT salesman_id, name
FROM elitsalesman a
WHERE 3 <= (
  SELECT COUNT(*)
  FROM customer b
  WHERE a.salesman_id = b.salesman_id
);


-- 9. From the following table, create a view to find all the customers who have the highest grade. Return all the fields of customer.
CREATE VIEW highgrade
AS SELECT *
FROM customer a
WHERE grade = ANY (
  SELECT MAX(grade)
  FROM customer b
  WHERE a.customer_id = b.customer_id
  GROUP BY b.customer_id
);

-- 10. From the following table, create a view to count the number of salespeople in each city. Return city, number of salespersons.
CREATE VIEW citysales
AS SELECT city, COUNT(DISTINCT salesman_id)
FROM salesman
GROUP BY city;


-- 11. From the following table, create a view to compute the average purchase amount and total purchase amount for each salesperson. Return name, average purchase and total purchase amount. (Assume all names are unique.).

CREATE VIEW avgpurchamt
AS SELECT name, AVG(purch_amt), SUM(purch_amt)
FROM salesman, orders
WHERE salesman.salesman_id = orders.salesman_id
GROUP BY name; -- Group the result by name from 'salesman' table


-- 12. From the following table, create a view to identify salespeople who work with multiple clients. Return all the fields of salesperson.
CREATE VIEW scm
AS SELECT *
FROM salesman a
WHERE salesman_id IN
(SELECT salesman_id
  FROM customer b
  WHERE a.salesman_id = b.customer_id
  HAVING COUNT(customer_id) > 1;
);

-- Other possible solution:
-- Creating a VIEW named 'mcustomer'
CREATE VIEW mcustomer
-- Selecting all columns from the 'salesman' table as 'a'
-- Filtering the rows where a salesman has more than one customer
-- Using a subquery to count the number of customers for each salesman and comparing it to 1
AS SELECT *
FROM salesman a
WHERE 1 <
   (SELECT COUNT(*)
     FROM customer b
     WHERE a.salesman_id = b.salesman_id);


-- 13. From the following table, create a view that shows all matching customers with salespeople, ensuring that at least one customer in the city of the customer is served by the salesperson in the city of the salesperson.

CREATE VIEW custsales
AS SELECT customer.city, salesman.city
FROM customer, salesman
WHERE 1 <= 
  (SELECT COUNT(*)
  FROM customer a
  WHERE a.customer_id = customer.customer_id);

-- Another attempt
