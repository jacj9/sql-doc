-- 49. From the following tables, write a SQL query to find those departments where the starting salary is at least 8000. Return all the fields of departments.

SELECT *
FROM departments
WHERE department_id IN
(SELECT department_id
FROM employees
GROUP by department_id
HAVING MIN(salary) >= 8000);
