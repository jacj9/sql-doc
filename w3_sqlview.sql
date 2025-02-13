-- Here is where I document my solutions to the SQL View exercises on W3resource

-- 1. From the following table, create a view for those salespeople who belong to the city of New York. 

CREATE VIEW newyorksalespeople AS
SELECT *
FROM salesman
WHERE city = 'New York';

-- 2. From the following table, create a view for all salespersons. Return salesperson ID, name, and city.  
-- Creating a VIEW named 'salesperson'
CREATE VIEW salesperson
-- Selecting specific columns (salesman_id, name, city) from the 'salesman' table
AS SELECT salesman_id, name, city
-- Retrieving data from the 'salesman' table and storing it in the VIEW
FROM salesman;


-- 3. From the following table, create a view to locate the salespeople in the city 'New York'.
CREATE VIEW salesman_nyc
AS SELECT *
FROM salesman
WHERE city = 'New York';
