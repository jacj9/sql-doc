/*
Lesson 11
Adding JOIN Queries
Written on: December 22, 2024
*/

-- Listing 11.1: Using a SELECT to Resolve Statuses
Use TrackIt;

SELECT *
FROM Taskstatus
WHERE IsResolved = 1;

-- Listing 11.2: Selecting the Tasks
-- TaskStatusIds happen to be in a sequential order, so we can use BETWEEN.
-- If they were out of sequence, we might use an IN (id1, id2, idN).
SELECT *
FROM Task
WHERE TaskStatusId BETWEEN 5 AND 8;

SELECT *
FROM Task
WHERE TaskStatusId IN (1, 3, 7, 8);


-- Listing 11.3: Using a JOIN
SELECT Task.TaskId, Task.Title, TaskStatus.Name
FROM TaskStatus
INNER JOIN Task ON TaskStatus.TaskStatusId = Task.TaskStatusId
WHERE TaskStatus.IsResolved = 1;

SHOW TABLES;


-- Listing 11.4: Query 1
-- (no table names):
SELECT
	TaskId,
    Title,
    'Name'
FROM TaskStatus
INNER JOIN Task ON TaskStatus.TaskStatusId = Task.TaskStatusId
WHERE TaskStatus.IsResolved = 1;


-- Listing 11.5: Query 2
-- (includes table names)
SELECT
	Task.TaskId,
    Task.Title,
    TaskStatus.Name
FROM TaskStatus
INNER JOIN Task ON TaskStatus.TaskStatusId = Task.TaskStatusId
WHERE TaskStatus.IsResolved = 1;


-- Listing 11.6: Omitting Table Names
SELECT
	TaskId,
    Title,
    'Name',
    TaskStatusId -- This will cause problems.
FROM TaskStatus
INNER JOIN Task ON TaskStatus.TaskStatusId = Task.TaskStatusId
WHERE TaskStatus.IsResolved = 1;


-- Listing 11.7: Omitting the INNER Keyword
SELECT
	Task.TaskId,
    Task.Title,
    TaskStatus.Name
FROM TaskStatus
-- INNER omitted in the following
JOIN Task ON TaskStatus.TaskStatusId = Task.TaskStatusId
WHERE TaskStatus.IsResolved = 1;


-- Listing 11.8 Omitting the INNER Keyword
SELECT
	Project.Name,
    Worker.FirstName,
    Worker.LastName
FROM Project
INNER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.ProjectId
INNER JOIN Worker ON ProjectWorker.WorkerId = Worker.WorkerId
WHERE Project.ProjectId = 'game-goodboy';


-- Listing 11.9: Joining Another Table (the Task Table)
SELECT
	Project.Name,
    Worker.FirstName,
    Worker.LastName,
    Task.Title
FROM Project
INNER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.ProjectId
INNER JOIN Worker ON ProjectWorker.WorkerId = Worker.WorkerId
INNER JOIN Task ON ProjectWorker.ProjectId = Task.ProjectId
	AND ProjectWorker.WorkerId = Task.WorkerId
WHERE Project.ProjectId = 'game-goodboy';


-- Listing 11.10: Adding the LEFT OUTER JOIN
SELECT *
	FROM Task
LEFT OUTER JOIN TaskStatus
	ON Task.TaskStatusId = TaskStatus.TaskStatusId;


-- Listing 11.11: Using the IFNULL() Function
SELECT
	Task.TaskId,
    Task.Title,
    IFNULL(Task.TaskStatusId, 0) AS TaskStatusId,
    IFNULL(TaskStatus.Name, '[None]') AS StatusName
FROM Task
LEFT OUTER JOIN TaskStatus
	ON Task.TaskStatusId = TaskStatus.TaskStatusId;
    
-- Listing 11.12: Finding Projects Without Workers
SELECT
	Project.Name ProjectName, -- An alias makes this clearer.
    Worker.FirstName,
    Worker.LastName
FROM Project
LEFT OUTER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.ProjectId
LEFT OUTER JOIN Worker ON ProjectWorker.WorkerId = Worker.WorkerId;


-- Listing 11.13: Removing Projects with Workers
SELECT
	Project.Name ProjectName,
    Worker.FirstName,
    Worker.LastName
FROM Project
LEFT OUTER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.ProjectId
LEFT OUTER JOIN Worker ON ProjectWorker.WorkerId = Worker.WorkerId
WHERE ProjectWorker.WorkerId IS NULL; -- Throws out projects with workers. 


-- Listing 11.14: Omitting the Worker Table
-- Projects without workers, your only need the bridge table to confirm.
SELECT
	Project.Name ProjectName
FROM Project
LEFT OUTER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.ProjectId
WHERE ProjectWorker.WorkerId IS NULL;


-- Listiing 11.15: Getting Workers Without a Project
SELECT
	Project.Name ProjectName,
    Worker.FirstName,
    Worker.LastName
FROM Project
RIGHT OUTER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.ProjectId
RIGHT OUTER JOIN Worker ON ProjectWorker.WorkerId = Worker.WorkerId
WHERE ProjectWorker.WorkerId IS NULL;
-- WHERE ProjectWorker.WorkerId IS NULL; // This works as well. Why?


-- Listiing 11.16: Simplifying the Workers Without a Project to Drop Project Name
-- Workers without a project
SELECT
    Worker.FirstName,
    Worker.LastName
FROM Worker
RIGHT OUTER JOIN ProjectWorker ON ProjectWorker.WorkerId = Worker.WorkerId
WHERE ProjectWorker.WorkerId IS NULL;


-- Listing 11.17: Workers Without Projects, from the Left
SELECT
    Worker.FirstName,
    Worker.LastName
FROM Worker
LEFT OUTER JOIN ProjectWorker ON ProjectWorker.WorkerId = Worker.WorkerId
WHERE ProjectWorker.WorkerId IS NULL;


-- Listing 11.18: Joining a Table to Itself
SELECT *
FROM Task
INNER JOIN Task ON Task.TaskId = Task.ParentTaskId;


-- Listing 11.19: Table Aliases to Differentiate Parent vs. Child Tasks
SELECT
	parent.TaskId ParentTaskId,
    child.TaskId ChildTaskId,
    CONCAT(parent.Title, ': ', child.Title) Title
FROM Task parent
INNER JOIN Task child ON parent.TaskId = child.ParentTaskId;


-- Listing 11.20: Multitable Project and Task Query
SELECT
	p.Name ProjectName,
    w.FirstName,
    w.LastName,
    t.Title
FROM Project p
INNER JOIN ProjectWorker pw ON p.ProjectId = pw.ProjectId
INNER JOIN Worker w ON pw.WorkerId = w.WorkerId
INNER JOIN Task t ON pw.ProjectId = t.ProjectId
	AND pw.WorkerId = t.WorkerId
WHERE p.ProjectId = 'game-goodboy';


-- Listing 11.21: CROSS JOIN
SELECT
	CONCAT(w.FirstName, ' ', w.LastName) WorkerName,
    p.Name ProjectName
FROM Worker w
CROSS JOIN Project p
WHERE w.WorkerId = 1
AND p.ProjectId NOT LIKE 'game-%';