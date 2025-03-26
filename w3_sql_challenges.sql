"""Practicing sql exercises in this document. The sql challenge exercises are from https://www.w3resource.com/sql-exercises/challenges-1/index.php"""

-- 1. From the following tables, write a SQL query to find the information on each salesperson of ABC Company. Return name, city, country and state of each salesperson.
CREATE TABLE IF NOT EXISTS salespersons (
  salesperson_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL
);

INSERT INTO salespersons (salesperson_id, first_name, last_name) VALUES
  (1, 'Green', 'Wright'),
  (2, 'Jones', 'Collins'),
  (3, 'Bryant', 'Davis');

CREATE TABLE IF NOT EXISTS address (
  address_id INT PRIMARY KEY,
  salesperson_id INT NOT NULL,
  city VARCHAR(50) NOT NULL,
  state VARCHAR(50) NOT NULL,
  country VARCHAR(50) NOT NULL
);

INSERT INTO address (address_id, salesperson_id, city, state, country) VALUES
  (1, 2, 'Los Angeles', 'California', 'USA'),
  (2, 3, 'Denver', 'Colorado', 'USA'),
  (3, 4, 'Atlanta', 'Georgia', 'USA');
  

SELECT first_name, last_name, city, state, country
FROM salespersons a
LEFT JOIN address b ON a.salesperson_id = b.salesperson_id;


-- 2. From the following table, write a SQL query to find the third highest sale. Return sale amount.
CREATE TABLE IF NOT EXISTS salemast (
  sale_id INT PRIMARY KEY,
  employee_id INT NOT NULL,
  sale_date DATETIME NOT NULL,
  sale_amt INT NOT NULL
);

INSERT INTO salemast (sale_id, employee_id, sale_date, sale_amt) VALUES
  (1, 1000, '2012-03-08', 4500),
  (2, 1001, '2012-03-09', 5500),
  (3, 1003, '2012-04-10', 3500),
  (3, 1003, '2012-04-10', 2500);

SELECT MAX(sale_amt) AS ThirdHighestSale
  FROM salemast
  LIMIT 1
  OFFSET 2;

-- Other query:
SELECT MAX(sale_amt) AS ThirdHighestSale
FROM salemast
WHERE sale_amt <
(
  SELECT MAX(sale_amt)
  FROM salemast
  WHERE sale_amt <
    (
    SELECT MAX(sale_amt)
    FROM salemast
    )
);


-- Retry exercise 2 using LIMIT OFFSET
SELECT MAX(sale_amt) AS ThirdHighestSale
FROM salemast
LIMIT 1 OFFSET 2; -- Display one value starting from third value


-- 3. From the following table, write a SQL query to find the Nth highest sale. Return sale amount.
CREATE TABLE IF NOT EXISTS salemast (
  sale_id INT PRIMARY KEY,
  employee_id INT NOT NULL,
  sale_date DATETIME NOT NULL,
  sale_amt INT NOT NULL
);

INSERT INTO salemast (sale_id, employee_id, sale_date, sale_amt) VALUES
  (1, 1000, '2012-03-08', 4500),
  (2, 1001, '2012-03-09', 5500),
  (3, 1003, '2012-04-10', 3500);
  
SELECT MAX(sale_amt) AS getNthHighestSaleAmt
FROM salemast;


-- 4. From the following table, write a SQL query to find the marks, which appear at least thrice one after another without interruption. Return the number.
CREATE TABLE IF NOT EXISTS logs (
  student_id INT PRIMARY KEY,
  marks INT NOT NULL
);

INSERT INTO logs (student_id, marks) VALUES
      (101, 83),
      (102, 79),
      (103, 83),
      (104, 83),
      (105, 83),
      (106, 79),
      (107, 79),
      (108, 83);

SELECT DISTINCT marks
FROM (
  SELECT marks,
          LAG(marks) OVER (ORDER BY student_id) AS prev_marks,
          LEAD(marks) OVER (ORDER BY student_id) AS next_marks
  FROM logs
  ) subquery
WHERE marks = prev_marks AND marks = next_marks;

-- Another Solution
SELECT DISTINCT L1.marks AS  ConsecutiveNums
FROM (logs L1 JOIN logs L2 ON L1.marks = L2.marks AND L1.student_id = L2.student_id-1) -- L1 and L2 match in marks, and L2 student_id shoulb be exactly one more than L1's student_id
JOIN logs L3 ON L1.marks = L3.marks AND L2.student_id = L3.student_id-1; -- L1 and L3 should match in marks, and L3 shold be exactly one more L2's student_id


-- 5. From the following table, write a SQL query to find all the duplicate emails (no upper case letters) of the employees. Return email id.
CREATE TABLE IF NOT EXISTS salespersons (
  salesperson_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL
);

INSERT INTO salespersons (salesperson_id, first_name, last_name) VALUES
  (101, 'Liam Alton', 'li.al@abc.com'),
  (102, 'Josh Day', 'jo.da@abc.com'),
  (103, 'Sean Mann', 'se.ma@abc.com'),
  (104. 'Evan Blake', 'ev.bl@abc.com'),
  (105, 'Toby Scott', 'jo.da@abc.com');


SELECT email_id
FROM employees
GROUP BY email_id
HAVING COUNT(email_id)>1;


