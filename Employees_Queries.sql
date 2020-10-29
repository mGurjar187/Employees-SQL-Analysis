-- Employees Queries  

SELECT 
    emp.first_name, emp.last_name, sal.salary, emp.hire_date
FROM
    Employees AS emp
        INNER JOIN
    employee_salaries AS sal ON emp.emp_no = sal.emp_no
ORDER BY sal.salary DESC
LIMIT 10;
 
 -- #2 Department Managers with their from_date and to_date
 
SELECT 
    emp.first_name,
    emp.last_name,
    dept.dept_name,
    dept_m.from_date,
    dept_m.to_date
FROM
    employees AS emp
        INNER JOIN
    department_managers AS dept_m ON emp.emp_no = dept_m.emp_no
        INNER JOIN
    departments AS dept ON dept_m.dept_no = dept.dept_no;

-- #3 Employees with their title with from_date and and to_date  

SELECT 
    emp.first_name,
    emp.last_name,
    emp_t.title,
    emp_t.from_date,
    emp_t.to_date
FROM
    employees AS emp
        INNER JOIN
    employee_titles AS emp_t ON emp.emp_no = emp_t.emp_no_id
ORDER BY first_name , last_name;

-- #4 Titles with Average Salary from High to Low

SELECT 
    emp_t.Title, AVG(emp_sal.Salary) AS Avg_Salary
FROM
    employee_titles AS emp_t
        INNER JOIN
    employee_salaries AS emp_sal ON emp_t.emp_no_id = emp_sal.emp_no
GROUP BY title
ORDER BY Avg_Salary DESC;

-- #5 Employees with Maximum Salary within their Titles

SELECT 
    emp.first_name,
    emp.last_name,
    emp_tit.title,
    MAX(emp_sal.salary) AS Max_Salary
FROM
    employees AS emp
        INNER JOIN
    employee_titles AS emp_tit ON emp.emp_no = emp_tit.emp_no_id
        INNER JOIN
    employee_salaries AS emp_sal ON emp.emp_no = emp_sal.emp_no
GROUP BY emp_tit.title
ORDER BY Max_Salary DESC;

-- #6 Employees hired on Day 1 of the Company

SELECT 
    first_name, last_name, hire_date
FROM
    employees
WHERE
    hire_date = (SELECT 
            MIN(hire_date)
        FROM
            employees)
ORDER BY first_name , last_name;

-- #7 Employees with Salary with 100000 or above and name starting with 'ber

SELECT 
    CONCAT(emp.first_name, ' ', emp.last_name) AS full_name,
    emp_sal.salary
FROM
    employees AS emp
        INNER JOIN
    employee_salaries AS emp_sal ON emp.emp_no = emp_sal.emp_no
WHERE
    emp_sal.salary >= 100000
        AND CONCAT(emp.first_name, ' ', emp.last_name) REGEXP '^ber';

-- regexp basics --

SELECT 
    emp.first_name, emp.last_name, emp_tit.title
FROM
    employees AS emp
        INNER JOIN
    employee_titles AS emp_tit ON emp.emp_no = emp_tit.emp_no_id
WHERE
    emp.first_name LIKE 'ari_'
        AND emp_tit.title LIKE '%engineer%';
        
- #9 Create View for Employees with their Salary

CREATE VIEW employee_sal AS 
SELECT 
    emp.first_name,
    emp.last_name,
    emp_sal.salary
FROM
    employees AS emp
        INNER JOIN
    employee_salaries AS emp_sal ON emp.emp_no = emp_sal.emp_no
    ORDER BY first_name, last_name;

-- #10 Employees with Categorised into Low, Medium and High by Salary

SELECT 
    first_name, last_name, salary, 'Low' AS Salary_Category
FROM
    employee_sal
WHERE
    salary < 53000 
UNION SELECT 
    first_name, last_name, salary, 'Medium' AS Salary_Category
FROM
    employee_sal
WHERE
    salary BETWEEN 53000 AND 90000 
UNION SELECT 
    first_name, last_name, salary, 'High' AS Salary_Category
FROM
    employee_sal
WHERE
    salary > 90000
ORDER BY first_name , last_name;
