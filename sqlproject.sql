create database Hospitalpatient;
use Hospitalpatient;
create table  patients(
patient_id varchar(20) primary key,
patient_name varchar(100)not null,
age int not null,
gender varchar(10) not null,
city varchar(50)not null,
patient_type varchar(20)not null,
preferred_time_slot varchar(20)not null,
registration_date date not null);


create table doctors(
doctor_id varchar(10)primary key,
doctor_name varchar(100)not null,
specialty varchar(50) not null,
hire_date date not null,
rating decimal(3,2),
employment_type varchar(200) not null,
is_active varchar(3));


create table rooms(
room_id varchar(10) primary key,
room_type varchar(30) not null,
floor int not null,
equipment_type varchar(30) not null,
capacity int not null,
last_maintenance_date date,
is_available varchar(3));


create table appointments(
appointment_id varchar(20) primary key,
patient_id varchar(20),
appointment_date date not null,
doctor_id varchar(10),
service_type varchar(30) not null,
priority varchar(10) not null,
estimated_cost decimal(10,2)not null,
booking_channel varchar(20)not null,
constraint Fk_appointment_patients
Foreign key (patient_id) references patients(patient_id),
constraint Fk_appointment_doctors
Foreign key(doctor_id) references doctors(doctor_id)
);


create table treatments(
treatment_id varchar(20) primary key,
appointment_id varchar(20),
doctor_id varchar(10),
room_id varchar(10),
actual_treatment_date date not null,
status varchar(20) not null,
treatment_attempt int not null,
treatment_duration_min int not null,
waiting_time_min int not null,
treatment_cost decimal(10,2) not null,
constraint Fk_treatments_rooms
Foreign key(room_id) references rooms(room_id),
constraint Fk_treatments_appointments
Foreign key(appointment_id) references appointments(appointment_id),
constraint Fk_treatments_doctors
Foreign key(doctor_id) references doctors(doctor_id));


select * from rooms;
select * from doctors;
select * from patients;
select * from appointments;
select * from treatments;

# sprint1
#1 Patients who booked multiple appointments

select patient_id,count(appointment_id) as count_appoint 
from appointments
group by patient_id
having count(appointment_id)>1;

#2 Appointments requiring more than one treatment attempt
SELECT 
    appointment_id,
    MAX(treatment_attempt) AS treatment_attempts
FROM treatments
GROUP BY appointment_id
HAVING MAX(treatment_attempt) > 1;

#3Compare General, Corporate and Insurance patients by appointment activity
select * from patients;
select * from appointments;
SELECT 
    p.patient_type,
    COUNT(a.appointment_id) AS appointment_count
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_type;


#4 Compare service types by treatment duration and waiting time
SELECT 
    a.service_type,
    AVG(t.treatment_duration_min) AS avg_treatment_duration,
    AVG(t.waiting_time_min) AS avg_waiting_time
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY a.service_type;

#5Doctors who handled treatments and their ratings
SELECT 
    d.doctor_id,
    d.doctor_name,
    d.rating,
    COUNT(t.treatment_id) AS treatment_count
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.doctor_name, d.rating;

#6Room/equipment types used for different service types
SELECT 
    a.service_type,
    r.room_type,
    r.equipment_type,
    COUNT(t.treatment_id) AS treatment_count
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
JOIN rooms r
    ON t.room_id = r.room_id
GROUP BY 
    a.service_type,
    r.room_type,
    r.equipment_type;
    
#7 Compare treatment performance across cities
SELECT 
    p.city,
    COUNT(t.treatment_id) AS treatment_count,
    AVG(t.treatment_duration_min) AS avg_treatment_duration,
    AVG(t.waiting_time_min) AS avg_waiting_time
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY p.city;


#8 Priority level vs waiting time and treatment outcome
SELECT 
    a.priority,
    AVG(t.waiting_time_min) AS avg_waiting_time,
    t.status,
    COUNT(t.treatment_id) AS treatment_count
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY a.priority, t.status;

#9 Treatment outcomes across service types
SELECT 
    a.service_type,
    t.status,
    COUNT(t.treatment_id) AS treatment_count
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY a.service_type, t.status;

#1010. Connect patients to appointments and treatment outcomes

SELECT 
    p.patient_id,
    p.patient_name,
    a.appointment_id,
    a.appointment_date,
    a.service_type,
    t.treatment_id,
    t.status
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id;
    
#sprint2

DESCRIBE patients;
DESCRIBE doctors;
DESCRIBE rooms;
DESCRIBE appointments;
DESCRIBE treatments;


SHOW CREATE TABLE appointments;
SELECT COUNT(*) AS total_patients
FROM patients;
SELECT COUNT(*) AS total_doctors
FROM doctors;
SELECT COUNT(*) AS total_rooms
FROM rooms;
SELECT COUNT(*) AS total_appointments
FROM appointments;
SELECT COUNT(*) AS total_treatments
FROM treatments;

