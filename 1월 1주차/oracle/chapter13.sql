--chapter.13

--유저 생성
create user usertest01 IDENTIFIED BY pass1;

conn usertest01/pass1;

--디비에 접속할 권한 부여
grant create session to usertest01;


--테이블 생성 권한 부여
grant create table to usertest01;

--QUOTA부여
alter user usertest01 quota 2m on users;

--usertest01에게 사원테이블 조회 권한 부여
grant select on hr.employee to usertest01;

--유저 비번 변경
alter user usertest01 identified by 123456;

--권한 제거
revoke create session from usertest01;

--with grant option
create user user02 identified by pass2;
create user user03 identified by pass3;

grant create session , create table, create view to user02;
grant create session , create table, create view to user03;

grant select on hr.employee to user02 with grant option;
conn user02/pass2;
--user02가 usertest01에게 권한 승계
grant select on hr.employee to usertest01;

--public 
--모든 사용제에게 권한부여
grant select on hr.department to public;

--role을 이용한 권한 부여 (DBA,CONNECT,RESOURCE)
create user uesrtest04 identified by pass4;
grant connect to uesrtest04;
grant resource to uesttest04;

--role create
create role roletest01;
grant create session, create table, create view to roletest01;
grant roletest01 to uesrtest01;

--권한 정보확인 하기
select * from user_role_privs;

--role drop
drop role roletest01;