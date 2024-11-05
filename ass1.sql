create table employee(
	employee_name varchar(50) primary key,
    street varchar(50),
    city varchar(50),
    birthdate date
);


create table company(
	company_name varchar(50) primary key,
    city varchar(50)
);


create table works(
	employee_name varchar(50),
    company_name varchar(50),
    monthly_salary decimal(10,2),
    primary key(employee_name,company_name),
    foreign key(employee_name) references employee(employee_name),
    foreign key(company_name) references company(company_name)
);
CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
    FOREIGN KEY (manager_name) REFERENCES employee(employee_name)
);
INSERT INTO company (company_name, city) VALUES
('First Bank Corporation', 'Pune'),
('Small Bank Corporation', 'Mumbai'),
('Special Bank Corporation', 'Nashik');


INSERT INTO employee (employee_name, street, city, birthdate) VALUES
('Raj Shukla', 'MG Road', 'Mumbai', '1990-01-15'),
('Sandip Patil', 'Park Street', 'Pune', '1992-05-12'),
('Shital Sonje', 'Laxmi Road', 'Nashik', '1988-10-20'),
('Aditya Makre', 'Baner Road', 'Pune', '1991-07-15'),
('Rohan Pawar', 'Wakad Road', 'Mumbai', '1993-03-05');

INSERT INTO works (employee_name, company_name, monthly_salary) VALUES
('Raj Shukla', 'First Bank Corporation', 60000),
('Sandip Patil', 'Small Bank Corporation', 45000),
('Shital Sonje', 'Special Bank Corporation', 70000),
('Aditya Makre', 'First Bank Corporation', 55000),
('Rohan Pawar', 'Small Bank Corporation', 50000);


INSERT INTO manages (employee_name, manager_name) VALUES
('Sandip Patil', 'Raj Shukla'),
('Shital Sonje', 'Sandip Patil'),
('Aditya Makre', 'Shital Sonje'),
('Rohan Pawar', 'Raj Shukla');


alter table employee
add birthdate date;


UPDATE employee
SET birthdate = '1990-01-01'
WHERE employee_name = 'Raj Shukla';

UPDATE employee
SET birthdate = '1992-05-12'
WHERE employee_name = 'Sandip Patil';

delete from employee
where employee_name='Raj Shukla ';

alter table works
rename column salary to monthly_salary;

create table dependent(employee_name varchar(50),
dependent_name varchar(50),
relation varchar(50),
foreign key (employee_name) references employee(employee_name)
);

INSERT INTO dependent (employee_name, dependent_name, relation) VALUES
('Sandip Patil', 'Aarav Patil', 'Son'),
('Shital Sonje', 'Nisha Sonje', 'Daughter'),
('Aditya Makre', 'Sneha Makre', 'Wife'),
('Rohan Pawar', 'Naina Pawar', 'Sister');

truncate table dependent;
delete from dependent;


select employee_name
from employee
where employee_name like "S%";

select employee_name
from works
where company_name='First Bank Corporation';

SELECT company_name
FROM company
WHERE city = 'Pune';


SELECT employee_name, FLOOR(DATEDIFF(CURDATE(), birthdate) / 365) AS age
FROM employee;


SELECT e.employee_name, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'First Bank Corporation';


SELECT employee_name, monthly_salary
FROM works
WHERE monthly_salary > 50000;



SELECT e.employee_name, e.street, e.city, w.company_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name;


SELECT manager_name
FROM manages
WHERE employee_name = 'Sandip Patil';



SELECT employee_name
FROM employee
WHERE MONTH(birthdate) = 1;
