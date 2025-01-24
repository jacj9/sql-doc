-- 17. From the following table, write a SQL query to find the name of the country, city, and departments, which are running there.

-- First solution
SELECT c.country_name, l.city, d.department_name
FROM countries c
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id;

-- Second solution
SELECT country_name, city, department_name
FROM countries 
JOIN locations USING (country_id)
JOIN departments USING (location_id);
