/* COMP 144 Lab 09 
Author: Sergio Valbuena
Date: Mon Nov 22 / 2021
*/

/* QUERY 1 - Find number of records in employees table */
SELECT count(*) as 'total employees' FROM employees;

/* QUERY 2 - Display the first 5 employees from the employees table */
SELECT * FROM employees order by employee_id asc limit 5;

/* QUERY 3 - Display all employees whose last name starts with "L". Display first name, last name
	and department ID. Protect against upper/lower case anomolies. */
SELECT FIRST_NAME, LAST_NAME  
FROM employees 
where lower(last_name) like 'L%';

/* QUERY 4 - Display all employees who have a salary that is less than 2500 per month. 
	Display first name and last name concatenated with the title "Poor Employees" as well as the salary
    	Order the salaries descending. */
SELECT CONCAT (FIRST_NAME, ' ', LAST_NAME) as 'Poor Employees', salary
FROM employees 
where Salary < 2500
order by salary desc;

/* QUERY 5 - Display all the employee phone numbers that start with area code 603
	include first name, last name (concatenated as "Full Name") and phone number */
SELECT CONCAT (FIRST_NAME, ' ', LAST_NAME) as 'Poor Employees', phone_number
FROM employees 
where PHONE_NUMBER like ('603%');

/* QUERY 6 - Display all the distinct department names from the departments table
	that have the word "sales" */
SELECT * from departments
where DEPARTMENT_NAME like upper('%sales%')
order by location_id desc;

/* QUERY 7 - Display the first name, department id, and salary from employees whose name begins 
	with A. Protect against upper/lowercase anomalies. Order results by descending department id. */
SELECT first_name, last_name, salary from employees
where upper(first_name) like ('A%')
order by department_id desc;

/* QUERY 8 - Write a query to display the first name, last name, and department name for all employees 
	in departments 40, 60 and 110 in alphabetical order by last name. HINT: simple JOIN */
SELECT e.first_name, e.last_name, department_name
from employees e
join departments d on e.department_id = d.department_id
where d.department_id in (40, 60, 110)
order by last_name asc;

/* QUERY 9 - Display the job title and yearly salary (monthly salary * 12) for all employees who have a monthly salary
	more than 12000. Display their first and last name concatenated with a heading of "Rich Employees".
   	 Display their yearly salary as "Yearly Salary" HINT: simple JOIN */ 
SELECT job_title as "Job title", concat(first_name, last_name) as 'Rich Employees' , salary * 12 as'Yearly Salary', concat("$",format(salary,2)) as salary
from employees e
join jobs j on e.job_id = j.job_id
where salary > 12000
order by salary asc;