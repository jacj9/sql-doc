-- Here is where I document my solutions to the SQL View exercises on W3resource

-- 1. From the following table, create a view for those salespeople who belong to the city of New York. 

CREATE VIEW newyorksalespeople AS
SELECT *
FROM salesman
WHERE city = 'New York';
