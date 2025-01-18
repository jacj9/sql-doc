/*
Lesson 15 Exercises
Written on: January 8, 2025
*/
USE TrackIt;
SHOW TABLES;

-- Exercise 15.1: Recent Tasks (26 rows)
TABLE project; -- Name, (FK)ProjectId
TABLE task; -- TaskId, Title, (FK)ProjectId

SELECT p.Name AS ProjectName, MAX(t.TaskId) AS MaxTaskId, t.Title AS MaxTaskTitle
FROM project p
JOIN task t ON p.ProjectId = t.ProjectId
GROUP BY p.Name;


-- Exercise 15.2: Before Grumps (513 rows)
-- Generate a list of tasks whose due date is no or before the due date for the project named Grumps. (Use subquery)
TABLE project; -- (FK)ProjectId, Name = 'Grumps', DueDate = '2018-11-01'
TABLE task; -- Title, DueDate, (FK)ProjectId

SELECT t.title, t.DueDate
FROM task t
WHERE t.DueDate <=
	(SELECT p.DueDate
    FROM project p
    WHERE p.Name = 'Grumps');
    
    
-- Exercise 15.3: Project Due Dates (543 rows)
-- Create a view that displays a list of all project names and due dates, the title of each task associated with each project, and the first name and last name of each work assigned to the tasks.
-- Assign the view any name that makes sense to you.
TABLE project; -- (FK)ProjectId, Name
TABLE task; -- (FK)ProjectId, (FK)WorkerId, DueDate, Title
TABLE worker; -- (FK)WorkerId, FirstName, LastName

CREATE VIEW ProjectDueDates
AS
SELECT
	p.Name ProjectName,
    t.DueDate,
    t.Title,
    w.FirstName,
    w.LastName
FROM project p
JOIN task t ON p.projectId = t.projectId
JOIN worker w ON t.WorkerId = w.workerId;

SELECT Title FROM ProjectDueDates; -- Check if the view table is successfully created.


-- Exercise 15.4: The Work of Ealasaid Blinco (15 rows)
-- Use the view created in the previous exercise to generate a list of all tasks assigned to worker Ealasaid Blinco.

SELECT ProjectName
FROM ProjectDueDates
WHERE FirstName = 'Ealasaid' AND LastName = 'Blinco';