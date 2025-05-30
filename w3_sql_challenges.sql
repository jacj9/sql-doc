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


SELECT DISTINCT a.customer_id
FROM orders a, orders  b
where (a.customer_id=b.customer_id) AND (a.order_id!=b.order_id) AND (b.order_date - a.order_date) BETWEEN 0 AND 10
ORDER BY customer_id;


-- 11. From the following table, write a SQL query to convert negative numbers to positive and vice verse. Return the number.
DROP TABLE IF EXISTS tablefortest; 
CREATE TABLE tablefortest(srno int,  pos_neg_val int);
INSERT INTO tablefortest VALUES (1, 56);
INSERT INTO tablefortest VALUES (2, -74);
INSERT INTO tablefortest VALUES (3, 15);
INSERT INTO tablefortest VALUES (4, -51);
INSERT INTO tablefortest VALUES (5, -9);
INSERT INTO tablefortest VALUES (6, 32);
select * from tablefortest;

SELECT srno, pos_neg_val, -pos_neg_val AS converted_signed_value
FROM tablefortest;


-- 12. From the following table, write a SQL query to find the century of a given date. Return the century.
DROP TABLE IF EXISTS tablefortest;
CREATE TABLE tablefortest (id INT, date_of_birth DATE);
INSERT INTO tablefortest VALUES (1, '1907-08-15');
INSERT INTO tablefortest VALUES (2, '1883-06-27');
INSERT INTO tablefortest VALUES (3, '1900-01-01');
INSERT INTO tablefortest VALUES (4, '1901-01-01');
INSERT INTO tablefortest VALUES (5, '2005-09-01');
INSERT INTO tablefortest VALUES (6, '1775-11-23');
INSERT INTO tablefortest VALUES (7, '1800-01-01');
SELECT * FROM tablefortest;

-- Review what does this query do
SELECT ID, date_of_birth,
       CEIL(YEAR(date_of_birth) / 100) AS century 
  -- YEAR(date_of_birth) extracts the year from the date_of_birth
  -- Dividing this year by 100 determines the century (e.g., 1999 divided by 100 equals 19.99)
  -- The CEIL() function rounds up the result to the next integer. So, the year 1999 falls into the 20th century, and the year 2000 falls into the 21st century.
FROM tablefortest;

SELECT ID, date_of_birth,
  CEIL(YEAR(date_of_birth)/100) AS century
FROM tablefortest;

-- Review what does this query do
SELECT id, date_of_birth, (SUBSTRING((EXTRACT(YEAR FROM(date_of_birth))-1),1,2))+1 AS Century 
FROM tablefortest;
-- SELECT id, date_of_birth: This retrieves the id and date_of_birth columns from the table tablefortest.

-- EXTRACT(YEAR FROM(date_of_birth)): This extracts the year from the date_of_birth. For example, if the date of birth is 1987-05-23, it will extract 1987.

-- (EXTRACT(YEAR FROM(date_of_birth))-1): This subtracts 1 from the extracted year. For example, 1987 - 1 = 1986.

-- SUBSTRING((...),1,2): This retrieves the first two characters of the resulting year after subtraction. For example, from 1986, it would extract 19.

-- +1 AS Century: This adds 1 to the extracted first two digits. So, 19 + 1 = 20, meaning the century is the 20th century.

-- FROM tablefortest: This specifies the table tablefortest from which the data is retrieved.

SELECT id, date_of_birth, (SUBSTRING(EXTRACT(YEAR FROM(date_of_birth)-1)1, 2))+1 AS cemtkury
  FROM tablefortest;


""" 13. From the following table, write a SQL query to find the even or odd values. Return "Even" for even number and "Odd" for odd number."""

  DROP TABLE IF EXISTS tablefortest;
