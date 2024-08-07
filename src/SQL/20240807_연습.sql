-- EMP 테이블에서 직원명, 입사일을 조회
-- 입사일 내림차순 정렬
-- 단, 입사일은 포멧을 지정해서 조회한다. (2021-09-28 (화))
SELECT      EMP_NAME 직원명
            , TO_CHAR(HIRE_DATE,'YYYY-MM-DD (DY)') 입사일
FROM        EMP
ORDER BY    HIRE_DATE DESC;

-- EMP 테이블에서 1998년 1월 1일 이후에 입사한 사원의 사번, 이름, 입사일 조회
SELECT      EMP_NO      사번
            , EMP_NAME  이름
            , HIRE_DATE 입사일
FROM        EMP
WHERE       HIRE_DATE >= '1998/01/01'
ORDER BY    HIRE_DATE;

-- EMPLOYEE 테이블에서 사원명, 직급 코드, 기존 급여, 인상된 급여를 조회
-- 직급 코드가 J7인 사원은 급여를 10% 인상(SALARY * 1.1) 
-- 직급 코드가 J6인 사원은 급여를 15% 인상(SALARY * 1.15) 
-- 직급 코드가 J5인 사원은 급여를 20% 인상(SALARY * 1.2) 
-- 이 외의 직급은 사원은 급여를 5%만 인상 (SALARY * 1.05)
SELECT  EMP_NAME    "사원명"
        , JOB_CODE  "직급 코드"
        , SALARY    "기존 급여"
        , CASE  WHEN    JOB_CODE = 'J7' THEN    SALARY * 1.1
                WHEN    JOB_CODE = 'J6' THEN    SALARY * 1.15
                WHEN    JOB_CODE = 'J5' THEN    SALARY * 1.2
                ELSE    SALARY * 1.05
        END "인상된 급여"
FROM    EMP;

-- 사원의 급여가 5000000 이상이면 고수익, 3000000이상이면 일반, 나머지는 ''
SELECT  EMP_NAME    "사원명"
        , SALARY    "급여"
        , CASE  WHEN    SALARY >= 5000000   THEN    '고수익'
                WHEN    SALARY >= 3000000   THEN    '일반'
                ELSE    ' '
        END         "조회결과"
FROM    EMP;

-- 1.노옹철 사원과 같은 부서인 사원들의 이름과 부서코드를 조회 하시오!
-- 1) 노옹철 사원의 부서를 조회 
-- 2) 조건문에 값대신 서브쿼리를 대입
SELECT  EMP_NAME        "사원명"
        , DEPT_CODE     "부서코드"
FROM    EMP
WHERE   DEPT_CODE = (
    SELECT  DEPT_CODE
    FROM    EMP
    WHERE   EMP_NAME = '노옹철'
)
AND     EMP_NAME != '노옹철';

-- 2. 전 직원의 평균 급여보다 급여를 적게 받는 직원의 이름, 직급코드, 직급명, 급여를 조회
SELECT  EMP_NAME        직원명
        , EMP.JOB_CODE  직급코드
        , JOB_NAME      직급명
        , SALARY        급여
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     SALARY < (
    SELECT  FLOOR(AVG(SALARY))
    FROM    EMP 
);

-- 3. 최저 급여를 받는 직원의 사번, 이름, 직급 코드, 급여, 입사일 조회
SELECT  EMP_ID      "사번"
        , EMP_NAME  "이름"
        , JOB_CODE  "직급 코드"
        , SALARY    "급여"
        , HIRE_DATE "입사일"
FROM    EMP
WHERE   SALARY = (
SELECT  MIN(SALARY)
FROM    EMP
);


-- 4. 노옹철 사원의 급여보다 더 많은 급여받는 
-- 사원들의 사번, 사원명, 부서명, 직급 코드, 급여 조회
-- 노옹철 사원의 급여를 조회
SELECT  EMP_ID              "사번"
        , EMP.EMP_NAME      "사원명"
        , DEPT.DEPT_TITLE   "부서명"
        , JOB_CODE          "직급 코드"
        , SALARY            "급여"
FROM    EMP, DEPT
WHERE   EMP.DEPT_CODE = DEPT.DEPT_ID
AND     SALARY > (
    SELECT  SALARY
    FROM    EMP
    WHERE   EMP_NAME = '노옹철'    
);



-- 5. 부서별 급여의 합이 가장 큰 부서의 
--    부서 코드, 급여의 합 조회
--    각 부서별 급여의 합 중에 가장 큰 급여의 합을 조회
🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔;
SELECT      DEPT_CODE       "부서 코드"
            , SUM(SALARY)   "급여의 합"
FROM        EMP
GROUP BY    DEPT_CODE
HAVING      SUM(SALARY) = (
    SELECT      MAX(SUM(SALARY))
    FROM        EMP
    GROUP BY    DEPT_CODE    
);


-- 6. 부서별 평균(소수점버림)급여가 가장 작은 부서의 부서코드와 부서명 평균급여를 조회
🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔;
-- GROUP BY에서 문제 발생 DEPT_TITLE 추가로 해결 / 이유 GROUP BY 에서 묶지않은 컬럼은 SELECT에 올수 없기때문!!! 
SELECT      DEPT_CODE               "부서 코드"
            , DEPT_TITLE            "부서명"
            , FLOOR(AVG(SALARY))    "평균 급여"
FROM        EMP, DEPT
WHERE       EMP.DEPT_CODE = DEPT.DEPT_ID
GROUP BY    DEPT_CODE, DEPT_TITLE
HAVING      FLOOR(AVG(SALARY)) = (
    SELECT      MIN(FLOOR(AVG(SALARY)))
    FROM        EMP
    GROUP BY    DEPT_CODE
);



-- 7. 전지연 사원이 속해있는 부서원들 조회 (단, 전지연 사원은 제외)
-- 사번, 사원명, 전화번호, 직급명, 부서명, 입사일 
-- 전지연 사원이 속해있는 부서 조회
SELECT  EMP_ID          "사번"
        , EMP_NAME      "사원명"
        , PHONE         "전화번호"
        , JOB_NAME      "직급명"
        , DEPT_TITLE    "부서명"
        , HIRE_DATE     "입사일"
FROM    EMP, DEPT, JOB
WHERE   DEPT_CODE = DEPT_ID
AND     EMP.JOB_CODE = JOB.JOB_CODE
AND     DEPT_CODE = (
    SELECT  DEPT_CODE
    FROM    EMP
    WHERE   EMP_NAME = '전지연'
)
AND     EMP_NAME != '전지연';



-- 1) 각 부서별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회
-- 각 부서별 최고 급여를 조회

-- 2) 전 직원들에 대해 사번, 이름, 부서코드, 구분 (매니저/사원)
-- 매니저의 사번을 조회 / 중복을 제거

-- 3) 대리 직급임에도 과장 직급들의 최소 급여보다 많이 받는
-- 직원의 사번, 이름, 직급명, 급여 조회

-- 4) 과장 직급임에도 차장 직급의 최대 급여보다 더 많이 받는 
-- 직원들의 사번, 이름, 직급명, 급여 조회 
