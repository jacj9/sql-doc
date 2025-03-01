"""Documenting my sql exercises in this document. The sql challenge exercises are from https://www.w3resource.com/sql-exercises/challenges-1/index.php"""

-- 1. From the following tables, write a SQL query to find the information on each salesperson of ABC Company. Return name, city, country and state of each salesperson.

SELECT first_name, last_name, city, state, country
FROM salesperson a
LEFT JOIN address ON a.salesperson_id = b.salesperson_id;
