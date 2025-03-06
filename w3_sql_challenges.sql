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

SELECT DISTINCT marks
FROM (
  SELECT marks,
          LAG(marks) OVER (ORDER BY student_id) AS prev_marks,
          LEAD(marks) OVER (ORDER BY student_id) AS next_marks
  FROM logs
  ) subquery
WHERE marks = prev_marks AND marks = next_narks;

-- Another Solution to get clarification tomorrow
SELECT DISTINCT L1.marks AS  ConsecutiveNums
FROM (logs L1 JOIN logs L2 ON L1.marks = L2.marks AND L1.student_id = L2.student_id-1)
JOIN logs L3 ON L1.marks = L3.marks AND L2.student_id = L3.student_id-1;
