-- From the following tables, write a  SQL query to find the department name and the full name (first and last name) of the manager.

-- First attempt did not retrieve the correct output:
SELECT d.department_name, e.first_name || ' ' || e.last_name name_of_manager
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id;

-- Second attempt:
SELECT d.department_name, 
e.first_name || ' ' || e.last_name AS name_of_manager
FROM departments d
JOIN employees e 
  ON d.manager_id = e.employee_id;
