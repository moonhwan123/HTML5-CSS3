--chapter.6 연습문제

-- 1.
select e.ename, d.dno , d.dname
from employee e , department d
where e.dno = d.dno and e.ename='SCOTT';

select e.ename, dno , d.dname
from employee e natural join department d
where e.ename='SCOTT';


-- 2.
select e.ename, d.loc , d.dname
from employee e join department d
on e.dno = d.dno;

-- 3.
select dno, job , loc
from employee inner join department
using(dno)
where dno = 10;


-- 4.
select e.ename,d.dname,d.loc
from employee e natural join department d
where e.commission is not null and e.commission != 0;

-- 5.
select e.ename , d.dname
from employee e , department d
where e.dno = d.dno and e.ename like '%A%';

-- 6.
select ename, job, dno, dname
from employee natural join department 
where loc = 'NEW YORK';

-- 7.
select e.ename , e.eno , m.ename , m.eno
from employee e , employee m
where e.manager = m.eno;

-- 8.
select e.ename , e.eno , m.ename , m.eno
from employee e , employee m
where e.manager = m.eno(+)
order by e.eno desc;


-- 9.
select e.ename , e.dno , n.ename as 동료
from employee e , employee n
where e.dno = n.dno and e.ename='SCOTT' and n.ename != 'SCOTT';

-- 10.
select * from employee;

select e.ename, e.hiredate from employee e , employee w
where w.hiredate < e.hiredate and 'WARD' = w.ename
order by e.hiredate;

-- 11.
select e.ename , e.hiredate , m.ename , m.hiredate
from employee e , employee m 
where e.manager = m.eno and e.hiredate <= m.hiredate;