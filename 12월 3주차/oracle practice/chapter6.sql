--chapter.6 JOIN

--NATURAL JOIN(equi join)

--���� Į���� ���̺� ��Ī ���x
select e.eno, e.ename, d.dname , e.dno
from employee e natural join department d
where e.eno = 7799;

select e.eno, e.ename, d.dname , dno
from employee e natural join department d
where e.eno = 7788;

select e.eno, e.ename, d.dname, dno from employee e join department d
using(dno) 
where e.eno = 7788;

select e.eno, e.ename, d.dname, e.dno from employee e join department d
on e.dno = d.dno 
where e.eno = 7788;


--NATURAL JOIN(non-equi join)
select ename,salary,grade from employee,salgrade
where salary between losal and hisal;

select e.ename,d.dname,e.salary,s.grade
from employee e , department d, salgrade s
where e.dno = d.dno and salary between losal and hisal;


--SELF JOIN
select employees.ename as ����̸� , manager.ename as ���ӻ���̸�
from employee employees , employee manager
where employees.manager = manager.eno;

select ee.ename || '�� ���ӻ���� ' || ma.ename
from employee ee join employee ma 
on ee.manager=ma.eno;


--OUTER JOIN
select ee.ename || '�� ���ӻ���� ' || ma.ename
from employee ee join employee ma 
on ee.manager=ma.eno(+);

select ee.ename || '�� ���ӻ���� ' || ma.ename
from employee ee left outer join employee ma 
on ee.manager=ma.eno;