
-- 이너(내부) 조인
SELECT *
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id;

-- 오라클 문법 (잘 사용 안합니다.)
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;

-- auth_id 컬럼을 그냥 쓰면 모호하다 라고 뜹니다.
-- 그 이유는 양쪽 테이블에 모두 존재하기 때문입니다.
-- 이럴 때는, 컬럼에 테이블 이름을 붙이던지, 별칭을 쓰셔서
-- 확실하게 지목을 해주세요.
SELECT 
    i.auth_id, i.title, i.content, a.name
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id;