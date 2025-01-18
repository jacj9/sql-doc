-- 48. From the following tables, write a SQL query to find those departments where maximum salary is 7000 and above. The employees worked in those departments have already completed one or more jobs. Return all the fields of the departments.

SELECT *
FROM departments
WHERE department_id IN
(SELECT department_id
FROM employees
WHERE employee_id IN
(SELECT employee_id
FROM job_history
GROUP BY employee_id
HAVING COUNT(employee_id)>=1)
GROUP BY department_id
HAVING MAX(salary) >=7000);
