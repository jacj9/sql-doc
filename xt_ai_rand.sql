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


"""
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
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""

"""
Here's one exercise for you:
Exercise:
Based on the database schema provided, write a SQL query to identify users who have had more than 5 reports against their content in the last month. 
Show the user_id and the number of reports.
"""
-- First Attempt
SELECT a.user_id, COUNT(b.report_id) AS number_reports
FROM users a
  JOIN content b ON a.user_id = b.user_id
  JOIN content_reports c ON b.content_id = c.content_id
WHERE b.report_date >= NOW() - INTERVAL 1 MONTH
GROUP BY a.user_id
HAVING number_reports > 5;

"""
Write a SQL query to find users who were suspended more than once for 'Hate Speech'. 
  Show the user_id and the number of suspensions.
"""
-- First attempt
SELECT a.user_id, COUNT(c.action_type) AS num_susp
FROM users a 
JOIN content_reports b ON a.user_id = b.reporting_user_id
JOIN user_account_action c ON a.user_id = c.user_id
WHERE b.report_type = 'Hate Speech'
AND c.action_type = 'Suspension'
GROUP BY a.user_id
HAVING  num_susp > 1;

-- Second attempt
SELECT user_id, COUNT(action_type) AS num_sus
FROM user_account_action
WHERE action_type = 'Suspension' AND reason = 'Hate Speech'
GROUP BY user_id
HAVING num_sus >1;


"""
Write a SQL query to analyze the trend of 'Spam' reports over the last quarter. 
Show the date (grouped by week) and the number of 'Spam' reports for each week.
"""
-- First Attempt
SELECT DATE_TRUNC('week', report_date) AS week_start date, COUNT(report_type) AS rep_spam_week
FROM content_reports
WHERE report_type = 'Spam'
AND report_date >= NOW() - INTERVAL 3 MONTH
GROUP BY week_start_date
ORDER BY week_start_date;


"""
Write a SQL query to identify accounts created in the last year which are currently suspended and have had at least one content report marked as 'Actioned'. 
Show the user_id, account_creation_date, and the number of 'Actioned' reports for each user.

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
"""
-- First Attempt
SELECT user_id, account_creation_date, COUNT(c.status) AS num_report
FROM users a
  JOIN content b ON a.user_id = b.user_id
  JOIN content_reports c ON b.content_id = c.content_id
WHERE a.account_status = 'Suspended'
  AND c.status = 'Actioned'
  AND a.account_creation_date >= NOW() - INTERVAL 1 YEAR
GROUP BY a.user_id
  HAVING num_report > 1;

-- Sample Solution
SELECT
    a.user_id,
    a.account_creation_date,
    COUNT(c.status) AS num_reports
FROM
    users a
JOIN
    content b ON a.user_id = b.user_id
JOIN
    content_reports c ON b.content_id = c.content_id
WHERE
    a.account_status = 'Suspended'
    AND c.status = 'Actioned'
    AND a.account_creation_date >= NOW() - INTERVAL 1 YEAR
GROUP BY
    a.user_id, a.account_creation_date -- Include account_creation_date in GROUP BY
HAVING
    num_reports >= 1; -- Changed to >= 1 to include those with 1 or more Actioned reports


"""
Write a SQL query to identify users who have both reported abusive content and had actions taken against their accounts. 
  Show the user_id and the number of reports they made, and the number of actions taken against their accounts.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
-- First Attempt
SELECT a.user_id, COUNT(b.report_id) AS num_rep, COUNT(c.action_id) AS num_act
FROM users a 
LEFT JOIN content_reports b ON a.user_id = b.reporting_user_id
LEFT JOIN user_account_actions c ON a.user_id = c.user_id
WHERE b.report_type IS NOT NULL 
  OR c.action_type IS NOT NULL
GROUP BY a.user_id;

-- Sample solution
SELECT
    u.user_id,
    COUNT(DISTINCT cr.report_id) AS reports_made,
    COUNT(DISTINCT uaa.action_id) AS actions_taken
FROM
    users u
LEFT JOIN
    content_reports cr ON u.user_id = cr.reporting_user_id
LEFT JOIN
    user_account_actions uaa ON u.user_id = uaa.user_id
WHERE cr.report_id IS NOT NULL AND uaa.action_id IS NOT NULL
GROUP BY
    u.user_id;


"""
Write a SQL query to identify the top 5 countries with the highest number of users who have had actions taken against their accounts. 
Show the country and the number of users with actions taken.

TABLE: users: Contains user information.
user_id (INT, Primary Key)
account_creation_date (DATE)
country (VARCHAR)
account_status (VARCHAR, e.g., 'Active', 'Suspended', 'Closed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
-- First Attempt
SELECT a.country, COUNT(DISTINCT b.user_id) AS num_acc_act
FROM users a
LEFT JOIN user_account_actions b ON a.user_id = b.user_id
WHERE b.action_id IS NOT NULL
GROUP BY a.country
ORDER BY num_acc_act DESC
LIMIT 5;


"""
Write a SQL query to find the top 3 most common reasons for user account suspensions. 
Show the reason and the number of suspensions for each reason.

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
SELECT reason, COUNT(action_type) AS num_susp
FROM user_account_actions
WHERE action_type = 'Suspension'
GROUP BY reason
ORDER BY num_susp DESC
LIMIT 3;


