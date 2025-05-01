# SQL-assignment-2
1. Introduction
This report outlines the implementation of a relational database schema designed to manage customer and book information. The SQL script provided establishes a dedicated schema, creates the necessary tables, inserts sample data, and includes basic table alteration commands.

2. Schema Configuration
A new schema named customer is created to logically group the tables and data operations. The search path is then set to this schema to simplify table references.

sql

CREATE SCHEMA customer;
SET search_path TO customer;

3. Customer Table
3.1 Table Structure
The customer table is created to store basic personal and contact details of customers. The structure is as follows:

customer_id: SERIAL, Primary Key

first_name: CHAR(100)

last_name: VARCHAR(100)

email: VARCHAR(100)

phone_number: CHAR(10)

city: CHAR(100)

3.2 Data Insertion
Sample customer records are inserted into the table:

sql
Copy
Edit
INSERT INTO customer (first_name, last_name, email, phone_number, city)
VALUES
  ('Ahmed', 'Rufaa', 'ahmedrufaa001@gmail.com', '0703345289', 'Nairobi'),
  ('Jamal', 'Abass', 'jamalabass@gmail.com', '0116220039', 'Mombasa'),
  ('Jhon', 'Onyango', 'Jhonoyango@gmail.com', '0757223517', 'Kisumu'),
  ('Abdalla', 'Otieno', 'abdalla.otieno@gmail.com', '0712345678', 'Nairobi');
4. Book Table
4.1 Table Structure
The book table is created to hold information about books including title, author, price, and publication date.

book_id: SERIAL, Primary Key

title: CHAR(100), NOT NULL

author: VARCHAR(100), NOT NULL

price: DECIMAL(8,2), NOT NULL

published_date: DATE, NOT NULL

4.2 Table Alteration
An attempt is made to alter the table to add a column named title, which is already present. This may be an error or duplication in the script:

sql


ALTER TABLE book
ADD COLUMN title CHAR(100);
5. Issues Identified
Duplicate Column Definition: The book table includes a redundant ALTER TABLE command that tries to re-add the title column.

Incomplete Statement: The script ends with a partial ALTER TABLE command targeting an orders table, which is not defined in the script:

sql


ALTER TABLE orders 
ADD COLUMN title CHAR
This appears to be unfinished and may cause execution errors if run as-is.

6. Conclusion
The script establishes a foundational schema for handling customer and book records in a PostgreSQL database. With minor corrections—especially regarding duplicate columns and incomplete commands—it can serve as a solid basis for a small-scale book store or customer relationship system.

