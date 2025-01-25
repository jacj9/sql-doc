-- 54. From the following table, write a  SQL query to find those employees who earn the highest salary in a department. Return department ID, employee name, and salary.

SELECT department_id, 
first_name || ' ' || last_name AS employee_name, salary
FROM employees e
WHERE salary =
(SELECT MAX(salary)
FROM employees
WHERE department_id = e.department_id);
