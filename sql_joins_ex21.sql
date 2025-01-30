-- From the following tables, write a SQL query to find out which departments have at least two employees. Group the result set on country name and city. Return country name, city, and number.

-- First attempt:
SELECT C.country_name, L.city, COUNT(D.department_id) AS 'number'
FROM countries C
JOIN locations L ON C.country_id = L.country_id
JOIN departments D ON L.location_id = D.location_id
JOIN employees E ON D.department_id = E.department_id
GROUP BY C.country_name, L.city;


-- Second attempt: This one makes more sense
SELECT country_name, city, department_id
FROM countries
JOIN locations USING (country_id)
JOIN departments USING (location_id)
WHERE department_id IN
(SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id)>=2);


-- Final attempt
SELECT country_name, city, COUNT(department_id) AS num_employee
FROM countries
JOIN locations USING (country_id)
JOIN departments USING (location_id)
WHERE department_id IN
(SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id)>=2)
GROUP BY country_name, city;
