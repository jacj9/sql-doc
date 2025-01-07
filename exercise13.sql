/*
Exercises from Lesson 13
Written on: December 30, 2024
*/
USE PersonalTrainer;
SHOW TABLES;

-- Exercise 13.1: Number of Clients (1 row)
/*
Use an aggregate to count the number of Clients.
*/
SELECT COUNT(*)
FROM Client;


-- Exercise 13.2: Counting Client Birth Dates (1 row)
/*
Use an aggregate to count Client.BirthDate. The number is different from total Clients. Why?
*/
TABLE Client;

SELECT COUNT(Client.BirthDate)
FROM Client;


-- Exercise 13.3: Clients by City (20 rows)
/*
Group Clients by City and count them.
- Sort by the number of Clients descending.
- Include both City and the client count in the results.
*/
SELECT COUNT(*) As NumberCliets, City
FROM Client
GROUP BY City
ORDER BY COUNT(*) DESC;


-- Exercise 13.4: Invoice Totals (1,000 rows)
/*
Calculate a total invoice using only the InvoiceLineItem table.
- Group by InvoiceId.
- You'll need an expression for the line item total: Price * Quantity.
- Aggregate per group using SUM.
*/
SHOW TABLES;
TABLE InvoiceLineItem;

SELECT InvoiceId, SUM(Price*QuaNtity) AS TotalSum
FROM InvoiceLineItem
GROUP BY InvoiceId;


-- Exercise 13.5: Invoices More Than $500 (234 rows)
/*
Modify the query in Exercise 13.4 for the following:
- Only include totals greater than $500.00.
- Sort from lowest total to highest.
*/
SELECT InvoiceId, SUM(Price*QuaNtity) AS TotalSum
FROM InvoiceLineItem
GROUP BY InvoiceId
HAVING SUM(Price*QuaNtity) > 500
ORDER BY SUM(Price*QuaNtity) ASC;


-- Exercise 13.6: Average Line Item Totals (3 rows)
/*
Calculate the average line item total, grouped by InvoiceLineItem.Description.
*/
SELECT Description, AVG(Price*QuaNtity) AS Average_invoice
FROM InvoiceLineItem
GROUP BY Description;


-- Exercise 13.7: More Than $1,000 Paid (146 rows)
/*
Select ClientId, FirstName, and LastName from Client for clients who have paid more than $1,000 total.
- Paid is Invoice.InvoiceStatus = 2.
- Sort by LastName, then FirstName.
*/
SHOW TABLES;
TABLE Client;
TABLE Invoice;
TABLE InvoiceLineItem;

SELECT Client.ClientID, Client.FirstName, Client.LastName, SUM(InvoiceLineItem.Price*InvoiceLineItem.Quantity) AS TotalSumm
FROM Client
INNER JOIN Invoice ON Client.ClientId = Invoice.ClientId
INNER JOIN InvoiceLineItem ON Invoice.InvoiceId = InvoiceLineItem.InvoiceId
WHERE Invoice.InvoiceStatus = 2
GROUP BY ClientId
HAVING SUM(InvoiceLineItem.Price*InvoiceLineItem.Quantity) > 1000
ORDER BY LastName, FirstName;


-- Exercise 13.8: Counts by Category (13 rows)
/*
Count exercises by category.
- Group by ExerciseCategory.Name.
- Sort by exercise count descending.
*/
TABLE Exercise;
TABLE ExerciseCategory;

SELECT ExerciseCategory.Name AS ExerciseCategory, COUNT(Exercise.Name)
FROM Exercise
INNER JOIN ExerciseCategory ON Exercise.ExerciseCategoryId = ExerciseCategory.ExerciseCategoryId
GROUP BY ExerciseCategory.Name
ORDER BY COUNT(Exercise.Name) DESC;


-- Exercise 13.9: Exercises (64 rows)
/*
Select Exercise.Name along with the minimum, maximum, and average ExerciseInstance.Sets. Sort the results by Exercise.Name.
*/
TABLE Exercise;
TABLE ExerciseInstance;

SELECT Exercise.Name AS ExerciseName, MIN(ExerciseInstance.Sets), Max(ExerciseInstance.Sets), AVG(ExerciseInstance.Sets)
FROM Exercise
RIGHT JOIN ExerciseInstance ON Exercise.ExerciseId = ExerciseInstance.ExerciseId
GROUP By Exercise.Name
ORDER BY Exercise.Name;


