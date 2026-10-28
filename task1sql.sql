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