CREATE TABLE tablefortest(srno int,  col_val int);
INSERT INTO tablefortest VALUES (1, 56);
INSERT INTO tablefortest VALUES (2, 74);
INSERT INTO tablefortest VALUES (3, 15);
INSERT INTO tablefortest VALUES (4, 51);
INSERT INTO tablefortest VALUES (5, 9);
INSERT INTO tablefortest VALUES (6, 32);
SELECT * FROM tablefortest;

-- A CASE statement in SQL is a way to perform conditional logic within queries. It acts like an if-then-else statement, allowing you to evaluate different conditions and return specific values based on those conditions.

SELECT srno, col_val,
     CASE WHEN col_val%2=0 THEN 'Even' -- If col_val is divisible by 2 (col_val % 2 = 0), it assigns 'Even' to the Even_Odd column.
          WHEN col_val%2=1 THEN 'Odd' -- If col_val is not divisible by 2 (col_val % 2 = 1), it assigns 'Odd' to the Even_Odd column.
          END AS Even_Odd
     FROM tablefortest;

-- Another possible solution for ex.13
SELECT srno, col_val,
       CASE 
           WHEN column_name % 2 = 0 THEN 'Even' -- checks if the number is divisible by 2 (even)
           ELSE 'Odd'
       END AS even_odd -- CASE statement assigns "Even" or "Odd" based on the condition.
FROM tablefortest;

-- On my own
SELECT srno, col_val,
CASE WHEN col_val%2=0 THEN 'EVEN'
ELSE 'ODD'
FROM tablefortest;

SELECT srno, col_val,
  CASE WHEN col_val%2 = 0 THEN 'EVEN'
      WHEN col_val%2=1 THEN 'ODD'
      END AS even_odd
FROM tablefortest;


-- 14. From the following table, write a SQL query to find the unique marks. Return the unique marks.
DROP TABLE IF EXISTS student_test;
CREATE TABLE student_test(student_id int, marks_achieved int);
INSERT INTO student_test VALUES (1, 56);
INSERT INTO student_test VALUES (2, 74);
INSERT INTO student_test VALUES (3, 15);
INSERT INTO student_test VALUES (4, 74);
INSERT INTO student_test VALUES (5, 89);
INSERT INTO student_test VALUES (6, 56);
INSERT INTO student_test VALUES (7, 93);

SELECT DISTINCT marks_achieved as "Unique Marks"
FROM student_test;


-- 15. From the following table, write a SQL query to find those students who have referred by the teacher whose id not equal to 602. Return the student names.
CREATE TABLE IF NOT EXISTS students (student_id INT,student_name VARCHAR(25),teacher_id INT);
TRUNCATE TABLE students;

CREATE TABLE IF NOT EXISTS students (student_id INT,student_name VARCHAR(25),teacher_id INT);
INSERT INTO students (student_id, student_name, teacher_id) values ('1001', 'Alex', '601');
INSERT INTO students (student_id, student_name, teacher_id) values ('1002', 'Jhon', NULL);
INSERT INTO students (student_id, student_name, teacher_id) values ('1003', 'Peter', NULL);
INSERT INTO students (student_id, student_name, teacher_id) values ('1004', 'Minto', '604');
INSERT INTO students (student_id, student_name, teacher_id) values ('1005', 'Crage', NULL);
INSERT INTO students (student_id, student_name, teacher_id) values ('1006', 'Chang', '601');
INSERT INTO students (student_id, student_name, teacher_id) values ('1007', 'Philip', '602');

SELECT student_name
FROM students
WHERE teacher_id != 602 OR teacher_id IS NULL; -- Includes students without teacher_id

-- Other input
SELECT student_name
FROM students
WHERE teacher_id <> 602 OR teacher_id IS NULL;


