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

-- Second attempt
SELECT u.id, u.username, u.email, l1.country_code as country1, l2.country_code as country2
FROM users u
JOIN logins l1 ON u.id = l1.user_id
JOIN logins l2 ON u.id = l2.user_id
WHERE l1.login_time BETWEEN DATE_SUB(l2.login_time, INTERVAL 1 HOUR) AND l2.login_time -- To subtract 1 hour from the l2.login_time
AND l1.country_code != l2.country_code;
  

""" Official Solution
SELECT u.id, u.username, u.email, l1.country_code as country_code1, l2.country_code as country_code2
FROM Users u
JOIN Logins l1 ON u.id = l1.user_id
JOIN Logins l2 ON u.id = l2.user_id
WHERE l1.id != l2.id
AND l1.login_time BETWEEN DATE_SUB(l2.login_time, INTERVAL 1 HOUR) AND l2.login_time
AND l1.country_code != l2.country_code
"""

"""
Scenario:

You are an Analyst at a social media company. You have access to a database with the following tables:

users: Contains user information.

user_id (INT, Primary Key)

account_creation_date (DATE)

country (VARCHAR)

account_status (VARCHAR, e.g., 'Active', 'Suspended', 'Closed')

content_reports: Contains reports of potentially abusive content.

report_id (INT, Primary Key)

content_id (INT, Foreign Key referencing a content table - not included here for simplicity)

reporting_user_id (INT, Foreign Key referencing users.user_id)

report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')

report_date (DATE)

status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

user_account_actions: Contains records of actions taken against user accounts.

action_id (INT, Primary Key)

user_id (INT, Foreign Key referencing users.user_id)

action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')

action_date (DATE)

reason (VARCHAR)

Exercise:

Write SQL queries to answer the following questions:

1. Identify users who have had more than 5 reports against their content in the last month:

 - Show user_id, and the number of reports.
"""

SELECT reporting_user_id, COUNT(report_id) AS number_of_reports
  FROM content_reports
  WHERE report_date >= NOW() - INTERVAL 1 MONTH 
  GROUP BY reporting_user_id
  HAVING number_of_reports > 5;
  
"""
2. Calculate the average time it takes to resolve a content report (i.e., go from 'Pending' to 'Reviewed', 'Actioned', or 'Dismissed'):

- Show the report_type and the average resolution time in days.
"""
SELECT report_type, AVG(DATEDIFF, report_date)
  FROM content_reports
  


"""
  3. Find users who were suspended more than once for 'Hate Speech':

- Show user_id and the number of suspensions.
"""

SELECT a.user_id, COUNT(a.action_type) AS number_of_suspensions
  FROM user_account_actions a 
  JOINS content_reports b ON a.user_id = b.reporting_user_id
  WHERE a.action_type = 'Suspension'
  AND b.report_type = 'Hate Speech'
  GROUP BY a.user_id
  HAVING number_suspensions > 1;

"""
4. Analyze the trend of 'Spam' reports over the last quarter:

- Show the date (grouped by week) and the number of 'Spam' reports.
"""

  SELECT report_date, report_type
  FROM content_reports
  WHERE report_type = 'Spam'
  GROUP BY report_date;

"""
5. Identify accounts created in the last year which are currently suspended and have had at least one content report marked as 'Actioned':

- Show the user_id, account_creation_date, and the number of 'Actioned' reports.
"""

SELECT a.user_id, a.account_creation_date, COUNT(b.status) AS number_of_actioned_reports
  FROM users a JOINS content_reports b ON a.user_id = b.reporting_user_id
  WHERE a.account_status = 'Suspended' 
  AND a.account_creation_date >= NOW() - INTERVAL 1 YEAR 
  AND b.status = 'Actioned'
  GROUP BY a.user_id;
  
"""
Bonus Question:

6.Write a query that identifies users who have both reported abusive content and had actions taken against their accounts. This could help identify potential patterns of retaliatory reporting or users who are both victims and perpetrators of abuse.

- Show the user_id and the number of reports they made and the number of actions taken against their accounts.
"""
