-- chapter4 연습문제

-- 1. 
select substr(hiredate,1,2) as 입사년도 , substr(hiredate,4,2) as 달 from employee;
-- 2.
select * from employee where substr(hiredate,4,2) = '04';
-- 3.
select * from employee where mod(eno,2) = 0;
-- 4.
select hiredate,to_char(hiredate,'YY/MON/DY') from employee;
-- 5. 
select trunc(sysdate - to_date('2020/01/01','YYYY/MM/DD')) from dual;
-- 6.
select eno,ename,nvl2(manager,manager,0)as manager from employee;
-- 7.
select eno,ename,job,salary,decode(job,
    'analyst',salary+200,
    'salesman',salary+180,
    'manager',salary+150,
    'clerk',salary+100,
    salary
) as update_salary
from employee;