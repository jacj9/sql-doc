-- From the following table, write a SQL query to find employees who have previously worked as 'Sales Representatives'. Return all the fields of jobs.

-- Initial solution:
SELECT *
FROM jobs
WHERE job_id =
(SELECT job_id
FROM employees
WHERE employee_id IN
(SELECT employee_id
FROM job_history
WHERE job_id = 'SA_REP'));

-- Sample solution, and with the same output:
SELECT *
FROM jobs
WHERE job_id IN
(SELECT job_id
FROM employees
WHERE employee_id IN
(SELECT employee_id
FROM job_history
WHERE job_id = 'SA_REP'));
