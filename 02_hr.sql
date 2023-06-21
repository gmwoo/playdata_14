select * from student;
SELECT * FROM student;
SELECT * FROM professor;
select * from department;
select * from salgrade;
select * from tab;
select * from emp;

SELECT  name, birthdate
FROM    student
WHERE   birthdate between '81/01/01' and '83/12/31';

SELECT  name, grade, deptno
FROM    student
WHERE   deptno  IN  (102,201);

/* ��� ���̺��� �޿��� 1500~5000 �̰� ������ PRESIDENT�� ANALYST�� �ƴ� ��� ����� ����
���, �̸�, ����, �޿��� ��� */
SELECT  empno, ename, job, sal
FROM    emp
WHERE   sal between 1500 and 5000
and     job in ('PRESIDENT', 'ANALYST');

/* LIKE ������ */
SELECT  name, grade, deptno
FROM    student
WHERE   name LIKE '��%';

/* �̸��� '��'���� ������ �л� */ 
SELECT  name, grade, deptno
FROM    student
WHERE   name LIKE '%��';

SELECT  name, grade, deptno
FROM    student
WHERE   name LIKE '��_��';

/* �л� ���̺��� ���л��� �̸�, �г�, �а���ȣ, �ֹε�Ϲ�ȣ ��� */
SELECT  name, grade, deptno, idnum
FROM    student
WHERE   idnum LIKE '______2%';

/* escape �ɼ� - insert */
insert into student (studno, name)
values(33333, 'Ȳ��_��ȣ');
select * from student;

select  name
from    student
where   name like 'Ȳ��\_%' escape '\';

SELECT  empno, sal, comm
FROM    emp;

SELECT  empno, sal + comm
FROM    emp;

SELECT  empno, sal, comm, sal + comm, NVL(sal+comm, sal), NVL2(sal+comm, sal, sal)
FROM    emp;

SELECT  name, position, comm
FROM    professor;

SELECT  name, position, comm
FROM    professor
WHERE   comm = NULL;

SELECT  name, position, comm
FROM    professor
WHERE   comm is null;

/* ��� ���̺��� Ŀ�̼��� ���� �ʰ� �޿��� 2500 �̻��� ����� �̸��� ����° A�� �����ϴ� ����� �̸�,
�޿�, Ŀ�̼� ��� */
SELECT  ename, sal, comm
FROM    emp
WHERE   comm is null
and     sal >= 2500
and     ename LIKE '__A%';

/* employee ���̺��� Ŀ�̼��� ���� �ʰ� �޿��� 2500 �̻�, �̸��� ����° e�� ������
����� �̸�, �޿�, Ŀ�̼� */
SELECT * FROM employees;

SELECT  first_name, salary, commission_pct
FROM    employees
WHERE   commission_pct is null
and     salary >= 2500
and     first_name LIKE '__e%';

SELECT  name, sal, comm, sal+comm sal_com
FROM    professor;

SELECT  name, grade AS G, deptno
FROM    student
WHERE   deptno = 102
AND     (grade = '1'
OR      grade = '4');

/* ���� ���� */
CREATE TABLE    stud_heavy
AS SELECT *
FROM    student
WHERE   weight >=70 AND grade = '1';

CREATE TABLE    stud_101
AS SELECT *
FROM    student
WHERE   deptno = 101 AND grade = '1';

SELECT * FROM stud_heavy;
SELECT * FROM stud_101;

SELECT  studno, name
FROM    stud_heavy
UNION
SELECT  studno, name
FROM    stud_101;

SELECT  studno, name
FROM    stud_heavy
UNION ALL
SELECT  studno, name
FROM    stud_101;

/* �л� ���̺�� ���� ���̺� ���� UNION ������ �����Ͽ� NAME, USERID, SAL ���
SAL ������ 0���� ���. ��ü �ο��� Ȯ�� */
SELECT  name, userid, 0 sal
FROM    student
UNION
SELECT  name, userid, sal
FROM    professor;

/* ������ */
SELECT  name    FROM    stud_heavy
intersect
SELECT  name    FROM    stud_101;

/* ������ */
SELECT  studno �й�, name �̸�
FROM    stud_heavy
MINUS
SELECT  studno, name
FROM    stud_101;

SELECT  studno �й�, name �̸�
FROM    stud_101
MINUS
SELECT  studno, name
FROM    stud_heavy;

/* ���� ���̺��� ��ü ������ �޿��� �λ��ϱ� ���� ���� ����� ����ϰ��� ��
MINUS ������ ����Ͽ� ������ ���Ӱ����� ������� ��ܿ��� ���� */

SELECT  name, position, sal
FROM    professor
MINUS
SELECT  name, position, sal
FROM    professor
WHERE   position = '���Ӱ���';

SELECT  name, position, sal
FROM    professor
WHERE   position <> '���Ӱ���';

/* ���� order by */
SELECT  name, grade, tel
FROM    student
Order By grade desc;

SELECT  ename, job, deptno, sal
FROM    emp
Order By deptno, sal desc, ename;

SELECT  ename, job, deptno, sal 
FROM    emp
Order By 3, 4 desc, 1;

SELECT  ename, deptno
FROM    emp
WHERE   deptno IN (10, 30)
Order By ename;

SELECT  ename, hiredate
FROM    emp
WHERE   hiredate LIKE '82%';

SELECT  ename, sal, comm
FROM    emp
Order By sal desc, comm desc;

SELECT  ename, sal, comm
FROM    emp
WHERE   comm >= sal * 0.2
and     deptno = 30;


