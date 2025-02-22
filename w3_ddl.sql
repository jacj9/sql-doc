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
ADD COLUMN department VARCHAR(50)
ADD COLUMN salary INT;

ALTER TABLE customers
ADD COLUMN created_at DATETIME,
ADD COLUMN phone_number INT,
ADD COLUMN is_active BOOLEAN,
ADD COLUMN discount_rate DECIMAL;


-- 3. Modify a Column's Data Type: Write a SQL query to change the data type of an existing column in a table.
ALTER TABLE customers
MODIFY COLUMN phone_nuber SMALLINT;

ALTER TABLE employees
-- Modify from INT to DECIMAL(10,2)
MODIFY COLUMN salary DECIMAL(10,2), 
MODIFY COLUMN department TEXT,
MODIFY COLUMN birthday DATE; 


-- 4. Drop a column: Write a SQL query to remove a column from an existing table.
ALTER TABLE customers
DROP COLUMN is_active;

ALTER TABLE employees
DROP COLUMN department;


-- 5. Add a Unique Constraint: Write a SQL query to add a unique constraint to a column in an existing table.
-- The UNIQUE constraint ensures that all values in a column are different.

-- Add a unique constraint to the "Name" column to ensure no duplicate name
ALTER TABLE employees -- Specify the table to modify.
ADD CONSTRAINT UC_Name UNIQUE (Name); -- Ensure all names are unique.

-- Write a SQL query to add a unique constraint to the username column in the users table.
ALTER TABLE users
ADD CONSTRAINT UC_users UNIQUE (username);

-- Write a SQL query to ensure that the product_code column in the products table contains only unique values.
ALTER TABLE products
ADD CONSTRAINT UC_products UNIQUE (product_code);

-- Write a SQL query to add a unique constraint to the email_address column in the customers table.
ALTER TABLE customers
ADD CONSTRAINT UC_customers UNIQUE (email_address);

-- Write a SQL query to enforce uniqueness on the order_reference column in the orders table.
ALTER TABLE orders
ADD CONSTRAINT UC_order UNIQUE (order_reference);


-- 6. Add a Foreign Key: Write a SQL query to create a foreign key relationship between two tables.
-- Create a table
CREATE TABLE customers (
  CustomerId INT PRIMARY KEY, -- Primary key for the customers table
  name VARCHAR(50)    -- Column to customer names.
);

ALTER TABLE Orders
ADD customerID INT, -- Add a column to reference the "customers" table
ADD CONSTRAINT FK_CustomerOrder
FOREIGN KEY CustomerID REFERENCES Customers(CustomerID); 
-- This will link orders.customerid to customers.customerid using a foreing key

-- More practice
-- Write a SQL query to create a foreign key relationship between the customer_id column 
-- in the orders table and the id column in the customers table.

CREATE TABLE orders (
customer_id INT PRIMARY KEY,
name VARCHAR(50)
);

ALTER TABLE customers
ADD CONSTRAINT FK_customersorders
FOREIGN KEY id REFERENCES orders(customer_id);

-- Write a SQL query to establish a foreign key constraint between the department_id column in 
-- the employees table and the id column in the departments table.

CREATE TABLE employees (
  id INT PRIMARY KEY NOT NULL,
  depamrtment_id INT
);

ALTER TABLE departments
ADD CONSTRAINT FK_employeesdepartments
FOREIGN KEY id REFERENCES employees(department_id);

-- Write a SQL query to link the supplier_id column in the products table to the id column in 
-- the suppliers table using a foreign key.

CREATE TABLE products (
  id INT PRIMARY KEY NOT NULL,
  supplier_id INT
);

ALTER TABLE suppliers
ADD CONSTRAINT FK_productssuppliers
FOREIGN KEY supplier_id REFERENCES suppliers(id);

-- Write a SQL query to create a foreign key relationship between the category_id column in 
-- the items table and the id column in the categories table.

