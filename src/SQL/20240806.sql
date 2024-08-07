/*
    <그룹함수>
        대량의 데이터들로 집계나 통계같은 작업을 처리해야 하는 경우 사용 하는 함수
        모든 그룹함수는 NULL 값을 자동으로 제외
        => NVL()함수와 함께 사용하는것을 권장 합니다.
    
    1) SUM(NUMBER) 
        - 해당 컬럼의 총 합계를 반환 합니다
    2) AVG(NUMBER)
        - 해당 컬럼의 평균을 반환 합니다.
    3) MIN(모든타입) / MAX(모든타입)
        - MIN : 해당 컬럼의 값들중 가장 작은 값을 반환 합니다.
        - MAX : 해당 컬럼의 값들중 가장 큰 값을 반환 합니다.
    4) COUNT(*|컬럼명)
        - 결과 행의 갯수를 세서 반환 하는 함수
        - COUNT(*) : 조회결과에 해당하는 모든 행의 갯수를 반환
        - COUNT(컬럼명) : 제시한 컬럼값이 NULL이 아닌 행의 갯수를 반환
*/

-- 집계함수 : 여러행 또는 테이블 전체 행으로 부터 하나의 결과 값을 반환

-- >에러
SELECT  COUNT (*), EMP_NAME
FROM    EMP;
-- 하나의 값만을 반환
SELECT  COUNT (*)
FROM    EMP;

SELECT  *
FROM    EMP;

SELECT  COUNT (EMP_ID)
FROM    EMP;

-- NULL값 2건을 제외
SELECT  COUNT (DEPT_CODE)
FROM    EMP;

-- 중복제거
SELECT  DISTINCT DEPT_CODE
FROM    EMP;

SELECT  COUNT (DISTINCT DEPT_CODE)
FROM    EMP;

-- 사원은 총 급여의 합계
SELECT  SUM(SALARY)
FROM    EMP;

-- 사원의 총 급여의 평균
SELECT  AVG(SALARY)
FROM    EMP;

-- 새로운 사원번호 = 최대값 + 1
SELECT  MAX (EMP_ID) + 1
FROM    EMP;

-- 급여의 최대값, 최소값 구하기
SELECT  MAX (SALARY), MIN (SALARY)
FROM    EMP;

/*
    <GROUP BY>
        - 그룹에 대한 기준을 제시할 수 있는 구문
        여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.
        SELECT 
        FROM
        [WHERE]
        [GROUP BY]
        [ORDER BY]
        생략이 가능 한 절도 있지만 
        - 쿼리를 작성시 순서대로 작성 해야 한다
        - SELECT 절에는 집계함수와 GROUP BY절에 명시된 컬럼만 작성이 가능하다
*/

-- 부서별 사원의 급여의 합계

SELECT      DEPT_CODE, SUM(SALARY) 부서별총급여, COUNT (EMP_ID), COUNT(*) 부서별사원수
FROM        EMP
GROUP BY    DEPT_CODE
ORDER BY    1;

-- 직급별 사원의 수

SELECT      JOB_CODE, COUNT(*) 직급별사원수
FROM        EMP
GROUP BY    JOB_CODE;

-- 각 부서별 보너스를 받는 사원수
-- NULL을 세어 주지 않으므로

SELECT      JOB_CODE, COUNT (BONUS)
FROM        EMP
GROUP BY    JOB_CODE;

-- 직급별 급여의 평균
-- FLOOR : 소수점 버리기
-- TO CHAR(컬럼, 형식)
-- 형식 : 3자리 컴마, 소수점 자릿수
SELECT      JOB_CODE, TO_CHAR (AVG (SALARY), '9,999,999') || '원'
FROM        EMP
GROUP BY    JOB_CODE;


-- 부서별
-- 사원수, 보너스를 받는 사원수, 급여의 합, 평균급여, 최고급여, 최저급여
-- 금액 3자리콤마, 사원수에는 명을 붙여서 왼쪽 정렬

SELECT      DEPT_CODE                               부서코드
            , COUNT(*) || '명'                      사원수
            , COUNT(BONUS)                          보너스를받는사원
            , TO_CHAR (SUM (SALARY), '99,999,999')  급여의합
            , TO_CHAR (AVG (SALARY), '9,999,999')   평균급여
            , TO_CHAR (MAX (SALARY), '9,999,999')   최고급여
            , TO_CHAR (MIN (SALARY), '9,999,999')   최저급여
FROM        EMP
GROUP BY    DEPT_CODE
ORDER BY    부서코드;

-- 남자사원의 총급여의 합계

SELECT      SUM(SALARY)
FROM        EMP
WHERE       SUBSTR(EMP_NO,8,1) IN ('1', '3');

-- 퇴직한 직원의 수
SELECT  COUNT(*) 퇴사자의수
FROM    EMP
WHERE   ENT_YN = 'Y';