-- 16. From the following table, write a SQL query to find the order_id(s) that was executed by the maximum number of salespersons.
-- If there are, more than one order_id(s) executed by the maximum number of salespersons find all the order_id(s). Return order_id.
DROP TABLE  IF EXISTS salemast;
CREATE TABLE salemast(salesperson_id int,  order_id int);
INSERT INTO salemast(salesperson_id, order_id) VALUES ('5001', '1001');
INSERT INTO salemast(salesperson_id, order_id) VALUES ('5002', '1002');
INSERT INTO salemast(salesperson_id, order_id) VALUES ('5003', '1002');
INSERT INTO salemast(salesperson_id, order_id) VALUES ('5004', '1002');
INSERT INTO salemast(salesperson_id, order_id) VALUES ('5005', '1003');
INSERT INTO salemast(salesperson_id, order_id) VALUES ('5006', '1004');
INSERT INTO salemast(salesperson_id, order_id) VALUES ('5007', '1004');
INSERT INTO salemast(salesperson_id, order_id) VALUES ('5008', '1004');
SELECT order_id
FROM salemast
GROUP BY order_id
HAVING COUNT(DISTINCT salesperson_id) = (
    SELECT MAX(salesperson_count)
    FROM (
        SELECT COUNT(DISTINCT salesperson_id) AS salesperson_count
        FROM salemast
        GROUP BY order_id
    ) AS counts
); 

-- Practice query

SELECT order_id
FROM salemast
GROUP BY order_id
HAVING COUNT(DISTINCT salesperson_id) = 
(
  SELECT MAX(spcount)
  FROM (SELECT COUNT(DISTINCT salesperson_id) FROM salemast GROUP BY order_id) AS spcount
);


-- 17. A city is big if it has an area bigger than 50K square km or a population of more than 15 million.
-- From the following table, write a SQL query to find big cities name, population and area.
CREATE TABLE cities_test(city_name varchar(255), country varchar(255), city_population int, city_area int);

INSERT INTO cities_test VALUES ('Tokyo	 		','Japan		',	13515271,	2191	);	
INSERT INTO cities_test VALUES ('Delhi	 		','India		',	16753235,	1484	);	
INSERT INTO cities_test VALUES ('Shanghai	 	','China		',	24870895,	6341	);	
INSERT INTO cities_test VALUES ('Sao Paulo	 	','Brazil		',	12252023,	1521	);	
INSERT INTO cities_test VALUES ('Mexico City	','Mexico		',	9209944,	1485	);	
INSERT INTO cities_test VALUES ('Cairo	 		','Egypt		',	9500000,	3085	);	
INSERT INTO cities_test VALUES ('Mumbai	 		','India		',	12478447,	603		);	
INSERT INTO cities_test VALUES ('Beijing	 	','China		',	21893095,	16411	);	
INSERT INTO cities_test VALUES ('Osaka	 		','Japan		',	2725006,	225		);	
INSERT INTO cities_test VALUES ('New York	 	','United States',	8398748,	786		);	
INSERT INTO cities_test VALUES ('Buenos Aires	','Argentina	',	3054300,	203		);	
INSERT INTO cities_test VALUES ('Chongqing	 	','China		',	32054159,	82403	);	
INSERT INTO cities_test VALUES ('Istanbul	 	','Turkey		',	15519267,	5196	);	
INSERT INTO cities_test VALUES ('Kolkata	 	','India		',	4496694,	205		);	
INSERT INTO cities_test VALUES ('Manila	 		','Philippines	',	1780148,	43		);	

SELECT *
FROM cities_test
WHERE city_area > 50000 OR city_population > 15000000;


-- 18. From the following table, write a SQL query to find those items, which have ordered 5 or more times. Return item name and number of orders.
DROP IF TABLE EXISTS orders;
CREATE TABLE orders(order_id integer(5) NOT NULL, customer_id INTEGER(4) NOT NULL, item_desc varchar(30)) NOT NULL;
  INSERT INTO orders VALUES(101,2109,'juice');
