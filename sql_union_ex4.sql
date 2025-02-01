-- From the following table, write a SQL query to find the salespersons who generated the largest and smallest orders on each date. Return salesperson ID, name, order no., highest on/lowest on, order date.

-- First attempt:
SELECT salesman_id, name
FROM salesman
UNION
(SELECT salesman_id, ord_no, MAX(ord_no), MIN(ord_no), ord_date
FROM orders
GROUP BY salesman_id);

-- Second attempt:
SELECT S.salesman_id, S.name, A.ord_no, 'highest on ', A.ord_date
FROM salesman S, orders A
WHERE A.purch_amt =
(SELECT MAX(B.purch_amt)
FROM orders B
WHERE A.ord_no = B.ord_no)
UNION
SELECT X.salesman_id, X.name, C.ord_no, 'lowerst on', C.ord_date
FROM salesman X, orders C
WHERE C.purch_amt =
(SELECT MIN(D.purch_amt)
FROM orders D
WHERE C.ord_no = D.ord_no);

-- Final attempt:
SELECT S.salesman_id, S.name, A.ord_no, 'highest on', A.ord_date
FROM salesman S, orders A
WHERE S.salesman_id = A.salesman_id
AND A.purch_amt =
(SELECT MAX(B.purch_amt)
FROM orders B
WHERE A.ord_date = B.ord_date)
UNION
SELECT S.salesman_id, S.name, A.ord_no, 'lowerst on', A.ord_date
FROM salesman S, orders A
WHERE S.salesman_id = A.salesman_id
AND A.purch_amt =
(SELECT MIN(B.purch_amt)
FROM orders B
WHERE A.ord_date = B.ord_date);
