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

TABLE: users: Contains user information.
user_id (INT, Primary Key)
account_creation_date (DATE)
country (VARCHAR)
account_status (VARCHAR, e.g., 'Active', 'Suspended', 'Closed')

TABLE: content
content_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
content_type (VARCHAR, e.g., 'Video', 'Post', 'Comment')
creation_date (DATE)

TABLE: content_reports: Contains reports of potentially abusive content.
report_id (INT, Primary Key)
content_id (INT, Foreign Key referencing a content table - not included here for simplicity)
reporting_user_id (INT, Foreign Key referencing users.user_id)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
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
-- First Attempt
SELECT reporting_user_id, COUNT(report_id) AS number_of_reports
  FROM content_reports
  WHERE report_date >= NOW() - INTERVAL 1 MONTH 
  GROUP BY reporting_user_id
  HAVING number_of_reports > 5;

-- Second Attempt
SELECT a.user_id, COUNT(b.report_id) AS number_of_reports
  FROM users a JOIN content_reports b ON a.user_id = b.reporting_user_id
  JOIN content c ON b.content_id = c.content_id
  WHERE report_date >= NOW() - INTERVAL 1 MONTH
  GROUP BY a.user_id
  HAVING number_of_reports > 5;
  
"""
2. Calculate the average time it takes to resolve a content report (i.e., go from 'Pending' to 'Reviewed', 'Actioned', or 'Dismissed'):

- Show the report_type and the average resolution time in days.
"""
-- First Attempt
  SELECT report_type,
  AVG(DATEDIFF(day, report_date, action_date)) AS avg_resolution_time_resolve
  FROM content_report a
  JOIN user_account_action b ON a.reporting_user_id = b.user_id
  WHERE a.status IN ('Reviewed', 'Actioned', 'Dismissed')
  GROUP BY report_type;
  
-- Second Attempt
SELECT report_type, AVG(DATEDIFF(DAY, report_date, report_date_status)) AS avg_resolution_time
  FROM content_reports
  WHERE status IN ('Reviewed', 'Actioned', 'Dismissed')
  GROUP BY report_type;


"""
3. Find users who were suspended more than once for 'Hate Speech':
- Show user_id and the number of suspensions.
"""
-- First Attempt
SELECT a.user_id, COUNT(a.action_type) AS number_of_suspensions
  FROM user_account_actions a 
  JOIN content_reports b ON a.user_id = b.reporting_user_id
  WHERE a.action_type = 'Suspension'
  AND b.report_type = 'Hate Speech'
  GROUP BY a.user_id
  HAVING number_suspensions > 1;

-- Second Attempt
SELECT user_id, COUNT(action_type) AS number_of_suspensions
  FROM user_account_actions
  WHERE action_type = 'Suspension'
  AND reason = 'Hate Speech'
  GROUP BY user_id
  HAVING number_of_suspensions > 1;


"""
4. Analyze the trend of 'Spam' reports over the last quarter:
- Show the date (grouped by week) and the number of 'Spam' reports.
"""
-- First Attempt
  SELECT report_date, COUNT(report_type) AS number_of_reports
  FROM content_reports
  WHERE report_type = 'Spam' AND report_date >= NOW() - INTERVAL 3 MONTH
  GROUP BY report_date = INTERVAL 1 WEEK;

-- Second Attempt
SELECT DATE_TRUNC('week', report_date) AS week_start_date, -- Show the date (grouped by week)
  COUNT(report_type) AS number_of_spam_reports
  FROM content_reports
  WHERE report_type = 'Spam' AND report_date >= NOW() - INTERVAL 3 MONTH
  GROUP BY DATE_TRUNC('week', report_date) -- To group the reports by the beginning of the week. This is the standard way to group by week
  ORDER BY week_start_date;

"""
5. Identify accounts created in the last year which are currently suspended and have had at least one content report marked as 'Actioned':
- Show the user_id, account_creation_date, and the number of 'Actioned' reports.
"""
-- First Attempt
SELECT a.user_id, a.account_creation_date, COUNT(b.status) AS number_of_actioned_reports
  FROM users a JOIN content_reports b ON a.user_id = b.reporting_user_id
  WHERE a.account_status = 'Suspended' 
  AND a.account_creation_date >= NOW() - INTERVAL 1 YEAR 
  AND b.status = 'Actioned'
  GROUP BY a.user_id;

-- Second Attempt
SELECT a.user_id, a.account_creation_date, COUNT(c.content_id) AS number_of_reports
  FROM users a 
  JOIN content_reports b ON a.user_id = b.reporting_user_id
  JOIN content c ON b.content_id = c.content_id
  WHERE a.account_status = 'Suspended'
  AND a.account_creation_date >= NOW() - INTERVAL 1 YEAR
  AND b.status = 'Actioned'
  GROUP BY a.user_id, b.account_creation_date;

"""
Bonus Question:

6.Write a query that identifies users who have both reported abusive content and had actions taken against their accounts. This could help identify potential patterns of retaliatory reporting or users who are both victims and perpetrators of abuse.

- Show the user_id and the number of reports they made and the number of actions taken against their accounts.
"""
-- First Attempt
SELECT a.user_id, COUNT(b.report_id) AS number_of_reports, COUNT(c.action_id) AS number_of_actions_taken
FROM users a
LEFT JOIN content_reports b ON a.user_id = b.reporting_user_id
LEFT JOIN user_account_actions c ON a.user_id = c.user_id
WHERE b.reporting_user_id = c.user_id
GROUP BY a.user_id;

-- Second Attempt
SELECT a.user_id, 
COUNT(DISTINCT b.report_id) AS number_of_reports,
COUNT(DISTINCT c.action_id) AS action_against
FROM users a
LEFT JOIN content_reports b ON a.user_id = b.reporting_user_id -- Join to get reports made by the user
LEFT JOIN user_account_actions c ON a.user_id = c.user_id -- Join to get actions agaiinst the user
WHERE b.report_id IS NOT NULL OR c.action_type IS NOT NULL 
GROUP BY a.user_id;
