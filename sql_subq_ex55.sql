-- From the following table, write a SQL query to find those employees who have not had a job in the past. Return all the fields of employees.

SELECT *
FROM employees
WHERE employee_id NOT IN
(SELECT employee_id
FROM job_history);
