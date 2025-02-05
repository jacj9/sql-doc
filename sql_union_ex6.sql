-- From the following tables, write a SQL query to find those salespeople who live in the same city where the customer lives as well as those who do not have customers in their cities by indicating 'NO MATCH'. Sort the result set on 2nd column (i.e. name) in descending order. Return salesperson ID, name, customer name, commission.

-- First attemtp:
SELECT s.salesman_id, s.name, c.cust_name, s.commission
FROM salesman s, customer c

UNION

SELECT s.salesman_id, s.name, c.cust_name, s.commission
FROM salesman s, customer c

ORDER BY 2;

-- Second attempt:
SELECT a.salesman_id, a.name, b.cust_name, a.commission
FROM salesman a, customer b
WHERE a.city = b.city

UNION

SELECT a.salesman_id, a.name, 'NO MATCH', a.commission
FROM salesman a, customer b
WHERE NOT a.city = ANY
(SELECT c.city
FROM customer c
WHERE b.city = c.city)

ORDER BY 2 DESC;
