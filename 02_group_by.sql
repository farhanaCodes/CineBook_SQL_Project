USE CineBook;

--How many movies are available in each genre?
SELECT
    Genre,
    COUNT(*) AS Movie_Count
FROM Movies
GROUP BY Genre;

--How many movies are available in each language?
SELECT
    Language,
    COUNT(*) AS Movie_Count
FROM Movies
GROUP BY Language;

--How many customers belong to each city?
SELECT
    City,
    COUNT(*) AS Customer_Count
FROM Customers
GROUP BY City;

--How many bookings has each customer made?
SELECT
    Customer_ID,
    COUNT(*) AS Booking_Count
FROM Bookings
GROUP BY Customer_ID
ORDER BY Booking_Count DESC;

--How much money has each customer spent?
SELECT
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent
FROM Bookings
GROUP BY Customer_ID
ORDER BY Total_Spent DESC;

--Average Booking Amount by Customer
SELECT
    Customer_ID,
    AVG(Total_Amount) AS Average_Booking
FROM Bookings
GROUP BY Customer_ID
ORDER BY Average_Booking DESC;

--How many payments were made using each payment method?
SELECT
    Payment_Method,
    COUNT(*) AS Payment_Count
FROM Payments
GROUP BY Payment_Method
ORDER BY Payment_Count DESC;

--Payment Status
SELECT
    Payment_Status,
    COUNT(*) AS Payment_Count
FROM Payments
GROUP BY Payment_Status;

--Why are customers cancelling bookings?
SELECT
    Cancellation_Reason,
    COUNT(*) AS Cancellation_Count
FROM Booking_Cancellations
GROUP BY Cancellation_Reason
ORDER BY Cancellation_Count DESC;

--Refund Status
SELECT
    Refund_Status,
    COUNT(*) AS Refund_Count
FROM Payment_Refunds
GROUP BY Refund_Status;

--Revenue by Booking Status
SELECT
    Booking_Status,
    COUNT(*) AS Booking_Count,
    SUM(Total_Amount) AS Revenue
FROM Bookings
GROUP BY Booking_Status;

--Customers with more than 5 bookings
SELECT
    Customer_ID,
    COUNT(*) AS Booking_Count
FROM Bookings
GROUP BY Customer_ID
HAVING COUNT(*) > 5;

--Customers who spent more than ₹2,000
SELECT
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent
FROM Bookings
GROUP BY Customer_ID
HAVING SUM(Total_Amount) > 2000;

--Genres with more than 2 movies
SELECT
    Genre,
    COUNT(*) AS Movie_Count
FROM Movies
GROUP BY Genre
HAVING COUNT(*) > 2;

--Payment methods used more than 40 times
SELECT
    Payment_Method,
    COUNT(*) AS Payment_Count
FROM Payments
GROUP BY Payment_Method
HAVING COUNT(*) > 40;

--Find customers who made bookings of more than ₹500 and whose total spending is greater than ₹2,000.
SELECT
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent
FROM Bookings
WHERE Total_Amount > 500
GROUP BY Customer_ID
HAVING SUM(Total_Amount) > 2000;

