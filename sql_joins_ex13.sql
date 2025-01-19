-- 13. From the following tables, write a SQL query to find all employees who joined on or after 1st January 1993 and on or before 31 August 1997. Return job title, department name, employee name, and joining date of the job.

SELECT j.job_title, d.department_name, e.first_name || ' ' || e.last_name AS employee_name, jh.start_date
FROM job_history jh
JOIN employees e ON jh.employee_id = e.employee_id
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON jh.department_id = d.department_id
WHERE jh.start_date >= '1993-01-01' 
  AND jh.start_date <= '1997-08-31';
