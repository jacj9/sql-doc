-- From the following tables, write a SQL query to calculate the number of days worked by employees in a department of ID 80. Return employee ID, job title, number of days worked.

SELECT H.employee_id, J.job_title, (H.end_date - H.start_date) AS "days"
FROM jobs J
JOIN job_history H ON J.job_id = H.job_id
WHERE H.department_id = 80;

-- Another attempt:
SELECT employee_id, job_title, end_date - start_date AS days
FROM jobs
NATURAL JOIN job_history
WHERE department_id = 80;
