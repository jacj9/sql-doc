-- From the following table, write a SQL query to find the employees and their managers. Return the first name of the employee and manager.

SELECT E.first_name AS Employee_Name, S.first_name As manager
FROM employees E
JOIN employees S ON E.manager_id = S.employee_id;
