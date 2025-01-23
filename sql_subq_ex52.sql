-- 52. From the following table, write a SQL query to find those employees who earn the second-lowest salary of all the employees. Return all the fields of employees.

SELECT *
FROM employees
WHERE employee_id IN
  (SELECT employee_id
  FROM employees
  WHERE salary =
    (SELECT MIN(salary)
    FROM employees
    WHERE salary >
      (SELECT MIN(salary)
      FROM employees)));
