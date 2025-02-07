-- From the following table, write a SQL query to create a union of two queries that shows the customer id, cities, and ratings of all customers. Those with a rating of 300 or greater will have the words 'High Rating', while the others will have the words 'Low Rating'.

SELECT customer_id, city, grade, 'High Ratings'
FROM customer
WHERE grade >= 300

UNION

SELECT customer_id, city, grade, 'Low Ratings'
FROM customer
WHERE grade < 300

ORDER BY 3 ASC;
