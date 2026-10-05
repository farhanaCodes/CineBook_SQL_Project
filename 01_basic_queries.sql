USE CineBook;

SELECT *
FROM Customers;

SELECT *
FROM Movies;

SELECT *
FROM Theatres;

SELECT *
FROM Bookings;

SELECT Title
FROM Movies;

SELECT
    Title,
    Rating
FROM Movies;


SELECT
    Title,
    Rating
FROM Movies
WHERE Rating > 8;

SELECT
    Title,
    Genre,
    Language
FROM Movies
WHERE Language = 'Hindi';

SELECT
    Title,
    Genre
FROM Movies
WHERE Genre = 'Action';

SELECT
    Customer_ID,
    Name,
    City
FROM Customers
WHERE City = 'Kolkata';

SELECT
    Title,
    Rating
FROM Movies
ORDER BY Rating DESC;

SELECT
    Title,
    Rating
FROM Movies
ORDER BY Rating DESC
LIMIT 5;

SELECT
    Title,
    Rating
FROM Movies
WHERE Rating BETWEEN 8 AND 9;

SELECT
    Title,
    Genre
FROM Movies
WHERE Genre IN ('Action', 'Comedy', 'Thriller');

SELECT
    Customer_ID,
    Name
FROM Customers
WHERE Name LIKE 'A%';

SELECT
    Customer_ID,
    Name,
    Age
FROM Customers
WHERE Age BETWEEN 20 AND 30;
----------------------
SELECT COUNT(*) AS Total_Customers
FROM Customers;

SELECT COUNT(*) AS Total_Movies
FROM Movies;

SELECT COUNT(*) AS Total_Bookings
FROM Bookings;

SELECT COUNT(*) AS Total_Shows
FROM Shows;

SELECT SUM(Total_Amount) AS Total_Revenue
FROM Bookings;

SELECT AVG(Total_Amount) AS Average_Booking_Amount
FROM Bookings;

SELECT MAX(Total_Amount) AS Highest_Booking
FROM Bookings;

SELECT MIN(Total_Amount) AS Lowest_Booking
FROM Bookings;

SELECT AVG(Rating) AS Average_Movie_Rating
FROM Movies;

SELECT MAX(Rating) AS Highest_Rating
FROM Movies;

SELECT MIN(Rating) AS Lowest_Rating
FROM Movies;

SELECT COUNT(*) AS Total_Cancellations
FROM Booking_Cancellations;

SELECT SUM(Refund_Amount) AS Total_Refund
FROM Payment_Refunds;

SELECT AVG(Refund_Amount) AS Average_Refund
FROM Payment_Refunds;

