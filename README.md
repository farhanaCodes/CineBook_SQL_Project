# 🎬 CineBook — Movie Ticket Booking System

A SQL database project for managing movie ticket bookings, customers, movies, theatres, screens, shows, payments, cancellations, and refunds.

The project is built using **MySQL** and **MySQL Workbench** and includes database design, sample data, analytical SQL queries, an ER diagram, screenshots, and project documentation.

---

## 📌 Project Overview

**CineBook** is a relational database system designed to represent the workflow of a movie ticket booking platform.

The database stores information about:

- 👤 Customers
- 🎬 Movies
- 🏢 Theatres
- 🖥️ Screens
- 🎟️ Movie Shows
- 📋 Bookings
- 💳 Payments
- ❌ Booking Cancellations
- 💰 Payment Refunds

The dataset contains records covering **January to June 2026**.

---

## 🎯 Project Objectives

The main objectives of this project are to:

- Design a normalized relational database for a movie ticket booking system.
- Create tables with primary keys and foreign-key relationships.
- Store and analyze realistic booking data.
- Practice SQL querying from basic to advanced levels.
- Analyze bookings, revenue, cancellations, and refunds.
- Use joins, aggregate functions, subqueries, and window functions.
- Create indexes to support query performance.
- Create a reusable database view for booking details.
- Build an ER diagram representing the database relationships.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| **MySQL** | Database management and SQL queries |
| **MySQL Workbench** | Database creation, querying, and ER diagram |
| **VS Code** | SQL project organization and file management |
| **Microsoft Word** | Project documentation |
| **Excel** | Dataset reference |

---

## 🗄️ Database Schema

The project contains **9 tables**:

| Table | Description |
|---|---|
| `Customers` | Stores customer information |
| `Movies` | Stores movie details |
| `Theatres` | Stores theatre information |
| `Screens` | Stores screens within theatres |
| `Shows` | Stores movie show schedules |
| `Bookings` | Stores customer ticket bookings |
| `Payments` | Stores booking payment information |
| `Booking_Cancellations` | Stores cancelled booking information |
| `Payment_Refunds` | Stores refund information |

### Main Relationships

```text
Theatres
   │
   └── Screens
          │
          └── Shows ─── Movies
                │
                └── Bookings ─── Customers
                      │
                      ├── Payments
                      ├── Booking_Cancellations
                      └── Payment_Refunds
```

---

## 📊 Dataset

The project dataset contains **814 records**:

| Table | Records |
|---|---:|
| Customers | 50 |
| Movies | 20 |
| Theatres | 8 |
| Screens | 16 |
| Shows | 100 |
| Bookings | 250 |
| Payments | 250 |
| Booking Cancellations | 60 |
| Payment Refunds | 60 |
| **Total** | **814** |

The booking, show, payment, cancellation, and refund data covers **January–June 2026**.

---

## 🔎 SQL Analysis Covered

The project progresses from basic SQL to advanced analysis.

### Basic Queries
- Selecting records
- Filtering with `WHERE`
- Filtering movies by rating, genre, and language
- Filtering customers by city

### Aggregate Functions
- `COUNT()`
- `SUM()`
- `AVG()`
- `MAX()`
- `MIN()`

### GROUP BY & HAVING
- Movie and genre counts
- Customer booking counts
- Customer spending
- Payment method analysis
- Cancellation and refund analysis
- Filtering grouped results with `HAVING`

### JOINs
The project uses multiple-table joins to analyze:

- Customer booking history
- Movie bookings
- Movie, theatre, and screen information
- Theatre-wise bookings and revenue
- Payment information

### Business Analysis
The advanced analysis includes:

- Monthly bookings and revenue
- Movie-wise bookings and revenue
- Theatre-wise revenue
- Most-booked movies
- Customer spending
- Highest-revenue movie
- Cancellation analysis
- Refund analysis
- Net revenue

### Advanced SQL
The project also demonstrates:

- **Subqueries**
- **Nested subqueries**
- **Window functions**
- `RANK()`
- **Indexes**
- **Database Views**

---

## ⭐ Example Advanced Query

### Movies with Rating Above Average

