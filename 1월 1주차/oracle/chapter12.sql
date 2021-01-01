--Chapter.12 

--시퀀스생성
create sequence sample_seq increment by 10
start with 10;

--시퀀스 조회
select sequence_name, min_value, max_value , increment_by, cycle_flag
from user_sequences;

--시퀀스의 현재값과 다음값
select sample_seq.nextval from dual;
select sample_seq.currval from dual;

--시퀀스를 기본키에 접목하기
create sequence dno_seq INCREMENT by 10 start with 10;

insert into dept_second values(dno_seq.nextval,'ACCOUNTING','NEW YORK');

--dno_seq의 최대값 확인
select sequence_name, min_value, max_value , increment_by, cycle_flag
from user_sequences where sequence_name in ('DNO_SEQ');

--시퀀스 최대값 변경
alter sequence dno_seq maxvalue 50;

--시퀀스 제거
drop sequence dno_seq;

-------------------------------------------------------------------------------------

--employee,department 테이블에 자동 생성된 인덱스 살피기
select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE','DEPARTMENT');

--인덱스 생성하기
create index idx_employee_ename
on employee(ename);

--인덱스 제거하기
drop index idx_employee_ename;

--인덱스 재생성
alter index index_name rebuild;

--고유 인덱스 지정하기
create unique index idx_dept_dno
on dept_second(dno);

--결합 인덱스
create index idx_dept_com on dept_second(dname,loc);

--함수 기반 인덱스
create index idx_emp_second_annsal on emp_second(salary*12);