/* ��� ���̺��� �޿��� 1000~5000 �̰� ������ president�� analyst�� �ƴϸ鼭
���ʽ��� �޿��� 10% �̻��� ��� ����� ���� job ��������, sal �������� ��� */
SELECT  empno ���, ename "����� �̸�", job ����, sal �޿�
FROM    emp
WHERE   sal between 1000 and 5000
and     job not in ('PRESIDENT', 'ANALYST')
and     comm >= sal*0.1
Order By job desc, sal desc;

DESC student;

CREATE TABLE ex_type
(c  CHAR(10),   v   VARCHAR2(10));

INSERT INTO ex_type
VALUES('sql', 'sql');

SELECT  *
FROM    ex_type
WHERE c ='sql';

SELECT  *
FROM    ex_type
WHERE v ='sql';

SELECT  *
FROM    ex_type
WHERE c =v;

/* sysdate */
select sysdate from dual;

SELECT rowid, empno, ename FROM emp;

SELECT rowid, empno, ename 
FROM emp
WHERE rowid = 'AAAE5yAAEAAAAH+AAM';

/* TIMESTAMP */
CREATE TABLE ex_time
(id             NUMBER(2),
basictime       TIMESTAMP,
standardtime    TIMESTAMP WITH TIME ZONE,
localtime       TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO ex_time VALUES(1, sysdate, sysdate, sysdate);

set linesize 100
SELECT * FROM ex_time;

desc SYS.DUAL;

SELECT DUMMY FROM DUAL;

SELECT 20*30 FROM dual;

/* ����Ŭ�� ������ �� ������ ��ųʸ��� �ڵ� ����, ��� ����ڵ��� ���� ���
sys�� ������ ���̺� �����Ͱ� �ִ� ���̺��� �������� �ʴ� �����, �ǻ翭, ǥ���� ����
���� �� �� ���� �����ų� ���� ��¥, �ð��� �˰��� �� �� �Ͻ��� ���, ��¥ ���� � �ַ� ��� */

SELECT sysdate -1 Yesterday, sysdate Today, sysdate +1 Tomorrow
From dual;

/* ---- �Լ� ----  */
select name, userid, INITCAP(userid)
FROM student
WHERE name = '�迵��';

/* 'Smith' ����� �ִ��� Ȯ���ϰ� ������ ���, �̸� ��� */
SELECT empno, ename
FROM emp
WHERE INITCAP(ename) = 'Smith';

/* Lower, Upper - ��ҹ��� */
SELECT userid, LOWER(userid), UPPER(userid)
FROM student
WHERE studno = 20101;

/* manager�鸸 �̸�, job, deptno�� ename ������ ��� */
SELECT ename, job, deptno
FROM emp
WHERE LOWER(job) = 'manager'
Order By ename;

SELECT dname, LENGTH(dname), LENGTHB(dname)
FROM department;


/*���� ĳ���ͼ� Ȯ��*/
SELECT *
FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';


/* ���� ���� �Լ� */
SELECT concat(concat(concat(name, '�� ��å�� '),position), '�̴�.')
FROM professor;

SELECT name, idnum, SUBSTR(idnum, 1, 6) birth_date, SUBSTR(idnum,3,2) birth_mon
FROM student
WHERE grade = '1';

SELECT name, idnum, SUBSTR(idnum, 1, 6) birth_date, SUBSTR(idnum,3,2) birth_mon
FROM student
WHERE grade = '1'
and SUBSTR(idnum, 7, 1) = 2;

/* �̸��� J,A �Ǵ� M���� �����ϴ� ��� ����� ���ؼ� ù ��° ���ڴ� �빮�ڷ�
�׸��� �������� ��� �ҹ��ڷ� ��Ÿ���� ����� �̸��� �̸� ���̸� ���
�� ���� Name, Length ��� ���̺� �ο�*/
SELECT INITCAP(ename) "Name", INITCAP(LENGTH(ename)) "Length"
FROM emp
WHERE SUBSTR(ename, 1, 1) IN ('J', 'A', 'M');

SELECT dname, INSTR(dname, '��')
FROM department;

SELECT position, LPAD(position, 10, '*') lpad_position, userid,
    RPAD(userid, 12, '+') rpad, userid
FROM professor;

SELECT LTRIM('xyxXxyLASTWORD','xy')
FROM DUAL;

SELECT RTRIM('TURNERyxXxy','xy')
FROM DUAL;

SELECT dname, RTRIM(dname, '��')
FROM department;

/* ---- ���� �Լ� ---- */
SELECT name, sal, sal/22, ROUND(sal/22), ROUND(sal/22, 2),
        ROUND(sal/22, -1), TRUNC(sal/22, -1)
FROM professor
WHERE deptno = 101;

SELECT name, sal, comm, MOD(sal, comm)
FROM professor
WHERE deptno = 101;

SELECT CEIL(19.7), FLOOR(12.345)
FROM dual;

/* ---- ��¥ �Լ� ---- */

SELECT name, hiredate, hiredate+30, hiredate+60
FROM professor
WHERE profno = 9908;

SELECT profno, hiredate, MONTHS_BETWEEN(SYSDATE, hiredate) TENURE,
        ADD_MONTHS(hiredate, 6) REVIEW
FROM professor
WHERE MONTHS_BETWEEN(SYSDATE, hiredate) < 360;


/* ---- ���� ---- */
SELECT userid, name, grade, deptno
FROM student
WHERE SUBSTR(name, 3, 1) = '��'
and PROFNO IS NULL 
and deptno = 101;

SELECT ename, job, sal
FROM emp
WHERE job in ('MANAGER', 'SALESMAN')
and sal not in (1500, 3000, 5000)
order by sal desc;

SELECT ename, hiredate
FROM emp
WHERE SUBSTR(hiredate, 4, 2) = '02';

SELECT empno, ename, job
FROM emp
WHERE job='MANAGER';

SELECT empno, ename, sal, round(sal*1.12) "New Salary", round(sal*1.12 - sal) "Increase"
FROM emp;