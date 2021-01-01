--Chapter.12 

--����������
create sequence sample_seq increment by 10
start with 10;

--������ ��ȸ
select sequence_name, min_value, max_value , increment_by, cycle_flag
from user_sequences;

--�������� ���簪�� ������
select sample_seq.nextval from dual;
select sample_seq.currval from dual;

--�������� �⺻Ű�� �����ϱ�
create sequence dno_seq INCREMENT by 10 start with 10;

insert into dept_second values(dno_seq.nextval,'ACCOUNTING','NEW YORK');

--dno_seq�� �ִ밪 Ȯ��
select sequence_name, min_value, max_value , increment_by, cycle_flag
from user_sequences where sequence_name in ('DNO_SEQ');

--������ �ִ밪 ����
alter sequence dno_seq maxvalue 50;

--������ ����
drop sequence dno_seq;

-------------------------------------------------------------------------------------

--employee,department ���̺� �ڵ� ������ �ε��� ���Ǳ�
select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE','DEPARTMENT');

--�ε��� �����ϱ�
create index idx_employee_ename
on employee(ename);

--�ε��� �����ϱ�
drop index idx_employee_ename;

--�ε��� �����
alter index index_name rebuild;

--���� �ε��� �����ϱ�
create unique index idx_dept_dno
on dept_second(dno);

--���� �ε���
create index idx_dept_com on dept_second(dname,loc);

--�Լ� ��� �ε���
create index idx_emp_second_annsal on emp_second(salary*12);

