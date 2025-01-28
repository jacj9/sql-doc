-- From the following table, write a SQL query to find the employees who earn $12000 or more. Return employee ID, starting date, end date, job ID and department ID.

SELECT j.employee_id, j.start_date, j.end_date,  j.job_id, j.department_id
FROM employees e
JOIN job_history j
ON e.employee_id = j.employee_id
WHERE e.salary >= 12000;
