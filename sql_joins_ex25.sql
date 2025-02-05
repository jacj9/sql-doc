-- From the following tables, write a SQL query to find full name (first and last name), job title, start and end date of last jobs of employees who did not receive commissions.

-- First attempt:
SELECT e.first_name || ' ' || e.last_name AS full_name, j.job_title, jh.start_date, jh.end_date, e.employee_id
FROM jobs j
JOIN employees e USING (job_id)
JOIN job_history jh USING (employee_id)
WHERE e.commission_pct = 0;

