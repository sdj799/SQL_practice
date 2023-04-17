--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
--EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT *
FROM employees e
JOIN departments d
ON e.DEPARTMENT_ID = d.department_id;

SELECT *
FROM employees e
LEFT JOIN departments d
ON e.DEPARTMENT_ID = d.department_id; -- 107��

SELECT *
FROM employees e
RIGHT JOIN departments d
ON e.DEPARTMENT_ID = d.department_id; -- 122��

SELECT *
FROM employees e
FULL OUTER JOIN departments d
ON e.DEPARTMENT_ID = d.department_id; -- 123��

--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�

SELECT 
CONCAT(e.first_name, e.last_name) as �̸�,
d.department_name
FROM employees e
JOIN departments d
ON e.DEPARTMENT_ID = d.department_id
WHERE e.employee_id = 200;

--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����Ǿ� �ִ��� Ȯ��

SELECT 
e.FIRST_NAME,
e.job_id,
j.job_title
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
ORDER BY e.FIRST_NAME;

--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.

SELECT *
FROM jobs j
LEFT JOIN job_history jh
ON j.job_id = jh.job_id;

--���� 5.
--Steven King�� �μ����� ����ϼ���.

SELECT 
CONCAT(e.first_name, e.last_name),
d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE CONCAT(e.FIRST_NAME, e.LAST_NAME) = 'StevenKing';

--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���

SELECT *
FROM employees
CROSS JOIN departments;

--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)

SELECT
e.employee_id, e.first_name, e.salary,
d.department_name,
l.city
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE e.job_id = 'SA_MAN';
--���� 8.
-- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.

SELECT *
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
WHERE j.job_title IN('Stock Mnanager', 'Stock Clerk');

--���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT
d.department_name
FROM departments d
LEFT JOIN employees e
ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.

SELECT
e.first_name,
e2.first_name AS manager_name
FROM employees e
JOIN employees e2
ON e.manager_id = e2.employee_id;

--���� 11. 
--6. EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���

SELECT
e.employee_id, e.first_name, e.manager_id,
e2.first_name, e2.salary
FROM employees e
LEFT JOIN employees e2
ON e.manager_id = e2.employee_id
WHERE e.manager_id IS NOT NULL
ORDER BY e.salary DESC;