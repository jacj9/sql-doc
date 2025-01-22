-- 15. From the following table, write a SQL query to calculate the average salary, the number of employees receiving commissions in that department. Return department name, average salary and number of employees.

SELECT d.department_name, ROUNd(AVG(e.salary),2) AS average_salary, COUNT(e.employee_id) AS number_of_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;
