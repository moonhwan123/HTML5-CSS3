--chapter.15

--프로시져 생성
create procedure sp_salary
is
v_salary employee.ename%type;
begin
    select salary into v_salary
    from employee
    where ename='SCOTT';
    dbms_output.put_line('SCOTT의 급여는 '||v_salary);
end;

--프로시져 실행
execute sp_salary;

--프로시져 조회
select name,text from user_source
where name like ('%sp_salary_ename2%');

--프로시져 삭제
drop procedure sp_salary_ename;


--IN 매개변수 (호출 할 때 사용)
create procedure sp_salary_ename(v_ename in employee.ename%type)
is
v_salary employee.salary%type;
begin
    select salary into v_salary
    from employee
    where ename=v_ename;
    DBMS_OUTPUT.PUT_LINE(v_ename || '의 급여는' || v_salary);
end;
/

execute sp_salary_ename('SCOTT');


--OUT 매개변수
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

--OUT매개변수로 프로시져 결과 값 얻어오기
variable v_salary varchar2(14);
execute sp_salary_ename2('SCOTT',:v_salary);
print v_salary;


---------------------------------------------------------------------------------------------------------------

--FUNCTION  
--함수는 실행환경에 매개변수를 사용하지 않고 결과 값을 돌려 주기 위한 용도로 사용된다.

--함수 생성
create or replace function fn_salary_ename(
    v_ename in employee.ename%type
)
return number --return될 데이터타입을 지정 해준다.
is
    v_salary number(7,2);
begin
    select salary into v_salary
    from employee where ename = v_ename;
    return v_salary;
end;
/

--함수 결과값 얻어오기
variable v_salary number;
execute :v_salary := fn_salary_ename('SCOTT');
print v_salary;


----------------------------------------------------------------------------
--TRIGGER

--연습용 테이블
create table dept_original
as
select * from department where 0=1;

create table dept_copy
as
select * from department where 0=1;

desc dept_original;

--Trigger 생성
set SERVEROUTPUT ON
create trigger trigger_sample1
    AFTER insert
    on dept_original
    for each row
begin
    if inserting then
        DBMS_OUTPUT.PUT_LINE('Insert Trigger 발생');
        insert into dept_copy values(:new.dno, :new.dname, :new.loc); --new는 임시테이블 , 인서트가 수행되고 난 이후의 데이터가 저장
    end if;
end;
/

insert into dept_original values(10, 'ACCOUNTING', 'NEW YORK');
 
--삭제시 수행될 트리거
set SERVEROUTPUT ON
create or replace trigger trigger_sample2
    after delete
    on dept_original
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('Delete Trigger 발생');
    delete from dept_copy
    where dept_copy.dno = :old.dno; --old또한 임시 테이블 삭제가 수행되기 전에 데이터가 저장되어 있다.
end;
/

delete dept_original where dno = 10;