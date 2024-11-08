-- Corrected Code

-- Create Student Table
CREATE TABLE Student (
    studentid INT PRIMARY KEY,
    studentname VARCHAR(50),
    instructorid INT,
    studentcity VARCHAR(50)
);

-- Create Instructor Table
CREATE TABLE Instructor (
    instructorid INT PRIMARY KEY,
    instructorname VARCHAR(50),
    instructorcity VARCHAR(50),
    specialization VARCHAR(50)
);

-- Sample Data Insertion (You can adjust values as needed)
INSERT INTO Instructor VALUES (1, 'Dr. Smith', 'Pune', 'Computer Science');
INSERT INTO Instructor VALUES (2, 'Prof. Johnson', 'Nashik', 'Mathematics');
INSERT INTO Instructor VALUES (3, 'Dr. Brown', 'Pune', 'Physics');
INSERT INTO Instructor VALUES (4, 'Ms. Taylor', 'Mumbai', 'Computer Science');

INSERT INTO Student VALUES (101, 'Alice', 1, 'Pune');
INSERT INTO Student VALUES (102, 'Bob', 2, 'Mumbai');
INSERT INTO Student VALUES (103, 'Charlie', NULL, 'Nashik');
INSERT INTO Student VALUES (104, 'David', 3, 'Pune');
INSERT INTO Student VALUES (105, 'Eve', NULL, 'Mumbai');

-- 1. Find the instructor of each student
SELECT s.studentname, i.instructorname
FROM Student s
INNER JOIN Instructor i ON s.instructorid = i.instructorid;

-- 2. Find the student who is not having any instructor
SELECT studentname
FROM Student
WHERE instructorid IS NULL;

-- 3. Find the student who is not having any instructor as well as the instructor who is not having a student
SELECT studentname
FROM Student
WHERE instructorid IS NULL
UNION
SELECT instructorname
FROM Instructor i
LEFT JOIN Student s ON i.instructorid = s.instructorid
WHERE s.studentid IS NULL;

-- 4. List students and their instructors for a specific specialization (e.g., 'Computer Science')
SELECT s.studentname, i.instructorname
FROM Student s
JOIN Instructor i ON s.instructorid = i.instructorid
WHERE i.specialization = 'Computer Science';

-- 5. Find students whose city does not match with their instructor
SELECT s.studentname, i.instructorname, s.studentcity, i.instructorcity
FROM Student s
JOIN Instructor i ON s.instructorid = i.instructorid
WHERE s.studentcity <> i.instructorcity;

-- 6. List All Instructors and Their Students (Including Without Students)
SELECT i.instructorname, s.studentname
FROM Instructor i
LEFT JOIN Student s ON i.instructorid = s.instructorid;

-- 7. List of students of each instructor who stays in Pune
SELECT s.studentname, i.instructorname
FROM Student s
JOIN Instructor i ON s.instructorid = i.instructorid
WHERE i.instructorcity = 'Pune';

-- 8. Calculate the Average Number of Students per Instructor in Nashik
SELECT AVG(student_count) AS avg_students
FROM (
    SELECT COUNT(s.studentid) AS student_count
    FROM Instructor i
    LEFT JOIN Student s ON i.instructorid = s.instructorid
    WHERE i.instructorcity = 'Nashik'
    GROUP BY i.instructorid
) AS counts;

-- 9. Create a view containing the total number of students whose instructor belongs to “Pune”
CREATE VIEW PuneInstructorStudents AS
SELECT i.instructorid, i.specialization, COUNT(s.studentid) AS total_students
FROM Instructor i
LEFT JOIN Student s ON i.instructorid = s.instructorid
WHERE i.instructorcity = 'Pune'
GROUP BY i.instructorid, i.specialization;

-- 10. Operations on PuneInstructorStudents View

-- 10.1 List All Specializations of Instructors in Pune
SELECT DISTINCT specialization
FROM PuneInstructorStudents;

-- 10.2 Count Students for Each Instructor in Pune
SELECT i.instructorname, ps.total_students
FROM PuneInstructorStudents ps
JOIN Instructor i ON ps.instructorid = i.instructorid;

-- 10.3 Find the Number of Students Grouped by Specialization of Instructors in Pune
SELECT specialization, SUM(total_students) AS student_count
FROM PuneInstructorStudents
GROUP BY specialization;

-- 10.4 List Instructors from Pune with No Students
SELECT i.instructorname
FROM Instructor i
LEFT JOIN PuneInstructorStudents ps ON i.instructorid = ps.instructorid
WHERE i.instructorcity = 'Pune' AND ps.total_students = 0;
