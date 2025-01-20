-- 14. From the following tables, write a SQL query to calculate the difference between the maximum salary of the job and the employee's salary. Return job title, employee name, and salary difference.

SELECT j.job_title, 
  e.first_name || ' ' || e.last_name AS employee_name, 
  j.max_salary - e.salary AS salary_difference
FROM employees e
JOIN jobs j ON e.job_id = j.job_id;

-- Other Solution:
-- Selecting specific columns (job_title, first_name || ' ' || last_name AS Employee_name, max_salary - salary AS salary_difference) from the 'employees' table
SELECT job_title, first_name || ' ' || last_name AS Employee_name, max_salary - salary AS salary_difference 

-- Performing a NATURAL JOIN between the 'employees' table and the 'jobs' table, where the join is implicitly based on columns with the same name in both tables
FROM employees 

NATURAL JOIN jobs;
