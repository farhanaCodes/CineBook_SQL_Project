USE CineBook;

-- Q7 Monthly Booking and Revenue Analysis
SELECT
    MONTHNAME(Booking_Date) AS Month,
    COUNT(*) AS Total_Bookings,
    SUM(Total_Amount) AS Total_Revenue
FROM Bookings
GROUP BY MONTH(Booking_Date), MONTHNAME(Booking_Date)
ORDER BY MONTH(Booking_Date);

-- Q8 Movie-wise Booking and Revenue Analysis
SELECT
    m.Title AS Movie_Name,
    COUNT(b.Booking_ID) AS Total_Bookings,
    SUM(b.Total_Amount) AS Total_Revenue
FROM Bookings b
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Movies m
    ON s.Movie_ID = m.Movie_ID
GROUP BY m.Title
ORDER BY Total_Revenue DESC;

-- Q9 Theatre-wise Booking and Revenue Analysis
SELECT
    t.Theatre_Name,
    COUNT(b.Booking_ID) AS Total_Bookings,
    SUM(b.Total_Amount) AS Total_Revenue
FROM Bookings b
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Screens sc
    ON s.Screen_ID = sc.Screen_ID
JOIN Theatres t
    ON sc.Theatre_ID = t.Theatre_ID
GROUP BY t.Theatre_Name
ORDER BY Total_Revenue DESC;

-- Q10 Most Booked Movies
SELECT
    m.Title AS Movie_Name,
    COUNT(b.Booking_ID) AS Total_Bookings
FROM Bookings b
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Movies m
    ON s.Movie_ID = m.Movie_ID
GROUP BY m.Title
ORDER BY Total_Bookings DESC;

-- Q11 Customer Booking and Spending Analysis
SELECT
    c.Name AS Customer_Name,
    COUNT(b.Booking_ID) AS Total_Bookings,
    SUM(b.Total_Amount) AS Total_Spending
FROM Bookings b
JOIN Customers c
    ON b.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spending DESC;

-- Q12 Customer with Highest Spending
SELECT
    c.Name AS Customer_Name,
    SUM(b.Total_Amount) AS Total_Spending
FROM Bookings b
JOIN Customers c
    ON b.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spending DESC
LIMIT 1;

-- Q13 Movie with Highest Revenue
SELECT
    m.Title AS Movie_Name,
    SUM(b.Total_Amount) AS Total_Revenue
FROM Bookings b
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Movies m
    ON s.Movie_ID = m.Movie_ID
GROUP BY m.Movie_ID, m.Title
ORDER BY Total_Revenue DESC
LIMIT 1;

-- Q14 Total Cancellations
SELECT COUNT(*) AS Total_Cancellations
FROM Booking_Cancellations;

-- Q15 Cancellation Reasons
SELECT
    Cancellation_Reason,
    COUNT(*) AS Cancellation_Count
FROM Booking_Cancellations
GROUP BY Cancellation_Reason
ORDER BY Cancellation_Count DESC;

-- Q16 Monthly Cancellations
SELECT
    MONTHNAME(Cancellation_Date) AS Month,
    COUNT(*) AS Total_Cancellations
FROM Booking_Cancellations
GROUP BY MONTH(Cancellation_Date), MONTHNAME(Cancellation_Date)
ORDER BY MONTH(Cancellation_Date);

-- Q17 Movie-wise Cancellations
SELECT
    m.Title AS Movie_Name,
    COUNT(bc.Cancellation_ID) AS Total_Cancellations
FROM Booking_Cancellations bc
JOIN Bookings b
    ON bc.Booking_ID = b.Booking_ID
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Movies m
    ON s.Movie_ID = m.Movie_ID
GROUP BY m.Movie_ID, m.Title
ORDER BY Total_Cancellations DESC;

-- Q18 Theatre-wise Cancellations
SELECT
    t.Theatre_Name,
    COUNT(bc.Cancellation_ID) AS Total_Cancellations
FROM Booking_Cancellations bc
JOIN Bookings b
    ON bc.Booking_ID = b.Booking_ID
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Screens sc
    ON s.Screen_ID = sc.Screen_ID
JOIN Theatres t
    ON sc.Theatre_ID = t.Theatre_ID
GROUP BY t.Theatre_ID, t.Theatre_Name
ORDER BY Total_Cancellations DESC;

-- Q19 Total Refund Amount
SELECT
    SUM(Refund_Amount) AS Total_Refund
FROM Payment_Refunds;

-- Q20 Monthly Refund Analysis
SELECT
    MONTHNAME(Refund_Date) AS Month,
    COUNT(*) AS Total_Refunds,
    SUM(Refund_Amount) AS Total_Refund_Amount
