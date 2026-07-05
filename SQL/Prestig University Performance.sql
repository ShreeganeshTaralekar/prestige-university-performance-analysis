-- Creating Database
CREATE DATABASE University_Performance;
Use University_Performance;

-- Creating Tables
-- 1.Campus 
CREATE TABLE dim_campus( 
campus_id INT PRIMARY KEY ,
campus_name VARCHAR(100) ,
location VARCHAR(100),
chancellor VARCHAR(100)
);

-- 2.Faculty 
CREATE TABLE dim_faculty(
faculty_id INT PRIMARY KEY,
faculty_name VARCHAR(100),
dean VARCHAR(100)
);

-- 3.Department 
CREATE TABLE dim_department(
department_id INT PRIMARY KEY,
department_name VARCHAR(100),
department_code VARCHAR(100) ,
faculty_id INT ,
FOREIGN KEY (faculty_id) REFERENCES dim_faculty(faculty_id)
);

-- 4.Course 
CREATE TABLE dim_course(
course_id INT PRIMARY KEY,
course_code VARCHAR(100),
course_name VARCHAR(100),
course_description TEXT,
credits INT,
department_id INT,
FOREIGN KEY (department_id) REFERENCES dim_department(department_id)
);

-- 5.Instructor 
CREATE TABLE dim_instructor(
instructor_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
title VARCHAR(50),
department_id INT,
hire_date DATE,
FOREIGN KEY (department_id) REFERENCES dim_department(department_id)
);

-- 6.Students 
CREATE TABLE dim_student(
 student_id INT PRIMARY KEY ,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 date_of_birth DATE,
 gender VARCHAR(10),
 ethnicity VARCHAR(50),
 enrollment_status VARCHAR(20),
 major_department_id INT,
 admission_date DATE,
 expected_grad_date DATE,
 campus_id INT
 );
 
 -- 7.Date 
 CREATE TABLE dim_date(
 date_id INT PRIMARY KEY,
 full_date DATE,
 academic_year VARCHAR(20),
 academic_semester VARCHAR(20),
 academic_term VARCHAR(20),
 is_holiday BOOLEAN,
 fiscal_period VARCHAR(20)
 );
 
 -- 8.Fact Table
CREATE TABLE fact_course_enrollment(
enrollment_id INT PRIMARY KEY,
student_id INT,
course_id INT,
instructor_id INT,
semester_date_id INT,
campus_id INT,
final_grade DECIMAL(3,2),
grade_letter CHAR(2),
credits_earned INT,
status VARCHAR(20),
FOREIGN KEY (semester_date_id) REFERENCES dim_date(date_id),
FOREIGN KEY (campus_id) REFERENCES dim_campus(campus_id),
FOREIGN KEY (student_id) REFERENCES dim_student(student_id),
FOREIGN KEY (course_id) REFERENCES dim_course(course_id),
FOREIGN KEY (instructor_id) REFERENCES dim_instructor(instructor_id)
);

-- Inserting values into tables
-- 1.Campus 
INSERT INTO dim_campus(campus_id, campus_name, location, chancellor) VALUES
(1, 'Main Campus', 'Mumbai', 'Dr. R. Nair'),
(2, 'North Campus', 'Delhi', 'Dr. P. Kapoor'),
(3, 'South Campus', 'Chennai', 'Dr. L. Reddy');

SELECT * FROM dim_campus;

-- 2.Faculty
INSERT INTO dim_faculty(faculty_id, faculty_name, dean) VALUES
(1, 'Faculty of Engineering', 'Dr. A. Mehta'),
(2, 'Faculty of Science', 'Dr. B. Singh'),
(3, 'Faculty of Arts', 'Dr. C. Rao'),
(4, 'Faculty of Business', 'Dr. D. Shah'),
(5, 'Faculty of Medical', 'Dr. E. Patel');

SELECT * FROM dim_faculty;

UPDATE dim_faculty
SET faculty_name = 'Faculty of Science'
WHERE faculty_id = 2;

UPDATE dim_faculty
SET faculty_name = 'Faculty of Arts'
WHERE faculty_id = 3;

UPDATE dim_faculty
SET faculty_name = 'Faculty of Business'
WHERE faculty_id = 4;