```sql
SELECT
    Title,
    Rating
FROM Movies
WHERE Rating > (
    SELECT AVG(Rating)
    FROM Movies
)
ORDER BY Rating DESC;
```

### Ranking Movies by Revenue

```sql
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
```

---

## 📈 Key Finding

The movie with the highest revenue in the project's booking dataset was:

**Dark Horizon — 20,710.00**

This result was obtained through the movie revenue analysis query.

---

## ⚡ Indexes

The project creates indexes on frequently analyzed columns:

```sql
CREATE INDEX idx_movie_genre
ON Movies(Genre);

CREATE INDEX idx_booking_date
ON Bookings(Booking_Date);

CREATE INDEX idx_show_date
ON Shows(Show_Date);
```

---

## 👁️ Database View

A view named `Booking_Details` was created to provide a convenient combined view of booking information.

It includes:

- Booking ID
- Customer name
- Movie name
- Theatre
- Screen
- Show date
- Show time
- Seats booked
- Total amount
- Booking status

Example:

```sql
SELECT *
FROM Booking_Details;
```

---

## 📁 Project Structure

```text
CineBook_SQL_Project
│
├── dataset
│   ├── CineBook_Movie_Ticket_Dataset_Jan-Jun_2026.sql
│   └── CineBook_Movie_Ticket_Dataset_Jan-Jun_2026.xlsx
│
├── documentation
│   └── CineBook_Movie_Ticket_Booking_System_Documentation_Final.docx
│
├── er_diagram
│   └── CineBook_ER_Diagram_Final.png
│
├── queries
│   ├── 01_basic_queries.sql
│   ├── 02_group_by.sql
│   ├── 03_joins.sql
│   └── 04_advanced_analysis.sql
│
├── screenshots
│   ├── 01_database_tables.png
│   ├── 02_basic_query.png
│   ├── 03_group_by.png
│   ├── 04_join_query.png
│   ├── 05_business_analysis.png
│   ├── 06_er_diagram.png
│   ├── 07_view_result.png
│   └── 08_index_result.png
│
├── sql
│   ├── 01_database.sql
│   ├── 02_create_tables.sql
│   └── 03_insert_data.sql
│
└── README.md
```

---

## 🚀 How to Run the Project

### 1. Install MySQL

Install MySQL and MySQL Workbench.

### 2. Create the Database

Open MySQL Workbench and run:

```sql
CREATE DATABASE CineBook;
USE CineBook;
```

Alternatively, use the prepared SQL files in the `sql` folder.

### 3. Create the Tables

Run:

```text
sql/02_create_tables.sql
```

### 4. Insert the Dataset

Run:

```text
sql/03_insert_data.sql
```

The complete dataset SQL file is also available in:

```text
dataset/CineBook_Movie_Ticket_Dataset_Jan-Jun_2026.sql
```

### 5. Run the Queries

Execute the query files in order:

```text
queries/01_basic_queries.sql
queries/02_group_by.sql
queries/03_joins.sql
queries/04_advanced_analysis.sql
```

### 6. Verify the Database

```sql
USE CineBook;

SHOW TABLES;
```

You should see the nine project tables.

---

## 📚 Learning Outcomes

This project demonstrates practical understanding of:

- Relational database design
- Primary and foreign keys
- One-to-many and one-to-one relationships
- Data retrieval and filtering
- Aggregate functions
- `GROUP BY` and `HAVING`
- Multi-table `JOIN`s
- Subqueries
- Window functions
- Index creation
- Views
- Business-oriented SQL analysis

---

## 📄 Documentation

Detailed project documentation is available in:

```text
documentation/
CineBook_Movie_Ticket_Booking_System_Documentation_Final.docx
```

The documentation covers the project introduction, objectives, scope, technologies, database design, relationships, ER diagram, SQL analysis, results, and conclusion.

---

## 👤 Project

**Project Name:** CineBook Movie Ticket Booking System  
**Database:** CineBook  
**Database Technology:** MySQL  
**Project Type:** SQL / Relational Database Project  
**Dataset Period:** January–June 2026

---

## 📝 Notes

This project is designed as a practical SQL learning and portfolio project. The included dataset is structured specifically for demonstrating database design, querying, and analytical SQL techniques.
