--chapter.13

--���� ����
create user usertest01 IDENTIFIED BY pass1;

conn usertest01/pass1;

--��� ������ ���� �ο�
grant create session to usertest01;


--���̺� ���� ���� �ο�
grant create table to usertest01;

--QUOTA�ο�
alter user usertest01 quota 2m on users;

--usertest01���� ������̺� ��ȸ ���� �ο�
grant select on hr.employee to usertest01;

--���� ��� ����
alter user usertest01 identified by 123456;

--���� ����
revoke create session from usertest01;

--with grant option
create user user02 identified by pass2;
create user user03 identified by pass3;

grant create session , create table, create view to user02;
grant create session , create table, create view to user03;

grant select on hr.employee to user02 with grant option;
conn user02/pass2;
--user02�� usertest01���� ���� �°�
grant select on hr.employee to usertest01;

--public 
--��� ��������� ���Ѻο�
grant select on hr.department to public;

--role�� �̿��� ���� �ο� (DBA,CONNECT,RESOURCE)
create user uesrtest04 identified by pass4;
grant connect to uesrtest04;
grant resource to uesttest04;

--role create
create role roletest01;
grant create session, create table, create view to roletest01;
grant roletest01 to uesrtest01;

--���� ����Ȯ�� �ϱ�
select * from user_role_privs;

--role drop
drop role roletest01;