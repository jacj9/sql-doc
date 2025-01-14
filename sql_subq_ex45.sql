-- 45. From the following table, write a SQL query to find those employees who earn less than the average salary and work at the department where Laura (first name) is employed. Return first name, last name, salary, and department ID.

-- My initial Solution:
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary <
(SELECT AVG(salary)
FROM employees)
AND department_id = 
(SELECT department_id
FROM employees
WHERE first_name = 'Laura');
