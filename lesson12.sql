/*
Lesson 12: Sorting and Limiting Query Results
Written on: December 27, 2024
Trackit Database
*/

SHOW TABLES;

-- Listing 12.1: Using ORDER BY
SELECT *
FROM Worker
ORDER BY LastName;

-- Listing 12.2: Using ASC
SELECT *
FROM Worker
ORDER BY LastName ASC;


-- Listing 12.3: Sorting in Descending Order
SELECT *
FROM Worker
ORDER BY LastName DESC;


-- Listing 12.4: Sorting Joined Table
SELECT 
	w.FirstName,
	w.LastName,
    p.Name ProjectName
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Project p ON pw.ProjectId = p.ProjectId
ORDER BY w.LastName ASC;


-- Listing 12.5: Sorting by LastName, Then the project Name
SELECT 
	w.FirstName,
	w.LastName,
    p.Name ProjectName
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Project p ON pw.ProjectId = p.ProjectId
ORDER BY w.LastName ASC, p.Name ASC;


-- Listing 12.6: Changing Sort Order for Individual Sort Items
SELECT 
	w.FirstName,
	w.LastName,
    p.Name ProjectName
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Project p ON pw.ProjectId = p.ProjectId
ORDER BY w.LastName DESC, p.Name ASC;


-- Listing 12.7: Projects Before Workers
SELECT 
	p.Name ProjectName,
    w.FirstName,
	w.LastName
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Project p ON pw.ProjectId = p.ProjectId
ORDER BY p.Name ASC, w.LastName ASC;


-- Listing 12.8: Printing Tasks with Their Status
SELECT
	t.Title,
    s.Name StatusName
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
ORDER BY s.Name ASC;


-- LIsting 12.9: Sorting NULL Values to the End
SELECT
	t.Title,
    s.Name StatusName
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
ORDER BY ISNULL(s.Name), s.Name ASC;


-- Listing 12.10: Selecting a Limited Number of Workers
-- LIMIT [Row offset], [Number of rows]
SELECT *
FROM Worker
ORDER BY LastName DESC
LIMIT 0, 10;


-- Listing 12.11: Selecting Without the Row offset
SELECT *
FROM Worker
ORDER BY LastName DESC
LIMIT 10;


-- Listing 12.12: Using an Offset
SELECT *
FROM Worker
ORDER BY LastName DESC
LIMIT 10, 10;


-- Listing 12.13: Using an offset beyond the data
SELECT *
FROM Worker
ORDER BY LastName DESC
LIMIT 200, 10;


-- Listing 12.14: List All Projects That Have a Task
SELECT
	p.Name ProjectName,
    p.ProjectId
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
ORDER BY p.Name;


-- Listing 12.15: List All Projects Once That Have a Task
SELECT DISTINCT
	p.Name ProjectName,
    p.ProjectId
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
ORDER BY p.Name;