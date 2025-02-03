-- From the following tables, write a SQL query to find the salespeople who generated the largest and smallest orders on each date. Sort the result-set on third field. Return salesperson ID, name, order no., highest on/lowest on, order date.

SELECT a.salesman_id, a.name, b.ord_no, 'highest on', b.ord_date
FROM salesman a, orders b
WHERE a.salesman_id = b.salesman_id
AND b.purch_amt =
(SELECT MAX(c.purch_amt)
FROM orders c
WHERE b.ord_date = c.ord_date)

UNION

SELECT a.salesman_id, a.name, b.ord_no, 'lowest on', b.ord_date
FROM salesman a, orders b
WHERE a.salesman_id = b.salesman_id
AND b.purch_amt =
(SELECT MIN(c.purch_amt)
FROM orders c
WHERE b.ord_date = c.ord_date)
-- Ordering the result set based on the third column (ord_no)
ORDER BY ord_no; -- You can also use ORDER BY 3