INSERT INTO orders VALUES(102,2139,'chocolate');
INSERT INTO orders VALUES(103,2120,'juice');
INSERT INTO orders VALUES(104,2108,'cookies');
INSERT INTO orders VALUES(105,2130,'juice');
INSERT INTO orders VALUES(106,2103,'cake');
INSERT INTO orders VALUES(107,2122,'cookies');
INSERT INTO orders VALUES(108,2125,'cake');
INSERT INTO orders VALUES(109,2139,'cake');
INSERT INTO orders VALUES(110,2141,'cookies');
INSERT INTO orders VALUES(111,2116,'cake');
INSERT INTO orders VALUES(112,2128,'cake');
INSERT INTO orders VALUES(113,2146,'chocolate');
INSERT INTO orders VALUES(114,2119,'cookies');
INSERT INTO orders VALUES(115,2142,'cake');
SELECT * FROM  orders;

SELECT item_desc, COUNT(order_id) AS 'Number of orders'
FROM orders
GROUP BY item_desc
  HAVING COUNT(order_id) >= 5;


-- 19. From the following tables, write a SQL query to find the overall rate of execution of orders, which is the number of orders execution divided by the number of orders quote. Return rate_of_execution rounded to 2 decimals places.
CREATE TABLE orders_issued (distributor_id int, company_id int, quotation_date date);
INSERT INTO orders_issued VALUES (101, 202, '2019-11-15');
INSERT INTO orders_issued VALUES (101, 203, '2019-11-15');
INSERT INTO orders_issued VALUES (101, 204, '2019-11-15');
INSERT INTO orders_issued VALUES (102, 202, '2019-11-16');
INSERT INTO orders_issued VALUES (102, 201, '2019-11-15');
INSERT INTO orders_issued VALUES (103, 203, '2019-11-17');
INSERT INTO orders_issued VALUES (103, 202, '2019-11-17');
INSERT INTO orders_issued VALUES (104, 203, '2019-11-18');
INSERT INTO orders_issued VALUES (104, 204, '2019-11-18');

CREATE TABLE orders_executed (orders_from int, executed_from int, executed_date date);
INSERT INTO orders_executed VALUES (101, 202, '2019-11-17');
INSERT INTO orders_executed VALUES (101, 203, '2019-11-17');
INSERT INTO orders_executed VALUES (102, 202, '2019-11-17');
INSERT INTO orders_executed VALUES (103, 203, '2019-11-18');
INSERT INTO orders_executed VALUES (103, 202, '2019-11-19');
INSERT INTO orders_executed VALUES (104, 203, '2019-11-20');

SELECT
ROUND(
    IFNULL(
    (SELECT COUNT(*) FROM (SELECT DISTINCT orders_from, executed_from FROM orders_executed) AS A) -- It selects distinct pairs of orders_from and executed_from from the orders_executed table.
  -- Then it counts the total number of these unique pairs
    /
    (SELECT COUNT(*) FROM (SELECT DISTINCT distributor_id, company_id FROM orders_issued) AS B), -- It selects distinct pairs of distributor_id and company_id from the orders_issued table. 
  -- Then it counts the total number of these unique pairs.
    0) -- Handling Null values. If the denominator is zero or if there are no valid counts, it ensures the result is 0 instead of NULL
, 2) AS rate_of_execution; -- Rounding the output. The final result is rounded to 2 decimal places.


-- On my own
SELECT
ROUND(
  IFNULL(
  (SELECT COUNT(*) FROM(SELECT DISTINCT orders_from, executed_from FROM orders_executed) AS A) /
  (SELECT COUNT(*) FROM (SELECT DISTINCT distributor_id, company_id FROM orders_issued) AS B), 0), 2) AS rate_of_execution;


