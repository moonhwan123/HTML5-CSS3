--chapter.11

create table emp_second as select * from employee;
create table dept_second as select * from department;

--view ����(���Ϻ�)
create view v_emp_job(���,����̸�,�μ���ȣ,������)
as select eno,ename,dno,job
from emp_second where job like 'SALESMAN';

create view v_emp_job2
as select eno,ename,dno,job
from emp_second where job like 'SALESMAN';

--view ����
select * from v_emp_job;
select * from v_emp_job2;

--view ����(���պ�)
create view v_emp_complex
as select * from emp_second natural join dept_second;

select * from  v_emp_complex;

--������ ���� �� Ȱ��(�޿� ����)
create view v_emp_sample as select eno,ename,job,manager,dno
from emp_second;

select * from  v_emp_sample;

create view v_emp_complex2 as 
select e.eno, e.ename, e.salary,dno,d.dname,d.loc
from emp_second e natural join dept_second d;

select * from  v_emp_complex2;

select * from USER_VIEWS;

--USER_VIEWS ������ ����
select view_name,text from user_views;
--view�� select���� �̸��� ���ΰ�

--view�� ���� �⺻���̺� ������ �߰��ϱ�
insert into v_emp_job values(8000,'����ȭ',30,'SALESMAN');
select * from v_emp_job;
select * from emp_second;

--�پ��� ��
--�信 �׷��Լ� ����ϱ�
create view v_emp_salary
as
select dno,sum(salary) as "sal_sum" , avg(salary) as "sal_avg"
from emp_second group by dno;
select * from v_emp_salary;

--�� ����
drop view v_emp_job;


--�پ��� �� �ɼ�

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

insert into v_emp_job_chk values(9000,'����ȯ',30,'MANAGER');

--with read only
create or replace view v_emp_job_readonly
as 
select eno,ename,dno,job
from emp_second where job like 'MANAGER' with read only;
