--chapter.15

--���ν��� ����
create procedure sp_salary
is
v_salary employee.ename%type;
begin
    select salary into v_salary
    from employee
    where ename='SCOTT';
    dbms_output.put_line('SCOTT�� �޿��� '||v_salary);
end;

--���ν��� ����
execute sp_salary;

--���ν��� ��ȸ
select name,text from user_source
where name like ('%sp_salary_ename2%');

--���ν��� ����
drop procedure sp_salary_ename;


--IN �Ű����� (ȣ�� �� �� ���)
create procedure sp_salary_ename(v_ename in employee.ename%type)
is
v_salary employee.salary%type;
begin
    select salary into v_salary
    from employee
    where ename=v_ename;
    DBMS_OUTPUT.PUT_LINE(v_ename || '�� �޿���' || v_salary);
end;
/

execute sp_salary_ename('SCOTT');


--OUT �Ű�����
create procedure sp_salary_ename2(
    v_ename in employee.ename%type,
    v_salary out employee.salary%type
)
is
begin
    select salary into v_salary
    from employee where ename = v_ename;
end;
/

--OUT�Ű������� ���ν��� ��� �� ������
variable v_salary varchar2(14);
execute sp_salary_ename2('SCOTT',:v_salary);
print v_salary;


---------------------------------------------------------------------------------------------------------------

--FUNCTION  
--�Լ��� ����ȯ�濡 �Ű������� ������� �ʰ� ��� ���� ���� �ֱ� ���� �뵵�� ���ȴ�.

--�Լ� ����
create or replace function fn_salary_ename(
    v_ename in employee.ename%type
)
return number --return�� ������Ÿ���� ���� ���ش�.
is
    v_salary number(7,2);
begin
    select salary into v_salary
    from employee where ename = v_ename;
    return v_salary;
end;
/

--�Լ� ����� ������
variable v_salary number;
execute :v_salary := fn_salary_ename('SCOTT');
print v_salary;


----------------------------------------------------------------------------
--TRIGGER

--������ ���̺�
create table dept_original
as
select * from department where 0=1;

create table dept_copy
as
select * from department where 0=1;

desc dept_original;

--Trigger ����
set SERVEROUTPUT ON
create trigger trigger_sample1
    AFTER insert
    on dept_original
    for each row
begin
    if inserting then
        DBMS_OUTPUT.PUT_LINE('Insert Trigger �߻�');
        insert into dept_copy values(:new.dno, :new.dname, :new.loc); --new�� �ӽ����̺� , �μ�Ʈ�� ����ǰ� �� ������ �����Ͱ� ����
    end if;
end;
/

insert into dept_original values(10, 'ACCOUNTING', 'NEW YORK');
 
--������ ����� Ʈ����
set SERVEROUTPUT ON
create or replace trigger trigger_sample2
    after delete
    on dept_original
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('Delete Trigger �߻�');
    delete from dept_copy
    where dept_copy.dno = :old.dno; --old���� �ӽ� ���̺� ������ ����Ǳ� ���� �����Ͱ� ����Ǿ� �ִ�.
end;
/

delete dept_original where dno = 10;