#ScienceQtech Employee Performance Mapping

/*Create a 1.database named employee, then import data_science_team.csv 
proj_table.csv and emp_record_table.csv into the employee 
database from the given resources.*/

create database employee;
use employee;

create table ds_team (
EMP_ID varchar(40) not null,
FIRST_NAME varchar(40) not null,
LAST_NAME varchar(40) not null,
GENDER varchar(40) not null,
ROLE varchar(40) not null,
DEPT varchar(40) not null,
EXP dec not null,
COUNTRY varchar(40) not null,
CONTINENT varchar(40) not null,
primary key(EMP_ID));

create table emp_table (
EMP_ID varchar(40) not null,
FIRST_NAME varchar(40) not null,
LAST_NAME varchar(40) not null,
GENDER varchar(40) not null,
ROLE varchar(40) not null,
DEPT varchar(40) not null,
EXP dec not null,
COUNTRY varchar(40) not null,
CONTINENT varchar(40) not null,
SALARY dec not null,
EMP_RATING dec not null,
MANAGER_ID varchar(40) not null,
PROJ_ID varchar(40) null,
primary key(EMP_ID));

create table Proj_table (
PROJECT_ID varchar(40) not null,
PROJ_Name varchar(40) not null,
DOMAIN varchar(40) not null,
START_DATE date not null,
CLOSURE_DATE varchar(40) not null,
DEV_QTR varchar(40) not null,
STATUS varchar(40) not null,
primary key(PROJECT_ID));

select*from ds_team;

select*from emp_table;

select*from Proj_table;

/*3. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, 
and DEPARTMENT from the employee record table, and make
 a list of employees and details of their department*/
 
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_table;

/*4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, 
and EMP_RATING if the EMP_RATING is: */

#less than two

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from emp_table
where EMP_RATING<2;

#greater than four 

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from emp_table
where EMP_RATING>4;

#between two and four

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from emp_table
where EMP_RATING between 2 and 4;



/*5.Write a query to concatenate the FIRST_NAME and the LAST_NAME 
of employees in the Finance department from the employee table 
and then give the resultant column alias as NAME.*/

select FIRST_NAME, LAST_NAME, concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME,DEPT  from emp_table
where dept='finance';

/*6. Write a query to list only those employees who have someone reporting to them. 
Also, show the number of reporters (including the President).*/

select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME,DEPT from emp_table
where role <>'manager' and role !='president';

/*7. Write a query to list down all the employees from the healthcare and 
finance departments using union. Take data from the employee record table*/

select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME ,DEPT from  emp_table
where dept='healthcare' or dept='finance'
union 
select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME ,DEPT from emp_table
where dept='healthcare' or dept='finance';

/*8. Write a query to list down employee details such as EMP_ID, FIRST_NAME, 
LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include 
the respective employee rating along with the max emp rating for the department.*/

select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,max(EMP_RATING) from emp_table
group by DEPT 
order by max(EMP_RATING) desc ;

/*9. Write a query to calculate the minimum and the maximum salary of 
the employees in each role. Take data from the employee record table.*/

select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME,DEPT,min(salary), max(salary),ROLE from emp_table
group by ROLE;

/*10.Write a query to assign ranks to each employee based on their experience. 
Take data from the employee record table.*/

select EMP_ID, FIRST_NAME, LAST_NAME, EXP,rank () over (order by EXP) as Ranks from emp_table;

/*11. Write a query to create a view that displays employees in various 
countries whose salary is more than six thousand. Take data from 
the employee record table.*/

select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME, COUNTRY, SALARY from emp_table
where salary>6000;

/*12. Write a nested query to find employees with experience of more 
than ten years. Take data from the employee record table.*/

select  concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME, EXP from emp_table
where EXP>10;

/*13.Write a query to create a stored procedure to retrieve the details 
of the employees whose experience is more than three years. 
Take data from the employee record table*/

delimiter &&
create procedure emp_exp()
begin
select EMP_ID, FIRST_NAME, LAST_NAME, EXP from emp_table
where exp>3;
end &&
delimiter ;;
call emp_exp();

/*14. Write a query using stored functions in the project table to check 
whether the job profile assigned to each employee in the data science 
team matches the organization’s set standard.
The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'*/

#For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',

delimiter &&
create procedure JUNIOR_DATA_SCIENTIST()
begin
select EMP_ID, FIRST_NAME, LAST_NAME, EXP from emp_table
where EXP<=2;
end &&
delimiter ;;

call JUNIOR_DATA_SCIENTIST;

#For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',

delimiter &&
create procedure ASSOCIATE_DATA_SCIENTIST()
begin
select EMP_ID, FIRST_NAME, LAST_NAME, EXP from emp_table
where EXP>2 and EXP<=5;
end &&
delimiter ;;

call ASSOCIATE_DATA_SCIENTIST;

#For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',

delimiter &&
create procedure SENIOR_DATA_SCIENTIST()
begin
select EMP_ID, FIRST_NAME, LAST_NAME, EXP from emp_table
where EXP>5 and EXP<=10;
end &&
delimiter ;;

call SENIOR_DATA_SCIENTIST;

#For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',

delimiter &&
create procedure LEAD_DATA_SCIENTIST()
begin
select EMP_ID, FIRST_NAME, LAST_NAME, EXP from emp_table
where EXP>10 and EXP<=12;
end &&
delimiter ;;

call LEAD_DATA_SCIENTIST;

#For an employee with the experience of 12 to 16 years assign 'MANAGER'

delimiter &&
create procedure MANAGER()
begin
select EMP_ID, FIRST_NAME, LAST_NAME, EXP from emp_table
where EXP>12 and EXP<=16;
end &&
delimiter ;;

call MANAGER;

/*15.	Create an index to improve the cost and performance of the query to find the employee 
whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.*/
 
 select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME from emp_table
 where FIRST_NAME ='eric';

 /*16.	Write a query to calculate the bonus for all the employees, based on their ratings 
and salaries (Use the formula: 5% of salary * employee rating).*/
 
select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME ,( SALARY *0.05)* EMP_RATING as Bonus
from emp_table;

 /*17.	Write a query to calculate the average salary distribution based on the continent 
and country. Take data from the employee record table.*/

select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME ,CONTINENT,avg(SALARY) as Average_Salary 
from emp_table
group by CONTINENT ;

select concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME ,COUNTRY,avg(SALARY) as Average_Salary 
from emp_table
group by COUNTRY ;