-- 20. From the following table write an SQL query to display the records with four or more rows with consecutive match_no's, and the crowd attended more than or equal to 50000 for each match. Return match_no, match_date and audience. Order the result by visit_date, descending.
CREATE TABLE match_crowd (match_no int, match_date date not null unique, audience int);
INSERT INTO match_crowd VALUES ( 1,'2016-06-11',  75113 );
INSERT INTO match_crowd VALUES ( 2,'2016-06-12',  62343 );
INSERT INTO match_crowd VALUES ( 3,'2016-06-13',  43035 );
INSERT INTO match_crowd VALUES ( 4,'2016-06-14',  55408 );
INSERT INTO match_crowd VALUES ( 5,'2016-06-15',  38742 );
INSERT INTO match_crowd VALUES ( 6,'2016-06-16',  63670 );
INSERT INTO match_crowd VALUES ( 7,'2016-06-17',  73648 );
INSERT INTO match_crowd VALUES ( 8,'2016-06-18',  52409 );
INSERT INTO match_crowd VALUES ( 9,'2016-06-19',  67291 );
INSERT INTO match_crowd VALUES (10,'2016-06-20',  49752 );
INSERT INTO match_crowd VALUES (11,'2016-06-21',  28840 );
INSERT INTO match_crowd VALUES (12,'2016-06-22',  32836 );
INSERT INTO match_crowd VALUES (13,'2016-06-23',  44268 );

SELECT DISTINCT m.match_no, m.match_date, m.audience
FROM match_crowd m, -- Define the 'match_crowd' as table m
  -- The main query works with the match_crowd table. It references matches by their match number (match_no), match date (match_date), and audience count (audience).
(SELECT m1.match_no AS FROM_ID, m1.match_no+2 AS TO_ID -- Create a subquery that defines 'FROM_ID' and "TO_ID"
FROM match_crowd m1, match_crowd m2, match_crowd m3 -- Calculates a range of match numbers based on three consecutive matches (m1, m2, and m3) 
WHERE m1.match_no+1 = m2.match_no -- Verifies that the match in table m2 occurs immediately after the match in table m1
AND m2.match_no+1 = m3.match_no -- Ensures that the match in table m3 follows right after m2
  -- The logic ensure the subquery identifies three matches that are consecutive in terms of their match_no.
  -- The addition is a simple arithmetic operation used to establish continuity between the matches
AND m1.audience >= 50000
AND m2.audience >= 50000
AND m3.audience >= 50000) m2 -- This subquery outputs two columns "FROM_ID" AND "TO_ID"
WHERE m.match_no BETWEEN m2.FROM_ID AND m2.TO_ID; -- The main query retrieves distinct match records (match_no, match_date, audience) from the match_croud table
-- The match number falls between the FROM_ID and TO_ID generated by the subquery

-- Purpose: 
-- The overall query identifies all matches in the match_crowd table that occur within the range of three consecutive matches, provided all those matches have an audience size of at least 50,000.

-- Try on my own
SELECT match_no, match_date, audience
FROM match_crowd m, 
(SELECT DISTINCT m1.match_no AS FROM_ID, m1.match_no+2 AS TO_ID
  FROM match_crowd m1, match_crowd m2, match_crowd m3
  WHERE m1.audience = m2.audience+1
  AND m1.audience = m3.audience+2
  AND m1.audience >= 50000
  AND m2.audience >= 50000
  AND m3.audience >= 50000) m2
  WHERE m.match_no BETWEEN m2.FROM_ID AND m2.TO_ID;


-- 21. From the following table write a SQL query to know the availability of the doctor for consecutive 2 or more days. Return visiting days.
-- First try on my own
SELECT visiting_date
FROM dr_clinic d, (
  SELECT d1.availability AS "AVAIL_A", d2.availability AS "AVAIL_B"
  FROM dr_clinic d1, dr_clinic d2
  WHERE d1.availability = d2.availability+1
  AND d2.availability+1 = d1.availability+2) d2
  WHERE d.availability BETWEEN d2.AVAIL_A AND d2.AVAIL_B;

-- Given Solution
CREATE TABLE dr_clinic (visiting_date date primary key, availability bool);

