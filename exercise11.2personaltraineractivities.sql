/*
Exercise 11.2: Personal Trainer Activities
Written on: December 25, 2024
*/
SHOW TABLES;

/* 
Activity 1 (64 Rows)
Select all columns from the ExerciseCategory and Exercise tables. 
The tables should be joined on ExerciseCategoryId. 
This query should return all Exercises and their associated ExerciseCategory.
*/
TABLE ExerciseCategory;
TABLE Exercise;

SELECT *
FROM ExerciseCategory
INNER JOIN Exercise ON ExerciseCategory.ExerciseCategoryId = Exercise.ExerciseCategoryId;


/*
Activity 2 (9 Rows)
Select ExerciseCatgory.Name and Exercise.Name where the ExerciseCategory does not have a ParentCategoryId (it is null).
Again, join the tables on their shared key (ExerciseCategoryId).
*/
SELECT ExerciseCategory.Name, Exercise.Name
FROM ExerciseCategory
INNER JOIN Exercise ON ExerciseCategory.ExerciseCategoryId = Exercise.ExerciseCategoryId
WHERE ExerciseCategory.ParentCategoryId IS NULL;


/*
Activity 3 (9 Rows)
The results of the query in Activity 2 might be a little confusing.
If you used the field names, then at first glance, it is probably hard to tell which Name belongs to ExerciseCategory and which belongs to Exercise.
Rewrite the query using aliases:
	- Alias ExerciseCategory.Name as 'CategoryName'.
    - Alias Exercise.Name as 'ExerciseName'.
*/
SELECT ExerciseCategory.Name AS 'CategoryName', Exercise.Name AS 'ExerciseName'
FROM ExerciseCategory
INNER JOIN Exercise ON ExerciseCategory.ExerciseCategoryId = Exercise.ExerciseCategoryId
WHERE ExerciseCategory.ParentCategoryId IS NULL;


/*
Activity 4 (35 Rows)
Select FirstName, LastName, and BirthDate from Client and EmailAddress from Login where Client.BirthDate is in the 1990s. Join the tables by their key relationship. 
What is the primary-foreign key relationship?
*/
TABLE Client;
TABLE Login;

SELECT Client.FirstName, Client.LastName, Client.Birthdate, Login.EmailAddress
FROM Client
INNER JOIN Login ON Client.ClientId = Login.ClientId
WHERE Client.Birthdate BETWEEN '1990-01-01' AND '1999-12-31';


/*
Activity 5 (25 Rows)
Select Workout.Name, Client.FirstName, and Client.LastName for Clients with LastName starting with C. 
How are Clients and Workout related?
*/
SHOW TABLES;
TABLE Workout;
Table Client;
TABLE ClientWorkout;

SELECT Workout.Name, Client.FirstName, Client.LastName
FROM Workout
INNER JOIN ClientWorkout ON Workout.WorkoutId = ClientWorkout.WorkoutId
INNER JOIN Client ON ClientWorkout.ClientId = Client.ClientId
WHERE Client.LastName LIKE 'C%';

-- Clients and Workout are related by talbe ClientWorkout. 


/*
Aritcle 6 (78 Rows)
Select Names from Workouts and their Goals. This is many-to-many relationship with a bridge table. 
Use aliases appropriately to avoid ambiguous columns in the result. 
*/
SHOW TABLES;
TABLE Workout;
Table Goal;
TABLE WorkoutGoal;

SELECT Workout.Name AS 'WorkoutName', Goal.Name AS 'GoalName'
FROM Workout
INNER JOIN WorkoutGoal ON Workout.WorkoutId = WorkoutGoal.WorkoutId
INNER JOIN Goal ON WorkoutGoal.GoalId = Goal.GoalId;


/*
Article 7 (200 Rows)
Select client names and email addresses. Select FirstName and LastName from Client. 
Select ClientId and EmailAddress from Login. Join the tables, but make Login optional. This should result in 500 rows.

Using the query just created as a foundation, select Clients who do not have a Login. This should result in 200 rows.
*/
SHOW TABLES;
TABLE Client;
TABLE Login;

SELECT Client.FirstName, Client.LastName, Login.ClientId, Login.EmailAddress
FROM Client
LEFT JOIN Login ON Client.ClientId = Login.ClientId
WHERE Login.ClientID IS NULL;


/*
Activity 8 (0 or 1 Row)
Does the Client Romeo Seaward have a Login?
Decide using a single query. Depending on how this query is set up, it will return 1 row or 0 rows.
*/
SELECT Client.FirstName, Client.LastName, Login.ClientId, Login.EmailAddress
FROM Client
LEFT JOIN Login ON Client.ClientId = Login.ClientId
WHERE Client.FirstName = 'Romeo'; -- Romeo Seaward does not have a Login.


