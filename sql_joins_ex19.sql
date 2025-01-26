-- From the following table, write a SQL query to calculate the average salary of employees for each job title.

-- First attempt:
SELECT j.job_title, AVG(e.salary)
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title

-- Second attempt:
SELECT job_title, AVG(salary)
FROM employees
NATURAL JOIN jobs -- perform NATURAL JOIN to join columns with the same name in both tables
GROUP BY job_title;
