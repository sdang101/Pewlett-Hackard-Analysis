-- Deliverable 1: Number of Retiring Employees by Title
SELECT ce.emp_no
	, ce.first_name
	, ce.last_name
	, t.title
	, t.from_date
	, s.salary
INTO challenge_retiring_emp
FROM current_emp AS ce
	INNER JOIN titles AS t 
		ON ce.emp_no = t.emp_no
	INNER JOIN salaries AS s 
		ON ce.emp_no = s.emp_no;

-- Partition the data to show only most recent title per employee
SELECT emp_no
	, first_name
	, last_name
	, title
	, from_date
	, salary
INTO retiring_emp_by_title
FROM
 (SELECT *, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM challenge_retiring_emp as cre
 ) tmp WHERE rn = 1
ORDER BY emp_no;

-- Deliverable 2: Mentorship Eligibility
SELECT e.emp_no
	, e.first_name
	, e.last_name
	, t.title
	, t.from_date
	, t.to_date
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '01-01-1965' AND '12-31-1965')