-- Exercise 13.10: Client Birth Dates (26 rows)
/*
Find the minimum and maximum Client.BirthDate per workout. Sort the results by the workout name.
*/
TABLE Client;
TABLE ClientWorkout;
TABLE Workout;

SELECT MIN(Client.BirthDate), MAX(Client.BirthDate), Workout.Name AS WorkoutName
FROM Client
INNER JOIN ClientWorkout ON Client.ClientId = ClientWorkout.ClientId
INNER JOIN Workout ON ClientWorkout.WorkoutId = Workout.WorkoutId
GROUP BY Workout.Name
ORDER BY Workout.Name;


-- Exercise 13.11: Client Goal Count (500 rows, 50 rows with no goal)
/*
Count the client goals. Be careful not to exclude rows for clients without goals.
*/
TABLE Client;
TABLE ClientGoal;
TABLE Goal;

SELECT Client.ClientId, COUNT(ClientGoal.GoalId)
FROM ClientGoal
RIGHT JOIN Goal ON ClientGoal.GoalId = Goal.GoalId
RIGHT JOIN Client ON ClientGoal.ClientId = Client.ClientId
GROUP BY Client.ClientId
HAVING COUNT(ClientGoal.GoalId) = 0;


-- Exercise 13.12: Exercise Unit Value (82 rows) - I got 77 rows
/*
Select Exercise.Name, Unit.Name, and minimum and maximum ExerciseInstanceUnitValue.Value for all exercises with a configured ExerciseInstanceUnitValue.
Sort the results by Exercise.Name and then Unit.Name.
*/
TABLE ExerciseInstanceUnitValue;
TABLE Unit;
TABLE Exercise;
TABLE ExerciseInstance;

SELECT Exercise.Name AS ExerciseName, Unit.Name AS UnitName, Min(ExerciseInstanceUnitValue.Value), Max(ExerciseInstanceUnitValue.Value)
FROM Exercise
JOIN ExerciseInstance ON Exercise.ExerciseId = ExerciseInstance.ExerciseId
JOIN ExerciseInstanceUnitValue ON ExerciseInstance.ExerciseInstanceId = ExerciseInstanceUnitValue.ExerciseInstanceId
JOIN Unit ON ExerciseInstanceUnitValue.UnitId = Unit.UnitId
GROUP BY Exercise.Name, Unit.Name
ORDER BY Exercise.Name, Unit.Name;


-- Exercise 13.13: Categorized Exercise Unit Value (82 rows)
/*
Modify the query in Exercise 13.12 to include ExerciseCategory.Name. Order the output by ExerciseCategory.Name, then Exercise.Name, and then Unit.Name.
*/
SELECT 
	ExerciseCategory.Name As ExerciseCategory, 
	Exercise.Name AS ExerciseName, 
    Unit.Name AS UnitName, 
    Min(ExerciseInstanceUnitValue.Value), 
    Max(ExerciseInstanceUnitValue.Value)
FROM Exercise
JOIN ExerciseCategory ON Exercise.ExerciseCategoryId = ExerciseCategory.ExerciseCategoryId
JOIN ExerciseInstance ON Exercise.ExerciseId = ExerciseInstance.ExerciseId
JOIN ExerciseInstanceUnitValue ON ExerciseInstance.ExerciseInstanceId = ExerciseInstanceUnitValue.ExerciseInstanceId
JOIN Unit ON ExerciseInstanceUnitValue.UnitId = Unit.UnitId
GROUP BY ExerciseCategory.Name, Exercise.Name, Unit.Name
ORDER BY ExerciseCategory.Name, Exercise.Name, Unit.Name;


-- Exercise 13.14: Level Ages (4 rows)
/*
Select the minimum and maximum age in years for each Level. To calculate age in years, use the MySQL function DATEDIFF. (Do online research to see how this function works. 
One location online you can review is dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html.)
*/
TABLE Level;
TABLE Workout;
TABLE ClientWorkout;
TABLE Client;

SELECT Level.Name AS LevelName, MIN(DATEDIFF('2024-12-30', BirthDate)/365) AS MinAge, MAX(DATEDIFF('2024-12-30', BirthDate)/365) AS MaxAge
FROM Level
JOIN Workout ON Level.LevelId = Workout.LevelId
JOIN ClientWorkout ON Workout.WorkoutId = ClientWorkout.WorkoutId
JOIN Client ON ClientWorkout.ClientId = Client.ClientId
GROUP BY Level.Name;