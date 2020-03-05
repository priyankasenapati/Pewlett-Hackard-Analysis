SELECT * FROM departments;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31'


- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_employees.emp_no;

SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date 
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp;*/

-- Employee count by department number



SELECT COUNT(ce.emp_no, de.dept_no, ce.birth_date, ce.hire_date)
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;
WHERE (ce.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (ce.hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT COUNT(ce.emp_no, de.dept_no, ce.birth_date, ce.hire_date)
FROM employees as ce
WHERE (ce.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (ce.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Create new table for retiring employees

SELECT emp_no, first_name, last_name, birth_date, hire_date, gender
INTO retirement_info_c
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info_c

SELECT COUNT(ri.emp_no), de.dept_no
FROM retirement_info_c as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info_full
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info_full;


SELECT COUNT(rfull.emp_no), de.dept_no
FROM retirement_info_full as rfull
LEFT JOIN dept_employees as de
ON rfull.emp_no = de.emp_no
GROUP BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;


-- List 1: EMployee information
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no
INNER JOIN dept_employees as de
ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 	AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info;
		
-- List 2: Management
-- List of managers per department
SELECT	dm.dept_no,
		d.dept_name,
		dm.emp_no,
		ce.last_name,
		ce.first_name,
		dm.from_date,
		dm.to_date
-- INTO dept_info
FROM dept_manager as dm
	INNER JOIN departments as d
		ON dm.dept_no = d.dept_no
	INNER JOIN current_emp as ce
		ON dm.emp_no = ce.emp_no;

-- List 3: Department retirees
-- LIST 3 pilot
SELECT 	ce.emp_no, 
		ce.first_name,
		ce.last_name,
		d.dept_name
-- INTO list3
FROM current_emp as ce
	LEFT JOIN dept_employees as de
		ON ce.emp_no = de.emp_no
	LEFT JOIN departments as d
		ON de.dept_no = d.dept_no;

-- Create a tailored list for the Sales team
-- List of sales employees retiring
SELECT ri.emp_no, ri.first_name, ri.last_name, d.dept_name
INTO sales_retirees
FROM retirement_info as ri
	LEFT JOIN dept_employees as de
		ON ri.emp_no = de.emp_no
	LEFT JOIN departments as d
		ON de.dept_no = d.dept_no
WHERE (d.dept_name = 'Salesw');

-- List of sales and Development employees retiring
SELECT ri.emp_no, ri.first_name, ri.last_name, d.dept_name
-- INTO sales_retirees
FROM retirement_info as ri
	LEFT JOIN dept_employees as de
		ON ri.emp_no = de.emp_no
	LEFT JOIN departments as d
		ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');




/*
-- List 1: EMployee information
SELECT rif.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM retirement_info_full as rif
INNER JOIN salaries as s
ON e.emp_no = s.emp_no
INNER JOIN dept_employees as de
ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 	AND (de.to_date = '9999-01-01');
*/


-- Create new table for retiring employees
/* SELECT rif.emp_no, rif.birth_date, rif.first_name, rif.last_name, rif.gender, rif.hire_date, ti.title */
SELECT rif.emp_no, rif.first_name, rif.last_name, ti.title, sal.from_date, sal.salary
INTO retiring_titles
FROM retirement_info_full as rif
INNER JOIN titles as ti
ON rif.emp_no = ti.emp_no
INNER JOIN salaries as sal
ON rif.emp_no = sal.emp_no
/*GROUP BY rif.title; */


