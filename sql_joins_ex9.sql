-- 9. From the following tables, write a SQL query to display the department name, city, and state province for each department.

SELECT D.department_name, L.city, L.state_province
FROM departments D
JOIN locations L ON D.location_id = L.location_id;
