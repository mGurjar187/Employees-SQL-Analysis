DROP DATABASE IF EXISTS Employees_db;
CREATE DATABASE Employees_db;
USE Employees_db;

DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees(
emp_no INT NOT NULL,
birth_date DATE NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
gender CHAR(2) NOT NULL,
hire_date DATE NOT NULL DEFAULT(CURRENT_DATE),
PRIMARY KEY(emp_no));

LOAD DATA 
INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

DROP TABLE IF EXISTS Employee_titles;

CREATE TABLE Employee_titles (
    emp_no_id INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE,
    FOREIGN KEY (emp_no_id)
        REFERENCES Employees (emp_no)
);

LOAD DATA 
INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employee_titles.csv'
INTO TABLE employee_titles
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (dept_no)
);

-- ALTER TABLE departments
-- MODIFY COLUMN dept_no VARCHAR(10) NOT NULL;

LOAD DATA
INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Departments.csv'
INTO TABLE departments
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

DROP TABLE IF EXISTS employee_salaries;

CREATE TABLE employee_salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)
        REFERENCES EMPLOYEES (emp_no)
);

LOAD DATA
INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Salaries.csv'
INTO TABLE employee_salaries
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

DROP TABLE IF EXISTS employee_department;

CREATE TABLE employee_department (
    emp_no_id INT NOT NULL,
    dept_no_id VARCHAR(5) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no_id)
        REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no_id)
        REFERENCES departments (dept_no)
);

LOAD DATA
INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employee_department.csv'
INTO TABLE employee_department
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

DROP TABLE IF EXISTS department_managers;

CREATE TABLE department_managers (
    dept_no VARCHAR(5) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)
        REFERENCES EMPLOYEES (emp_no),
    FOREIGN KEY (dept_no)
        REFERENCES departments (dept_no)
);

LOAD DATA
INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Department_managers.csv'
INTO TABLE department_managers
FIELDS TERMINATED BY ','
IGNORE 1 LINES;
