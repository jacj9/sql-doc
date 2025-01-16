-- 47. From the following tables, write a SQL query to find the city of the employee of ID 134. Return city.

SELECT city
FROM locations
WHERE location_id IN
(SELECT location_id
FROM departments
WHERE department_id =
(SELECT department_id
FROM employees
WHERE employee_id = 134));