INSERT INTO dr_clinic VALUES ('2016-06-11','1');
INSERT INTO dr_clinic VALUES ('2016-06-12','1');
INSERT INTO dr_clinic VALUES ('2016-06-13','0');
INSERT INTO dr_clinic VALUES ('2016-06-14','1');
INSERT INTO dr_clinic VALUES ('2016-06-15','0');
INSERT INTO dr_clinic VALUES ('2016-06-16','0');
INSERT INTO dr_clinic VALUES ('2016-06-17','1');
INSERT INTO dr_clinic VALUES ('2016-06-18','1');
INSERT INTO dr_clinic VALUES ('2016-06-19','1');
INSERT INTO dr_clinic VALUES ('2016-06-20','1');	   
INSERT INTO dr_clinic VALUES ('2016-06-21','1');

-- (Explain further)
SELECT DISTINCT a.visiting_date -- Retrieve only the unique value of visiting_date column
FROM dr_clinic a JOIN dr_clinic b -- Joining the dr_clinic table with itself. We're giving the first instance the alias a and the second instance the alias b so we can refer them seperately. This self-join is crucial for comparing rows withing the same table.
  ON ABS(a.visiting_date - b.visiting_date) = 1 -- Calculate the difference between the two visiting dates.
  -- ABS(..) takes the absolute value of this difference.
  -- = 1 checks if the absolute difference between the two visiting dates is exactly 1 day. This condition identifies pairs of records that are for consecutive days.
  AND a.availability = true AND b.availability = true -- This adds another condition to the join. It ensures that both the record from the first instance a and the record from the second instance b have their availability column set to True. This means we are only considering in ascending order.
ORDER BY a.visiting_date; -- Finally, this clause sorts the resulting distinct visiting_date values in ascending order.


-- Trying on my own
SELECT visiting_date
FROM dr_clinic a JOIN dr_clinic b ON ABS(a.visiting_date - b.visiting_date) = 1
AND a.availability = True AND b.availability = True
ORDER BY a.visiting_date;


-- 22. From the following tables find those customers who did not make any order to the supplier 'DCX LTD'. Return customers name.

-- First try on my own:
SELECT a.customer_name
FROM customers a JOIN orders b ON a.customer_id = b.customer_id
JOIN supplier c JOIN b.supplier_id = c.supllier_id
WHERE c.supplier_name <> 'DCX LTD';

-- Answer key:
DROP TABLE if exists customers;
CREATE TABLE customers (customer_id int, customer_name varchar(255), customer_city varchar(255), avg_profit int);
INSERT INTO customers  VALUES ('101', 'Liam','New York',25000);
INSERT INTO customers  VALUES ('102', 'Josh','Atlanta',22000);
INSERT INTO customers  VALUES ('103', 'Sean','New York',27000);
INSERT INTO customers  VALUES ('104', 'Evan','Toronto',15000);
INSERT INTO customers  VALUES ('105', 'Toby','Dallas',20000);

CREATE TABLE supplier (supplier_id int, supplier_name varchar(255), supplier_city varchar(255));
INSERT INTO supplier  VALUES ('501', 'ABC INC','Dallas');
INSERT INTO supplier  VALUES ('502', 'DCX LTD','Atlanta');
INSERT INTO supplier  VALUES ('503', 'PUC ENT','New York');
INSERT INTO supplier  VALUES ('504', 'JCR INC','Toronto');
	
CREATE TABLE orders (order_id int, customer_id int, supplier_id int, order_date Date, order_amount int);
INSERT INTO orders  VALUES (401, 103,501,'2012-03-08','4500');
INSERT INTO orders  VALUES (402, 101,503,'2012-09-15','3650');
INSERT INTO orders  VALUES (403, 102,503,'2012-06-27','4800');
INSERT INTO orders  VALUES (404, 104,502,'2012-06-17','5600');
INSERT INTO orders  VALUES (405, 104,504,'2012-06-22','6000');
INSERT INTO orders  VALUES (406, 105,502,'2012-06-25','5600');


