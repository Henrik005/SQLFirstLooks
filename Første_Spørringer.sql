--The Database this file is made for has 5 TABLES, wich is Authors, Books, Customers, OrderItems and Orders. 
--Authors has 3 Columns that contain id PRIMARY KEY INTEGER, name(VARCHAR), and birthdate(DATE)
--Books contains 5 Columns that contain id PRIMARY KEY INTEGER, title(VARCHAR), genre(VARCHAR), published_year(YEAR), and a FOREIGN KEY INTEGER author_id wich is the connection between Authors and Books
--Customers has 3 Columns that contains id PRIMARY KEY INTEGER, name(VARCHAR) and email(VARCHAR)
--OrderItems has 3 Columns that contain order_id FOREIGN KEY INTEGER, book_id FOREIGN KEY INTEGER and quantity INTEGER. The two FOREIGN KEYS connecting it to the Orders and Books TABLES
--Orders has 3 Columns that contain id PRIMARY KEY INTEGER, order_date(DATE) and FOREIGN KEY INTEGER customer_id wich connects it to the Customers TABLE

--Down bellow you will find all of the queries with comments that explain them as you go!









--The code bellow gets all books who's published year is after the year 2000
SELECT
 *
FROM
Books
WHERE
published_year >2000;

 --The code bellow gets all Authors who's birthdate is after 1980
SELECT
 * 
 FROM
 Authors
 WHERE
 birthdate > '1980-01-01';

--The code bellow gets all the data on the Orders table, and the email and names from the Customers TABLE
--by first selecting the specified columns and then using an INNER JOIN in order to be able to access
--multiple TABLES within one query, this being possible because we have a FOREIGN KEY in 
--the Orders TABLE wich acts as a link to the Authors TABLE.
SELECT 
Orders.*,
Customers.name,email
FROM 
Orders
INNER JOIN
Customers ON Orders.customer_id=Customers.id;

--The code bellow does the same as the code above except it gets all the books and the authors names instead.
SELECT 
Books.*,
Authors.name
FROM 
Books
INNER JOIN 
Authors ON Books.author_id=Authors.id;

--The code bellow  counts the total of books per genre
--by first selecting the genre column and counting all the rows 
--in it and then grouping them by genre
SELECT genre, COUNT(*) AS NumberOfBooksPerGenre
FROM
Books
GROUP BY genre;

--The code bellow gets the average published year from the Books TABLE 
--using the AVG aggregate function to get the average from the published_year collumn
SELECT AVG(published_year) AS AveragePublishedYearOfAllBooks
FROM
Books;

-- The code bellow gets the name of all the authors as the main query
--then uses a subquery to count how many books the author has written by matching
-- author.id in the Books TABLE with id in the Authors TABLE
SELECT name, 
(SELECT COUNT(*) FROM Books WHERE Books.author_id = Authors.id) AS TotalBooksWritten
FROM Authors;

--In the code bellow we get all the customer ID's that have made more then one order 
--like in previous code, we select the column we want, count the rows and then group them
--then we use HAVING in order to filter the results because WHERE cannot be used on aggregated data.
SELECT customer_id, COUNT(*) AS TotalOrders
FROM
Orders
GROUP BY
customer_id
HAVING COUNT(*)> 1;

--The bellow code updates the email data in the Customers TABLE and specifies that this
--should only be done where the id is 3
UPDATE Customers
SET email = 'doodly.diddly@gmail.com'
WHERE id = 3;

--this does the same as the code above, but with the genre of a book in the Books TABLE
-- and at id 4
UPDATE Books
SET genre = 'Do It Yourself'
WHERE id = 4;

--The code bellow deletes a book from the Books TABLE at the specified ID
--We also use ON DELETE SET NULL to make the refrence to said book NULL in the OrderItems TABLE
DELETE FROM Books
WHERE id = 1;

--The code bellow does the same as the one above but i have added a ON DELETE CASCADE to the related FOREIGN KEYS 
--So that when the Customer is deleted, the related data in Orders and OrderItems is deleted too
DELETE FROM Customers
Where id = 1;