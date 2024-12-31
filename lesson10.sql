/*
Following along lesson 10
*/

use ConsumerComplaints;

DESCRIBE Complaint;

SELECT DateReceived, Product, Company, State
FROM Complaint;

-- Listing 10.4: Using WHERE
-- Two hyphens is a SQL comment. This line is ignored.
-- If your query has many columns, you may want to stack them for readability.
-- Whitespace is ignored.

SELECT
    Product,
    Issue,
    SubmissionMethod
FROM Complaint
WHERE State = 'TX';

-- Listing 10.5: A query to fetch records from the ConsumerComplaints database
USE consumercomplaints;

SELECT *
FROM complaint
WHERE state = 'LA'
AND (Product = 'Mortagage' OR Product = 'Debt collection');

-- Listing 10.6: Dropping the parentheses
USE consumercomplaints;

SELECT *
FROM complaint
WHERE state = 'LA'
AND Product = 'Mortagage' OR Product = 'Debt collection';

-- Listing 10.7: Using Math Comparisons
USE ConsumerComplaints;

SELECT Product, Issue, Company, ResponseToConsumer
FROM complaint
WHERE ConsumerDisputed = 1
AND ConsumerConsent = 1
AND Product NOT IN ('Mortgage', 'Debt collection');

-- Listing 10.8: Invalid WHERE Statements
USE ConsumerComplaints;

-- This query does not return any records at all.
SELECT *
FROM complaint
WHERE SubProduct = NULL;

-- But neither does this!
SELECT *
FROM complaint
WHERE SubProduct != NULL;

-- Still empty
SELECT *
FROM complaiint
WHERE ComplaintId BETWEEN 15000 AND NULL;

-- No NULLS included in results.
SELECT *
FROM complaint
WHERE SubProduct IN ('Other mortgage', NULL);


-- Listing 10.9: Valid WHERE Statements Using IS NULL or IS NOT NULL

USE ConsumerComplaints;

-- Return 278 rows
SELECT *
FROM Complaint
WHERE SubProduct IS NULL;

-- Returns 722 rows
SELECT *
FROM complaint
WHERE SubProduct IS NOT NULL;

-- Returns 991 rows
SELECT *
FROM complaint
WHERE CompaintId > 15000 OR ComplaintId IS NULL;

-- Return 391 rows
SELECT *
FROM Complaint
WHERE SubProduct = 'Other mortgage'
OR SubProduct IS NULL;

-- All complaints with a value for ComplaintNarrative.
-- Exclude null values.
SELECT *
FROM Complaint
WHERE ComplaintNarrative IS NOT NULL;


-- Listing 10.10: Calculating the Number of Days Between Two Dates
USE ConsumerComplaints;

SELECT
	ComplaintId,
    DateReceived,
    DateSentToCompany,
    (DateSentToCompany - DateReceived) AS DateDifference
FROM Complaint;


-- Listing 10.11: Using a Calculated Value in a WHERE Clause

USE ConsumerComplaints;

SELECT
	ComplaintId,
    DateReceived,
    DateSentToCompany,
    (DateSentToCompany - DateReceived) AS DateDifference
FROM Complaint
WHERE (DateSentToCompany - DateReceived) > 365;


-- Listing 10.12: Using a Calculated Field in a WHERE Clause

USE ConsumerComplaints;

SELECT
	Newtable.ComplaintId,
    Newtable.DateReceived,
    Newtable.DateSentToCompany,
    Newtable.DateDifference
FROM (SELECT
		ComplaintId,
        DateReceived,
        DateSentToCompany,
        (DateSentToCompany - DateReceived) AS DateDifference
        FROM Complaint) AS Newtable
WHERE Newtable.DateDifference > 365;