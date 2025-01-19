-- 50. From the following table, write a SQL query to find those managers who supervise four or more employees. Return manager name, department ID.

SELECT first_name || ' ' || last_name AS manager_name, department_id
FROM employees
WHERE employee_id IN
(SELECT manager_id
FROM employees
GROUP BY manager_id
HAVING COUNT(employee_id)>=4);
