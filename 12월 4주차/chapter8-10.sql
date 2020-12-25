--chapter.8

--user_ 데이터 사전
select table_name from user_tables;

--all_ 데이터 사전
select owner,table_name from all_tables;

--DBA_ 데이터 사전
select owner,table_name from dba_tables;

-------------------------------------------------------------------------------------------

--chapter.9
--데이터 조작, 트랜잭션

--테이블 구조만 복사하여 새로운 테이블 생성
create table dept_copy as select * from department
where 0=1;

select * from dept_copy;

insert into dept_copy values(10,'ACCOUNTING','NEW YORK');

commit;

insert into dept_copy (dno,loc,dname) values(20,'DALLAS','RESEARCH');

--NULL 삽입방법(암시적,명시적,공백)
insert into dept_copy (dno,dname) values(30,'SALES');
insert into dept_copy values(40,'OPERATIONS',NULL);
insert into dept_copy values(50,'COMPUTING','');


create table emp_copy as select eno,ename,job,hiredate,dno from employee where 0=1;

select * from emp_copy;

insert into emp_copy values(7000,'CANDY','MANAGER','2015/05/01',10);
insert into emp_copy values(7000,'CANDY','MANAGER',to_date('2012,05,01','YYYY,MM,DD'),10);
insert into emp_copy values(7020,'JERRY','SALESMAN',sysdate,10);

--다른 테이블에서 데이터 복사
create table dept_copy2 as select * from department where 0=1;
insert into dept_copy2 select * from department;
select * from dept_copy2;

--update
select * from dept_copy;
update dept_copy set dname='PROGRAMING' where dno=10;

update dept_copy set loc=(select loc from dept_copy2 where dno=20)
where dno=10;

--delete
delete dept_copy where dno=10;
delete dept_copy;
delete emp_copy where dno=(select dno from department where dname='SALES');

select * from dept_copy;

rollback;

------------------------------------------------------------------------------------------------------------------
--chapter.10

--not null
create table customer(
    id varchar(20) not null,
    pwd varchar2(20) not null,
    phone varchar(30)    
);

--unique
create table customer(
    id varchar(20) unique,
    pwd varchar2(20) not null,
    phone varchar(30)    
);

--이름 지정
create table customer(
    id varchar(20) CONSTRAINT cus_id_uk unique,
    pwd varchar2(20) not null,
    phone varchar(30)    
);

--기본키 제약조건
create table customer(
    id varchar(20) CONSTRAINT cus_id_uk unique,
    pwd varchar2(20) not null,
    phone varchar(30),
    CONSTRAINT customer_id_pk primary key (id)
);

--외래키 제약조건
create table emp_second(
    eno number(4) constraint emp_se_eno_pk primary key,
    ename varchar2(10),
    job varchar2(9),
    dno number(2) constraint emp_se_dno_fk references department
);

--check 제약조건
create table emp_second(
    eno number(4) constraint emp_se_eno_pk primary key,
    ename varchar2(10),
    job varchar2(9),
    dno number(2) constraint emp_se_dno_ck check(dno>0)
);

--DEFAULT 제약조건
create table emp_second(
    eno number(4) constraint emp_se_eno_pk primary key,
    ename varchar2(10),
    job varchar2(9),
    dno number(2) default 1000
);


--제약 조건 추가
alter table emp_copy add constraint emp_pk primary key (eno);
alter table emp_copy add CONSTRAINT emp_fk foreign key(dno) REFERENCES dept_copy(dno);
alter table emp_copy modify ename constraint ename_nn not null;

--제약 조건 제거
alter table emp_copy drop primary key;
alter table dept_copy drop primary key cascade;
alter table emp_copy drop constraint emp_copy_ename_nn;

--제약조건 활성화/비활성화
alter table emp_copy disable constraint emp_copy_dno_fk;
alter table emp_copy enable constraint emp_copy_dno_fk;
