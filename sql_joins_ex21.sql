-- From the following tables, write a SQL query to find out which departments have at least two employees. Group the result set on country name and city. Return country name, city, and number.

-- First attempt:
SELECT C.country_name, L.city, COUNT(D.department_id) AS 'number'
FROM countries C
JOIN locations L ON C.country_id = L.country_id
JOIN departments D ON L.location_id = D.location_id
JOIN employees E ON D.department_id = E.department_id
GROUP BY C.country_name, L.city;
