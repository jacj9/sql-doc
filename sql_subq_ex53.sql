-- 53. From the following table, write a SQL query to find the departments managed by Susan. Return all the fields of departments.

SELECT *
FROM departments
WHERE manager_id =
(SELECT employee_id
FROM employees
WHERE first_name = 'Susan');
