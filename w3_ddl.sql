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
