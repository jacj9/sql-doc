-- SQL Exercise: Employees who earn less than employee 182
--  7. From the following table, write a SQL query to find the employees who earn less than the employee of ID 182. Return first name, last name and salary.

SELECT e1.first_name, e1.last_name, e1.salary
FROM employees e1
JOIN employees e2 ON e1.employee_id = e2.employee_id
WHERE e1.salary <
(SELECT e2.salary
  FROM employees e2
  WHERE e2.employee_id = 182);

-- Alternative solution:
SELECT e.first_name, e.last_name, e.salary
FROM employees e
JOIN employees s ON e.salary < s.salary
AND s.employee_id = 182;
