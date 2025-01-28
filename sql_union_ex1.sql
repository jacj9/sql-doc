-- From the following tables, write a SQL query to find all salespeople and customers located in the city of London.

SELECT salesman_id, name, 'Salesman'
FROM salesman
WHERE city = 'London'
UNION
(SELECT customer_id, cust_name, 'Customer'
FROM customer
WHERE city = 'London')
