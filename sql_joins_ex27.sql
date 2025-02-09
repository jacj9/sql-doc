-- From the following tables, write a SQL query to find out the full name (first and last name) of the employee with an ID and the name of the country where he/she is currently employed.

-- First attempt
SELECT CONCAT(first_name, ' ', last_name) AS full_name, employee_id, country_name
FROM countries
JOIN locations USING (country_id)
JOIN departments USING (location_id)
JOIN employees USING (department_id);
