-- 1.문자 함수

-- 1.1 대소문자 변환 함수
select 'Oracle mania',upper('Oracle mania'),lower('Oracle mania'),initcap('Oracle mania') from dual;
select ename,lower(ename),job,initcap(job) from employee;
select eno,ename,dno from employee where ename='scott';
select eno,ename,dno from employee where lower(ename)='scott';
select eno,ename,dno from employee where initcap(ename)='Scott';

-- 1.2 문자 길이를 반환하는 함수
select length('OracleMania'),length('오라클매니아') from dual;
select lengthb('OracleMania'),lengthb('오라클매니아') from dual;

-- 1.3 문자 조작 함수
select 'Oracle' , 'mania' , concat('Oracle','Mania') from dual;
select substr('Oracle mania',4,3),substr('Oracle mania',-4,3) from dual;
select * from employee where substr(ename,-1,1) = 'N';
select * from employee where substr(hiredate,1,2) = '87';
select * from employee where instr(ename,'R',3,1)=3;
select LPAD(salary,10,'*') from employee;
select RPAD(salary,10,'*') from employee;
select TRIM('  OracleMania  ') from dual;

-- 2.숫자함수
select 98.7654, round(98.7654), round(98.7654,2), round(98.7654,-1) from dual;
select 98.7654, trunc(98.7654), trunc(98.7654,2), trunc(98.7654,-1) from dual;
select MOD(31,2), mod(31,5) ,mod(31,8) from dual;
select ename,salary,mod(salary,500) from employee;

-- 3.날짜함수
select sysdate from dual;
select sysdate-1 어제, sysdate 오늘 , sysdate+1 내일 from dual;
select ename,round(sysdate-hiredate)as 근무일수 from employee;
select hiredate,trunc(hiredate,'MONTH') from employee;
select ename,sysdate,hiredate,round(MONTHS_BETWEEN(sysdate,hiredate)) from employee;
select ename,hiredate,ADD_MONTHS(hiredate,6) from employee;
select sysdate,next_day(sysdate,6) from dual;
select ename,hiredate,last_day(hiredate) from employee;

-- 4.형 변환 함수
select ename,hiredate,to_char(hiredate,'YY-MM'),to_char(hiredate,'YYYY/MM/DD DAY') from employee;
select to_char(sysdate,'YYYY/MM/DD,HH24:MI:SS') from dual;
select ename,to_char(salary,'L999,999') from employee;
select ename,hiredate from employee where hiredate=19810220;
select ename,hiredate from employee where hiredate=to_date(19810220,'YYYYMMDD');
select to_number('100,000','999,999') - to_number('50,000','999,999') from dual;

-- 5.일반 함수

-- 5.1 NVL함수
select ename,salary,commission,nvl(commission,0),salary*12+nvl(commission,0)
from employee
order by job;

select ename,salary,commission,nvl2(commission,salary*12+commission,salary*12)
from employee
order by job;

select nullif('A','A'),nullif('A','B') from dual;

select ename,salary,commission,coalesce(commission,salary,0)
from employee order by job;

select ename,dno,decode(
    dno,10,'ACCOUNTING',
    20,'RESEARCH',
    30,'SALES',
    40,'OPERATION',
    'DEFAULT'
)as dname
from employee order by dno;

select ename,dno,
    case when dno=10 then 'ACCOUNTING'
         when dno=20 then 'RESEARCH'
         when dno=30 then 'SALES'
         when dno=40 then 'OPERATION'
         else 'DEFAULT'
    end as dname
from employee order by dno;