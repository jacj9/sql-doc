/*
Exercise 10.1: Complaints
Date written: December 14, 2024
*/

USE ConsumerComplaints;
SHOW TABLES;
TABLE complaint;

-- Does ComplaintId 1200385 exixt?
SELECT *
FROM complaint
WHERE complaintId = 1200385;

-- How many Complaints are there with a ComplaintId 100,000 and 200,000?
SELECT COUNT(*)
FROM complaint
WHERE complaintId BETWEEN 100000 AND 200000;


-- What is the most common Product between ComplaintId 100,000 and 200,000?
SELECT product, COUNT(product)
FROM complaint
WHERE complaintId BETWEEN 100000 AND 200000
GROUP BY product
ORDER BY COUNT(product) DESC;


-- Did anyone submit a complaint on New Year's Day 2014?
TABLE complaint;

SELECT DateReceived
FROM complaint
WHERE dateSentToCompany = '2014-01-01';

-- Are there complaints in 2018?
SELECT *
FROM complaint
WHERE datereceived LIKE '2018&';

-- How many complaints were reported in July 2015?
SELECT *
FROM complaint
WHERE dateReceived LIKE '2015-07&';


-- Do any complaints claim to have been sent to the company (DateSentToCompany) before the complaint was received (DateRecived)?
TABLE complaint;

SELECT DateSentToCompany, DateReceived
FROM complaint
WHERE DateSentToCompany < DateReceived;


-- Find consumer complaints about companies with names that start with 'V'.
SELECT company
FROM complaint
WHERE company LIKE '%V%'
GROUP BY company;


-- Find complaints that use the word 'whom' in their ComplaintNarrative.
SELECT complaintId, ComplaintNarrative
FROM complaint
WHERE ComplaintNarrative LIKE '%whom%';


-- What are the SubmissionMethods with exactly three characters?
Table complaint;

SELECT SubmissionMethod
FROM complaint
WHERE SubmissionMethod LIKE '___'
GROUP BY SubmissionMethod;


-- Which Complaints mention 'loan' in their issue?
SELECT ComplaintId, Issue
FROM complaint
WHERE Issue LIKE '%loan%';
