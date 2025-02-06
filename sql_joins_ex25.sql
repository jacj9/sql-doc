-- From the following tables, write a SQL query to find full name (first and last name), job title, start and end date of last jobs of employees who did not receive commissions.

-- First attempt:
SELECT e.first_name || ' ' || e.last_name AS full_name, j.job_title, jh.start_date, jh.end_date, e.employee_id
FROM jobs j
JOIN employees e USING (job_id)
JOIN job_history jh USING (employee_id)
WHERE e.commission_pct = 0;

-- Second attempt:

SELECT CONCAT(e.first_name, ' ', e.last_name) full_name, 
  j.job_title, 
  h.starting_date, 
  h.ending_date, 
  e.employee_id
FROM employees e
JOIN (SELECT MAX(start_date)starting_date, MAX(end_date)ending_date, employee_id
        FROM  job_history 
        GROUP BY employee_id) h ON e.employee_id = h.employee_id
JOIN jobs j ON e.job_id = j.job_id
WHERE e.commission_pct = 0;