SELECT * FROM customers;
SELECT * FROM supplier;
SELECT * FROM orders; 

-- Further explanation needed**
SELECT cus.customer_name
FROM customers cus
WHERE cus.customer_id 
NOT IN (SELECT ord.customer_id
FROM orders ord
LEFT JOIN supplier sup 
ON ord.supplier_id = sup.supplier_id
WHERE sup.supplier_name = 'DCX LTD');


-- 23. Table students contain marks of mathematics for several students in a class. It may same marks for more than one student.
-- From the following table write a SQL table to find the highest unique marks a student achieved. Return the marks.
-- First guess:
SELECT COUNT(DISTINCT marks_achieved) AS marks
FROM students;

-- Official solution:
CREATE TABLE students(student_id int, student_name varchar(255), marks_achieved int);

INSERT INTO students VALUES(1, 'Alex',87);
INSERT INTO students VALUES(2, 'Jhon',92);
INSERT INTO students VALUES(3, 'Pain',83);
INSERT INTO students VALUES(4, 'Danny',87);
INSERT INTO students VALUES(5, 'Paul',92);
INSERT INTO students VALUES(6, 'Rex',89);
INSERT INTO students VALUES(7, 'Philip',87);
INSERT INTO students VALUES(8, 'Josh',83);
INSERT INTO students VALUES(9, 'Evan',92);
INSERT INTO students VALUES(10, 'Larry',87);

SELECT * FROM students;

-- Further explanation needed***
SELECT MAX(marks_achieved) as marks -- Calculates the maximum value among the unique marks_achieved values retrieved from the inner query.
FROM (
	SELECT marks_achieved
	FROM students
	GROUP BY marks_achieved -- Group rows in the students table by the marks_achieved column
	HAVING COUNT(*) = 1 -- Filters out any duplicate values. Selecting only those marks_achieved values that appear exactly only once in the table
) z;

-- On my own
SELECT MAX(mark_achieved) as marks
FROM (
	SELECT mark_achieved
	FROM students
	GROUP BY mark_achieved
	HAVING COUNT(*) = 1
)z;


-- 24. In a hostel, each room contains two beds. After every 6 months a student have to change their bed with his or her room-mate.
-- From the following tables write a SQL query to find the new beds of the students in the hostel. Return original_bed_id, student_name, bed_id and student_new.

-- First try on my own:
SELECT a.bed_id AS original_bed_id, a.student_name, b.bed_id, bstudent_name AS student_new
FROM bed_info a
JOIN ben_info b ON a.bed_id = b.bed_id;

-- Sample solution
CREATE TABLE bed_info(bed_id int, student_name varchar(255));
INSERT INTO bed_info VALUES (101, 'Alex');
INSERT INTO bed_info VALUES (102, 'Jhon');
INSERT INTO bed_info VALUES (103, 'Pain');
INSERT INTO bed_info VALUES (104, 'Danny');
INSERT INTO bed_info VALUES (105, 'Paul');
INSERT INTO bed_info VALUES (106, 'Rex');
INSERT INTO bed_info VALUES (107, 'Philip');
INSERT INTO bed_info VALUES (108, 'Josh');
INSERT INTO bed_info VALUES (109, 'Evan');
INSERT INTO bed_info VALUES (110, 'Green');