UPDATE dim_faculty
SET faculty_name = 'Faculty of Medical'
WHERE faculty_id = 5;


-- 3.Department
INSERT INTO dim_department(department_id, department_name, department_code, faculty_id) VALUES
(1,'Computer Engineering', 'CSE',1),
(2,'Mechanical Engineering', 'ME',1),
(3,'Physics', 'PHY',2),
(4,'Chemistry', 'CHE',2),
(5,'English', 'ENG',3),
(6,'History', 'HIS',3),
(7,'Accounts', 'ACC',4),
(8,'Finance', 'FIN',4),
(9,'Anatomy', 'ANA',5),
(10,'Pharmacology', 'PHA',5);

SELECT * FROM dim_department;

UPDATE dim_department
SET department_code = 'CSE'
WHERE department_id = 1;

-- 4.Course
INSERT INTO dim_course(course_id, course_code, course_name, course_description, credits, department_id) VALUES
(1, 'CSE101', 'Intro to Programming', 'Basics of C programming', 4, 1),
(2, 'CSE201', 'Data Structures', 'Study of data structures', 4, 1),
(3, 'ME101', 'Thermodynamics', 'Principles of thermodynamics', 3, 2),
(4, 'PHY101', 'Classical Mechanics', 'Newtonian mechanics', 4, 3),
(5, 'CHE101', 'Organic Chemistry', 'Introduction to organic chemistry', 4, 4),
(6, 'ENG101', 'English Literature', 'Study of classic literature', 3, 5),
(7, 'HIS101', 'World History', 'History of civilizations', 3, 6),
(8, 'ACC101', 'Financial Accounting', 'Principles of accounting', 3, 7),
(9, 'FIN101', 'Corporate Finance', 'Basics of finance', 3, 8),
(10, 'ANA101', 'Human Anatomy', 'Study of human body structure', 4, 9);

SELECT * FROM dim_course;

-- 5.Instructor
INSERT INTO dim_instructor(instructor_id, first_name, last_name, title, department_id, hire_date) VALUES
(1, 'Rajesh', 'Kumar', 'Professor', 1, '2015-08-01'),
(2, 'Neha', 'Sharma', 'Assoc Prof', 2, '2017-07-15'),
(3, 'Amit', 'Patel', 'Professor', 3, '2012-06-20'),
(4, 'Priya', 'Rao', 'Assoc Prof', 4, '2018-09-10'),
(5, 'Suresh', 'Menon', 'Professor', 5, '2010-01-25'),
(6, 'Kiran', 'Joshi', 'Assoc Prof', 6, '2016-03-14'),
(7, 'Vikas', 'Shah', 'Professor', 7, '2019-05-30'),
(8, 'Meera', 'Iyer', 'Assoc Prof', 8, '2014-04-04'),
(9, 'Deepak', 'Desai', 'Professor', 9, '2009-02-12'),
(10, 'Anjali', 'Verma', 'Assoc Prof', 10, '2011-11-11');

SELECT * FROM dim_instructor;

-- 6.Student
INSERT INTO dim_student(student_id, first_name, last_name, date_of_birth, gender, ethnicity, enrollment_status, 
major_department_id, admission_date, expected_grad_date, campus_id) VALUES
(1, 'Arjun', 'Reddy', '2002-05-10', 'Male', 'Asian', 'Active', 1, '2021-08-01', '2025-05-30', 1),
(2, 'Sneha', 'Kapoor', '2001-11-20', 'Female', 'Asian', 'Active', 2, '2020-08-01', '2024-05-30', 1),
(3, 'Rahul', 'Shah', '2002-03-12', 'Male', 'Asian', 'Active', 3, '2021-08-01', '2025-05-30', 1),
(4, 'Pooja', 'Nair', '2001-07-05', 'Female', 'Asian', 'Active', 4, '2020-08-01', '2024-05-30', 2),
(5, 'Karan', 'Mehta', '2002-12-02', 'Male', 'Asian', 'Active', 5, '2021-08-01', '2025-05-30', 2),
(6, 'Ananya', 'Joshi', '2003-01-25', 'Female', 'Asian', 'Active', 6, '2022-08-01', '2026-05-30', 2),
(7, 'Rohan', 'Iyer', '2001-06-18', 'Male', 'Asian', 'Active', 7, '2020-08-01', '2024-05-30', 3),
(8, 'Divya', 'Patil', '2002-08-30', 'Female', 'Asian', 'Active', 8, '2021-08-01', '2025-05-30', 3),
(9, 'Vikram', 'Deshmukh', '2001-10-14', 'Male', 'Asian', 'Active', 9, '2020-08-01', '2024-05-30', 3),
(10, 'Meena', 'Kulkarni', '2002-04-22', 'Female', 'Asian', 'Active', 10, '2021-08-01', '2025-05-30', 1);

