-- chapter 5

--count�Լ�
select count(*) as "�����" from employee;
select count(commission)as "Ŀ�̼� �޴� �����" from employee;
select count(commission)as "Ŀ�̼� �޴� �����" from employee where commission is not null; --���� ������ ���
select count(DISTINCT job)as "���� ���� ����" from employee;
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