-- 6. From the following tables, write a SQL query to find those customers who never ordered anything. Return customer name.
CREATE TABLE IF NOT EXISTS customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATETIME NOT NULL,
  order_amount INT NOT NULL
);

INSERT INTO customers (customer_id, customer_name) VALUES
  (101, 'Liam'),
  (102, 'Josh'),
  (103, 'Sean'),
  (104, 'Evan'),
  (105, 'Toby');

INSERT INTO orders (order_id, customer_id, order_date, order_amount) VALUES
  (401, 103, '2012-03-08', 4500),
  (402, 101, '2012-09-15', 3650),
  (403, 102, '2012-06-27', 4800);

SELECT customer_name
FROM customers
WHERE customer_id NOT IN
(SELECT customer_id
  FROM orders);


-- 7. From the following table, write a SQL query to remove all the duplicate emails of employees keeping the unique email with the lowest employee id. Return employee id and unique emails.
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    email_id VARCHAR(255) NOT NULL
);

INSERT INTO employees (employee_id, employee_name, email_id) VALUES
(101, 'Liam Alton', 'li.al@abc.com'),
  (102, 'Josh Day', 'jo.da@abc.com'),
  (103, 'Sean Mann', 'se.ma@abc.com'),
  (104, 'Evan Blake', 'ev.bl@abc.com'),
  (105, 'Toby Scott', 'jo.da@abc.com');

SELECT DISTINCT email_id, employee_id
FROM employees;

-- Retry again

SELECT * FROM employees;

DELETE e1 FROM employees e1,  employees e2 -- This query deletes duplicate rows from the employees table based on the email_id column.
WHERE
    e1.email_id = e2.email_id  -- The condition identifies rows with duplicate email_id values
  AND e1.employee_id > e2.employee_id; -- The condition ensures that the row with the larger employee_id is the one to be deleted

SELECT * FROM employees;


-- 8. From the following table, write a SQL query to find all dates' city ID with higher pollution compared to its previous dates (yesterday). Return city ID, date and pollution.

CREATE TABLE IF NOT EXISTS so2_pollution (
  city_id INT PRIMARY KEY,
  date DATETIME NOT NULL,
  so2_amt INT NOT NULL
);

INSERT INTO so2_pollution (city_id, date, so2_amt) VALUES
(701, '2015-10-15', 5),
(702, '2015-10-16', 7),
(703, '2015-10-17', 9),
(704, '2018-10-18', 15),
(705, '2015-10-19', 14);

SELECT 
    p1.city_id, 
    p1.date, 
    p1.so2_amt
FROM 
    so2_pollution p1
JOIN -- links the table to itself, allowing us to compare a record with its "previous" record.
    so2_pollution p2
ON 
    p1.city_id = p2.city_id AND p1.date = DATE_ADD(p2.date, INTERVAL 1 DAY) -- Ensure that the two rows being compared are one day apart.
WHERE 
    p1.so2_amt > p2.so2_amt; -- Filters out records where the pollution level so2_amt is not greater than the previous day's pollution level.


-- 9. A salesperson is a person whose job is to sell products or services. From the following tables, write a SQL query to find the top 10 salesperson that have made highest sale. Return their names and total sale amount.
CREATE TABLE IF NOT EXISTS sales (
  transaction_id INT PRIMARY KEY,
  salesman_id INT NOT NULL,
  sale_amount FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS salesman (
  salesman_id INT PRIMARY KEY,
  salesman_name VARCHAR(50)
);

INSERT INTO sales (transaction_id, salesman_id, sale_amount) VALUES
  (501, 18, 5200.00),
  (502, 50. 5566.00),
  (503, 38, 8400.00),
  (599, 24, 16745.00)
  (600, 12, 14900.00);

INSERT INTO salesman (salesman_id, salesman_name) VALUES
 (11, 'Jonathan Goodwin'),
  (12, 'Adam Hughes'),
  (13, 'Mark Davenport'),
  (59, 'Cleveland Hart'),
  (60, 'Marion Gregory');

SELECT a.salesman_name, SUM(b.sale_amount) AS total_amount
FROM salesman a
  NATURAL JOIN sales b
GROUP BY a.salesman_name
ORDER BY total_amount DESC
LIMIT 10;


-- 10. An active customer is simply someone who has bought company's product once before and has returned to make another purchase within 10 days.
-- From the following table, write a SQL query to identify the active customers. Show the list of customer IDs of active customers.

CREATE TABLE IF NOT EXISTS orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  item_desc VARCHAR(50) NOT NULL,
  order_date DATETIME NOT NULL
);

INSERT INTO orders (order_id, customer_id, item_desc, order_date) VALUES
(101, 2109, 'juice', '2020-03-03'),
(102, 2139, 'chocolate', '2019-03-18'),
(103, 2120, 'juice', '2019-03-18'),
(199, 2130, 'juice', '2019-03-16'),
(200, 2117, 'cake', '2021-03-10');

-- More information needed. Review again.
SELECT DISTINCT a.customer_id
FROM orders a, orders  b
where (a.customer_id=b.customer_id) AND (a.order_id!=b.order_id) AND (b.order_date - a.order_date) BETWEEN 0 AND 10
ORDER BY customer_id;
