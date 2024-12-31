/*
Exercise 10.2: Personal Trainer
Date written: December 15, 2024
*/

drop database if exists PersonalTrainer;

create database PersonalTrainer;

use PersonalTrainer;

-- Activity 1: Select all row and columns from the Exercise table.
SELECT *
FROM exercise;


-- Activity 2: Select all rows and columns from the Client table.
SELECT *
FROM client;

-- Activity 3: Select all columns from Client where the City is Metairie.
SELECT *
FROM client
WHERE City = 'Metairie';


-- Activity 4: Is there a Client with the ClientId '818u7faf-7b4b-48a2-bf12-7a26c92de20c'?
SELECT *
FROM client
WHERE ClientId = '818u7faf-7b4b-48a2-bf12-7a26c92de20c';


-- Activity 5: How many rows are in the Goal table?
SELECT COUNT(*)
FROM Goal;

-- Activity 6: Select Name and LevelId from the Workout table.
SELECT Name, LevelId
FROM Workout;


-- Activity 7: Select Name, LevelId, and Notes from Workout where LevelId is 2.
SELECT name, levelid, notes
FROM workout
WHERE levelId = 2;


-- Activity 8: Select FirstName, LastName, and City from Client where City is Metairie, Kenner, or Gretna. 
SELECT FirstName, LastName, City
FROM client
WHERE city IN ('Metairie', 'Kenner', 'Gretna');


-- Activity 9: Select FirstName, LastName, and BirthDate from Client for Clients  born in the 1980s.
SELECT FirstName, LastName, BirthDate
FROM client
WHERE birthdate >= '1980-01-01' AND birthdate <= '1989-12-31';


-- Activity 10: Write the query from Activity 9 in a different way. 
-- If you used BETWEEN, you can't use it again.
-- If you didn't use BETWEEN, use it!
SELECT FirstName, LastName, BirthDate
FROM client
WHERE birthdate BETWEEN '1980-01-01' AND '1989-12-31';


-- Activity 11: How many rows in the Login table have a .gov EmailAddress?
SELECT COUNT(*)
FROM Login
WHERE EmailAddress LIKE '%.gov';

-- Activity 12: How many Logins do not have a .com EmailAddress?
SELECT COUNT(*)
FROM Login
WHERE EmailAddress NOT LIKE '%.com';


-- Activity 13: Select the first and last names of Clients without a BirthDate.
SELECT firstName, LastName
FROM client
WHERE BirthDate IS NULL;


-- Activity 14: Select Name of each ExerciseCategory that has a parent (ParentCategoryId value is not null).
SELECT Name
FROM ExerciseCategory
WHERE ParentCategoryId IS NOT NULL;


-- Activity 15: Select Name and Notes of each level 3 Workout that contains the word 'you' in its Notes. 
SELECT Name, Notes
FROM workout
WHERE Notes LIKE '%you%'
AND levelId = 3;


-- Activity 16: Select FirstName, LastName, City from Client whose LastName starts with L, M, or N, and who live in LaPlace.
SELECT FirstName, LastName, City
FROM client
WHERE (LastName LIKE 'L%'
OR LastName LIKE 'M%'
OR LastName LIKE 'N%')
AND city = 'LaPlace';


-- Activity 17: Select InvoiceId, Description, Price, Quantity, ServiceDate, and the lineitem total, a calculated value, from InvoiceLineItem, where the line item total is between 15 and 25 dollars. 
TABLE InvoiceLineItem;

SELECT InvoiceId, Description, Price, Quantity, ServiceDate, (Price * Quantity) AS line_item_total
FROM InvoiceLineItem
WHERE (Price * Quantity) BETWEEN 15.0 AND 25.0;


-- Activity 18: Does the database include an email address for the Client, Estrella Bazely? To answer this question, it will require two queries:
/*
-- Select a Client record for Estrella Bazely. Does it exist?
-- If it does, select a Login record that matches its ClientId.
*/
TABLE Client;

SELECT *
FROM client
WHERE FirstName = 'Estrella' AND LastName = 'Bazely';

TABLE Login;

SELECT Emailaddress
FROM Login
WHERE ClientId = '87976c42-9226-4bc6-8b32-23a8cd7869a5';


-- Activity 19: What are the Goals of the Workout with the Name 'This Is Parkour'? You need three queries to answer this.
/*
-- 1. Select the WorkoutId from Workout where Name equals 'This Is Parkour' (1 row).
-- 2. Select GoalId from Workout Goal where the WorkoutId matches the WorkoutId from your first query (three rows).
-- 3. Select the goal name from Goal where the GoalId is one of the GoalIds from your second query (three rows).
-- Your results will be as follow:
-- Endurance
-- Muscle Bulk
-- Focus: Shoulders
*/

SELECT WorkoutId
FROM Workout
WHERE Name = 'This Is Parkour';

SELECT GoalId
FROM WorkoutGoal
WHERE WorkoutId = 12;

SELECT Name
FROM Goal
WHERE GoalId IN (3, 8, 15);