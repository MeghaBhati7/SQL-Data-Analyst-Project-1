use employees;

select * from employees;
select * from departments;
-- 1  List of Employees by Department
-- Question: Write a query to list all employees along with their respective department names. Include employee number, first name, last name, department number, and department name.
 
 select e.emp_no, e.first_name, e.last_name, d.dept_no, d.dept_name  from employees as e 
 join dept_emp as de
 on e.emp_no = de.emp_no
 join departments as d 
 on de.dept_no = d.dept_no;
 
 -- 2 Current and Past Salaries of an Employee
-- Question: Write a query to retrieve all the salary records of a given employee (by employee number). Include employee number, salary, from_date, and to_date.

select e.emp_no, s.from_date, s.to_date, s.salary from employees as e
join salaries as s
on e.emp_no = s.emp_no; 

select max(salary) from salaries 
where emp_no = '10045';

select * from salaries 
where emp_no = '42645' order by salary desc
limit 1;

--  3. Employees with Specific Titles
-- Question: Write a query to find all employees who have held a specific title (e.g., ‘Engineer’). Include employee number, first name, last name, and title.

select e.emp_no, e.first_name, e.last_name, t.title from employees as e
join titles as t 
on e.emp_no = t.emp_no
where t.title = 'Engineer' ;

-- 4. Departments with Their Managers
-- Question: Write a query to list all departments along with their current managers. Include department number, department name, manager’s employee number, first name, and last name.

select d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name from departments as d
join dept_manager as dm
on d.dept_no = dm.dept_no
join employees as e
on e.emp_no = dm.emp_no; 


-- 5. Employee Count by Department
-- Question: Write a query to count the number of employees in each department. Include department number, department name, and employee count.

select d.dept_no, dept_name, count(de.emp_no) as emp_count from departments as d
join dept_emp as de 
on d.dept_no = de.dept_no
group by dept_name,dept_no;  

-- 6. Employees’ Birthdates in a Given Year
-- Question: Write a query to find all employees born in a specific year (e.g., 1954). Include employee number, first name, last name, and birth date. 

select emp_no, first_name, last_name, birth_date from  employees 
where year(birth_date) = '1954';

-- 7. Employees Hired in the Last 50 Years
-- Question: Write a query to find all employees hired in the last 5 years. Include employee number, first name, last name, and hire date.

select emp_no, first_name, last_name, hire_date from employees 
where hire_date >= date_sub(curdate(),INTERVAL 45 year) ;

-- 8. Average Salary by Department
-- Question: Write a query to calculate the average salary for each department. Include department number, department name, and average salary.

select d.dept_no, d.dept_name, avg(s.salary) as avg_salary from departments as d
join dept_emp as de 
on d.dept_no = de.dept_no
join salaries as s
 de.emp_no = s.emp_no
group by d.dept_no, d.dept_name;  

-- 9. Gender Distribution in Each Department
-- Question: Write a query to find the gender distribution (number of males and females) in each department. Include department number, department name, count of males, and count of females

select d.dept_no, d.dept_name, 
sum(case when e.gender='M' then 1 or 0 end) as male_count, 
sum(case when e.gender='F' then 1 or 0 end) as female_count from departments as d
join dept_emp as de on d.dept_no = de.dept_no
join employees as e on de.emp_no = e.emp_no
group by d.dept_no,d.dept_name;

-- 10. Longest Serving Employees
-- Question: Write a query to find the employees who have served the longest in the company. Include employee number, first name, last name, and number of years served

select emp_no, first_name, last_name,
timestampdiff(year,hire_date,current_date()) as served_years
from employees
order by served_years desc
limit 10;