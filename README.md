# Hospital-Patient-Care-Operations-Analytics-MySQL-Project


## Project Overview

The **Hospital Patient Care Operations Analytics System** is a MySQL-based database project developed to manage and analyze hospital operations data.

The project was created to understand how a relational database can be used to organize information about patients, appointments, treatments, doctors, and rooms. Using SQL queries, we analyzed the data to identify useful patterns related to patient demand, appointment behavior, treatment outcomes, doctor performance, room utilization, and operational challenges.

The main focus of this project was not only to store the data, but also to use it to generate meaningful insights that could support better decision-making in hospital operations.

## Project Objectives

The main objectives of this project were:

* To design and implement a structured relational database using MySQL.
* To create relationships between different hospital-related tables.
* To maintain data consistency using primary keys and foreign keys.
* To analyze patient and appointment demand.
* To understand patient appointment behavior.
* To evaluate treatment outcomes and waiting times.
* To analyze doctor and room performance.
* To identify operational issues such as cancellations, no-shows, rescheduled appointments, and multiple treatment attempts.
* To use SQL analysis to convert raw hospital data into meaningful business insights.

## Database Structure

The database consists of **five main tables**:

1. **Patients** – Stores patient details such as name, age, gender, city, and patient type.
2. **Appointments** – Stores appointment details including date, doctor, service type, priority, estimated cost, and booking channel.
3. **Treatments** – Stores treatment-related information such as status, treatment duration, waiting time, and treatment cost.
4. **Doctors** – Stores doctor information including specialty, rating, employment type, and active status.
5. **Rooms** – Stores information about room type, floor, equipment, capacity, and availability.

These tables are connected through primary and foreign key relationships, allowing information to be analyzed across different areas of the hospital.

## Analysis Performed

### Patient and Appointment Analysis

We analyzed appointment demand based on:

* City
* Service type
* Priority
* Patient type
* Booking channel
* Appointment date

This helped us understand which services and locations had higher appointment activity and how patients were using different booking channels.

### Patient Behavior Analysis

We examined patient activity to identify:

* Patients with a high number of appointments
* Patients generating higher appointment values
* Appointment patterns across cities
* Differences between patient types
* Booking behavior over time

### Treatment Performance Analysis

Treatment data was analyzed based on:

* Treatment outcomes
* Treatment duration
* Waiting time
* City
* Service type
* Treatment status
* Treatment date

The analysis included different treatment statuses such as **Completed, Cancelled, No-Show, Rescheduled, and In Progress**.

### Doctor Performance Analysis

We compared doctors based on:

* Number of treatments handled
* Treatment outcomes
* Average treatment duration
* Overall treatment activity

This helped us understand differences in workload and treatment performance among doctors.

### Room and Equipment Analysis

We also analyzed hospital room usage based on:

* Room type
* Equipment type
* Number of treatments
* Treatment activity

This provided an overview of how different rooms and equipment were being utilized.

### Identifying Operational Problems

One important part of the project was identifying possible operational issues.

We analyzed:

* Multiple treatment attempts
* Common treatment problem statuses
* Waiting times
* Cancellations
* No-shows
* Rescheduled appointments
* Priority levels compared with waiting time and treatment outcomes

These analyses helped us identify areas that may require attention to improve hospital operations.

## SQL Concepts Used

During the project, we worked with several SQL concepts, including:

* Database and table creation
* Primary Keys
* Foreign Keys
* `SELECT`
* `WHERE`
* `JOIN`
* `GROUP BY`
* `ORDER BY`
* `COUNT()`
* `SUM()`
* `AVG()`
* Aggregate functions
* Filtering and sorting
* Data analysis using multiple related tables

## Tools and Technologies

* **MySQL**
* **SQL**
* **ER Diagram**
* **Relational Database Management**
* **Data Analytics**


## Key Learning

This project gave us practical experience in working with relational databases and SQL.

While working on the project, we learned how to design tables, establish relationships using primary and foreign keys, write SQL queries across multiple tables, and analyze the results.

We also learned that data analysis is not only about writing queries. Understanding the results and converting them into useful insights is equally important.


## Challenges

Some of the main challenges we faced during the project were:

* Understanding the relationships between the five tables.
* Creating correct primary key and foreign key relationships.
* Writing SQL queries involving multiple tables.
* Using `JOIN`, `GROUP BY`, and aggregate functions correctly.
* Analyzing large amounts of hospital-related data.
* Converting query results into meaningful business insights.

Overcoming these challenges helped us improve our understanding of relational database design and SQL-based analysis.


## Conclusion

The **Hospital Patient Care Operations Analytics System** helped us understand how SQL and relational databases can be applied to a real-world healthcare scenario.

We successfully designed a MySQL database containing five interconnected tables and performed different analyses related to patients, appointments, treatments, doctors, and rooms.

The project improved our practical knowledge of **SQL, database design, data analysis, and business-oriented problem solving**. It also helped us understand how structured data can be used to identify operational patterns and support better decisions.
