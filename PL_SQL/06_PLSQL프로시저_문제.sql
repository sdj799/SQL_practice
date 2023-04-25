
/*
프로시저명 guguProc
구구단 을 전달받아 해당 단수를 출력하는 procedure을 생성하세요. 
*/

CREATE OR REPLACE PROCEDURE guguProc
    (dan IN NUMBER) 
IS
BEGIN
    dbms_output.put_line('***'|| dan || '단***');
    FOR i IN 1..9
    LOOP
        dbms_output.put_line(dan || ' x ' || i || ' = ' || i*dan);
    END LOOP;
END;

EXEC guguProc(14);
/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/
ALTER TABLE depts ADD CONSTRAINT dept_px PRIMARY KEY(department_id);

CREATE OR REPLACE PROCEDURE depts_proc
    (p_dep_id IN depts.department_id%TYPE,
    p_dep_name IN depts.department_name%TYPE,
    p_flag IN VARCHAR2)
IS
    v_cnt NUMBER := 0;
BEGIN

    SELECT count(*)
    INTO v_cnt FROM depts
    WHERE department_id = p_dep_id;
    IF p_flag = 'I' THEN 
        INSERT INTO depts
        (department_id, department_name)
        VALUES(p_dep_id, p_dep_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts 
        SET department_name = p_dep_name
        WHERE department_id = p_dep_id;
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('삭제하고자 하는 부서가 존재하지 않습니다.');
            RETURN;
        END IF;
        DELETE FROM depts
        WHERE department_id = p_dep_id;
    ELSE
        dbms_output.put_line('해당 flag에 대한 동작이 준비되지 않았습니다.');
    END IF;
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('예외가 발생했습니다.');
        dbms_output.put_line('ERROR MSG: ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(321234,'오락부', 'D');

SELECT* FROM depts;
/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/

CREATE OR REPLACE PROCEDURE emp_hire_proc
    (p_emp_id IN employees.employee_id%TYPE,
    p_year OUT NUMBER)
IS
    v_hire_date DATE;
BEGIN
    SELECT
         hire_date
    INTO  v_hire_date
    FROM employees
    WHERE employee_id = p_emp_id;
    
    p_year := TRUNC((sysdate - v_hire_date)/365);
    
EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line(p_emp_id || '은(는) 없는 데이터 입니다.');
    RETURN;
END;

DECLARE
    v_year NUMBER;
BEGIN
    emp_hire_proc(135, v_year);
    dbms_output.put_line(v_year);
END;

/*
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
*/
CREATE OR REPLACE PROCEDURE new_emp_proc
    (p_emp_id IN employees.employee_id%TYPE,
    p_last_name IN employees.last_name%TYPE,
    p_email IN employees.email%TYPE,
    p_hire_date IN employees.hire_date%TYPE,
    p_job_id IN employees.job_id%TYPE)
IS
BEGIN
    MERGE INTO emps a
    USING (SELECT p_emp_id as employee_id FROM dual) b
        ON (a.employee_id = b.employee_id)
    WHEN MATCHED THEN
        UPDATE SET 
        a.last_name = p_last_name,
        a.email = p_email,
        a.hire_date = p_hire_date,
        a.job_id = p_job_id
    WHEN NOT MATCHED THEN
    INSERT (employee_id, last_name, email, hire_date, job_id)
    VALUES (p_emp_id, p_last_name, p_email, p_hire_date, p_job_id);
END;

EXEC new_emp_proc(100, 'kim', 'abc1234', sysdate, 'test');