/*
    <JOIN>
    두 개의 이상의 테이블에서 데이터를 조회하고자 할 때 사용하는 구문이다.
    
    1. 등가 조인(EQUAL JOIN) / 내부 조인(INNER JOIN)
    연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회한다.
    (일치하는 값이 없는 행은 조회 X)   
    
    1) 오라클 전용구문
        SELECT 컬럼, 컬럼, ...
        FROM   테이블1, 테이블2
        WHERE  테이블1.컬럼명 = 테이블2.컬럼명;
        
        - FROM절에 조회하고자 하는 컬럼들을 ,(콤마)로 구분하여 나열
        - WHERE절에 매칭시킬 컬럼에 대한 조건을 제시 한다.
    
    2) ANSI 표준 구문
        SELECT  컬럼, 컬럼, ...
        FROM    테이블1
        [INNER] JOIN 테이블2 ON (테이블1.컬럼명 = 테이블2.컬럼명);
        [INNER] JOIN 테이블2 USING (컬럼명);
            FROM절에 기준이 되는 테이블을 기술
            JOIN 절에 같이 조회하고자 하는 테이블을 기술 후 조건을 명시
            연결에 사용하려는 컬럼명이 같은 경우 ON절 대신 USING(컬럼명)을 사용
*/

-- 총 사원수 : 22명
SELECT  *
FROM    EMP;

-- 각 사원들의 사번, 사원명, 부서코드, 부서명을 조회
SELECT  *
FROM    DEPT;
-- DEPT_ID에 NULL이 존재 하지 않으므로 DEPT_CODE값에 NULL이 입력된 사원이 제외
-- 조회된 사원수 : 20명(NULL 2명제외됨)
-- INNERJOIN : 조건이 만족하는 값만 조회
SELECT  EMP_NO, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID;

-- 부서테이블에서 사용되지 않는 부서코드를 조회
-- EMP테이블이 사용중인 부서코드 목록
-- NOT IN 절에 NULL이 입력될 경우 조회결과가 상이함
SELECT  *
FROM    DEPT
WHERE   DEPT_ID NOT IN (
        SELECT  DISTINCT (DEPT_CODE)
        FROM    EMP
        WHERE   DEPT_CODE IS NOT NULL
);

-- 표준 ANSI
SELECT  EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM    EMP
JOIN    DEPT ON (DEPT_ID = DEPT_CODE);

-- 각 사원들의 사번, 사원명, 직급 코드, 직급명을 조회
-- 컬럼의 이름이 같은경우, 테이블명을 명시하여 구분할 수 있도록 해주어야 함
-- 조건절, 조회절 모두 테이블명을 명시해야 함
SELECT  EMP_NO, EMP_NAME, EMP.JOB_CODE, JOB_NAME
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE;

-- 테이블명을 별칭으로 사용하는 경우
-- 테이블에 별칭을 주는 경우, 테이블명은 사용 할 수 없다.
-- ORA-00904: "EMP"."JOB_CODE": 부적합한 식별자
SELECT  EMP_NO, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM    EMP E, JOB J
WHERE   E.JOB_CODE = J.JOB_CODE;

-- ANSI 표준구문
-- 컬럼이름이 같은경우
-- USING절에 사용된 컬럼은 테이블이름을 붙일 수 없다!!
SELECT  EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM    EMP
JOIN    JOB USING (JOB_CODE);

-- ON절 사용시 이름이 같은 컬럼 앞에 테이블 명을 명시 해야 함!!
SELECT  EMP_ID, EMP_NAME, EMP.JOB_CODE, JOB_NAME
FROM    EMP
JOIN    JOB ON (EMP.JOB_CODE = JOB.JOB_CODE);

/*
	* ANSI SQL
	DBMS(Oracle, My-SQL, DB2 등등)들에서 각기 다른 SQL를 사용하므로, 
	미국 표준 협회(American National Standards Institute)에서 이를 
    표준화하여 표준 SQL문을 정립 시켜 놓은 것이다.
*/ 

-- EMP 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의
-- 사번, 사원명, 직급명, 급여를 조회
-- ORACLE 구문
SELECT  EMP_ID, EMP_NAME, J.JOB_NAME, SALARY
FROM    EMP E, JOB J
WHERE   E.JOB_CODE = J.JOB_CODE
AND     JOB_NAME = '대리';

-- ANSI 구문
-- JOIN 테이블명 ON (조건)
SELECT  EMP_ID, EMP_NAME, JOB.JOB_NAME, SALARY
FROM    EMP
JOIN    JOB ON (EMP.JOB_CODE = JOB.JOB_CODE)
WHERE   JOB_NAME = '대리';

-- ANSI 구문 -> 컬럼이름이 같다면 USING사용가능!
-- JOIN 테이블명 USING (조건)
SELECT  EMP_ID, EMP_NAME, JOB.JOB_NAME, SALARY
FROM    EMP
JOIN    JOB USING (JOB_CODE)
WHERE   JOB_NAME = '대리';

/*
    2. 다중 JOIN
        여러개의 테이블을 조인 하는 경우 사용
*/

-- 사원, 사원명, 부서명, 지역명

SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM    EMP E, DEPT D, LOCATION L
WHERE   E.DEPT_CODE = D.DEPT_ID
AND     D.LOCATION_ID = L.LOCAL_CODE;

SELECT  EMP_ID, EMP_NAME, DEPT.DEPT_TITLE, LOCATION.LOCAL_NAME
FROM    EMP
JOIN    DEPT ON (DEPT_CODE = DEPT_ID)
JOIN    LOCATION ON (LOCATION_ID = LOCAL_CODE);

/*
    3. 외부조인(OUTTER JOIN)
        테이블간에 JOIN시 조건에 일치하지 않는 행도 포함시켜서 조회
        기준이 되는 테이블을 지정 해야 한다(LEFT/RIGNT/(+))
*/

-- 1) LEFT [OUTER] JOIN 
--      두 테이블중 왼편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행
--      JOIN 조건이 일치하지 않아도 왼쪽에 테이블을 모두 출력
-- 2) RIGHT [OUTER] JOIN 
--    두 테이블 중 오른편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행
--    오른쪽 테이블을 모두 출력
--    사원이름, 부서명, 급여를 출력하는데 부서테이블의 모든 데이터가 출력되도록

-- 조건이 일치 하지 않아도 조회하고자 하는 테이블의 반대편에 (+)
SELECT  EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID(+);

-- 사원테이블에는 없지만 부서테이블에 있는 데이터 조회
-- 기준테이블 (조건이 일치하지 않아도 모두 조회)
-- (+)가 있는 조건의 반대에 있는 테이블 기준
SELECT  EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM    EMP, DEPT
WHERE   DEPT_CODE(+) = DEPT_ID;

-- ANSI
-- OUTER는 생략가능
-- 왼쪽 테이블을 기준으로
SELECT  EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM    EMP
LEFT OUTER JOIN DEPT    ON  (DEPT_CODE = DEPT_ID);

SELECT      EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM        EMP
LEFT JOIN   DEPT    ON  (DEPT_CODE = DEPT_ID);

-- 오른쪽 테이블을 기준으로
SELECT      EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM        EMP
RIGHT JOIN  DEPT    ON  (DEPT_CODE = DEPT_ID);

-- 3) FULL [OUTER] JOIN : 두 테이블이 가지는 모든 행을 조회
--    오라클 구문은 지원하지 않음
-- 조회조건만족                           20건 
-- 사원테이블 부서코드가 NULL인             2건 
-- 부서테이블 사원이 배정되지 않은 부서코드   3건 
SELECT      EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM        EMP
FULL JOIN   DEPT    ON  (DEPT_CODE = DEPT_ID);


-- 사번, 이름, 관리자사번, 관리자이름
-- MANAGER_ID : 매니저의 사번
SELECT  E.EMP_NO 사번, E.EMP_NAME 이름, M.MANAGER_ID 관리자사번, M.EMP_NAME 관리자이름
FROM    EMP E, EMP M
WHERE   E.MANAGER_ID = M.EMP_ID;

SELECT  E.EMP_NO 사번, E.EMP_NAME 이름, M.MANAGER_ID 관리자사번, M.EMP_NAME 관리자이름
FROM    EMP E, EMP M
WHERE   E.MANAGER_ID = M.EMP_ID(+);

/*
5. 비등가 조인(NON EQUAL JOIN)
    조인 조건에 등호(=)를 사용하지 않는 조인문을 비등가 조인이라고 한다.
    지정한 컬럼 값이 일치하는 경우가 아닌, 
    값의 범위에 포함되는 행들을 연결하는 방식이다.
    ( = 이외에 비교 연산자 >, <, >=, <=, 
    BETWEEN AND, IN, NOT IN 등을 사용한다.)
    ANSI 구문으로는 JOIN ON 구문으로만 사용이 가능하다. (USING 사용 불가)    
*/
/* 급여등급 테이블 생성 */
CREATE TABLE SAL_GRADE(
	SAL_LEVEL CHAR(2 BYTE), 
	MIN_SAL NUMBER, 
	MAX_SAL NUMBER
);

COMMENT ON COLUMN SAL_GRADE.SAL_LEVEL IS '급여등급';
COMMENT ON COLUMN SAL_GRADE.MIN_SAL IS '최소급여';
COMMENT ON COLUMN SAL_GRADE.MAX_SAL IS '최대급여';
COMMENT ON TABLE SAL_GRADE IS '급여등급'; 

Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL)
                                values ('S1',6000000,10000000);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S2',5000000,5999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S3',4000000,4999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S4',3000000,3999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S5',2000000,2999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S6',1000000,1999999); 
COMMIT;

-- 범위 테이블의 값이 중복될 경우, 한명의 사원이 여러 등급을 가질수 있으므로 주의 해야한다.
SELECT  *
FROM    SAL_GRADE;

SELECT  EMP_NAME, SAL_LEVEL, SALARY
FROM    EMP, SAL_GRADE
WHERE   SALARY BETWEEN MIN_SAL AND MAX_SAL;

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