FROM Payment_Refunds
GROUP BY MONTH(Refund_Date), MONTHNAME(Refund_Date)
ORDER BY MONTH(Refund_Date);

-- Q21 Movie-wise Refund Analysis
SELECT
    m.Title AS Movie_Name,
    COUNT(pr.Refund_ID) AS Total_Refunds,
    SUM(pr.Refund_Amount) AS Total_Refund_Amount
FROM Payment_Refunds pr
JOIN Bookings b
    ON pr.Booking_ID = b.Booking_ID
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Movies m
    ON s.Movie_ID = m.Movie_ID
GROUP BY m.Movie_ID, m.Title
ORDER BY Total_Refund_Amount DESC;

-- Q22 Refunds by Payment Method
SELECT
    p.Payment_Method,
    COUNT(pr.Refund_ID) AS Total_Refunds,
    SUM(pr.Refund_Amount) AS Total_Refund_Amount
FROM Payment_Refunds pr
JOIN Payments p
    ON pr.Booking_ID = p.Booking_ID
GROUP BY p.Payment_Method
ORDER BY Total_Refund_Amount DESC;

-- Q23 Net Revenue
SELECT
    (SELECT SUM(Total_Amount) FROM Bookings)
    -
    (SELECT SUM(Refund_Amount) FROM Payment_Refunds)
    AS Net_Revenue;

-- Q24 Movies with Rating Above Average
SELECT
    Title,
    Rating
FROM Movies
WHERE Rating > (
    SELECT AVG(Rating)
    FROM Movies
)
ORDER BY Rating DESC;

-- Q25 Customers Spending Above Average
SELECT
    c.Name AS Customer_Name,
    SUM(b.Total_Amount) AS Total_Spending
FROM Bookings b
JOIN Customers c
    ON b.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING SUM(b.Total_Amount) > (
    SELECT AVG(Customer_Total)
    FROM (
        SELECT SUM(Total_Amount) AS Customer_Total
        FROM Bookings
        GROUP BY Customer_ID
    ) AS Customer_Spending
)
ORDER BY Total_Spending DESC;

-- Q26 Movie with Highest Revenue using a Subquery
SELECT
    m.Title AS Movie_Name,
    SUM(b.Total_Amount) AS Total_Revenue
FROM Bookings b
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Movies m
    ON s.Movie_ID = m.Movie_ID
GROUP BY m.Movie_ID, m.Title
HAVING SUM(b.Total_Amount) = (
    SELECT MAX(Movie_Revenue)
    FROM (
        SELECT SUM(b2.Total_Amount) AS Movie_Revenue
        FROM Bookings b2
        JOIN Shows s2
            ON b2.Show_ID = s2.Show_ID
        GROUP BY s2.Movie_ID
    ) AS Movie_Revenues
);

-- Q27 Customer with Highest Spending
SELECT
    c.Name AS Customer_Name,
    SUM(b.Total_Amount) AS Total_Spending
FROM Bookings b
JOIN Customers c
    ON b.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spending DESC
LIMIT 1;

-- Q28 Rank Movies by Revenue using a Window Function
SELECT
    Movie_Name,
    Total_Revenue,
    RANK() OVER (ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM (
    SELECT
        m.Title AS Movie_Name,
        SUM(b.Total_Amount) AS Total_Revenue
    FROM Bookings b
    JOIN Shows s
        ON b.Show_ID = s.Show_ID
    JOIN Movies m
        ON s.Movie_ID = m.Movie_ID
    GROUP BY m.Movie_ID, m.Title
) AS Movie_Revenue;

-- Q29 Create Indexes
CREATE INDEX idx_movie_genre ON Movies(Genre);
CREATE INDEX idx_booking_date ON Bookings(Booking_Date);
CREATE INDEX idx_show_date ON Shows(Show_Date);

-- Q30 Create Booking Details View
CREATE VIEW Booking_Details AS
SELECT
    b.Booking_ID,
    c.Name AS Customer_Name,
    m.Title AS Movie_Name,
    t.Theatre_Name,
    sc.Screen_Name,
    s.Show_Date,
    s.Show_Time,
    b.Seats_Booked,
    b.Total_Amount,
    b.Booking_Status
FROM Bookings b
JOIN Customers c
    ON b.Customer_ID = c.Customer_ID
JOIN Shows s
    ON b.Show_ID = s.Show_ID
JOIN Movies m
    ON s.Movie_ID = m.Movie_ID
JOIN Screens sc
    ON s.Screen_ID = sc.Screen_ID
JOIN Theatres t
    ON sc.Theatre_ID = t.Theatre_ID;
