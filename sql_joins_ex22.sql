-- From the following tables, write a SQL query to find the department name, full name (first and last name) of the manager and their city.

-- First attempt:
SELECT department_name, first_name || ' ' || last_name AS name_of_manager, city
FROM employees E
JOIN departments D ON E.employee_id = D.manager_id
JOIN locations L ON D.location_id = L.location_id;
