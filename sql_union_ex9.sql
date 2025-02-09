-- From the following table, write a SQL query to find those salespersons and customers who have placed more than one order. Return ID, name.

-- Attempt one
SELECT customer_id AS ID, cust_name AS name
FROM customer
WHERE customer_id = ANY
(SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1)

UNION

SELECT salesman_id, name
FROM salesman
WHERE salesman_id = ANY
(SELECT salesman_id
FROM orders
GROUP BY salesman_id
HAVING COUNT(*) > 1)

ORDER BY 2 ASC;


-- Second attempt
SELECT customer_id AS ID, cust_name AS name
FROM customer a
WHERE 1 <
(SELECT COUNT(*)
FROM orders b
WHERE a.customer_id = b.customer_id)

UNION

SELECT salesman_id AS ID, name
FROM salesman a
WHERE 1 <
(SELECT COUNT(*)
FROM orders b
WHERE a.salesman_id = b.salesman_id)

ORDER BY 2;
