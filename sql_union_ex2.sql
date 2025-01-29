-- From the following tables, write a SQL query to find distinct salespeople and their cities. Return salesperson ID and city.

-- First attempt:
SELECT DISTINCT salesman_id, city
FROM salesman
UNION
(SELECT DISTINCT salesman_id, city
FROM customer);

