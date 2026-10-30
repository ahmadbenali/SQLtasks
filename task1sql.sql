use TechWorldHRDB;



create table Department (
	DepartmentID INT identity(1,1) primary key,
	DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

create table Employees (

	EmployeeID INT identity(1,1) PRIMARY KEY,
	FullName NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) UNIQUE,
	Salary DECIMAL(10,2),
	DepartmentID INT
);


ALTER TABLE Employees ADD phoneNumber NVARCHAR(20); 

drop table TemporaryStaff;

select * from Department


insert into Department(DepartmentName)
values('IT'),('HR'),('Finance');


insert into Employees(FullName ,
	Email,
	Salary ,
	DepartmentID,
	phoneNumber)
values('Ahmad Ali','ahmad@techworld.com', 1200.00, 1,'0791111111'),
('Sara Hassan','sara@techworld.com' , 950.00 , 2, '0792222222'),
('Zaid Omar' ,'zaid@techworld.com' , 1500.00 , 1, '0793333333'),
( 'Mona Khaled','mona@techworld.com' , 800.00, 3, '0794444444');

UPDATE Employees SET salary = 1350.00 WHERE EmployeeID = 1;


DELETE FROM Employees WHERE EmployeeID = 4;

select * from Employees;


select FullName, Salary from Employees ;


select sum(Salary) as TotalSalaries , avg(Salary) as AverageSalary,
count(EmployeeID) as TotalEmployees , max(Salary) as HighestSalary,
min(Salary) as LowestSalary from Employees;



--****************************** PART 2 *****************************************

create table accessCrads(

	cardId int identity(1,1) primary key,
	cardNumber varchar(50) not null unique,
	employeeId int foreign key  references Employees(EmployeeID)

);

create table projects(

	projectId int identity(1,1) primary key,
	projectName varchar(100) not null

);

create table employeeProjects(

	employeeId int foreign key  references Employees(EmployeeID) ,
	projectId int foreign key  references projects(projectId) , 
	assignedDate date,
	primary key(employeeId, projectId)

);

insert into accessCrads(cardNumber,employeeId)
values(101,1),(102,2),(103,3);

insert into projects(projectName) values('AI & Security Training'),('Cloud Migration')

insert into employeeProjects(employeeId,projectId)
values(1,1),(1,2),(2,1),(3,2)

select e.FullName, e.Salary , d.DepartmentName from Employees as e
inner join Department as d on e.EmployeeID = d.DepartmentID

select d.* from Department as d
left join Employees as e on e.EmployeeID = d.DepartmentID

select e.FullName, a.cardNumber from Employees as e
inner join accessCrads as a on e.EmployeeID = a.employeeId

select e.FullName, ep.assignedDate, p.projectName from Employees as e
INNER JOIN employeeProjects ep ON e.EmployeeID = ep.employeeId
INNER JOIN projects p ON ep.projectID = p.projectID;

SELECT 
    DepartmentID,
    SUM(Salary) AS TotalSalary,
    COUNT(EmployeeID) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;

SELECT 
    DepartmentID,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 1000.00;

SELECT 
    EmployeeID, 
    FullName, 
    Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

CREATE VIEW vw_EmployeeDetails AS
SELECT 
    e.EmployeeID,
    e.FullName,
    e.Email,
    d.DepartmentName
FROM Employees e
INNER JOIN Department d ON e.DepartmentID = d.DepartmentID;

-- SELECT * FROM vw_EmployeeDetails;

CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT 
        EmployeeID, 
        FullName, 
        Email, 
        Salary
    FROM Employees
    WHERE DepartmentID = @DeptID;
END;

CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Action VARCHAR(50),
    ActionDate DATETIME
);

CREATE TRIGGER trg_AfterDeleteEmployee
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, Action, ActionDate)
    SELECT 
        deleted.EmployeeID, 
        'Deleted', 
        GETDATE()
    FROM deleted;
END;

-- DELETE FROM Employees WHERE EmployeeID = 3;
-- SELECT * FROM EmployeeAudit;