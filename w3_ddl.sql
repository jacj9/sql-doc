-- Here is where I document my work on Data Definition Language (DDL) exercises from w3resource.

-- 1. Create a Table: Write a SQL query to create a table with specific columns and constraints.
CREATE TABLE songs (
songid INT PRIMARY KEY,
title VARCHAR(50) NOT NULL,
artist VARCHAR(50) NOT NULL,
date_release DATETIME NOT NULL
);

-- 2. Add a New Column: Write a SQL query to add a new column to an existing table.

ALTER TABLE employees
ADD COLUMN birthdate DATETIME NOT NULL,
ADD COLUMN hire_date DATETIME NOT NULL,
ADD COLUMN department VARCHAR(50);

ALTER TABLE customers
ADD COLUMN created_at DATETIME,
ADD COLUMN phone_number INT,
ADD COLUMN is_active BOOLEAN,
ADD COLUMN discount_rate DECIMAL;

