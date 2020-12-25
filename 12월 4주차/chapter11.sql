--chapter.11

create table emp_second as select * from employee;
create table dept_second as select * from department;

--view 생성(단일뷰)
create view v_emp_job(사번,사원이름,부서번호,담당업무)
as select eno,ename,dno,job
from emp_second where job like 'SALESMAN';

create view v_emp_job2
as select eno,ename,dno,job
from emp_second where job like 'SALESMAN';

--view 접근
select * from v_emp_job;
select * from v_emp_job2;

--view 생성(복합뷰)
create view v_emp_complex
as select * from emp_second natural join dept_second;

select * from  v_emp_complex;

--보안을 위한 뷰 활용(급여 생략)
create view v_emp_sample as select eno,ename,job,manager,dno
from emp_second;

select * from  v_emp_sample;

create view v_emp_complex2 as 
select e.eno, e.ename, e.salary,dno,d.dname,d.loc
from emp_second e natural join dept_second d;

select * from  v_emp_complex2;

select * from USER_VIEWS;

--USER_VIEWS 데이터 사전
select view_name,text from user_views;
--view는 select문에 이름을 붙인것

--view를 통해 기본테이블에 데이터 추가하기
insert into v_emp_job values(8000,'윤정화',30,'SALESMAN');
select * from v_emp_job;
select * from emp_second;

--다양한 뷰
--뷰에 그룹함수 사용하기
create view v_emp_salary
as
select dno,sum(salary) as "sal_sum" , avg(salary) as "sal_avg"
from emp_second group by dno;
select * from v_emp_salary;

--뷰 제거
drop view v_emp_job;


--다양한 뷰 옵션

--or replace
create or replace view v_emp_job2 
as select eno,ename,dno,job from emp_second where job like 'MANAGER';

select * from v_emp_job2;

--force 
create or replace force view v_emp_notable
as
select eno,ename,dno,job
from emp_notable where job like 'MANAGER';

--with check option
create or replace view v_emp_job_chk
as
select eno,ename,dno,job
from emp_second where job like 'MANAGER' with check option;

insert into v_emp_job_chk values(9000,'윤정환',30,'MANAGER');

--with read only
create or replace view v_emp_job_readonly
as 
select eno,ename,dno,job
from emp_second where job like 'MANAGER' with read only;
