/*
Lesson 13: Grouping and Aggregates
Written on: December 29, 2024
*/
USE TrackIt;
SHOW TABLES;

-- Listing 13.1: Using an Aggregate Function to Count
USE TrackIt;
-- Count TaskIds, 543 values
SELECT COUNT(TaskId)
FROM Task;

-- Count everything, 543 values
SELECT COUNT(*)
FROM Task;


-- Listing 13.2: Counting TaskStatusId
SELECT COUNT(TaskStatusId) -- 532 values
FROM Task;


-- Listing 13.3: Counting Resolved Tasks
SELECT
	COUNT(t.TaskId)
FROM Task t
INNER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
WHERE s.IsResolved = 1;


-- Listing 13.4: Counting Tasks per Status
SELECT
	IFNULL(s.Name, '[None]') StatusName,
    COUNT(t.TaskId) TaskCount
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
GROUP BY s.Name
ORDER BY s.Name;


-- Listing 13.5: Dropping Group by
SELECT
	IFNULL(s.Name, '[None]') StatusName,
    COUNT(t.TaskId) TaskCount
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
ORDER BY s.Name;


-- Listing 13.6: Adding IsResolved
-- This script should not work.
SELECT
	IFNULL(s.Name, '[None]') StatusName,
    s.IsResolved,
    COUNT(t.TaskId) TaskCount
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
GROUP BY s.Name
ORDER BY s.Name;


-- Listing 13.7: Adding TaskStatus.IsResolved to the Groupings
SELECT
	IFNULL(s.Name, '[None]') StatusName,
    IFNULL(s.IsResolved, 0) IsResolved,
    COUNT(t.TaskId) TaskCount
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
GROUP BY s.Name, s.IsResolved -- IsResolved is now part of the GROUP.
ORDER BY s.Name;


-- Listing 13.8: Getting a List of Distinct Project Names
SELECT DISTINCT
	p.Name ProjectName,
    p.ProjectId
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
ORDER BY p.Name;


-- Listing 13.9: Getting Unique Project Names Using GROUP BY
SELECT
	p.Name ProjectName,
    p.ProjectId
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
GROUP BY p.Name, p.ProjectId
ORDER BY p.Name;


-- Listing 13.10: First Draft of Filteriing
SELECT 
	CONCAT(w.FirstName, ' ', w.LastName) WorkerName,
	SUM(t.EstimatedHours) TotalHours
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Task t ON pw.WorkerId = t.WorkerId
	AND pw.ProjectId = t.ProjectId
GROUP BY w.WorkerId, w.FirstName, w.LastName;


-- Listing 13.11: Adding HAVING
SELECT 
	CONCAT(w.FirstName, ' ', w.LastName) WorkerName,
	SUM(t.EstimatedHours) TotalHours
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Task t ON pw.WorkerId = t.WorkerId
	AND pw.ProjectId = t.ProjectId
GROUP BY w.WorkerId, w.FirstName, w.LastName
HAVING SUM(t.EstimatedHours) >= 100;


-- Listing 13.12: Query for Tasks Minimum Due Dates
SELECT 
	p.Name ProjectName,
    MIN(t.DueDate) MinTaskDueDate
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
WHERE p.ProjectId LIKE 'game-%'
	AND t.ParentTaskId IS NOT NULL
GROUP BY p.ProjectId, p.Name
ORDER BY p.Name;


-- Listing 13.13: An Overview of Each Project with 10 or More Tasks
SELECT
	p.Name ProjectName,
    MIN(t.DueDate) MinTaskDueDate,
    MAX(t.DueDate) MaxTaskDueDate,
    SUM(t.EstimatedHours) TotalHours,
    AVG(t.EstimatedHours) AverageTaskHours,
    COUNT(t.TaskId) TaskCount
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
WHERE t.ParentTaskId IS NOT NULL
GROUP BY p.ProjectId, p.Name
HAVING COUNT(t.TaskId) >= 10
ORDER BY COUNT(t.TaskId) DESC, p.Name;