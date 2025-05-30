-- 46. From the following tables, write a SQL query to find all employees whose department is located in London. Return first name, last name, salary, and department ID.

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id IN
(SELECT department_id
FROM departments
WHERE location_id =
(SELECT location_id
FROM locations
WHERE city='London'));
