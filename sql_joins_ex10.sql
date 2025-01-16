-- 10. From the following tables, write a SQL query to find out which employees have or do not have a department. Return first name, last name, department ID, department name.

SELECT E.first_name, E.last_name, E.department_id, D.department_name
FROM departments D
RIGHT JOIN employees E ON D.department_id = E.department_id;