/*
Activity 9 (12 Rows)
Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
Hint: This requires a self-join. 
*/
SHOW TABLES;
TABLE ExerciseCategory;

SELECT a.Name, b.ParentCategoryId
FROM ExerciseCategory a
JOIN ExerciseCategory b ON a.ExerciseCategoryId = b.ParentCategoryId;

/*
Activity 10 (16 Rows)
Rewrite the query from Activity 9 so that every ExerciseCategory.Name is included,
even if it doesn't have a parent. 
*/
SELECT a.Name, b.ParentCategoryId
FROM ExerciseCategory a
JOIN ExerciseCategory b ON a.ExerciseCategoryId = b.ExerciseCategoryId;

/*
Activity 11 (50 Rows)
Are there Clients who are not signed up for a Workout?
Write a query to determine the answer. 
*/
SHOW TABLES;
TABLE Client;
TABLE ClientWorkout;

SELECT Client.ClientId, ClientWorkout.WorkoutId
FROM Client
LEFT JOIN ClientWorkout ON Client.ClientId = ClientWorkout.ClientId
WHERE WorkoutId IS NULL;

/*
Activity 12 (6 Rows, 4 Unique Rows)
Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
Note that Goals are associated to Clients through ClientGoal. Additionally, Goals are
associated to Workouts through WorkoutGoal.
*/
SHOW TABLES;
TABLE Goal;
TABLE ClientGoal;
TABLE Client;
TABLE Workout;
TABLE WorkoutGoal;

SELECT DISTINCT Workout.LevelId AS 'WorkoutLevel', Client.FirstName, Client.LastName, Goal.Name AS 'GoalName', Workout.Notes
FROM Goal
JOIN ClientGoal ON Goal.GoalId = ClientGoal.GoalId
JOIN WorkoutGoal ON Goal.GoalId = WorkoutGoal.GoalId
JOIN Workout ON WorkoutGoal.WorkoutId = Workout.WorkoutId
JOIN Client ON ClientGoal.ClientId = Client.ClientId
WHERE Workout.LevelId =1 AND Client.FirstName = 'Shell';

/*
SELECT DISTINCT w.Name
FROM Workout w
JOIN WorkoutGoal wg ON w.ID = wg.WorkoutID
JOIN Goal g ON wg.GoalID = g.ID
JOIN ClientGoal cg ON g.ID = cg.GoalID
JOIN Client c ON cg.ClientID = c.ID
WHERE c.FirstName = 'Shell' AND c.LastName = 'Creane' 
AND w.Level = 'Beginner';
*/


/*
Activity 13 (26 Workouts, 3 Goals)
Select all Workouts. Join to the Goal 'Core Strength', but make it optional. Note that 
you might need to look up the GoalId before writing the main query.
If you filter on Goal.Name in a WHERE clause, Workouts will be excluded. Why?
*/
SHOW TABLES;
TABLE Goal;
TABLE WorkoutGoal;
TABLE Workout;

SELECT Workout.Name AS 'WorkoutName', Goal.Name AS 'GoalName'
FROM Workout
LEFT JOIN WorkoutGoal ON Workout.WorkoutId = WorkoutGoal.WorkoutId
LEFT JOIN Goal ON WorkoutGoal.GoalId = Goal.GoalId
WHERE Goal.Name = 'Core Strength';


/*
Activity 14 (744 Rows)
The relationship between Workouts and Exercises is...complicated. Workout links to WorkoutDay (one day in a Workout routine),
which links to WorkoutDayExerciseInstance (Exercises can be done with different weights, repetitions, laps, etc.), which
finally links to Exercise. 
Select Workout.Name and Exercise.Name for related Workouts and Exercises. 
*/
SHOW TABLES;
TABLE Workout;
TABLE WorkoutDay;
TABLE WorkoutDayExerciseInstance;
TABLE ExerciseInstance;
TABLE Exercise;

SELECT Workout.Name As 'WorkoutName', Exercise.Name AS 'ExerciseName'
FROM Workout
JOIN WorkoutDay ON Workout.WorkoutId = WorkoutDay.WorkoutId
JOIN WorkoutDayExerciseInstance ON WorkoutDay.WorkoutDayId = WorkoutDayExerciseInstance.WorkoutDayId
JOIN ExerciseInstance ON WorkoutDayExerciseInstance.ExerciseInstanceId = ExerciseInstance.ExerciseInstanceId
JOIN Exercise ON ExerciseInstance.ExerciseId = Exercise.ExerciseId

