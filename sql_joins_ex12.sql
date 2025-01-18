-- 12. From the following tables, write a SQL query to find the employees who work in the same department as the employee with the last name Taylor. Return first name, last name and department ID.

-- My initial solution:
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IN
(SELECT department_id
FROM employees
WHERE last_name = 'Taylor');

-- Second attempt:
SELECT A.first_name, A.last_name, A.department_id
FROM employees A
JOIN employees B ON A.department_id = B.department_id AND B.last_name = 'Taylor';
