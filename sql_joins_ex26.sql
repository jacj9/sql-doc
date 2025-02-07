-- From the following tables, write a SQL query to find the department name, department ID, and number of employees in each department.

-- First attempt:
SELECT d.department_name, d.department_id, COUNT(e.employee_id)no_employees
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id
ORDER BY 2 ASC;
