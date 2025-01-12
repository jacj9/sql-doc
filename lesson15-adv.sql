/*
Lesson 15: Diving into Advanced SQL Topics
Written on: January 6, 2025
*/

-- Listing 15.1: Grabing All the Workers Assigned to a Project
USE TrackIt;

SELECT *
FROM Worker
WHERE WorkerId IN (
	SELECT WorkerId FROM ProjectWorker
);


-- Listing 15.2: A Query with an Issue
-- This doesn't do what we want.
SELECT
	p.Name ProjectName,
    MIN(t.TaskId) MinTaskId
    -- t.Title is what we want, but the SQL Engine
    -- doesn't know which Task we're talkikng about.
    -- t.Title is not part of a group and there's
    -- no aggregate guaranteed to grab the Title from the MinTaskId.
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
Group By p.ProjectId, p.Name;


-- Listing 15.3: Solving the Problem with a Subquery
SELECT
 g.ProjectName,
 g.MinTaskId,
 t.Title MinTaskTitle
FROM Task t
INNER JOIN (
	SELECT
		p.Name ProjectName,
        MIN(t.TaskId) MinTaskId
	FROM Project p
    INNER JOIN Task t ON p.ProjectId = t.ProjectId
    GROUP BY p.ProjectId, p.Name) g ON t.TaskId = g.MinTaskId;
    
    
-- Listing 15.4: Fetching Workers with Project Counts
SELECT
	w.FirstName,
    w.LastName,
    (SELECT COUNT(*) FROM ProjectWorker
    WHERE WorkerId = w.WorkerId) ProjectCount
FROM Worker w;


-- Listing 15.5: Solving the Project/MIN Task Problem
SELECT
	p.Name ProjectName,
    MIN(t.TaskId) MinTaskId,
    (SELECT Title FROM Task
    WHERE TaskId=MIN(t.TaskId)) MinTaskTitle
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
GROUP BY p.ProjectId, p.Name;


-- Listing 15.6: Creating a View
CREATE VIEW ProjectNameWithMinTaskId
AS
SELECT
	p.Name ProjectName,
    MIN(t.TaskId) MinTaskId
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
GROUP BY p.ProjectId, p.Name;


-- Listing 15.7: A More Complex Query Using a View
SELECT
	pt.ProjectName,
    pt.MinTaskId TaskId,
    t.Title
FROM Task t
INNER JOIN ProjectNameWithMinTaskId pt -- Aliased just like a table.
	ON t.TaskId = pt.MinTaskId;


-- Listing 15.8: Performing a Transaction
START TRANSACTION;
SELECT balance FROM checking WHERE customer_id = 10233276;
UPDATE checking SET balance = balance - 200.00 WHERE customer_id=10233276;
UPDATE savings SET balance = balance + 200.00 WHERE customer_id=10233276;
COMMIT;


-- Listing 15.9: Creating an Index
CREATE TABLE person(
	lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    KEY(firstname, lastname, dob)
);


-- Listing 15.10: Using a Hash Index
CREATE TABLE person(
	firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    KEY USING HASH(firstname)
)Engine=MEMORY;