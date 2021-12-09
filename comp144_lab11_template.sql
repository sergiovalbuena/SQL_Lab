/* COMP 144 Lab 11
Author: Sergio Valbuena
Date: Dec 6 2021
*/

/*** QUERY 1 ***/ 
/* Write a query to display the number of people with the same job. Use JOB_ID 
in your query and list the jobs by JOB_ID along with the number of people having
that job.*/
select e.job_id as "Job ID", count(*) as "Number of People"
from employees e
join job_history jh on e.employee_id = jh.employee_id
join jobs j ON j.job_id = e.job_id 
group by j.job_id;


/*** QUERY 2 ***/ 
/* Write a query to display the maximum, minimum, sum, and average 
salary for each job type  (assume each job_id represents a job type). Be 
sure to give the job type in your output.*/
select job_id as 'Job Type', 
FORMAT(MAX(salary),2) as 'Max', 
FORMAT(MIN(salary),2) as 'Min', 
FORMAT(SUM(salary),2) as 'Total', 
FORMAT(AVG(salary),2) as 'Average'
from employees group by job_id;

/*** QUERY 3 ***/
/* Write a query to display the department name (NAME, not ID),
number of people, total salary and average salary for each department that has an 
overall monthly payroll that is more than $20000. For your results, round each dollar amount 
to 2 decimal places and put a "$" in front, Give the headings "Number of People", "Total Salary"
and "Avg Salary" for each respective column. Results must be displayed by total salary descending */
SELECT d.department_name, count(e.employee_id) AS "NUMBER OF PEOPLE", 
CONCAT("$ ",FORMAT(sum(e.salary),2)) AS "TOTAL SALARY", 
CONCAT("$ ",FORMAT(avg(e.salary),2)) AS "AVERAGE SALARY"
FROM employees e
JOIN departments d ON e.department_id = d.department_id 
GROUP BY e.department_id
HAVING sum(e.salary) > 20000
ORDER BY sum(e.salary) desc;


/*** QUERY 4 ***/ 
/* Display the manager number and the salary of the lowest paid employee for 
that manager. Exclude anyone whose manager is not known - in other words, 
exclude anyone who has a NULL manager_id. Exclude any groups that have a minimum salary 
that is less than $5000 */
SELECT m.employee_id as "manager number", concat("$ ",format(e.salary,2)) as "Salary"
FROM employees e 
INNER JOIN employees m ON e.manager_id = m.employee_id
where e.salary > 5000


/*** QUERY 5 ***/
/* USING A SUBQUERY, Write a query that will display the last name and salary of every employee who reports to Gerald Cambrault. (There is more than one Cambrault in the database so you must be careful to check the first name too.) Be sure to handle case. */
SELECT e.last_name as "employee last name", m.last_name as "Manager Last Name", m.first_name as "Manager First Name", concat('$ ',format(e.salary,2)) as "employee salary" 
FROM employees e INNER JOIN employees m
ON e.manager_id = m.employee_id
WHERE upper(m.last_name) = "Cambrault"
AND upper(m.first_name) = "Gerald"

/* :( I tryed  so hard to do with subquery but couldnt, here is the same result tho*/


/*** QUERY 6 ***/
/* You have been hired by this company in the IT department as a programmer.
INSERT a new record in to the employees table for yourself. Add your name with the following info:
employee_id - 220
first_name - your name
last_name - your name
phone_number - your phone number
email - your email
job_id - "IT_PROG"
salary - 4200     --!!!!!
commission - 0
manager_id - 145
department_id - 60 */
INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID, HIRE_DATE)
VALUES (220, "Sergio", "Valbuena", "mail@camosun.ca",2365089862, "IT_PROG", "4200", 0, 145, 60, "2021-06-18")


/*** QUERY 7 ***/
/* Write a query to show all of the information for yourself, including department name, job name, city, and manager
name (concatenate first name and last name with a heading of "Manager") */
SELECT e.first_name as "Name", e.last_name as"Last Name", j.job_title as "Job Name", d.department_name as "Dpt. name", l.city city,  concat(m.last_name," ",m.last_name) as manager 
FROM employees e 
INNER JOIN employees m ON e.manager_id = m.employee_id
JOIN jobs j on e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l on d.location_id = l.location_id
where e.last_name = "Valbuena"

/*** QUERY 8 ***/
/* You put in the wrong employee number for yourself. Write a query to change the employee number from 220 to 222
Display the resulting changes by displaying employee id, first name and last name (concatenated with a title "Full Name"),
department id, and manager id. */
update employees 
SET employee_id = 222
WHERE employee_id = 220

SELECT e.employee_id, concat(e.first_name, " ", e.last_name) as"Full Name", d.department_name as "Dpt. name", m.employee_id as "manager ID" 
FROM employees e 
INNER JOIN employees m ON e.manager_id = m.employee_id
JOIN jobs j on e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l on d.location_id = l.location_id
where e.employee_id = 222



/*** QUERY 9 ***/
/* Your company isn't doing well and is cutting back on staff. You are the first to be let go. Delete yourself
from the employees table. Show proof that the record for you is no longer in the employees table. */
--inster and selects
DELETE from employees where employee_id = 222

select * from employees
where employee_id = 222