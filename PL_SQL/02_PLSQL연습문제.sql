
-- 1. 구구단 중 3단을 출력하는 익명 블록을 만들어 보자. (출력문 9개를 복사해서 쓰세요)


-- 2. employees 테이블에서 201번 사원의 이름과 이메일 주소를 출력하는
-- 익명블록을 만들어 보자. (변수에 담아서 출력하세요.)


-- 3. employees 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤 (MAX 함수 사용)
-- 이 번호 + 1번으로 아래의 사원을 emps 테이블에
-- employee_id, last_name, email, hire_date, job_id를 신규 삽입하는 익명 블록을 만드세요.
-- SELECT절 이후에 INSERT문 사용이 가능합니다. 
/*
<사원명>: steven
<이메일>: stevenjobs
<입사일자>: 오늘날짜
<JOB_ID>: CEO
*/
DROP TABLE emps;
CREATE TABLE emps AS (SELECT * FROM employees WHERE 1=2);
-- 문제 1
DECLARE
    dan3 NUMBER := 3;
BEGIN
    DBMS_OUTPUT.put_line('3 x 1 = ' || TO_CHAR(dan3));
    DBMS_OUTPUT.put_line('3 x 2 = ' || TO_CHAR(dan3*2));
    DBMS_OUTPUT.put_line('3 x 3 = ' || TO_CHAR(dan3*3));
    DBMS_OUTPUT.put_line('3 x 4 = ' || TO_CHAR(dan3*4));
    DBMS_OUTPUT.put_line('3 x 5 = ' || TO_CHAR(dan3*5));
    DBMS_OUTPUT.put_line('3 x 6 = ' || TO_CHAR(dan3*6));
    DBMS_OUTPUT.put_line('3 x 7 = ' || TO_CHAR(dan3*7));
    DBMS_OUTPUT.put_line('3 x 8 = ' || TO_CHAR(dan3*8));
    DBMS_OUTPUT.put_line('3 x 9 = ' || TO_CHAR(dan3*9));
END;

-- 문제 2

DECLARE
    v_emp_name employees.first_name%TYPE;
    v_email employees.email%TYPE;
BEGIN
    SELECT first_name, email
    INTO v_emp_name, v_email
    FROM employees
    WHERE employee_id = 201;
    DBMS_OUTPUT.put_line(v_emp_name);
    DBMS_OUTPUT.put_line(v_email);
END;
-- 문제 3
DECLARE
    v_emp_id employees.employee_id%TYPE;
    v_emp_name employees.last_name%TYPE := 'steven';
    v_email employees.email%TYPE := 'stevenjobs';
    v_hire_date employees.hire_date%TYPE := sysdate;
    v_job_id employees.job_id%TYPE := 'CEO';
BEGIN
    SELECT MAX(employee_id)+1
    INTO v_emp_id
    FROM employees;
    INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
    VALUES(
    v_emp_id, v_emp_name, v_email, v_hire_date, v_job_id);        
    COMMIT;
END;
SELECT * FROM emps;