#sprint3
-- 1. Total number of patients
SELECT COUNT(*) AS total_patients
FROM patients;


-- 2. Total number of appointments
SELECT COUNT(*) AS total_appointments
FROM appointments;


-- 3. Total number of treatment records
SELECT COUNT(*) AS total_treatments
FROM treatments;


-- 4. Different medical service types
SELECT DISTINCT service_type
FROM appointments;


-- Service type appointment count
SELECT 
    service_type,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY service_type
ORDER BY appointment_count DESC;


-- 5. Number of active doctors
SELECT COUNT(*) AS active_doctors
FROM doctors
WHERE is_active = TRUE;


-- 6. Different room types
SELECT DISTINCT room_type
FROM rooms;
-- Room count by room type
SELECT 
    room_type,
    COUNT(*) AS room_count
FROM rooms
GROUP BY room_type
ORDER BY room_count DESC;


-- 7. Total estimated appointment value
SELECT 
    SUM(estimated_cost) AS total_estimated_appointment_value
FROM appointments;


-- 8. Average treatment duration
SELECT 
    ROUND(AVG(treatment_duration_min), 2) AS average_treatment_duration
FROM treatments;


#sprint 4


-- 4.1 Understand Patient and Appointment Demand
-- Q1. Which cities have the highest appointment volume?
SELECT
    p.city,
    COUNT(a.appointment_id) AS appointment_count
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.city
ORDER BY appointment_count DESC;

-- Q2. Which service types have the highest appointment volume?
SELECT
    service_type,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY service_type
ORDER BY appointment_count DESC;
-- Q3. How does appointment volume differ by priority?
SELECT
    priority,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY priority
ORDER BY appointment_count DESC;


-- Q4. How does appointment volume change over time?
SELECT
    YEAR(appointment_date) AS appointment_year,
    MONTH(appointment_date) AS appointment_month,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY
    YEAR(appointment_date),
    MONTH(appointment_date)
ORDER BY
    appointment_year,
    appointment_month;
-- Q5. Which patient types generate the highest estimated appointment value?
SELECT
    p.patient_type,
    SUM(a.estimated_cost) AS total_estimated_value
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_type
ORDER BY total_estimated_value DESC;
-- Q6. Which booking channels contribute the most to appointment demand?
SELECT
    booking_channel,
    COUNT(*) AS appointment_count,
    SUM(estimated_cost) AS total_estimated_value
FROM appointments
GROUP BY booking_channel
ORDER BY appointment_count DESC;



 
#4.2 Understand Patient Appointment Behaviour
-- Q7. Which patients have the highest number of appointments?
SELECT
    p.patient_id,
    p.patient_name,
    COUNT(a.appointment_id) AS appointment_count
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.patient_name
ORDER BY appointment_count DESC;
-- Q8. Which patients have the highest cumulative estimated appointment value?
SELECT
    p.patient_id,
    p.patient_name,
    SUM(a.estimated_cost) AS cumulative_estimated_value
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.patient_name
ORDER BY cumulative_estimated_value DESC;
-- Q9. Which cities have the highest patient activity?
SELECT
    p.city,
    COUNT(DISTINCT p.patient_id) AS patient_count,
    COUNT(a.appointment_id) AS appointment_count
FROM patients p
LEFT JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.city
ORDER BY appointment_count DESC;
-- Q10. How does appointment activity differ between General, Corporate and Insurance patients?
SELECT
    p.patient_type,
    COUNT(DISTINCT p.patient_id) AS patient_count,
    COUNT(a.appointment_id) AS appointment_count,
    SUM(a.estimated_cost) AS total_estimated_value
FROM patients p
LEFT JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_type
ORDER BY appointment_count DESC;
-- Q11. How does patient booking activity change over time?
SELECT
    YEAR(a.appointment_date) AS appointment_year,
    MONTH(a.appointment_date) AS appointment_month,
    COUNT(DISTINCT a.patient_id) AS active_patients,
    COUNT(a.appointment_id) AS appointment_count
FROM appointments a
GROUP BY
    YEAR(a.appointment_date),
    MONTH(a.appointment_date)
ORDER BY
    appointment_year,
    appointment_month;



#4.3 Evaluate Treatment Performance
-- Q12. How do treatment outcomes differ across cities?
SELECT
    p.city,
    t.status,
    COUNT(t.treatment_id) AS treatment_count
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY
    p.city,
    t.status
ORDER BY
    p.city,
    treatment_count DESC;
-- Q13. What is the average treatment duration and waiting time?
SELECT
    ROUND(AVG(treatment_duration_min), 2) AS avg_treatment_duration,
    ROUND(AVG(waiting_time_min), 2) AS avg_waiting_time
FROM treatments;
-- Q14. How do treatment outcomes compare?
SELECT
    status,
    COUNT(*) AS treatment_count
