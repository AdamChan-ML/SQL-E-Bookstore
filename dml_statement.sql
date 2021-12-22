-- DAS Assignment Query Questions

USE E_Bookstore;
GO

--Question i) - Leanne Ooi Xin Ru 
--List the book(s) which has the highest rating. Show book id, book name, and the rating.
SELECT B.ISBN, B.Title, MAX(F.Rating) AS 'The Hightest Rating'
FROM Book B INNER JOIN Feedback F ON B.ISBN = F.ISBN
GROUP BY B.ISBN, B.Title
HAVING MAX(F.Rating) = (SELECT MAX(Rating) FROM Feedback);


--Question ii) - Leanne Ooi Xin Ru 
--Find the total number of feedbacks per member. Show member id, member name, and total number of feedbacks per member.
SELECT M.MemberID, M.FirstName, M.LastName, COUNT(F.FeedbackID) AS 'Total Number of Feedbacks Per Member'
FROM Member M LEFT JOIN Feedback F ON M.MemberID = F.MemberID
GROUP BY M.MemberID, M.FirstName, M.LastName;


--Question iii) - Leanne Ooi Xin Ru 
--Find the total number of books published by each publisher. Show publisher id, publisher name, and number of books published.
SELECT P.PublisherID, P.Name, COUNT(B.PublisherID) AS 'The Number of Books Published'
FROM Publisher P INNER JOIN Book B ON P.PublisherID = B.PublisherID
GROUP BY P.PublisherID, P.Name;


--Quenstion iv) - Leanne Ooi Xin Ru 
--Find the total number of books ordered by store manager from each publisher.
SELECT P.PublisherID, COUNT(BO.OrderID) AS 'The Total Number of Books Ordered'
FROM Publisher P INNER JOIN Orders O ON P.PublisherID = O.PublisherID
INNER JOIN Book_Orders BO ON O.OrderID = BO.OrderID
GROUP BY P.PublisherID;


--Question v) - Chan Ming Li
--Find the total number of books ordered by each member.
SELECT M.MemberID, M.FirstName, M.LastName, SUM(BS.SaleQuantity) AS 'Total Number of Books Purchased'
FROM Sale S INNER JOIN Book_Sale BS ON S.SaleID = BS.SaleID
RIGHT JOIN Member M ON S.MemberID = M.MemberID
GROUP BY M.MemberID, M.FirstName, M.LastName
ORDER BY M.MemberID;


--Question vi) - Chan Ming Li
--Find the bestselling book(s).
SELECT B.ISBN, B.Title AS 'Best Selling Book(s) (Title)', SUM(BS.SaleQuantity) AS 'Total Sales'
FROM Book B INNER JOIN Book_Sale BS ON B.ISBN = BS.ISBN
GROUP BY B.ISBN, B.Title
HAVING SUM(BS.SaleQuantity) = (SELECT TOP(1) SUM(SaleQuantity) FROM Book_Sale
GROUP BY ISBN
ORDER BY SUM(SaleQuantity) DESC);


--Question vii) - Chan Ming Li
--Show list of total customers based on gender who are registered as members in APU E-Bookstore. 
--The list should show total number of registered members and total number of gender (male and female).
SELECT Gender, COUNT(*) AS 'Total Members'
FROM Member
GROUP BY Gender;


--Question viii) - Lim Jia Yong 
--Show a list of purchased books that have not been delivered to members. 
--The list should show member identification number, address, contact number, book serial number, book title, quantity, date and status of delivery.	
SELECT M.MemberID, M.Address, M.PhoneNumber AS 'Contact Number', B.ISBN, B.Title AS 'Book Title', 
BS.SaleQuantity AS 'Quantity', S.SaleDate AS 'Date of Purchase', S.DeliveryStatus AS 'Delivery Status'
FROM Member M INNER JOIN Sale S ON M.MemberID = S.MemberID
INNER JOIN Book_Sale BS ON S.SaleID = BS.SaleID
INNER JOIN Book B ON BS.ISBN = B.ISBN
WHERE S.DeliveryStatus = 'Pending'
ORDER BY M.MemberID, S.SaleDate;


--Question ix) - Lim Jia Yong 
--Show the member who spent most on buying books. Show member id, member name and total expenditure.
SELECT TOP 1 
M.MemberID, M.FirstName, M.LastName, SUM(BS.SaleQuantity * B.Price) AS 'Total Expenditure (RM)'
FROM Member M INNER JOIN Sale S ON M.MemberID = S.MemberID
INNER JOIN Book_Sale BS ON S.SaleID = BS.SaleID
INNER JOIN Book B ON BS.ISBN = B.ISBN
GROUP BY M.MemberID, M.FirstName, M.LastName
ORDER BY SUM(BS.SaleQuantity * B.Price) DESC;


--Question x) - Lim Jia Yong 
--Show a list of total books as added by each member in the shopping cart.
SELECT M.MemberID, M.FirstName, M.LastName, SUM(C.Quantity) AS 'Total Books Added to Cart'
FROM Member M LEFT JOIN Cart_Item C ON M.MemberID = C.MemberID
GROUP BY  M.MemberID, M.FirstName, M.LastName
ORDER BY SUM(C.Quantity) DESC;

--Presentation Question - Chan Ming Li
--List the names of all members who had given a rating of 6 or 7 for any one book.
SELECT M.MemberID, M.FirstName, M.LastName, F.Rating
FROM Member M INNER JOIN Feedback F ON M.MemberID = F.MemberID
WHERE F.Rating = '6' or F.Rating = '7'
ORDER BY M.MemberID;