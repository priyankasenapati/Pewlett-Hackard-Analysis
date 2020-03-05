-- Part 1
-- Number of [titles] Retiring
--
-- Create new table for retiring employees
SELECT emp_no, birth_date, first_name, last_name, gender, hire_date
INTO retirement_info_full
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info_full;

-- Create new table for retiring employees
SELECT rif.emp_no, rif.first_name, rif.last_name, ti.title, sal.from_date, sal.salary
INTO retiring_titles
FROM retirement_info_full as rif
INNER JOIN titles as ti
ON rif.emp_no = ti.emp_no
INNER JOIN salaries as sal
ON rif.emp_no = sal.emp_no
-- Check the table
SELECT * FROM retiring_titles;

-- Exclude the rows of data containing duplicate names using PARTITION
SELECT emp_no, first_name, last_name, title, from_date, salary
INTO ret_latest_titles
FROM
	(SELECT *, 
            ROW_NUMBER() 
            OVER  ( PARTITION BY (first_name, last_name)
                    ORDER BY from_date DESC) 
	FROM retiring_titles) tmp
WHERE ROW_NUMBER = 1;
-- Check the table
SELECT * FROM ret_latest_titles;

-- Who’s Ready for a Mentor?
SELECT e.emp_no, e.first_name, e.last_name, t.title, de.from_date, de.to_date
INTO mentors
FROM employees as e
    INNER JOIN dept_employees as de
            ON e.emp_no = de.emp_no
    INNER JOIN titles as t
            ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY (e.first_name, e.last_name);
-- SCheck the table
SELECT * FROM mentors;

