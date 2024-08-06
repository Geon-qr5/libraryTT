-- 실습문제 
-- 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명을 조회
-- 오라클

SELECT  EMP_ID, EMP_NAME, BONUS, DEPT.DEPT_TITLE
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID
AND     NOT BONUS = 0
AND     BONUS IS NOT NULL;

-- ANSI

SELECT  EMP_ID, EMP_NAME, BONUS, DEPT.DEPT_TITLE
FROM    EMP
JOIN    DEPT ON (DEPT_CODE = DEPT_ID)
WHERE   NOT BONUS = 0
AND     BONUS IS NOT NULL;

-- 인사관리부가 아닌 사원들의 사원명, 부서명, 급여를 조회
-- 오라클
-- 누락된 사원이 없도록! (부서코드가 입력되지 않은 사원)
-- != , ^= , <> NOT의 방식
-- INNER JOIN의 경우, 조건에 일치하는 값만 조회 하므로
-- 부서를 배정받지 못한 사원 2명이 누락된다.
-- OUTTER JOIN을 이용하여 조건이 일치하지 않는 사원도 조회 하도록 한다.
-- 오라클 문법에서는 (+)를 이용하여 OUTTER JOIN 을 구현 할 수 있다.
-- 기준이 되는 테이블의 컬럼 반대편에 (+)를 붙여준다.
SELECT  EMP_NAME, DEPT.DEPT_TITLE, SALARY
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID(+)
AND     (NOT DEPT.DEPT_TITLE = '인사관리부' OR DEPT_TITLE IS NULL);

-- 6개의 부서코드를 사용
SELECT  DISTINCT DEPT_CODE
FROM    EMP;
-- 9개의 부서코드
SELECT  DEPT_ID
FROM    DEPT;

SELECT      EMP_NAME, NVL(DEPT.DEPT_TITLE, '부서없음'), SALARY
FROM        EMP
LEFT JOIN   DEPT ON (DEPT_CODE = DEPT_ID)
WHERE       NOT NVL(DEPT.DEPT_TITLE, '부서없음') = '인사관리부';

-- 사번, 사원명, 부서명, 지역명, 국가명 조회
-- 누락되는 사원이 없이 조회해봅시다.
-- 여러테이블을 OUTER JOIN 으로 연결할 경우 JOIN 조건에 모두 (+)를 붙여준다.
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM    EMP, DEPT, LOCATION L, NATIONAL N
WHERE   DEPT_CODE = DEPT_ID
AND     LOCATION_ID = LOCAL_CODE
AND     L.NATIONAL_CODE = N.NATIONAL_CODE;

-- OUTER JOIN시 조건에 일치하지 않는 데이터는 모두 NULL로 조회가 되므로
-- 다음 조건에서 INNER JOIN 으로 비교할 경우 조회 되지 않는다.
SELECT  EMP_ID, DEPT.*
FROM    EMP, DEPT
WHERE   EMP.DEPT_CODE = DEPT.DEPT_ID(+)
AND     DEPT_CODE IS NULL;

-- ANSI
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM    EMP
LEFT JOIN   DEPT        ON      (EMP.DEPT_CODE = DEPT.DEPT_ID)
LEFT JOIN   LOCATION L  ON      (DEPT.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN   NATIONAL N  USING   (NATIONAL_CODE);

-- 부서별 최고 급여를 받는 사람
-- IN : 다중행에 대한 처리
-- = : 단일행에 대한 처리
-- 서브쿼리의 조회 결과가 단일행인 경우, = 또는 IN 사용가능
-- 서브쿼리의 조회 결과가 다중행인 경우, =은 사용불가!!
SELECT *
FROM    EMP
WHERE   (DEPT_CODE, SALARY) IN(
        SELECT      DEPT_CODE, MAX(SALARY)
        FROM        EMP
        GROUP BY    DEPT_CODE
        );

        SELECT      DEPT_CODE, MAX(SALARY)
        FROM        EMP
        GROUP BY    DEPT_CODE;
-- GROUP BY 절에 사용되지 않은 칼럼이 조회절에 나올때
-- ORA-00979 : GROUP BY 표현식이 아닙니다.
-- 사원이 22명 있는데 부서별별로 묶음
SELECT      DEPT_CODE, MAX(SALARY), COUNT(*), EMP_NAME
FROM        EMP
GROUP BY    DEPT_CODE;