"""
Write a SQL query to find the weekly number of new user account creations for the past quarter. 
Show the week starting date and the number of new accounts created in that week.

TABLE: users: Contains user information.
user_id (INT, Primary Key)
account_creation_date (DATE)
country (VARCHAR)
account_status (VARCHAR, e.g., 'Active', 'Suspended', 'Closed')
"""
SELECT DATE_TRUNC('week', account_creation_date) AS week_start_date, COUNT(user_id) AS new_acc
FROM users
WHERE account_creation_date >= NOW() - INTERVAL 3 MONTH
GROUP BY week_start_date
ORDER BY new_acc DESC;


"""
Write a SQL query to identify the users who have the highest number of reports made by them. 
Show the user ID and the number of reports made. 
Limit the results to the top 10 users.

TABLE: content_reports: Contains reports of potentially abusive content.
report_id (INT, Primary Key)
content_id (INT, Foreign Key referencing a content table - not included here for simplicity)
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
SELECT reporting_user_id, COUNT(report_id) AS num_rep
FROM content_reports
GROUP BY reporting_user_id
ORDER BY num_rep DESC
LIMIT 10;


"""
Write a SQL query to find the content that has received the most reports. Show the content_id and the number of reports for each content item, and limit the results to the top 10.

TABLE: content
content_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
content_type (VARCHAR, e.g., 'Video', 'Post', 'Comment')
creation_date (DATE)

TABLE: content_reports: Contains reports of potentially abusive content.
report_id (INT, Primary Key)
content_id (INT, Foreign Key referencing a content table - not included here for simplicity)
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""

SELECT a.content_id, COUNT(report_id) AS num_repo
FROM content a 
JOIN content_reports b ON a.content_id = b.content_id
GROUP BY a.content_id
ORDER BY num_repo DESC
LIMIT 10;


"""
Write a SQL query to identify users who have been reported for 'Harassment' at least once, but have not yet had any account actions (e.g., Suspension, Warning, Account Closure) taken against them. 
Show the user_id, account_creation_date, and the number of 'Harassment' reports they've received.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""

SELECT a.user_id, a.account_creation_date, COUNT(c.report_type) AS num_report
FROM users a 
JOIN content b ON a.user_id = b.user_id
JOIN content_reports c ON b.content_id = c.content_id
LEFT JOIN user_account_actions d ON a.user_id = d.user_id
WHERE c.report_type = 'Harassment' AND d.action_type IS NULL
GROUP BY a.user_id, a.account_creation_date
ORDER BY a.user_id, a.account_creation_date
HAVING num_report >=1;


"""
Write a SQL query to identify the top 5 users who have made the most reports of 'Hate Speech'. 
Show their user_id and the total number of 'Hate Speech' reports they have submitted.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
SELECT a.user_id, COUNT(c.report_type) AS num_rep
FROM users a
JOIN content b ON a.user_id = b.user_id
JOIN content_reports c ON a.user_id = c.reporting_user_id
WHERE c.report_type = 'Hate Speech'
GROUP by a.user_id
ORDER BY num_rep DESC
LIMIT 5;


"""
Write a SQL query to calculate the percentage of users who have had their account status changed to 'Suspended' within 30 days of their account creation.
Show the total number of users created in the last year, and the percentage of those users who were suspended within 30 days of creation.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
-- First attempt (Incorrect)
SELECT COUNT(user_id) AS num_year, ((SELECT COUNT(user_id) AS acc_susp 
                                      FROM users 
                                        WHERE account_creation_date >= NOW() - INTERVAL 30 DAY
                                        AND account_status = 'Suspended'
                                          GROUP BY acc_sus)/100)*10 AS pct_acc_sup
FROM users
WHERE account_creation_date >= NOW() - INTERVAL 1 YEAR 
GROUP BY num_year;


-- ***Corrected query **Sample Solution** ----
SELECT
  -- Total users created in the last year
    (SELECT COUNT(user_id) FROM users WHERE account_creation_date >= NOW() - INTERVAL 1 YEAR) AS total_users_last_year,
    -- Percentage calculation
  (CAST(COUNT(DISTINCT u.user_id) AS DECIMAL) * 100.0 /
     (SELECT COUNT(user_id) FROM users WHERE account_creation_date >= NOW() - INTERVAL 1 YEAR)) AS percentage_suspended
FROM
    users u
JOIN
    user_account_actions uaa ON u.user_id = uaa.user_id
WHERE
    u.account_creation_date >= NOW() - INTERVAL 1 YEAR -- Account created in the last year
    AND uaa.action_type = 'Suspension' -- Account was a suspension
    AND uaa.action_date <= u.account_creation_date + INTERVAL 30 DAY -- Suspension within the first 30 days after creation
    AND uaa.action_date >= u.account_creation_date; -- Ensure that the action date is not before acccount creation date


-- Another attempts
"""
Write a SQL query to calculate the percentage of users who have had their account status changed to 'Suspended' within 30 days of their account creation.
Show the total number of users created in the last year, and the percentage of those users who were suspended within 30 days of creation.