CREATE TABLE items (
  id INT PRIMARY KEY NOT NULL,
  category_id INT
);

ALTER TABLE categories
ADD CONSTRAINT FK_itemscatagories
FOREIGN KEY id REFERENCES items(category_id);


-- 7. Drop a Table: Write a SQL query to permanently delete a table and all its data.
DROP TABLE categories;

-- 8. Truncate a Table: Write a SQL query to remove all rows from a table while retaining its structure.
-- Create a table to truncate
CREATE TABLE employees (
  emp_id INT(4),
  name VARCHAR(20),
  age INT(3),
  dob DATE,
  salary DECIMAL(7,2)
);

-- truncate employees table
TRUNCATE TABLE employees;


-- 9. Create an Index: Write a SQL query to create an index on a column to improve query performance.

CREATE INDEX idx_salary ON employees (salary);

-- Create an index on the "Name" column to improve query performance.
CREATE INDEX idx_Name ON Employees(Name); -- Create an index for faster lookups.

-- Write a SQL query to create an index on the last_name column in the employees table.
CREATE INDEX idx_lname ON employees(last_name);

-- Write a SQL query to improve query performance by creating an index on the product_name column in the products table.
CREATE INDEX idx_pname ON products(product_name);

-- Write a SQL query to create a composite index on the city and state columns in the addresses table.
CREATE INDEX idx_city ON addresses(city);

-- Write a SQL query to create an index on the email column in the users table.
CREATE INDEX idx_email ON users(email);


-- 10. Drop an Index: Write a SQL query to remove an index from a table.

--SQL Server
DROP INDEX idx_salary ON employees;

-- MySQL
ALTER TABLE employees DROP INDEX idx_salary;

-- MORE PRACTICE
-- Write a SQL query to remove the index named idx_last_name from the employees table.
DROP INDEX idx_last_name ON employees;

-- Write a SQL query to drop the index on the product_name column in the products table.
DROP INDEX idx_pname ON products;

-- Write a SQL query to delete the composite index on the city and state columns in the addresses table.
DROP INDEX idx_city ON addresses;

-- Write a SQL query to remove the index on the email column in the users table.
DROP INDEX idx_email ON users;


-- 11. Rename a Table: Write a SQL query to rename an existing table.
ALTER TABLE departments RENAME TO all_departments;

-- 12. Add a Default Value: Write a SQL query to assign a default value to a column in an existing table.
-- The DEFAULT value will be added to all new records, if no other value is specified.

ALTER TABLE employees
ADD CONSTRAINT df_first_name DEFAULT 'John' FOR first_name; -- The DEFAULT value "John' is added to column first_name 


-- 13. Remove a Constraint: Write a SQL query to remove a constraint from an existing table.
-- Drop default valut constraint for employees table
ALTER TABLE employees
DROP CONSTRAINT df_first_name;

-- Remove the unique constraint "UC_Name" from the "employees" table
ALTER TABLE employees
DROP CONSTRAINT UC_Name; -- Delete the unique constraint on "Name"

-- More practice on related problems
-- Write a SQL query to remove the unique constraint from the email column in the users table.
ALTER TABLE users DROP CONSTRAINT UC_Email;

-- Write a SQL query to drop the NOT NULL constraint from the phone_number column in the customers table.
ALTER TABLE customers ALTER COLUMN phone_number DROP NOT NULL;

-- Write a SQL query to remove the foreign key constraint from the department_id column in the employees table.
ALTER TABLE employees ALTER COLUMN department_id DROP FOREIGN KEY;

-- Write a SQL query to delete the check constraint that ensures positive values in the price column of the products table.
ALTER TABLE products DROP CHECK price_chk;


-- 14. Create a Schema: Write a SQL query to create a new schema in the database.
CREATE SCHEMA emp_sch -- new schema name
AUTHORIZATION owner_name; --jajjk

-- W3 Solution:
-- Create a new schema named "HR".
CERATE SCHEMA HR; -- Define a new schema for organizing database objects.
