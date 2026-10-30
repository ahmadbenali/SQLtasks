create table departments(
	departmentId int identity(1,1) primary key,
	departmentName varchar(100) not null unique
);

create table student(
	studentId int identity(1,1) primary key,
	fullName varchar(100) not null,
	email varchar(100) unique,
	gpa decimal(3,2),
	departmentId int foreign key references departments(departmentId)
);

create table studentProfile(
	profileId int identity(1,1) primary key,
	studentId int foreign key references student(studentId),
	addr varchar(200),
	EmergencyPhone varchar(20)
);

create table Courses(
	CourseID  int identity(1,1) primary key,
	CourseName  varchar(100) not null,
	Credits  int,
	departmentId int foreign key references departments(departmentId)
);

create table StudentCourses(
	studentId int foreign key references student(studentId),
	EnrollmentDate date DEFAULT GETDATE(),
	CourseID int foreign key references Courses(CourseID),
	primary key(studentId,CourseID)
);

ALTER TABLE student 
ADD Age INT;

DROP TABLE TempInstructors;


INSERT INTO departments (departmentName) VALUES 
( 'Computer Science'),
( 'Software Engineering'),
( 'Business Administration');

INSERT INTO student ( fullName, email, gpa, departmentId, Age) VALUES 
( 'Ali Smadi', 'ali@coursehub.com', 3.80, 1, 22),
( 'Omar Ahmad', 'omar@coursehub.com', 2.90, 1, 21),
( 'Laila Hassan', 'laila@coursehub.com', 3.50, 2, 23),
( 'Tariq Zaid', 'tariq@coursehub.com', 2.10, 3, 20);


INSERT INTO studentProfile ( addr, EmergencyPhone) VALUES 
('Amman, Jordan', '0791111111'),
('Irbid, Jordan', '0792222222'),
('Zarqa, Jordan', '0793333333');

INSERT INTO Courses ( CourseName, Credits, departmentId) VALUES 
( 'Database Systems', 3, 1),
( 'Web Development', 3, 1),
('Software Architecture', 3, 2);

INSERT INTO StudentCourses (studentId, CourseID, EnrollmentDate) VALUES 
(101, 201, GETDATE()), 
(101, 202, GETDATE()), 
(102, 201, GETDATE()),
(103, 203, GETDATE()); 

UPDATE student 
SET gpa = 2.50 
WHERE studentId = 104;

DELETE FROM studentProfile WHERE studentId = 104;
DELETE FROM student WHERE studentId = 104;

SELECT s.fullName, s.gpa, d.departmentName
FROM student s
INNER JOIN departments d ON s.departmentId = d.departmentId;

SELECT d.departmentName, s.fullName
FROM departments d
LEFT JOIN student s ON d.departmentId = s.departmentId;

SELECT s.fullName, p.addr, p.EmergencyPhone
FROM student s
INNER JOIN studentProfile p ON s.studentId = p.studentId;

SELECT s.fullName, c.CourseName, sc.EnrollmentDate
FROM student s
INNER JOIN StudentCourses sc ON s.studentId = sc.studentId
INNER JOIN Courses c ON sc.CourseID = c.CourseID;

SELECT 
    COUNT(studentId) AS TotalStudents, 
    AVG(gpa) AS AverageGPA, 
    MAX(gpa) AS HighestGPA, 
    MIN(gpa) AS LowestGPA
FROM student;

SELECT 
    departmentId, 
    AVG(gpa) AS AverageGPA, 
    COUNT(studentId) AS TotalStudents
FROM student
GROUP BY departmentId;

SELECT 
    departmentId, 
    AVG(gpa) AS AverageGPA
FROM student
GROUP BY departmentId
HAVING AVG(gpa) > 3.00;

SELECT 
    departmentId, 
    COUNT(studentId) AS StudentCount
FROM student
WHERE gpa >= 2.50
GROUP BY departmentId
HAVING COUNT(studentId) > 1;

/*
  By default, 
  the Primary Key column (studentId) automatically creates a Clustered Index. 
*/

CREATE NONCLUSTERED INDEX IX_Students_Email
ON student (email);

SELECT fullName, gpa
FROM student
WHERE gpa > (SELECT AVG(gpa) FROM student);

CREATE VIEW vw_StudentAcademicDetails AS
SELECT 
    s.studentId, 
    s.fullName, 
    s.gpa, 
    d.departmentName
FROM student s
INNER JOIN departments d ON s.departmentId = d.departmentId;

CREATE PROCEDURE sp_GetStudentsByDepartment
    @DeptID INT
AS
BEGIN
    SELECT studentId, fullName, email, gpa
    FROM student
    WHERE departmentId = @DeptID;
END;