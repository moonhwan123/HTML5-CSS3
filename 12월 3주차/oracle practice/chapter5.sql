-- chapter 5

--count함수
select count(*) as "사원수" from employee;
select count(commission)as "커미션 받는 사원수" from employee;
select count(commission)as "커미션 받는 사원수" from employee where commission is not null; --위와 동일한 결과
select count(DISTINCT job)as "직업 종류 갯수" from employee;
select ename,salary from employee where salary=(select max(salary) from employee);

--group by
select dno,avg(salary) from employee group by dno;
select max(avg(salary)) from employee group by dno;

--havig
select dno,max(salary) from employee group by dno having max(salary) >= 3000;

select job,count(*),sum(salary) 
from employee
where job not like '%MANAGER%' 
group by job 
having sum(salary) >= 5000 
order by sum(salary);