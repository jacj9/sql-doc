-- From the following tables, write a SQL query to find all those salespeople and customers who are involved in the inventory management system. Return salesperson ID, customer ID.

SELECT salesman_id, customer_id
FROM orders
UNION
(SELECT salesman_id, customer_id
FROM customer);
