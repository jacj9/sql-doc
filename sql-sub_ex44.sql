-- Minimum salary of a department which ID is 70
-- 44. From the following table, write a SQL query to find those employees who earn less than the minimum salary of a department of ID 70. Return first name, last name, salary, and department ID.

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary <
(SELECT MIN(salary)
FROM employees
WHERE department_id = 70);