FROM treatments
GROUP BY status
ORDER BY treatment_count DESC;
-- Q15. Which service types have higher treatment activity or poorer outcomes?
SELECT
    a.service_type,
    COUNT(t.treatment_id) AS treatment_count,
    SUM(CASE
        WHEN t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
        THEN 1
        ELSE 0
    END) AS problem_count
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY a.service_type
ORDER BY problem_count DESC;
-- Q16. How does treatment performance change over time?
SELECT
    YEAR(actual_treatment_date) AS treatment_year,
    MONTH(actual_treatment_date) AS treatment_month,
    COUNT(*) AS treatment_count,
    ROUND(AVG(treatment_duration_min), 2) AS avg_duration,
    ROUND(AVG(waiting_time_min), 2) AS avg_waiting_time
FROM treatments
GROUP BY
    YEAR(actual_treatment_date),
    MONTH(actual_treatment_date)
ORDER BY
    treatment_year,
    treatment_month;



#4.4 Understand Doctor and Room Performance
-- Q17. Which doctors handle the highest number of treatments?
SELECT
    d.doctor_id,
    d.doctor_name,
    COUNT(t.treatment_id) AS treatment_count
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY
    d.doctor_id,
    d.doctor_name
ORDER BY treatment_count DESC;
-- Q18. How do treatment outcomes differ across doctors?
SELECT
    d.doctor_name,
    t.status,
    COUNT(t.treatment_id) AS treatment_count
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY
    d.doctor_name,
    t.status
ORDER BY
    d.doctor_name,
    treatment_count DESC;
-- Q19. Which doctors have the highest average treatment duration?
SELECT
    d.doctor_id,
    d.doctor_name,
    ROUND(AVG(t.treatment_duration_min), 2) AS avg_treatment_duration
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY
    d.doctor_id,
    d.doctor_name
ORDER BY avg_treatment_duration DESC;
-- 20. How frequently are different room types used?
SELECT
    r.room_type,
    COUNT(t.treatment_id) AS treatment_count
FROM rooms r
JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.room_type
ORDER BY treatment_count DESC;
-- Q21. How frequently are different equipment types used?
SELECT
    r.equipment_type,
    COUNT(t.treatment_id) AS treatment_count
FROM rooms r
JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.equipment_type
ORDER BY treatment_count DESC;
-- Q22. Which rooms have the highest treatment activity?
SELECT
    r.room_id,
    r.room_type,
    r.equipment_type,
    COUNT(t.treatment_id) AS treatment_count,
    ROUND(AVG(t.waiting_time_min), 2) AS avg_waiting_time
FROM rooms r
JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY
    r.room_id,
    r.room_type,
    r.equipment_type
ORDER BY treatment_count DESC;



#4.5 Identify Treatment and Appointment Problems
-- Q23. Which appointments required multiple treatment attempts?
SELECT
    appointment_id,
    MAX(treatment_attempt) AS max_attempts
FROM treatments
GROUP BY appointment_id
HAVING MAX(treatment_attempt) > 1
ORDER BY max_attempts DESC;
-- Q24. What are the most common problem statuses?
SELECT
    status,
    COUNT(*) AS treatment_count
FROM treatments
WHERE status IN ('Cancelled', 'No-Show', 'Rescheduled')
GROUP BY status
ORDER BY treatment_count DESC;
-- Q25. Do appointments with multiple treatment attempts have longer waiting times?
SELECT
    CASE
        WHEN treatment_attempt > 1 THEN 'Multiple Attempts'
        ELSE 'Single Attempt'
    END AS attempt_group,
    COUNT(*) AS treatment_count,
    ROUND(AVG(waiting_time_min), 2) AS avg_waiting_time
FROM treatments
GROUP BY attempt_group;
-- Q26. Which cities have more cancellations, no-shows and rescheduling?
SELECT
    p.city,
    t.status,
    COUNT(t.treatment_id) AS problem_count
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
WHERE t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
GROUP BY
    p.city,
    t.status
ORDER BY problem_count DESC;
-- Q27. Which service types have more cancellations, no-shows and rescheduling?
SELECT
    a.service_type,
    t.status,
    COUNT(t.treatment_id) AS problem_count
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
WHERE t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
GROUP BY
    a.service_type,
    t.status
ORDER BY problem_count DESC;
-- Q28. Is priority level associated with waiting time?
SELECT
    a.priority,
    COUNT(t.treatment_id) AS treatment_count,
    ROUND(AVG(t.waiting_time_min), 2) AS avg_waiting_time
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY a.priority
ORDER BY avg_waiting_time DESC;
-- Q29. Is priority level associated with treatment outcomes?
SELECT
    a.priority,
    t.status,
    COUNT(t.treatment_id) AS treatment_count
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY
    a.priority,
    t.status
ORDER BY
    a.priority,
    treatment_count DESC;
