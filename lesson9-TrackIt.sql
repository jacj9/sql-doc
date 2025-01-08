/*
Lesson 9: Applying CRUD: Basic Data Management and Manipulation
*/

DROP DATABASE IF EXISTS TrackIt;
CREATE DATABASE TrackIt;
-- Make sure we're in the correct database before we add schema.
USE TrackIt;

CREATE TABLE Project (
	ProjectID CHAR(50) PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    Summary VARCHAR(2000) NULL,
    DueDate DATE NOT NULL,
    IsActive BOOL NOT NULL DEFAULT 1    
);

CREATE TABLE Worker (
	WorkerId INT Primary Key AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

CREATE TABLE ProjectWorker (
	ProjectID CHAR(50) NOT NULL,
    WorkerId INT NOT NULL,
    PRIMARY KEY pk_ProjectWorker (ProjectID, WorkerID),
    FOREIGN KEY fk_ProjectWorker_Project (ProjectID)
		REFERENCES Project (ProjectID),
	FOREIGN KEY fk_ProjectWorker_Worker (WorkerID)
		REFERENCES Worker(WorkerID)
);

CREATE TABLE Task (
	TaskID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    Details TEXT NULL,
    DueDate DATE NOT NULL,
    EstimatedHours Decimal(5,2) NULL,
    ProjectID CHAR(50) NOT NULL,
    WorkerID INT NOT NULL,
    CONSTRAINT fk_task_ProjectWorker
		FOREIGN KEY (ProjectID, WorkerID)
        REFERENCES ProjectWorker (ProjectID, WorkerID)
);

INSERT INTO Worker (WorkerId, FirstName, LastName)
	VALUES (1, 'Rosemonde', 'Featherbie');

INSERT INTO Worker (FirstName, LastName)
	VALUES ('Kingsly', 'Besantie');

INSERT INTO Worker (FirstName, LastName)
	VALUES ('Goldi', 'Pilipets'),
    ('Dorey', 'Rulf'),
    ('Panchito', 'Ashtonhurst');

INSERT INTO Worker (WorkerId, FirstName, LastName)
	VALUES (50, 'Valentino', 'Newvill');

INSERT INTO Worker (FirstName, LastName)
	VALUES ('Violet', 'Mercado');

INSERT INTO project (ProjectId, ProjectName, DueDate)
	VALUES ('db-milestone', 'Database Material', '2022-12-31');
    
INSERT INTO ProjectWorker (ProjectId, WorkerId)
	VALUES ('db-milestone', 2);

INSERT INTO project (ProjectId, ProjectName, DueDate)
	VALUES ('kitchen', 'Kitchen Remodel', '2025-07-15');

INSERT INTO ProjectWorker (ProjectId, WorkerId) VALUES
	('db-milestone', 1), -- Rosemonde, Database
    ('kitchen', 2),      -- Kingsly, Kitchen
    ('db-milestone', 3), -- Goldi, Database
    ('db-milestone', 4); -- Dorey, Database

-- Provide a Project Summary and change the DueDate
UPDATE Project SET
	Summary = 'All lessons and exercises for the relational database milestone.',
    DueDate = '2023-10-15'
WHERE ProjectId = 'db-milestone';

-- Change Kingsly's LastName to 'Oaks'
UPDATE Worker SET
	LastName = 'Oaks'
WHERE WorkerId = 2;

UPDATE ProjectWorker
	SET WorkerId = 5
    WHERE WorkerId = 2;
TABLE ProjectWorker;

-- Disable safe updates.
SET SQL_SAFE_UPDATES = 0;

-- Deactivate active Projects from 2022.
UPDATE Project SET
	IsActive = 0
WHERE DueDate BETWEEN '2022-01-01' AND '2022-12-31'
AND IsActive = 1;

-- Enable safe updates.
SET SQL_SAFE_UPDATES = 1;

UPDATE Task SET
	EstimatedHours = EstimatedHours*1.25
WHERE WorkerId = 2;
TABLE Task;

DELETE FROM worker
WHERE workerId = 50;

-- Safe updates also prevent DELETE
SET SQL_SAFE_UPDATES = 0;

-- Delete any Tasks first because Task references ProjectWorker.
DELETE FROM Task
WHERE WorkerId = 5;

-- Delete ProjectWorker next.
-- That removes Panchito from all Projects. 
DELETE FROM ProjectWorker
WHERE WorkerId = 5;

-- Finally, remove Panchito. 
DELETE FROM Worker
WHERE workerid = 5;

SET SQL_SAFE_UPDATES = 1;

TABLE worker;
