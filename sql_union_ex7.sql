-- From the following tables, write a SQL query that appends strings to the selected fields, indicating whether the city of any salesperson is matched with the city of any customer. Return salesperson ID, name, city, MATCHED/NO MATCH.

-- First Attempt:
SELECT salesman_id, name, city, 'MATCHED'
FROM salesman
WHERE city = ANY
(SELECT city
FROM customer)

UNION

SELECT salesman_id, name, city, 'NO MATCH'
FROM salesman
WHERE NOT city = ANY
(SELECT city
FROM customer);