SELECT * FROM dim_student;

-- 7.Date
INSERT INTO dim_date(date_id, full_date, academic_year, academic_semester, academic_term, is_holiday, fiscal_period) VALUES
(1, '2021-09-01', '2021-2022', 'Fall', 'Fall 2021', 0, 'Q3'),
(2, '2022-01-15', '2021-2022', 'Spring', 'Spring 2022', 0, 'Q1'),
(3, '2022-09-01', '2022-2023', 'Fall', 'Fall 2022', 0, 'Q3'),
(4, '2023-01-15', '2022-2023', 'Spring', 'Spring 2023', 0, 'Q1'),
(5, '2023-09-01', '2023-2024', 'Fall', 'Fall 2023', 0, 'Q3'),
(6, '2024-01-15', '2023-2024', 'Spring', 'Spring 2024', 0, 'Q1'),
(7, '2022-06-01', '2021-2022', 'Summer', 'Summer 2022', 0, 'Q2'),
(8, '2023-06-01', '2022-2023', 'Summer', 'Summer 2023', 0, 'Q2'),
(9, '2024-06-01', '2023-2024', 'Summer', 'Summer 2024', 0, 'Q2'),
(10, '2021-12-25', '2021-2022', 'Fall', 'Fall 2021', 1, 'Q4');

SELECT * FROM dim_date;

-- 8.Fact Table
INSERT INTO fact_course_enrollment(enrollment_id, student_id, course_id, instructor_id, semester_date_id, campus_id, final_grade, grade_letter, credits_earned, status) VALUES
(1, 1, 1, 1, 1, 1, 3.8, 'A', 4, 'Completed'),
(2, 2, 2, 2, 1, 1, 3.2, 'B', 4, 'Completed'),
(3, 3, 3, 3, 2, 1, 2.7, 'C', 3, 'Completed'),
(4, 4, 4, 4, 2, 2, 2.0, 'D', 3, 'Completed'),
(5, 5, 5, 5, 3, 2, 3.9, 'A', 4, 'Completed'),
(6, 6, 6, 6, 3, 2, 3.0, 'B', 3, 'Completed'),
(7, 7, 7, 7, 4, 3, 2.5, 'C', 3, 'Withdrawn'),
(8, 8, 8, 8, 4, 3, 3.7, 'A', 3, 'Completed'),
(9, 9, 9, 9, 5, 3, 3.4, 'B', 3, 'Completed'),
(10, 10, 10, 10, 5, 1, 3.6, 'A', 4, 'Completed');

SELECT * FROM fact_course_enrollment;

CREATE VIEW vw_student_grades_flat AS
SELECT s.student_id, s.first_name AS student_first, s.last_name AS student_last,
       c.course_code, c.course_name,
       d.department_name, f.faculty_name,
       i.first_name AS instructor_first, i.last_name AS instructor_last, i.title,
       ca.campus_name, dt.academic_term, dt.academic_year,
       e.final_grade, e.grade_letter, e.credits_earned, e.status
FROM fact_course_enrollment e
JOIN dim_student s ON e.student_id = s.student_id
JOIN dim_course c ON e.course_id = c.course_id
JOIN dim_instructor i ON e.instructor_id = i.instructor_id
JOIN dim_department d ON c.department_id = d.department_id
JOIN dim_faculty f ON d.faculty_id = f.faculty_id
JOIN dim_campus ca ON e.campus_id = ca.campus_id
JOIN dim_date dt ON e.semester_date_id = dt.date_id;

SELECT * FROM vw_student_grades_flat LIMIT 10;

