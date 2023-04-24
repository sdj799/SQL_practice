
-- 1. ������ �� 3���� ����ϴ� �͸� ����� ����� ����. (��¹� 9���� �����ؼ� ������)


-- 2. employees ���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ�
-- �͸����� ����� ����. (������ ��Ƽ� ����ϼ���.)


-- 3. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps ���̺�
-- employee_id, last_name, email, hire_date, job_id�� �ű� �����ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT�� ����� �����մϴ�. 
/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
<JOB_ID>: CEO
*/
DROP TABLE emps;
CREATE TABLE emps AS (SELECT * FROM employees WHERE 1=2);
-- ���� 1
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

-- ���� 2

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
-- ���� 3
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