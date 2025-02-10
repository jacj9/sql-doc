-- AI generated random SQL exercises for me to practice

"""
1. Here's an exercise that combines JOIN and SELECT to simulate a real-world cybersecurity scenario:
Scenario: You have two tables, Users and Logins, that store user information and login activity respectively. 
  You need to detect any suspicious login attempts by identifying users who have logged in from different 
  countries within a short period of time.
Table Structures:
Users table:
- id (INT)
- username (VARCHAR)
- email (VARCHAR)
Logins table:
- id (INT)
- user_id (INT)
- login_time (DATETIME)
- country_code (VARCHAR)
SQL Exercise:
1. Create and populate the Users and Logins tables with sample data.
2. Write a SQL query that joins the Users and Logins tables and selects users who have logged in 
  from different countries within a specific time frame (e.g., 1 hour).
"""
-- First attempt
SELECT u.id, u.username, l.login_time, l.country_code
FROM users u
JOIN logins l ON u.id = l.user_id
JOIN logins l2 ON l.id = l2.id
WHERE l.id != l2.id
  AND 


"""
SELECT u.id, u.username, u.email, l1.country_code as country_code1, l2.country_code as country_code2
FROM Users u
JOIN Logins l1 ON u.id = l1.user_id
JOIN Logins l2 ON u.id = l2.user_id
WHERE l1.id != l2.id
AND l1.login_time BETWEEN DATE_SUB(l2.login_time, INTERVAL 1 HOUR) AND l2.login_time
AND l1.country_code != l2.country_code
"""
