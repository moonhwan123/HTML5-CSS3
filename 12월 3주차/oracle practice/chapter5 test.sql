--chapter.5 연습문제

-- 1.
select max(salary) as Maximum, min(salary) as Minimum, sum(salary) as Sum, round(avg(salary)) as Average from employee;

-- 2.
select job,max(salary) as Maximum, min(salary) as Minimum, sum(salary) as Sum, round(avg(salary)) as Average 
from employee 
group by job;

-- 3.
select job,count(*) from employee group by job;

-- 4.
select count(manager) from employee;

-- 5.
select max(salary) - min(salary) as "diferrence" from employee;

-- 6.
select job,min(salary) 
from employee 
group by job
having not min(salary) < 2000;

-- 7.
select dno,count(*),round(avg(salary),2) from employee group by dno order by dno;

