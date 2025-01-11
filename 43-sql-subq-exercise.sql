-- 43. From the following table, write a SQL query to find those employees who joined after the employee whose ID is 165. Return first name, last name and hire date.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >
(SELECT hire_date
  FROM employees
  WHERE employee_id = 165);

-- Alternative solution
SELECT first_name ||' '|| last_name AS full_name, hire_date
FROM employees
WHERE hire_date >
(SELECT hire_date
  FROM employees
  WHERE employee_id = 165);