SELECT bed_id AS original_bed_id,student_name,
    (CASE -- This is a CASE statement, which allows you to define different outcomes based on certain conditions. The result of this CASE statement will be a new value, and this new value is aliased as bed_id in the output, effectively overwriting the original bed_id for the result set.
        WHEN MOD(bed_id, 2) != 0 AND counts != bed_id THEN bed_id + 1 -- MOD(bd_id, 2) calculates the remainder when bed_id is divided by 2. If the remainder is not 0, it means bed_id is an odd number.
	-- counts != bed_id: This checks if the total count of rows in the bed_info table (which we'll see how counts is determined later), then the new bed_id will be the original bed_id plus 1.
        WHEN MOD(bed_id, 2) != 0 AND counts = bed_id THEN bed_id
        ELSE bed_id - 1 -- If neither of the WHEN conditions is met, it means the bed_id must be an even number(since the first WHEN condition checked for odd numbers). In this case, the new bed_id will be the original bed_id minus 1.
    END) AS bed_id,
    student_name AS student_new
FROM bed_info,
    (SELECT COUNT(*) AS counts
    FROM bed_info) AS bed_counts
ORDER BY bed_id ASC;


-- Trying to write the query again
SELECT bed_id AS original_bed_id, student_name
(CASE WHEN MOD(bed_id, 2) != 0 AND counts != bed_id THEN bed_id + 1
	WHEN MOD(bed_id, 2) != 0 AND counts = bed_id THEN bed_id
	ELSE bed_id - 1
	END) AS bed_id,
student_name AS student_new
FROM bed_info,
(SELECT COUNT(*) AS counts
	FROM bed_info) AS bed_counts
ORDER BY bed_id ASC;


-- 25. From the following table, write a SQL query to find the first login date for each customer. Return customer id, login date.

-- On my own: Querying for the selected columns
SELECT customer_id, (SELECT DISTINCT login_date FROM bank_trans) AS first_login
FROM bank_trans;

-- Sample Solution:
DROP TABLE IF EXISTS bank_trans;
CREATE TABLE bank_trans(trans_id int, customer_id int, login_date date);
INSERT INTO bank_trans VALUES (101, 3002, '2019-09-01');
INSERT INTO bank_trans VALUES (101, 3002, '2019-08-01');
INSERT INTO bank_trans VALUES (102, 3003, '2018-09-13');
INSERT INTO bank_trans VALUES (102, 3002, '2018-07-24');
INSERT INTO bank_trans VALUES (103, 3001, '2019-09-25');
INSERT INTO bank_trans VALUES (102, 3004, '2017-09-05');
SELECT * FROM bank_trans;

SELECT customer_id, MIN(login_date) first_login
FROM bank_trans
GROUP BY customer_id;

-- Try again
SELECT customer_id, MIN(login_date) AS first_login_date
FROM bank_trans
GROUP BY customer_id;


-- 26. From the following table, write a SQL query to find those salespersons whose commission is less than ten thousand. Return salesperson name, commission.

-- First try
SELECT salesman_name, commision_amt
FROM salesmast, commision
WHERE commision_amt < 10000;

SELECT a.salesman_name, b.commision_amt
FROM salesmast a
JOIN commision b ON a.salesman_id = b.salesman_id
WHERE b.commision_amt < 10000;

-- Sample solution
CREATE TABLE salemast(salesman_id int, salesman_name varchar(255), yearly_sale int);
INSERT INTO salemast VALUES (101, 'Adam', 250000);
INSERT INTO salemast VALUES (103, 'Mark', 100000);
INSERT INTO salemast VALUES (104, 'Liam', 200000);
INSERT INTO salemast VALUES (102, 'Evan', 150000);
INSERT INTO salemast VALUES (105, 'Blake', 275000);
INSERT INTO salemast VALUES (106, 'Noah', 50000);
SELECT * FROM  salemast;
CREATE TABLE commision (salesman_id int, commision_amt int);
INSERT INTO commision VALUES (101, 10000);
INSERT INTO commision VALUES (103, 4000);
INSERT INTO commision VALUES (104, 8000);
INSERT INTO commision VALUES (102, 6000);
INSERT INTO commision VALUES (105, 11000);
SELECT * FROM  commision;

SELECT s.salesman_name,c.commision_amt 
FROM salemast s LEFT JOIN
commision c
ON  s.salesman_id=c.salesman_id
WHERE c.commision_amt<10000;
