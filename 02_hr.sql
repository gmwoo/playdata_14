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

/* 사원 테이블에서 급여가 1500~5000 이고 직무가 PRESIDENT나 ANALYST가 아닌 모든 사원에 대해
사원, 이름, 직무, 급여를 출력 */
SELECT  empno, ename, job, sal
FROM    emp
WHERE   sal between 1500 and 5000
and     job in ('PRESIDENT', 'ANALYST');

/* LIKE 연산자 */
SELECT  name, grade, deptno
FROM    student
WHERE   name LIKE '김%';

/* 이름이 '영'으로 끝나는 학생 */ 
SELECT  name, grade, deptno
FROM    student
WHERE   name LIKE '%영';

SELECT  name, grade, deptno
FROM    student
WHERE   name LIKE '김_영';

/* 학생 테이블에서 여학생의 이름, 학년, 학과번호, 주민등록번호 출력 */
SELECT  name, grade, deptno, idnum
FROM    student
WHERE   idnum LIKE '______2%';

/* escape 옵션 - insert */
insert into student (studno, name)
values(33333, '황보_정호');
select * from student;

select  name
from    student
where   name like '황보\_%' escape '\';

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

/* 사원 테이블에서 커미션을 받지 않고 급여가 2500 이상인 사원의 이름의 세번째 A를 포함하는 사원의 이름,
급여, 커미션 출력 */
SELECT  ename, sal, comm
FROM    emp
WHERE   comm is null
and     sal >= 2500
and     ename LIKE '__A%';

/* employee 테이블에서 커미션을 받지 않고 급여가 2500 이상, 이름의 세번째 e를 포함한
사원의 이름, 급여, 커미션 */
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

/* 집합 연산 */
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

/* 학생 테이블과 교수 테이블에 대해 UNION 연산을 수행하여 NAME, USERID, SAL 출력
SAL 없으면 0으로 출력. 전체 인원수 확인 */
SELECT  name, userid, 0 sal
FROM    student
UNION
SELECT  name, userid, sal
FROM    professor;

/* 교집합 */
SELECT  name    FROM    stud_heavy
intersect
SELECT  name    FROM    stud_101;

/* 차집합 */
SELECT  studno 학번, name 이름
FROM    stud_heavy
MINUS
SELECT  studno, name
FROM    stud_101;

SELECT  studno 학번, name 이름
FROM    stud_101
MINUS
SELECT  studno, name
FROM    stud_heavy;

/* 교수 테이블에서 전체 교수의 급여를 인상하기 위한 직원 명단을 출력하고자 함
MINUS 연산을 사용하여 직급이 전임강사인 사람들은 명단에서 제외 */

SELECT  name, position, sal
FROM    professor
MINUS
SELECT  name, position, sal
FROM    professor
WHERE   position = '전임강사';

SELECT  name, position, sal
FROM    professor
WHERE   position <> '전임강사';

/* 정렬 order by */
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


/* 사원 테이블에서 급여가 1000~5000 이고 직무가 president나 analyst가 아니면서
보너스는 급여의 10% 이상인 모든 사원에 대해 job 내림차순, sal 내림차순 출력 */
SELECT  empno 사번, ename "사원의 이름", job 직무, sal 급여
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

/* 오라클이 생성될 때 데이터 딕셔너리에 자동 생성, 모든 사용자들의 접근 허용
sys가 소유한 테이블 데이터가 있는 테이블에서 유래하지 않는 상수값, 의사열, 표현식 등의
값을 단 한 번만 돌리거나 현재 날짜, 시각을 알고자 할 때 일시적 산술, 날짜 연산 등에 주로 사용 */

SELECT sysdate -1 Yesterday, sysdate Today, sysdate +1 Tomorrow
From dual;

/* ---- 함수 ----  */
select name, userid, INITCAP(userid)
FROM student
WHERE name = '김영균';

/* 'Smith' 사원이 있는지 확인하고 있으면 사번, 이름 출력 */
SELECT empno, ename
FROM emp
WHERE INITCAP(ename) = 'Smith';

/* Lower, Upper - 대소문자 */
SELECT userid, LOWER(userid), UPPER(userid)
FROM student
WHERE studno = 20101;

/* manager들만 이름, job, deptno를 ename 순으로 출력 */
SELECT ename, job, deptno
FROM emp
WHERE LOWER(job) = 'manager'
Order By ename;

SELECT dname, LENGTH(dname), LENGTHB(dname)
FROM department;


/*현재 캐릭터셋 확인*/
SELECT *
FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';


/* 문자 조작 함수 */
SELECT concat(concat(concat(name, '의 직책은 '),position), '이다.')
FROM professor;

SELECT name, idnum, SUBSTR(idnum, 1, 6) birth_date, SUBSTR(idnum,3,2) birth_mon
FROM student
WHERE grade = '1';

SELECT name, idnum, SUBSTR(idnum, 1, 6) birth_date, SUBSTR(idnum,3,2) birth_mon
FROM student
WHERE grade = '1'
and SUBSTR(idnum, 7, 1) = 2;

/* 이름이 J,A 또는 M으로 시작하는 모든 사원에 대해서 첫 번째 문자는 대문자로
그리고 나머지는 모두 소문자로 나타나는 사원의 이름과 이름 길이를 출력
각 열에 Name, Length 라는 레이블 부여*/
SELECT INITCAP(ename) "Name", INITCAP(LENGTH(ename)) "Length"
FROM emp
WHERE SUBSTR(ename, 1, 1) IN ('J', 'A', 'M');

SELECT dname, INSTR(dname, '과')
FROM department;

SELECT position, LPAD(position, 10, '*') lpad_position, userid,
    RPAD(userid, 12, '+') rpad, userid
FROM professor;

SELECT LTRIM('xyxXxyLASTWORD','xy')
FROM DUAL;

SELECT RTRIM('TURNERyxXxy','xy')
FROM DUAL;

SELECT dname, RTRIM(dname, '과')
FROM department;

/* ---- 숫자 함수 ---- */
SELECT name, sal, sal/22, ROUND(sal/22), ROUND(sal/22, 2),
        ROUND(sal/22, -1), TRUNC(sal/22, -1)
FROM professor
WHERE deptno = 101;

SELECT name, sal, comm, MOD(sal, comm)
FROM professor
WHERE deptno = 101;

SELECT CEIL(19.7), FLOOR(12.345)
FROM dual;

/* ---- 날짜 함수 ---- */

SELECT name, hiredate, hiredate+30, hiredate+60
FROM professor
WHERE profno = 9908;

SELECT profno, hiredate, MONTHS_BETWEEN(SYSDATE, hiredate) TENURE,
        ADD_MONTHS(hiredate, 6) REVIEW
FROM professor
WHERE MONTHS_BETWEEN(SYSDATE, hiredate) < 360;


/* ---- 문제 ---- */
SELECT userid, name, grade, deptno
FROM student
WHERE SUBSTR(name, 3, 1) = '진'
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