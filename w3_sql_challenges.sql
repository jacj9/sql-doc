"""Practicing sql exercises in this document. The sql challenge exercises are from https://www.w3resource.com/sql-exercises/challenges-1/index.php"""

-- 1. From the following tables, write a SQL query to find the information on each salesperson of ABC Company. Return name, city, country and state of each salesperson.

SELECT first_name, last_name, city, state, country
FROM salesperson a
LEFT JOIN address ON a.salesperson_id = b.salesperson_id;


-- 2. From the following table, write a SQL query to find the third highest sale. Return sale amount.

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

SELECT MAX(sale_amt) AS getNthHighestSaleAmt
FROM salemast;


-- 4. From the following table, write a SQL query to find the marks, which appear at least thrice one after another without interruption. Return the number.

SELECT DISTINCT mark
FROM (
  SELECT mark,
          LAG(mark) OVER (ORDER BY id) AS prev_mark,
          LEAD(mark) OVER (ORDER BY id) AS next_mark
  FROM marks_table
  ) subquery
WHERE mark = prev_mark AND MARK = next_nark;
