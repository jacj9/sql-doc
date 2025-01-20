-- 14. From the following tables, write a SQL query to calculate the difference between the maximum salary of the job and the employee's salary. Return job title, employee name, and salary difference.

SELECT j.job_title, 
  e.first_name || ' ' || e.last_name AS employee_name, 
  j.max_salary - e.salary AS salary_difference
FROM employees e
JOIN jobs j ON e.job_id = j.job_id;
