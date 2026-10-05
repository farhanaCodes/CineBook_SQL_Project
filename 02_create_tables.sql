-- CineBook Movie Ticket Booking System
-- Table creation

USE CineBook;

CREATE TABLE Customers (Customer_ID INT PRIMARY KEY, Name VARCHAR(100) NOT NULL, Age INT, Gender VARCHAR(10), Phone VARCHAR(15) UNIQUE, Email VARCHAR(100) UNIQUE, City VARCHAR(50));
CREATE TABLE Movies (Movie_ID INT PRIMARY KEY, Title VARCHAR(150) NOT NULL, Genre VARCHAR(50), Language VARCHAR(30), Duration_Min INT, Rating DECIMAL(3,1));
CREATE TABLE Theatres (Theatre_ID INT PRIMARY KEY, Theatre_Name VARCHAR(100) NOT NULL, Location VARCHAR(50), Total_Screens INT);
CREATE TABLE Screens (Screen_ID INT PRIMARY KEY, Theatre_ID INT, Screen_Name VARCHAR(50), Capacity INT, FOREIGN KEY (Theatre_ID) REFERENCES Theatres(Theatre_ID));
CREATE TABLE Shows (Show_ID INT PRIMARY KEY, Movie_ID INT, Screen_ID INT, Show_Date DATE, Show_Time VARCHAR(20), Ticket_Price DECIMAL(10,2), FOREIGN KEY (Movie_ID) REFERENCES Movies(Movie_ID), FOREIGN KEY (Screen_ID) REFERENCES Screens(Screen_ID));
CREATE TABLE Bookings (Booking_ID INT PRIMARY KEY, Customer_ID INT, Show_ID INT, Booking_Date DATE, Seats_Booked INT, Total_Amount DECIMAL(10,2), Booking_Status VARCHAR(20), FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID), FOREIGN KEY (Show_ID) REFERENCES Shows(Show_ID));
CREATE TABLE Payments (Payment_ID INT PRIMARY KEY, Booking_ID INT UNIQUE, Payment_Method VARCHAR(30), Payment_Status VARCHAR(20), Payment_Date DATE, FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID));
CREATE TABLE Booking_Cancellations (Cancellation_ID INT PRIMARY KEY, Booking_ID INT UNIQUE, Cancellation_Date DATE, Cancellation_Reason VARCHAR(100), FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID));
CREATE TABLE Payment_Refunds (Refund_ID INT PRIMARY KEY, Booking_ID INT UNIQUE, Refund_Date DATE, Refund_Amount DECIMAL(10,2), Refund_Status VARCHAR(20), Refund_Method VARCHAR(40), FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID));
