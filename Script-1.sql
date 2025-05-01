create schema customer;

set search_path to customer;

create table customer (
customer_id SERIAL  primary key,
first_name char (100),
last_name VARCHAR (100),
email VARCHAR (100),
PHONE_NUMBER CHAR (10),
City CHAR ( 100)
);

select * from customer;

insert into customer (first_name,last_name,email,phone_number,city)
values
('Ahmed','Rufaa','ahmedrufaa001@gmail.com','0703345289','Nairobi'),
('Jamal','Abass','jamalabass@gmail.com','0116220039','Mombasa'),
('Jhon','Onyango','Jhonoyango@gmail.com','0757223517','Kisumu'),
('Abdalla','Otieno','abdalla.otieno@gmail.com','0712345678','Nairobi');



create table book(
book_id SERIAL primary key,
Title char (100) not null,
AUthour VARCHAR (100) not null,
price decimal (8 ,2) not null,
published_date Date not null
);

select * from book;

alter table book
add column Title Char (100);


insert into book (authour,price,published_date,title)
--List the book title and total quantity ordered for each book. 

alter table orders 
add column title char (100);

update orders
set title ='power Bi'
where book_id =4 ;

select count( customer_id),title from orders as total_quntiy_orderd
group by title ;


 ---Show customers who have placed more orders than customer with ID = 1.

SELECT 
    c.first_name,
    c.last_name
FROM 
    customer c
WHERE 
    (
        SELECT COUNT(*)
        FROM orders o
        WHERE o.customer_id = c.customer_id
    ) >
    (
        SELECT COUNT(*)
        FROM orders o
        WHERE o.customer_id = 1
    );


-- List books that are more expensive than the average book price.


select title,price from book
where price > (select avg (price) from book);


 --Show each customer and the number of orders they placed using a subquery in SELECT

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    (
        SELECT COUNT(*) 
        FROM orders o 
        WHERE o.customer_id = c.customer_id
    ) AS number_of_orders
FROM customer c;


--Show all customers who placed more than 2 orders for books priced over 2000. 

SELECT 
    c.first_name,
    c.last_name
FROM 
    customer c
WHERE 
    (
        SELECT COUNT(*)
        FROM orders o
        JOIN book b ON o.book_id = b.book_id
        WHERE o.customer_id = c.customer_id
          AND b.price > 2000
    ) > 2;

--22. List customers who ordered the same book more than once. 

SELECT 
    o.customer_id,
    c.first_name,
    c.last_name,
    o.book_id
FROM 
    orders o
JOIN 
    customer c ON o.customer_id = c.customer_id
GROUP BY 
    o.customer_id, o.book_id, c.first_name, c.last_name
HAVING 
    COUNT(*) > 1;

        
---Show each customer's full name, total quantity of books ordered, and total amount 
spent. 

select 
   first_name,
   last_name
from 
    customer
     
    
    ---Show each customer's full name, total quantity of books ordered, and total amount 
spent. 
    
  SELECT 
    c.first_name,
    c.last_name,
    SUM(CAST(o.quantity AS INTEGER)) AS total_quantity,
    SUM(CAST(o.quantity AS INTEGER) * b.price) AS total_amount_spent
FROM 
    customer c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    book b ON o.book_id = b.book_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name;
  
  
  --List books that have never been ordered
  
  SELECT 
    b.title
FROM 
    book b
LEFT JOIN 
    orders o ON b.book_id = o.book_id
WHERE 
    o.book_id IS NULL;

  ---Find the customer who has spent the most in total (JOIN + GROUP BY + ORDER BY + 
      --LIMIT).
  
SELECT 
    c.first_name,
    c.last_name,
    SUM(CAST(o.quantity AS INT) * b.price) AS total_spent
FROM 
    customer c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    book b ON o.book_id = b.book_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_spent DESC
LIMIT 1;


-- Write a query that shows, for each book, the number of different customers who have 
ordered it

SELECT 
    b.title,
    COUNT(DISTINCT o.customer_id) AS number_of_customers
FROM 
    book b
LEFT JOIN 
    orders o ON b.book_id = o.book_id
GROUP BY 
    b.book_id, b.title;

--Using a subquery, list books whose total order quantity is above the average order 
quantity. 


SELECT 
    b.title
FROM 
    book b
WHERE 
    (
        SELECT SUM(CAST(o.quantity AS INT))
        FROM orders o
        WHERE o.book_id = b.book_id
    ) > 
    (
        SELECT AVG(total_quantity)
        FROM (
            SELECT 
                SUM(CAST(o2.quantity AS INT)) AS total_quantity
            FROM 
                orders o2
            GROUP BY 
                o2.book_id
        ) subquery
    );

---- Show the top 3 customers with the highest number of orders and the total amount they 
  spent. 
Be sure to format your output clearly and use meaningful aliases. Try using JOINs, 
subqueries, GROUP BY, and aggregate functions where appropriate

SELECT 
    c.first_name || ' ' || c.last_name AS full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(CAST(o.quantity AS INT) * b.price) AS total_spent
FROM 
    customer c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    book b ON o.book_id = b.book_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_orders DESC,
    total_spent DESC
LIMIT 3;


--joins
 ---Show full name of each customer and the titles of books they ordered. 
SELECT 
    c.first_name || ' ' || c.last_name AS full_name,
    b.title
FROM 
    customer c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    book b ON o.book_id = b.book_id
ORDER BY 
    full_name;



--17. List all orders including book title, quantity, and total cost (price × quantity). 
SELECT 
    o.order_id,
    b.title,
    CAST(o.quantity AS INT) AS quantity,
    (CAST(o.quantity AS INT) * b.price) AS total_cost
FROM 
    orders o
JOIN 
    book b ON o.book_id = b.book_id
ORDER BY 
    o.order_id;



--18. Show customers who haven't placed any orders (LEFT JOIN). 

SELECT 
    c.first_name || ' ' || c.last_name AS full_name
FROM 
    customer c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
WHERE 
    o.order_id IS NULL;


---19. List all books and the names of customers who ordered them, if any (LEFT JOIN). 
SELECT 
    b.title,
    c.first_name || ' ' || c.last_name AS customer_name
FROM 
    book b
LEFT JOIN 
    orders o ON b.book_id = o.book_id
LEFT JOIN 
    customer c ON o.customer_id = c.customer_id
ORDER BY 
    b.title;


----20. Show customers who live in the same city (SELF JOIN).

SELECT 
    c1.first_name || ' ' || c1.last_name AS customer_1,
    c2.first_name || ' ' || c2.last_name AS customer_2,
    c1.city
FROM 
    customer c1
JOIN 
    customer c2 ON c1.city = c2.city AND c1.customer_id != c2.customer_id
ORDER BY 
    c1.city;



     
     
     
  







