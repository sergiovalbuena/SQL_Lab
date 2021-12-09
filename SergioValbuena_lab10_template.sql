/* COMP 144 Lab 10 
Author: Sergio Valbuena
C0503190
Date: current date
*/

/* QUERY 1 -  
Display each country name, and the region name associated 
with it for the region of Asia.  Protect against upper/lowercase anomalies.
*/
SELECT country_name, r.region_name
from countries c
join regions r on c.region_id = r.region_id
where r.region_name Like upper("asia%");


/* QUERY 2 - 
Write a query to display the first name, last name (concatenated, with the header "Full Name", 
job title, department id, and department name for all employees who work 
in Toronto. Be sure to handle case (i.e. upper and lower case) when checking 
for the correct city.  Use a function to force a proper case comparison. 
Order by ascending last name.
*/
select CONCAT(e.first_name," ",e.last_name) as "Full Name" , j.job_title, d.department_id, d.department_name, l.city
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
where upper(l.city) = "TORONTO"
order by e.last_name asc;



/* QUERY 3 - 
Write a query to find the addresses of all the departments that are in 
Canada, Italy and Japan. Please include location id, street address, 
city, state/province and country name
*/
select location_id, street_address, city, state_province, c.country_name
from locations l
Join countries c ON l.country_id = c.country_id
where upper(c.country_name) IN ("Canada", "Italy", "Japan");

/* QUERY 4 - 
Display the employee last name, employee number, and department name, along with their 
   manager's last name and manager number (in other words the manager's 
   employee id) for all employees whose last name begins with 'C' (be 
   sure to handle case - use a function).  Label the columns Employee, 
   Employee ID, Employee Dept, Manager, and Manager ID, respectively 
*/
select concat(e.last_name, " ", e.first_name) as "employee", e.employee_id as "Employee ID",e.department_id, manager_id, last_name 
from employees e
JOIN departments d ON e.department_id = d.department_id
join employee m
WHERE e.last_name like upper("c%"); 



/* QUERY 5 - 
Display the first name, last name (concatenated with the title "Full Name",
employee id, department id, job id, job title and time (in years) that 
the employee worked the job for all employees who are in department 90.
*/
select concat(e.first_name, " ", e.last_name) as "Full Name", e.employee_id, e.department_id, e.job_id, j.job_title, timestampdiff(year, hire_date, curdate())
from employees e
join jobs j on e.job_id = j.job_id
where department_id = 90;


/* QUERY 6 - 
Display the first name, last name (concatenated with the title "Full Name"),
job title, department name, city, and country name, for all employees  in the 
Marketing department that do not work in the United States of America.
*/
select d.department_id, d.department_name, city, c.COUNTRY_name, j.job_title 
from employees e
join departments d ON e.department_id = d.department_id
join locations l ON d.location_id = l.location_id
join countries c ON l.country_id = c.country_id
join job_history jh ON e.employee_id = jh.employee_id
join jobs j ON jh.job_id = j.job_id
WHERE upper(DEPARTMENT_NAME) = "MARKETING"
AND country_name <> "United States%"