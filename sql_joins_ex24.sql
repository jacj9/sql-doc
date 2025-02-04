-- From the following tables, write a SQL query to find full name (first and last name), and salary of all employees working in any department in the city of London.

-- First attempt:
SELECT e.first_name || ' ' || e.last_name AS full_name, e.salary, d.department_name, l.city
FROM employees e
JOIN departments d USING (department_id)
JOIN locations l USING (location_id)
WHERE l.city = 'London';

-- Cleaner query:
SELECT first_name || ' ' || last_name AS full_name, salary, department_name, city
FROM employees
JOIN departments USING (department_id)
JOIN locations USING (location_id)
WHERE city = 'London';
