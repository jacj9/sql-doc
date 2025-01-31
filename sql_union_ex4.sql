-- From the following table, write a SQL query to find the salespersons who generated the largest and smallest orders on each date. Return salesperson ID, name, order no., highest on/lowest on, order date.

-- First attempt:
SELECT salesman_id, name
FROM salesman
UNION
(SELECT salesman_id, ord_no, MAX(ord_no), MIN(ord_no), ord_date
FROM orders
GROUP BY salesman_id);
