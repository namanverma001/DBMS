create database assignment3;
use assignment3;

-- Create Tables
CREATE TABLE employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT,
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
);

CREATE TABLE company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
    FOREIGN KEY (manager_name) REFERENCES employee(employee_name)
);

-- Insert data into employee table
INSERT INTO employee (employee_name, street, city) VALUES
('John Doe', 'Maple Street', 'New York'),
('Jane Smith', 'Oak Avenue', 'Boston'),
('Alice Johnson', 'Pine Road', 'New York'),
('Bob Brown', 'Cedar Lane', 'Chicago');

-- Insert data into works table
INSERT INTO works (employee_name, company_name, salary) VALUES
('John Doe', 'First Bank Corporation', 12000),
('Jane Smith', 'First Bank Corporation', 9000),
('Alice Johnson', 'Small Bank Corporation', 8000),
('Bob Brown', 'Small Bank Corporation', 9500);

-- Insert data into company table
INSERT INTO company (company_name, city) VALUES
('First Bank Corporation', 'New York'),
('Small Bank Corporation', 'Chicago'),
('Tech Solutions', 'Boston');

-- Insert data into manages table
INSERT INTO manages (employee_name, manager_name) VALUES
('John Doe', 'Jane Smith'),
('Alice Johnson', 'John Doe'),
('Bob Brown', 'Alice Johnson');

SELECT employee_name
FROM works
WHERE company_name = 'First Bank Corporation';


SELECT e.employee_name, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'First Bank Corporation';

SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'First Bank Corporation' AND w.salary > 10000;


SELECT e.employee_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
JOIN company c ON w.company_name = c.company_name
WHERE e.city = c.city;

SELECT e.employee_name
FROM employee e
JOIN manages m ON e.employee_name = m.employee_name
JOIN employee mng ON m.manager_name = mng.employee_name
WHERE e.city = mng.city AND e.street = mng.street;

SELECT employee_name
FROM works
WHERE company_name != 'First Bank Corporation';


SELECT w1.employee_name
FROM works w1
WHERE w1.salary > ALL (SELECT w2.salary FROM works w2 WHERE w2.company_name = 'Small Bank Corporation');


SELECT company_name
FROM company
WHERE city IN (SELECT city FROM company WHERE company_name = 'Small Bank Corporation')
GROUP BY company_name
HAVING COUNT(DISTINCT city) = (SELECT COUNT(DISTINCT city) FROM company WHERE company_name = 'Small Bank Corporation');

SELECT w.employee_name
FROM works w
JOIN (SELECT company_name, AVG(salary) AS avg_salary FROM works GROUP BY company_name) avg_w
ON w.company_name = avg_w.company_name
WHERE w.salary > avg_w.avg_salary;

SELECT company_name
FROM works
GROUP BY company_name
ORDER BY COUNT(employee_name) DESC
LIMIT 1;


SELECT company_name
FROM works
GROUP BY company_name
ORDER BY SUM(salary) ASC
LIMIT 1;



SELECT company_name
FROM works
GROUP BY company_name
HAVING AVG(salary) > (SELECT AVG(salary) FROM works WHERE company_name = 'First Bank Corporation');
