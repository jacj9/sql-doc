-- 11. From the following table, write a SQL query to find the employees and their managers. Those managers do not work under any manager also appear in the list. Return the first name of the employee and manager.

SELECT E1.first_name AS "Employee Name", E2.first_name As "Manager"
FROM employees E1
LEFT JOIN employees E2 ON E1.manager_id = E2.employee_id;
