-- SQL Exercise: Departments which does not have any employee

-- 6. From the following tables, write a SQL query to find all departments, including those without employees. 
-- Return first name, last name, department ID, department name.

SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;
