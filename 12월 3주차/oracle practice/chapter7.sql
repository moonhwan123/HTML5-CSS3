--chapter.7

--단일행 서브쿼리
select * from employee where dno=(select dno from employee where ename='SCOTT');
select * from employee where salary=(select min(salary) from employee);
select dno,min(salary) from employee group by dno having min(salary) > (select min(salary) from employee where dno=30);

--다중행 서브쿼리

--IN연산자
select eno,ename from employee where (salary) in
(select min(salary) from employee group by dno);

--ANY연산자
select eno,ename,job,salary from employee 
where salary < any(select salary from employee where job ='SALESMAN')
and job <>'SALESMAN';

--ALL연산자
select eno,ename,job,salary 
from employee where salary < all ( select salary from employee where job='SALESMAN')
and job<>'SALESMAN';