TABLE: users: Contains user information.
user_id (INT, Primary Key)
account_creation_date (DATE)
country (VARCHAR)
account_status (VARCHAR, e.g., 'Active', 'Suspended', 'Closed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
SELECT (SELECT COUNT(user_id) FROM users WHERE account_creation_date >= NOW() - INTERVAL 1 YEAR) AS acc_created_year, 
      (CAST(COUNT(DISTINCT b.user_id) AS DECIMAL)*100 / 
        (SELECT COUNT(user_id) FROM users WHERE account_creation_date >= NOW() - INTERVAL 1 YEAR)) AS prct_susp
FROM users a 
JOIN user_account_actions b ON a.user_id = b.user_id
WHERE 
  a.account_creation_date >= NOW() - INTERVAL 1 YEAR
  AND b.action_type = 'Suspension'
AND b.action_date <= a.account_creation_date + INTERVAL 30 DAY
AND b.action_date >= a.account_creation_date;


"""
Write a SQL query to identify users who received a 'Warning' action, and then later received a more severe action ('Suspension' or 'Account Closure').

Show the user_id, the action_date of their initial 'Warning', and the action_date of their subsequent 'Suspension' or 'Account Closure'. Ensure that the severe action occurred after the warning.

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
-- First attempt
SELECT user_id, 
  action_date, 
  (SELECT action_date FROM user_account_actions WHERE action_type = 'Warning' ) AS after_warning
FROM user_account_ations
WHERE after_warning < 
  (SELECT action_date 
  FROM user_account_actions 
  WHERE action_type IN ('Suspension', 'Account Closure'));

-- Sample Solution
SELECT DISTINCT
    w.user_id,
    w.action_date AS warning_date,
    sa.action_date AS severe_action_date
FROM
    user_account_actions w -- Alias for the 'Warning' actions
JOIN
    user_account_actions sa ON w.user_id = sa.user_id -- Join to find severe actions for the *same* user
WHERE
    w.action_type = 'Warning' -- Filter for the initial warning
    AND sa.action_type IN ('Suspension', 'Account Closure') -- Filter for the subsequent severe action
    AND sa.action_date > w.action_date; -- Ensure the severe action happened *after* the warning

-- Another attempt
"""
Write a SQL query to identify users who received a 'Warning' action, and then later received a more severe action ('Suspension' or 'Account Closure').

Show the user_id, the action_date of their initial 'Warning', and the action_date of their subsequent 'Suspension' or 'Account Closure'. Ensure that the severe action occurred after the warning.

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
SELECT a.user_id, a.action_date, b.action_date
FROM user_account_actions a
JOIN user_account_actions b ON a.user_id = b.user_id
WHERE a.action_type = 'Warning'
AND b.action_type IN ('Suspension', 'Account Closure')
AND a.action_date < b.action_date;


"""
Write a SQL query to identify users who reported content that was later determined to be not abusive (i.e., the content_report's status was set to 'Dismissed').

Show the user_id of the reporting user and the report_id of the dismissed report.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
-- First attempt(Incorrect)
  SELECT a.reporting_user_id, b.report_id
FROM content_reports a
JOIN content_reports b ON a.report_id = b.report_id
WHERE a.report_date < b.report_date
AND a.status IN ('Pending', 'Reviewed', 'Actioned')
AND b.status = 'Dimissed';

-- Sample solution
SELECT
    reporting_user_id,
    report_id
FROM
    content_reports
WHERE
    status = 'Dismissed';

-- Another attempt (27-05-2025)
"""
Write a SQL query to identify users who reported content that was later determined to be not abusive (i.e., the content_report's status was set to 'Dismissed').
Show the user_id of the reporting user and the report_id of the dismissed report.

TABLE: content_reports: Contains reports of potentially abusive content.
report_id (INT, Primary Key)
content_id (INT, Foreign Key referencing a content table - not included here for simplicity)
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
SELECT reporting_user_id, report_id
FROM content_reports
WHERE status = 'Dismissed';
  
  
"""
Write a SQL query to identify the top 3 content_type that have received the highest number of total reports.
Show the content_type and the total count of reports for each.

TABLE: content
content_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
content_type (VARCHAR, e.g., 'Video', 'Post', 'Comment')
creation_date (DATE)

TABLE: content_reports: Contains reports of potentially abusive content.
report_id (INT, Primary Key)
content_id (INT, Foreign Key referencing a content table - not included here for simplicity)
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
SELECT a.content_type, COUNT(b.report_id) AS num_rep
FROM content a
JOIN content_reports b ON a.content_id = b.content_id
GROUP BY a.content_type
ORDER BY num_rep DESC
LIMIT 3;


"""
Write a SQL query to find the user_id of accounts that were created in the last 6 months and have a current account_status of 'Active', but have no associated content reports (of any type) submitted against them within the last 3 months.
Show the user_id and their account_creation_date.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
-- First attempt(Incorrect)
  SELECT a.user_id, a.account_creation_date
  FROM users a
  JOIN user_account_actions b ON a.user_id = b.user_id
  WHERE a.account_creation_date = NOW() - INTERVAL 6 MONTH
  AND a.account_status = 'Active'
  AND b.action_id IS NULL
  AND b.action_date < NOW() - INTERVAL 3 MONTH
  AND a.action_creation_date < b.action_date;

-- Sample Solution
SELECT
    u.user_id,
    u.account_creation_date
FROM
    users u
LEFT JOIN
    content c ON u.user_id = c.user_id -- Link users to their content
LEFT JOIN
    content_reports cr ON c.content_id = cr.content_id
    AND cr.report_date >= NOW() - INTERVAL 3 MONTH -- Only consider reports within the last 3 months for the join
WHERE
    u.account_creation_date >= NOW() - INTERVAL 6 MONTH -- Accounts created in the last 6 months
    AND u.account_status = 'Active' -- Account is currently active
    AND cr.report_id IS NULL; -- No reports found for this user's content within the last 3 months

-- Another attempt
SELECT a.user_id, a.account_creation_date
  FROM users a
  LEFT JOIN content b ON a.user_id = b.user_id
  LEFT JOIN content_reports c ON b.content_id = c.content_id
  AND c.report_date >= NOW() - INTERVAL 3 MONTH
  WHERE a.account_creation_date >= NOW() - INTERVAL 6 MONTH
  AND a.account_status = 'Active'
  AND c.report_id IS NULL;
  
"""
Write a SQL query to identify users who have submitted at least one content report, but have never had any account actions (e.g., 'Suspension', 'Warning', 'Account Closure') taken against their own account.
Show the user_id and the total number of reports they have made.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
SELECT a.user_id, COUNT(b.report_id) AS num_report
FROM users a
LEFT JOIN content_reports b ON a.user_id = b.reporting_user_id
LEFT JOIN user_account_actions c ON a.user_id = c.user_id
WHERE c.action_type IS NULL
GROUP BY a.user_id
ORDER BY num_report
HAVING num_report >= 1;


"""
2025-05-31
Exercise:
Write a SQL query to calculate the average number of content reports submitted by users who have submitted at least one report.
The result should be a single numerical value (the average).

TABLE: content_reports: Contains reports of potentially abusive content.
report_id (INT, Primary Key)
content_id (INT, Foreign Key referencing a content table - not included here for simplicity)
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

"""
-- First Attempt (INCORRECT)
SELECT AVG(COUNT(content_id))
FROM content_reports
HAVING COUNT(content_id) >=1;

-- Sample Solution
SELECT
    AVG(reports_made) AS average_reports_per_active_reporter
FROM (
    SELECT
        reporting_user_id,
        COUNT(report_id) AS reports_made
    FROM
        content_reports
    GROUP BY
        reporting_user_id
    HAVING
        COUNT(report_id) >= 1 -- Ensures we only consider users who submitted at least one report
) AS subquery_user_reports;

-- Second Attempt
SELECT AVG(num_report) AS avg_num_rep_users
FROM (SELECT reporting_user_id, COUNT(report_id) AS num_report
    FROM content_reports
  GROUP BY reporting_user_id
  HAVING num_report >=1
  ) AS num_user_report;

"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
  
"""
Write a SQL query to calculate the Monthly Active Users (MAU) who have also submitted at least one content report within that same month.
Show the month (e.g., 'YYYY-MM') and the count of such users for each month in the last year.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
-- 07 June 2025
-- First Attempt (Wrong)
SELECT TO_CHAR(account_creation_date, 'YYYY-MM') AS MAU, 
        COUNT(b.reporting_user_id) AS us_ea_month
FROM users a 
JOIN content_reports b ON a.user_id = b.reporting_user_id
  AND (SELECT TO_CHAR(account_creation_date, 'YYYY-MM') AS month,
    COUNT(reporting_user_id) AS user
    FROM users, content_reports 
    WHERE report_date = NOW() - INTERVAL 1 MONTH
    GROUP BY month
    HAVING us_ea_month >= 1) monthly
WHERE a.account_creation_date = NOW() - INTERVAL 1 YEAR
GROUP BY us_ea_month;

-- Sample Solution 08 June 2025
SELECT
    TO_CHAR(report_date, 'YYYY-MM') AS report_month,
    COUNT(DISTINCT reporting_user_id) AS monthly_active_reporters
FROM
    content_reports
WHERE
    report_date >= NOW() - INTERVAL '1 year' -- Filter reports within the last year
GROUP BY
    TO_CHAR(report_date, 'YYYY-MM') -- report_month
ORDER BY
    report_month;

-- On my own
SELECT 
  TO_CHAR(report_date, 'YYYY-MM') AS report_month,
  COUNT(DISTINCT reporting_user_id) AS monthly_active_reporters
FROM content_reports
WHERE
  report_date >= NOW() - INTERVAL 1 YEAR
GROUP BY
report_month
ORDER BY
report_month;


"""
Write a SQL query to identify content_type that have a high volume of reports but a low percentage of those reports resulting in an 'Actioned' status. 
This could indicate content types that are frequently reported but rarely found to be in violation.
Show the content_type, the total_reports_count for that type, and the percentage_actioned (calculated as (number of 'Actioned' reports / total reports for that content type) * 100). 
Limit the results to content types with at least 100 total reports.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""

-- Correction Sample Solution
SELECT
    c.content_type,
    COUNT(cr.report_id) AS total_reports_count, -- counts all reports for each content_type after grouping
    CAST(SUM(CASE WHEN cr.status = 'Actioned' THEN 1 ELSE 0 END) AS DECIMAL) * 100.0 / COUNT(cr.report_id) AS percentage_actioned 
  -- Counts only reports where the status is 'Actioned'
  -- For every row where the status is 'Actioned', it counts 1; 
  -- otherwise, it counts 0. SUM() then totals these 1s for the group, giving you the number of 'Actioned' reports.
  -- CAST(... AS DECIMAL) * 100.0 / COUNT(cr.report_id): This ensures floating-point division and multiplies by 100 to get the percentage.
FROM
    content cr
JOIN
    content_reports cr_join ON c.content_id = cr_join.content_id -- Joining content to content_reports
GROUP BY
    c.content_type
HAVING
    COUNT(cr.report_id) >= 100 -- High volume of reports (at least 100) - This correctly filters for content types with at least 100 total reports.
    AND (CAST(SUM(CASE WHEN cr.status = 'Actioned' THEN 1 ELSE 0 END) AS DECIMAL) * 100.0 / COUNT(cr.report_id)) < <YOUR_LOW_PERCENTAGE_THRESHOLD>;
    -- Example: AND (CAST(SUM(CASE WHEN cr.status = 'Actioned' THEN 1 ELSE 0 END) AS DECIMAL) * 100.0 / COUNT(cr.report_id)) < 20 -- for less than 20% actioned
-- You need to define what "low percentage" means (e.g., less than 20%, less than 10%). I've put a placeholder YOUR_LOW_PERCENTAGE_THRESHOLD
ORDER BY
    percentage_actioned ASC; -- Order by lowest percentage to show 'low percentage' types first

-- On my own (Practice)
select c.content_type, count(cr.report_id) as total reports_count, cast(sum(case when cr.status = 'Actioned' then 1 else 0 end) as decimal) * 100.0 / count(cr.report_id) as percentage_actioned
from content cr join content_report cr_join on cr.content_id = cr_join.content_id
group by cr.content_type
having count(cr.report_id) > 100
AND percentatage_actioned < 0.20
order by percentage_actioned ASC;


"""
Write a SQL query to calculate the percentage of content created in the last 6 months that has received at least one report. Break this down by content_type.
Show the content_type, the total_content_items_created_last_6_months, and the percentage_reported_at_least_once.
Note: Assume a content table with content_id, content_type, and creation_date.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

"""
-- SOLUTION
SELECT
    c.content_type,
    COUNT(c.content_id) AS total_content_items_created_last_6_months,
    CAST(COUNT(DISTINCT CASE WHEN cr.report_id IS NOT NULL THEN c.content_id END) AS DECIMAL) * 100.0 / COUNT(c.content_id) AS percentage_reported_at_least_once
  -- CAST(... AS DECIMAL) * 100.0 / COUNT(c.content_id): This performs the division, 
    -- ensuring floating-point arithmetic by casting the numerator to DECIMAL and multiplying by 100.0 for the percentage. 
  --CASE WHEN cr.report_id IS NOT NULL THEN c.content_id END: This expression returns the content_id only 
    -- if there was a matching report in the content_reports table (meaning cr.report_id is not NULL from the LEFT JOIN). If there's no report, it returns NULL.
FROM
    content c
LEFT JOIN
    content_reports cr ON c.content_id = cr.content_id 
  -- LEFT JOIN: This is crucial because we want to include all content items created in the last 6 months, even those that have not received any reports.
  -- If we used an INNER JOIN, content without reports would be excluded.
WHERE
    c.creation_date >= NOW() - INTERVAL 6 MONTH -- Filter content created in the last 6 months
GROUP BY
    c.content_type -- This aggregates the results for each unique content_type
ORDER BY
    c.content_type;

"""
Write a SQL query to identify users who are "heavy reporters" relative to their content creation. 
Specifically, find users who have submitted at least 5 reports AND whose total number of reports is more than twice their total number of content items created.

Show the user_id, their total_reports_submitted, and their total_content_created.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
-- Sample SOLUTION
SELECT
    u.user_id,
    COUNT(cr.report_id) AS total_reports_submitted,
    COUNT(c.content_id) AS total_content_created
FROM
    users u
LEFT JOIN
    content_reports cr ON u.user_id = cr.reporting_user_id -- Link users to reports they submitted
LEFT JOIN
    content c ON u.user_id = c.user_id -- Link users to content they created
GROUP BY
    u.user_id
HAVING
    COUNT(cr.report_id) >= 5 -- User submitted at least 5 reports
    AND COUNT(cr.report_id) > (2 * COUNT(c.content_id)) -- Total reports is more than twice total content created
ORDER BY
    total_reports_submitted DESC, total_content_created ASC;

"""
Using the database schema we've discussed (users, content_reports, user_account_actions, and content), answer the following:

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

Exercise:

Count Total Reports: Write a SQL query to find the total number of content reports in the content_reports table.

Count Reports by Type: Write a SQL query to count how many reports there are for each report_type (e.g., 'Spam', 'Harassment', 'Hate Speech'). Show the report_type and its count.
"""

SELECT COUNT(report_id) AS total_num, report_type
FROM content_reports
GROUP BY report_type
ORDER BY total_num;

"""
Using the database schema we've discussed (users, content_reports, user_account_actions, and content), answer the following:

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

This exercise focuses on grouping and counting from a single table.

Exercise:

Count Total Actions per User: Write a SQL query to count the total number of actions (e.g., Suspensions, Warnings) taken against each user in the user_account_actions table. Show the user_id and the total_actions_count.

Filter and Count Specific Actions: Write a query to count only the 'Suspension' actions for each user. Show the user_id and the total_suspensions.
"""
SELECT
    user_id,
    COUNT(action_id) AS total_actions_count
FROM
    user_account_actions
GROUP BY
    user_id;

SELECT
    user_id,
    COUNT(action_id) AS total_suspensions
FROM
    user_account_actions
WHERE
    action_type = 'Suspension'
GROUP BY
    user_id;


"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

Your task is to write a SQL query that shows the total number of content items created by each user who has received at least one account action (like a Warning or Suspension).

Your query should join the users, content, and user_account_actions tables.

Show the user_id and the total_content_created.
"""
SELECT u.user_id, COUNT(c.content_id) AS total_content_created
FROM users u
JOIN content c ON u.user_id = c.user_id
JOIN user_account_actions ua ON u.user_id = ua.user_id
GROUP BY u.user_id
ORDER BY total_content_created;

"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

SQL Exercise: Unreported Content Creators

This exercise will give you practice with a LEFT JOIN to find data that doesn't have a matching record in another table.

Your task is to write a SQL query that identifies users who have created content but have never had any of their content items reported.

Show the user_id and the total_content_items they have created.
"""
SELECT u.user_id, COUNT(content_id) AS total_content_items
FROM users u LEFT JOIN content c ON u.user_id = c.user_id
LEFT JOIN content_reports cr ON c.content_id = cr.content_id
WHERE cr.report_id IS NULL
GROUP BY
    u.user_id
ORDER BY
    total_content_items DESC;


"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

SQL Exercise: Users with Multiple Warnings

This exercise will give you practice with a WHERE clause to filter rows and a HAVING clause to filter aggregated results.

Your task is to write a SQL query to identify users who have received more than three 'Warning' actions.

Show the user_id and the total_warnings.
"""
SELECT
    user_id,
    COUNT(action_id) AS total_warnings
FROM
    user_account_actions
WHERE
    action_type = 'Warning'
GROUP BY
    user_id
HAVING
    COUNT(action_id) > 3
ORDER BY
    total_warnings DESC;


"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
"""
SQL Exercise: Behavioral Flagging

This exercise will give you practice connecting multiple tables to identify users based on specific behavior.

Your task is to write a SQL query to identify users who have both created at least one content item and submitted more than two 'Spam' reports.

Show the user_id, the total_content_created, and the total_spam_reports_submitted.
"""

SELECT
    u.user_id,
    -- Count the number of unique content items created by each user.
    -- We use COUNT(DISTINCT...) to ensure if a user created content, it's counted only once,
    -- even if that content was joined to multiple reports.
    COUNT(DISTINCT c.content_id) AS total_content_created,
    -- This is a conditional count. We use a CASE statement inside a COUNT to only
    -- count the reports where the report_type is 'Spam'.
    COUNT(CASE WHEN cr.report_type = 'Spam' THEN cr.report_id END) AS total_spam_reports_submitted
FROM
    users u
-- LEFT JOIN ensures all users are included, even if they haven't created content yet.
LEFT JOIN
    content c ON u.user_id = c.user_id
-- LEFT JOIN ensures all users are included, even if they haven't submitted any reports.
LEFT JOIN
    content_reports cr ON u.user_id = cr.reporting_user_id
-- GROUP BY is essential to aggregate the counts for each individual user.
GROUP BY
    u.user_id
-- HAVING filters the aggregated results based on the conditions from the prompt.
-- We check for users with at least 1 content item AND more than 2 spam reports.
HAVING
    COUNT(DISTINCT c.content_id) >= 1
    AND COUNT(CASE WHEN cr.report_type = 'Spam' THEN cr.report_id END) > 2
-- Order the results to make them easier to read.
ORDER BY
    total_spam_reports_submitted DESC, total_content_created DESC;


"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
"""
SQL Exercise: Behavioral Flagging

This exercise will give you practice connecting multiple tables to identify users based on specific behavior.

Your task is to write a SQL query to identify users who have both created at least one content item and submitted more than two 'Spam' reports.

Show the user_id, the total_content_created, and the total_spam_reports_submitted.
"""
SELECT u.user_id, 
    COUNT(DISTINCT c.content_id) AS total_content_created,
    COUNT(CASE WHEN cr.report_type = 'Spam' THEN cr.report_id END) AS  total_spam_reports_submitted
FROM users u 
  LEFT JOIN content c ON u.user_id = c.user_id
  LEFT JOIN conten_reports cr ON cr.reporting_user_id = u.user_id
GROUP BY u.user_id
  HAVING total_spam_reports_submitted > 2
  AND total_content_created >= 1
ORDER BY total_content_created, total_spam_reports_submitted;


"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
"""
SQL Exercise: Unreported Content

This exercise will give you practice with a core data analysis pattern: finding records in one table that have no matching records in another.

Your task is to write a SQL query that identifies all content items that have never received a report.

Show the content_id, content_type, and creation_date for each unreported content item.
"""
SELECT
    c.content_id,
    c.content_type,
    c.creation_date
FROM
    content c
LEFT JOIN
    content_reports cr ON c.content_id = cr.content_id -- Note: Fixed typo from 'content_report' to 'content_reports'
WHERE
    cr.report_id IS NULL; -- This correctly filters for content that had NO match in the reports table


"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
"""
SQL Exercise: Prolific Reporters with Clean Records

This exercise focuses on identifying users who actively submit reports but have never had any account actions taken against them. This is a pattern often analyzed for potential malicious or retaliatory reporting.

Your task is to write a SQL query to identify users who have submitted at least one content report, but have never had any account actions (e.g., 'Suspension', 'Warning', 'Account Closure') taken against their own account.

Show the user_id and the total number of reports they have made.
"""
SELECT
    u.user_id,
    COUNT(cr.report_id) AS total_number_reports
FROM
    users u
-- 1. LEFT JOIN to find reports submitted by the user.
-- We use LEFT JOIN to include users who may not have submitted any reports yet.
LEFT JOIN
    content_reports cr ON u.user_id = cr.reporting_user_id
-- 2. LEFT JOIN to check for actions taken against the user.
LEFT JOIN
    user_account_actions ua ON u.user_id = ua.user_id
-- 3. The Exclusion Filter: This is the key to the solution. 
-- It filters out any user who had a successful match in the user_account_actions table (ua).
WHERE
    ua.action_id IS NULL
-- 4. Group results by user.
GROUP BY
    u.user_id
-- 5. The Inclusion Filter: Filter the aggregated count to ensure the user submitted AT LEAST ONE report.
HAVING
    COUNT(cr.report_id) >= 1
ORDER BY
    total_number_reports DESC;


"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
"""
SQL Exercise: Behavioral Flagging

This exercise will give you practice connecting multiple tables to identify users based on specific behavior.

Your task is to write a SQL query to identify users who have both created at least one content item and submitted more than two 'Spam' reports.

Show the user_id, the total_content_created, and the total_spam_reports_submitted.
"""
SELECT u.user_id, 
  COUNT(DISTINCT c.content_id) AS total_content_created, 
  COUNT(CASE WHEN cr.report_type = 'Spam' THEN cr.report_id END) AS total_spam_reports_submitted
FROM users u 
  LEFT JOIN content c ON u.user_id = c.user_id
  LEFT JOIN content_reports cr ON cr.reporting_user_id = u.user_id
GROUP BY u.user_id
HAVING total_content_created > = 1
  AND total_spam_reports_submitted > 2
ORDER BY u.user_id, total_content_created, total_spam_reports_submitted;


"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
"""
SQL Exercise: Unreported Content

This exercise will give you practice with a core data analysis pattern: finding records in one table that have no matching records in another.

Your task is to write a SQL query that identifies all content items that have never received a report.

Show the content_id, content_type, and creation_date for each unreported content item.
"""
SELECT content_id, content_type, creation_date
FROM content c LEFT JOIN content_reports cr
ON c.content_id = cr.content_id
WHERE report_id IS NULL;


"""
Write a SQL query to identify users who have submitted at least one content report, but have never had any account actions (e.g., 'Suspension', 'Warning', 'Account Closure') taken against their own account.
Show the user_id and the total number of reports they have made.

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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

SOLUTION:
SELECT a.user_id, COUNT(b.report_id) AS num_report
FROM users a
LEFT JOIN content_reports b ON a.user_id = b.reporting_user_id
LEFT JOIN user_account_actions c ON a.user_id = c.user_id
WHERE c.action_type IS NULL
GROUP BY a.user_id
ORDER BY num_report
HAVING num_report >= 1;
"""
SELECT u.user_id, COUNT(cr.report_id) AS total_reports_made
FROM users u 
LEFT JOIN content_reports cr ON cr.reporting_user_id = u.user_id
LEFT JOIN user_account_action ua ON ua.user_id = u.user_id
WHERE ua.action_type IS NULL
GROUP BY u.user_id
ORDER BY total_reports_made
HAVING total_reports_made >= 1;


"""
SAMPLE SOLUTION:
SELECT u.user_id, 
    COUNT(DISTINCT c.content_id) AS total_content_created,
    COUNT(CASE WHEN cr.report_type = 'Spam' THEN cr.report_id END) AS  total_spam_reports_submitted
FROM users u 
  LEFT JOIN content c ON u.user_id = c.user_id
  LEFT JOIN conten_reports cr ON cr.reporting_user_id = u.user_id
GROUP BY u.user_id
  HAVING total_spam_reports_submitted > 2
  AND total_content_created >= 1
ORDER BY total_content_created, total_spam_reports_submitted;
"""
"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
"""
SQL Exercise: Behavioral Flagging
This exercise will give you practice connecting multiple tables to identify users based on specific behavior.
Your task is to write a SQL query to identify users who have both created at least one content item and submitted more than two 'Spam' reports.
Show the user_id, the total_content_created, and the total_spam_reports_submitted.
"""
SELECT u.user_id, 
  COUNT(DISTINCT c.content_id) AS total_content_created, 
  COUNT (CASE WHEN cr.report_type = 'Spam' THEN cr.report_id END) AS total_spam_reports_submitted
FROM users u
LEFT JOIN content c ON u.user_id = c.user_id
LEFT JOIN content_reports cr ON u.user_id = cr.reporting_user_id
GROUP BY u.user_id
HAVING total_content_created >= 1
AND total_spam_reports_submitted >2
ORDER BY total_content_created, total_spam_reports_submitted;

"""
SAMPLE SOLUTION:
SELECT
    u.user_id,
    COUNT(cr.report_id) AS total_number_reports
FROM
    users u
-- 1. LEFT JOIN to find reports submitted by the user.
-- We use LEFT JOIN to include users who may not have submitted any reports yet.
LEFT JOIN
    content_reports cr ON u.user_id = cr.reporting_user_id
-- 2. LEFT JOIN to check for actions taken against the user.
LEFT JOIN
    user_account_actions ua ON u.user_id = ua.user_id
-- 3. The Exclusion Filter: This is the key to the solution. 
-- It filters out any user who had a successful match in the user_account_actions table (ua).
WHERE
    ua.action_id IS NULL
-- 4. Group results by user.
GROUP BY
    u.user_id
-- 5. The Inclusion Filter: Filter the aggregated count to ensure the user submitted AT LEAST ONE report.
HAVING
    COUNT(cr.report_id) >= 1
ORDER BY
    total_number_reports DESC;
"""
"""
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
reporting_user_id (INT, Foreign Key referencing users.user_id, users who made the report)
report_type (VARCHAR, e.g., 'Harassment', 'Hate Speech', 'Spam')
report_date (DATE)
report_status_date (DATE)
status (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')

TABLE: user_account_actions: Contains records of actions taken against user accounts.
action_id (INT, Primary Key)
user_id (INT, Foreign Key referencing users.user_id)
action_type (VARCHAR, e.g., 'Suspension', 'Warning', 'Account Closure')
action_date (DATE)
reason (VARCHAR, e.g., 'Pending', 'Reviewed', 'Actioned', 'Dismissed')
"""
"""
SQL Exercise: Prolific Reporters with Clean Records
This exercise focuses on identifying users who actively submit reports but have never had any account actions taken against them. This is a pattern often analyzed for potential malicious or retaliatory reporting.
Your task is to write a SQL query to identify users who have submitted at least one content report, but have never had any account actions (e.g., 'Suspension', 'Warning', 'Account Closure') taken against their own account.
Show the user_id and the total number of reports they have made.
"""
SELECT u.user_id, SUM(cr.report_id) AS tot_num_rep
FROM users u
LEFT JOIN content_report cr ON u.user_id = cr.reporting_user_id
LEFT JOIN user_account_actions ua ON u.user_id = ua.user_id
WHERE ua.action_type IS NULL
GROUP BY u.user_id
HAVING tot_num_rep >= 1
ORDER BY tot_num_rep;
