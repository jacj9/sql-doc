/*
Exercise 11.1: User Stories
Written on: December 24, 2024

Write a single SELECT statement that will allow you to present all the User Story tasks within the 
TrackIt database. Include the TaskType name along with the Project Names where the task has been 
included as well as the First and Last Name of the workers on that project.
*/

SHOW TABLES;
TABLE project;
TABLE task;
TABLE TaskType;
TABLE ProjectWorker;
TABLE Worker;


SELECT TaskType.Name As TaskName, Project.Name As ProjectName, Worker.FirstName, Worker.LastName
FROM project
INNER JOIN task ON Project.ProjectId = task.ProjectId
INNER JOIN TaskType ON task.TaskTypeId = TaskType.TaskTypeId
INNER JOIN Worker ON task.WorkerId = worker.workerId;


-- Trying to execute the query with only 'JOIN' in the query, no "INNER".
SELECT 
	TaskType.Name As TaskName, 
    Project.Name As ProjectName, 
    Worker.FirstName, 
    Worker.LastName
FROM project
JOIN task ON Project.ProjectId = task.ProjectId
JOIN TaskType ON task.TaskTypeId = TaskType.TaskTypeId
JOIN Worker ON task.WorkerId = worker.workerId;
