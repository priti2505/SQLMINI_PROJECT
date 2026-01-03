CREATE DATABASE   StudentManagementDB;
USE  StudentManagementDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male','Female','Other'),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    AdmissionDate DATE DEFAULT (CURRENT_DATE)
);

INSERT INTO Students (FirstName, LastName, DateOfBirth, Gender, Email, Phone, Address)
VALUES 
('Komal','Patil','2002-05-15','Female','komal@example.com','9876543210','Pune, India'),
('Rahul','Sharma','2001-12-01','Male','rahul@example.com','9123456780','Mumbai, India');

SELECT * FROM students;

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    CourseCode VARCHAR(20) UNIQUE NOT NULL,
    DurationMonths INT NOT NULL,
    Fees DECIMAL(10,2) NOT NULL
);

INSERT INTO Courses (CourseName, CourseCode, DurationMonths, Fees)
VALUES
('Computer Science','CS101',36,50000),
('Mathematics','MATH101',24,30000);

SELECT * FROM courses;

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE DEFAULT (CURRENT_DATE),
    Status ENUM('Active','Completed','Dropped') DEFAULT 'Active',
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

INSERT INTO Enrollments (StudentID, CourseID)
VALUES
(1, 1),
(2, 2);
SELECT * FROM Enrollments;


CREATE TABLE Grades (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    EnrollmentID INT NOT NULL,
    ExamName VARCHAR(50) NOT NULL,
    MarksObtained DECIMAL(5,2),
    TotalMarks DECIMAL(5,2),
    Grade CHAR(2),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE
);


INSERT INTO Grades (EnrollmentID, ExamName, MarksObtained, TotalMarks, Grade)
VALUES
(1, 'Midterm', 85, 100, 'A'),
(2, 'Midterm', 78, 100, 'B');

SELECT *FROM Grades;

CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    HireDate DATE
);  

INSERT INTO Faculty (FirstName, LastName, Email, Phone, HireDate)
VALUES
('Anil','Deshmukh','anil@example.com','9012345678','2020-06-01'),
('Sita','Patel','sita@example.com','9023456789','2019-08-15');


SELECT * FROM Faculty;


CREATE TABLE CourseAssignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT NOT NULL,
    FacultyID INT NOT NULL,
    Semester VARCHAR(10),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID) ON DELETE CASCADE
);

INSERT INTO CourseAssignments (CourseID, FacultyID, Semester)
VALUES
(1, 1, 'Sem1'),
(2, 2, 'Sem1');

SELECT *FROM students;

SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE s.StudentID = 1;

SELECT s.FirstName, s.LastName, c.CourseName, g.ExamName, g.MarksObtained, g.TotalMarks, g.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
WHERE s.StudentID = 1;

SELECT s.FirstName, s.LastName, AVG(g.MarksObtained) AS AvgMarks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
GROUP BY s.StudentID
ORDER BY AvgMarks DESC;


SELECT f.FirstName, f.LastName, c.CourseName
FROM Faculty f
JOIN CourseAssignments ca ON f.FacultyID = ca.FacultyID
JOIN Courses c ON ca.CourseID = c.CourseID;






