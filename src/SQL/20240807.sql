/*
    <숫자 관련 함수>
    
    1) ABS
        - ABS(NUBER)
        - 절대값을 구하는 함수
*/

SELECT  ABS(10.9), ABS(-10.9)
FROM    DUAL;

/*
    2) MOD
        - MOD(NUMBER, NUMBER)
        - 두 수를 나눈 나머지를 반환해 주는 함수 (자바의 % 연산과 동일하다.)
*/ 

SELECT  MOD(10,3)
FROM    DUAL;

SELECT  MOD(10.9,3)
FROM    DUAL;

/*
    3) ROUND
        - ROUND(NUMBER[, 위치])
        - 위치를 지정하여 반올림해주는 함수
        - 위치 : 기본값 0(.), 양수(소수점 기준으로 오른쪽)와 음수(소수점 기준으로 왼쪽)로 입력가능
*/ 

-- 반올림(버림) - 위치를 지정하지 않으면 정수로 반환
SELECT  ROUND(123.456)
FROM    DUAL;
-- 반올림(올림) - 위치를 지정하지 않으면 정수로 반환
SELECT  ROUND(123.556)
FROM    DUAL;

-- 반올림하여 위치만큼 보여줌
-- 양수인 경우 소수점의 지정한 위치 다음에 있는 자리를 반올림
-- 음수인 경우 정수부의 지정한 위치에서 반올림
SELECT  ROUND(123.456,2), ROUND(123.456,-2)
FROM    DUAL;
-- 천단위 반올림
SELECT  ROUND(123456, -3)
FROM    DUAL;

/*
    4) CEIL
        - CEIL(NUMBER)
        - 소수점 기준으로 올림해주는 함수
*/
SELECT  CEIL(123.456)
FROM    DUAL;
/*
    5) FLOOR
        - FLOOR(NUMBER)
        - 소수점 기준으로 버림하는 함수
*/ 

-- 올림, 버림 함수의 경우 두 매개변수는 하나만 입력이 가능하다
-- ORA-00909 : 인수의 개수가 부적합합니다.
SELECT  FLOOR(123.456,2)
FROM    DUAL;

/*
    6) TRUNC
        - TRUNC(NUMBER[, 위치])
        - 위치를 지정하여 버림이 가능한 함수
        - 위치 : 기본값 0(.), 양수(소수점 기준으로 오른쪽)와 음수(소수점 기준으로 왼쪽)로 입력가능
*/
-- 원단위 절삭
SELECT  TRUNC (123.456, -1)
FROM    DUAL;

/*
    <날짜 관련 함수>
    
    1) SYSDATE
        시스템의 현재 날짜와 시간을 반환한다.
*/
SELECT  SYSDATE
FROM    DUAL;

/* 
    2) MONTHS_BETWEEN
        [표현법]
            MONTHS_BETWEEN(DATE1, DATE2)
            
        - 입력받은 두 날짜 사이의 개월 수를 반환한다.
        - 결과값은 NUMBER 타입이다.
*/

SELECT  MONTHS_BETWEEN(SYSDATE, SYSDATE)
FROM    DUAL;

-- 문자타입을 넣어도 자동 형변환 되어 계산 됨
SELECT  FLOOR(MONTHS_BETWEEN(SYSDATE, '2024/03/01')) ||  '개월'
FROM    DUAL;

SELECT  TO_DATE('2024/03/01')
FROM    DUAL;

-- EMP 테이블에서 직원명, 입사일, 근무개월수

SELECT  EMP_NAME                                                직원명
        , HIRE_DATE                                             입사일
        , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월'   근무개월수
FROM    EMP;

/*
    3) ADD_MONTHS
        [표현법]
            ADD_MONTHS(DATE, NUMBER)
            
        - 특정 날짜에 입력받는 숫자만큼의 개월 수를 더한 날짜를 리턴한다.
        - 결과값은 DATE 타입이다.
*/ 

SELECT  ADD_MONTHS(SYSDATE, 6)
FROM    DUAL;
SELECT  ADD_MONTHS(SYSDATE, 8)
FROM    DUAL;
SELECT  ADD_MONTHS('2020/12/31', 2)
FROM    DUAL; 

/*
    4) NEXT_DAY
        [표현법]
            NEXT_DAY(DATE, 요일(문자|숫자))
        
        - 특정 날짜에서 구하려는 요일의 가장 가까운 날짜를 리턴한다.
        - 결과값은 DATE 타입이다.
*/ 

-- 언어설정확인 필요 / 설정되어있는 언어와 다른 언어입력시 오류
-- ORA-01846: not a valid day of the week
SELECT  SYSDATE, NEXT_DAY (SYSDATE, '목요일')
FROM    DUAL;

SELECT  SYSDATE, NEXT_DAY (SYSDATE, '금')
FROM    DUAL;

SELECT  SYSDATE, NEXT_DAY (SYSDATE, 'SUNDAY')
FROM    DUAL;

-- 1: 일요일 ~ 7: 토요일
SELECT  SYSDATE, NEXT_DAY (SYSDATE, 6)
FROM    DUAL;

-- 현재 사용중인 언어 확인 하는 방법

SELECT  VALUE
FROM    NLS_SESSION_PARAMETERS
WHERE   PARAMETER = 'NLS_LANGUAGE';

-- 언어 변경 -> 영어
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; 
-- 언어 변경 -> 한글
ALTER SESSION SET NLS_LANGUAGE = KOREAN; 
-- 시간형식변경 -> 하나의 섹션에서만 변경됨!!
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'; 

/*
    5) LAST_DAY
        [표현법]
            LAST_DAY(DATE|CHAR)
        
        - 해당 월의 마지막 날짜를 반환한다.
        - 결과값은 DATE 타입이다.   
*/
-- 말일을 반환

SELECT  LAST_DAY(SYSDATE)
FROM    DUAL;

SELECT  LAST_DAY('2024/12/01')
FROM    DUAL;

-- 입사월의 마지막 날짜를 조회 / 근무일
SELECT  HIRE_DATE                       "입사일"
        , LAST_DAY(HIRE_DATE)           "입사월의 말일"
        , LAST_DAY(HIRE_DATE)-HIRE_DATE "근무일"
FROM    EMP;

/*
    6) EXTRACT
        [표현법]
            EXTRACT(YEAR|MONTH|DAY FROM DATE);
            
        - 특정 날짜에서 연도, 월, 일 정보를 추출해서 반환한다.
          YEAR : 연도만 추출
          MONTH : 월만 추출
          DAY :  일만 추출
        - 결과값은 NUMBER 타입이다.
*/ 

SELECT  EXTRACT (YEAR FROM SYSDATE) 년
        , EXTRACT (MONTH FROM SYSDATE) 월
        , EXTRACT (DAY FROM SYSDATE) 일
        , TO_CHAR (SYSDATE, 'YYYY') 년
        , TO_CHAR (SYSDATE, 'MM') 월
        , TO_CHAR (SYSDATE, 'DD') 일
FROM    DUAL;

/*
    <형변환 함수>
    
    1) TO_CHAR
        [표현법]
            TO_CHAR(날짜|숫자[, 포멧])
        
        - 날짜 또는 숫자 타입의 데이터를 문자 타입으로 변환해서 반환한다.
        - 결과값은 CHARACTER 타입이다.
*/

-- 숫자 -> 문자

SELECT 1234, TO_CHAR(1234) FROM DUAL;
-- 6칸(9의 갯수 만큼)의 공간을 확보, 왼쪽 정렬
-- 9와 0은 형식을 지정하는 형식문자로 사옹되는데 9는 자릿수만 지정하는 반면 0은 빈자리에 출력됨
-- 9 : 빈칸은 공백으로 채워줌
SELECT TO_CHAR(1234,'999999') FROM DUAL;
-- 0 : 빈칸은 0으로 채워줌
SELECT TO_CHAR(1234,'000000') FROM DUAL;
-- 3자리 콤마
SELECT TO_CHAR(1234,'999,999') FROM DUAL;
-- 숫자의 길이보다 지정한 형식이 짧으면 #으로 출력
SELECT TO_CHAR(1234567,'999,999') FROM DUAL;
SELECT TO_CHAR(1234567,'9,999,999') FROM DUAL;

-- L : 현재 설정된 나라의 화폐단위
SELECT TO_CHAR(1234567,'L9,999,999') FROM DUAL;

-- 날짜 -> 문자
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE) FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
-- AM, PM 상관없음 : 오전, 오후 표시
SELECT SYSDATE, TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
-- HH24 : 24시간형식
SELECT SYSDATE, TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
-- DY : 요일만(월, 화, 수, 목, 금, 토, 일)
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
-- DAY : 요일(월요일, 화요일, 수요일, 목요일, 금요일, 토요일, 일요일)
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD(DAY)') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;

-- 일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DDD') -- 1년을 기준으로 몇일째 
        , TO_CHAR(SYSDATE, 'DD') -- 1달을 기준으로 몇일째
        , TO_CHAR(SYSDATE, 'D') -- 1주를 기준으로 몇일째 / 일요일부터시작
FROM DUAL; 

-- 직접 넣고싶은 문자는 ""사용
SELECT TO_CHAR (SYSDATE,'YYYY"년"MM"월"DD"일"') FROM DUAL;

-- EMP 테이블에서 직원명, 입사일을 조회
-- 입사일 내림차순 정렬
-- 단, 입사일은 포멧을 지정해서 조회한다. (2021-09-28 (화))

SELECT  EMP_NAME 직원명, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD (DY)') 입사일
FROM    EMP
ORDER BY 2 DESC;

/*
    2) TO_DATE
        [표현법]
            TO_DATE(숫자|문자[, 포멧])
        
        - 숫자 또는 문자형 데이터를 날짜 타입으로 변환해서 반환한다.
        - 결과값은 DATE 타입이다.
*/

-- 숫자 -> 날짜
SELECT  TO_DATE(20240807)
FROM    DUAL;

-- 형식이 맞지않으면 변환되지 않음 / SQL Developer 환경설정에서 변경하여 확인함!
SELECT  TO_DATE(20240807102423)
FROM    DUAL;

-- 문자 -> 날짜
SELECT  TO_DATE('20240807')
FROM    DUAL;

SELECT  TO_DATE('2024-08-07')
FROM    DUAL;

SELECT  TO_DATE('2024/08/07')
FROM    DUAL;

-- 형식을 지정해줄 수 있음
SELECT  TO_DATE('20240807','YYYYMMDD')
FROM    DUAL;


-- EMP 테이블에서 1998년 1월 1일 이후에 입사한 사원의 사번, 이름, 입사일 조회
SELECT  EMP_ID 사번, EMP_NAME 이름, TO_CHAR(HIRE_DATE,'YYYY"년" MM"월" DD"일"') 입사일
FROM    EMP
WHERE   HIRE_DATE > '19980101';

-- T) 문자인 경우 자동 형변환, 숫자인 경우 오류가 발생
SELECT      EMP_ID , EMP_NAME , TO_CHAR(HIRE_DATE,'YYYY"년" MM"월" DD"일"') 입사일
FROM        EMP
WHERE       HIRE_DATE > '19980101'
ORDER BY    HIRE_DATE;

-- T) 날짜형식 지정가능
SELECT      EMP_ID , EMP_NAME , TO_CHAR(HIRE_DATE,'YYYY"년" MM"월" DD"일"') 입사일
FROM        EMP
WHERE       HIRE_DATE > TO_DATE('19980101')
ORDER BY    HIRE_DATE;

-- T) BETWEEN 활용
SELECT      EMP_ID , EMP_NAME , TO_CHAR(HIRE_DATE,'YYYY"년" MM"월" DD"일"') 입사일
FROM        EMP
WHERE       HIRE_DATE BETWEEN '19980101' AND SYSDATE
ORDER BY    HIRE_DATE;

/*
    3) TO_NUMBER
        [표현법]
            TO_NUMBER('문자값'[, 포멧])
        
        - 문자 타입의 데이터를 숫자 타입의 데이터로 변환해서 반환한다.
        - 결과값은 NUMBER 타입이다.
*/ 

SELECT '123456', TO_NUMBER('123456') FROM DUAL;
-- 문자를 숫자로 형변환하여 수의 연산가능
SELECT '1234'+'567' FROM DUAL;
-- 수와 문자는 연산불가 -> 에러발생 / 숫자 형태의 문자들만 자동 형변환 된다!
-- ORA-01722: 수치가 부적합합니다
SELECT '1234'+'567A' FROM DUAL;

-- 세자리 컴마를 숫자로 변경
SELECT TO_NUMBER ('123,456,789','999,999,999') FROM DUAL;

/*
    <NULL 처리 함수>
    
    1) NVL
        [표현법]
            NVL(컬럼, 컬럼값이 NULL일 경우 반환할 값)
        
        - NULL로 되어있는 컬럼의 값을 인자로 지정한 값으로 변경하여 반환한다.

    2) NVL2
        [표현법]
            NVL2(컬럼, 변경할 값 1, 변경할 값 2)
            
        - 컬럼 값이 NULL이 아니면 변경할 값 1, 컬럼 값이 NULL이면 변경할 값 2로 변경하여 반환한다.  
    
    3) NULLIF
        [표현법]
            NULLIF(비교대상 1, 비교대상 2)
            
        - 두 개의 값이 동일하면 NULL 반환, 두 개의 값이 동일하지 않으면 비교대상 1을 반환한다.
*/ 

-- NULL은 연산에서 제외 되므로 0으로 치환하여 연산진행
SELECT NVL (BONUS, '0') FROM EMP;
-- 보너스를 0.1로 동결 NULL -> 0 / NOT NULL -> 0.1
SELECT NVL2 (BONUS, 0.1, 0) FROM EMP;
SELECT BONUS 보너스, NVL2 (BONUS, 0.1, 0) 동결된보너스 FROM EMP;

-- 두 값이 같으면 NULL 반환
SELECT NULLIF('123', '123') FROM DUAL;
-- 두 값이 같지 않으면 첫번째 값을 반환
SELECT NULLIF('123', '456') FROM DUAL;

/*
    <선택함수>
        여러 가지 경우에 선택을 할 수 있는 기능을 제공하는 함수이다.
    
    1) DECODE
        [표현법]
            DECODE(컬럼|계산식, 조건값 1, 결과값 1, 조건값 2, 결과값 2, ..., 결과값)
        
        - 비교하고자 하는 값이 조건값과 일치할 경우 그에 해당하는 결과값을 반환해 주는 함수이다.
*/

SELECT  SUBSTR(EMP_NO,8,1)  뒷자리1
        , DECODE(SUBSTR(EMP_NO,8,1),  1, '남'
                                    , 2, '여'
                                    , 3, '남'
                                    , 4, '여'
                                    , '잘못된 주민번호 입니다.'
                ) 성별
FROM    EMP;

-- EMPLOYEE 테이블에서 사원명, 직급 코드, 기존 급여, 인상된 급여를 조회
-- 직급 코드가 J7인 사원은 급여를 10% 인상(SALARY * 1.1) 
-- 직급 코드가 J6인 사원은 급여를 15% 인상(SALARY * 1.15) 
-- 직급 코드가 J5인 사원은 급여를 20% 인상(SALARY * 1.2) 
-- 이 외의 직급은 사원은 급여를 5%만 인상 (SALARY * 1.05) 

SELECT  EMP_NAME    "사원명"
        , JOB_CODE  "직급 코드"
        , SALARY    "기존 급여"
        , DECODE (JOB_CODE  , 'J7'  , SALARY * 1.1
                            , 'J6'  , SALARY * 1.15
                            , 'J5'  , SALARY * 1.2
                            , SALARY * 1.05
                )   "인상된 급여"
FROM    EMP;

/*
    2) CASE
        [표현법]
            CASE WHEN 조건식 1 THEN 결과값 1
                 WHEN 조건식 2 THEN 결과값 2
                 ...
                 ELSE 결과값 N
            END
*/

-- ELSE는 생략이 가능함! / END는 생략 불가!
SELECT  CASE    WHEN    SUBSTR(EMP_NO,8,1) = 1  THEN '남자'
                WHEN    SUBSTR(EMP_NO,8,1) = 2  THEN '여자'
                WHEN    SUBSTR(EMP_NO,8,1) = 3  THEN '남자'
                WHEN    SUBSTR(EMP_NO,8,1) = 4  THEN '여자'
                ELSE    '주민번호 확인요망'
        END
FROM    EMP;

-- 사원의 급여가 5000000 이상이면 고수익, 3000000이상이면 일반, 나머지는 ''
SELECT  CASE    WHEN    SALARY >= 5000000   THEN '고수익'
                WHEN    SALARY >= 3000000   THEN '일반'
                ELSE    ' '
        END     조회
FROM    EMP;

/*
    <SUBQUERY>
        하나의 SQL문 안에 포함된 또다른 SQL 문을 뜻한다.
        메인 쿼리 (기존쿼리)를 보조하는 역할을 하는 쿼리문
*/
-- 노옹철 사원과 같은 부서인 사원들의 이름과 부서코드를 조회 하시오!
-- 1. 노옹철 사원의 부서를 조회 
-- 2. 조건문에 값대신 서브쿼리를 대입
-- 주의) 서브쿼리는 괄호로 묶어준다!
-- 단일행 서브쿼리 : 서브쿼리의 실행결과가 행과 열의 갯수가 1개인 쿼리
-- 비교 연산자(>,<,=,>=,<=,!=)를 이용할 때
SELECT  EMP_NAME 사원명, DEPT_CODE 부서코드
FROM    EMP
WHERE   DEPT_CODE = (
                        SELECT  DEPT_CODE
                        FROM    EMP
                        WHERE   EMP_NAME = '노옹철'
                    );

SELECT  EMP_NAME 사원명, DEPT_CODE 부서코드, DEPT.DEPT_TITLE 부서이름
FROM    EMP, DEPT
WHERE   EMP.DEPT_CODE = DEPT.DEPT_ID
AND     DEPT_CODE = (
                        SELECT  DEPT_CODE
                        FROM    EMP
                        WHERE   EMP_NAME = '노옹철'
                    );

SELECT  EMP_NAME 사원명, DEPT_CODE 부서코드, DEPT.DEPT_TITLE 부서이름
FROM    EMP
JOIN    DEPT        ON  (EMP.DEPT_CODE = DEPT.DEPT_ID)
WHERE   DEPT_CODE = (
                        SELECT  DEPT_CODE
                        FROM    EMP
                        WHERE   EMP_NAME = '노옹철'
                    );

-- 2. 전 직원의 평균 급여보다 급여를 적게 받는 직원의 이름, 직급코드, 직급코드명, 급여를 조회
SELECT  EMP_NAME 직원명, EMP.JOB_CODE 직급코드, JOB_NAME, TO_CHAR(SALARY,'999,999,999') 급여
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     SALARY < (
                    SELECT  FLOOR (AVG ((SALARY)))
                    FROM    EMP
                );

-- 3. 최저 급여를 받는 직원의 사번, 이름, 직급 코드, 급여, 입사일 조회
SELECT  EMP_ID 사번, EMP_NAME 이름, JOB_CODE 직급코드, SALARY 급여, HIRE_DATE 입사일
FROM    EMP
WHERE   SALARY = (
            SELECT  MIN(SALARY)
            FROM    EMP
);

-- 4. 노옹철 사원의 급여보다 더 많은 급여받는 
-- 사원들의 사번, 사원명, 부서명, 직급 코드, 급여 조회
-- 노옹철 사원의 급여를 조회
SELECT  EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서명, JOB_CODE 직급코드, SALARY 급여
FROM    EMP
WHERE   SALARY > (
                    SELECT  SALARY
                    FROM    EMP
                    WHERE   EMP_NAME = '노옹철'
);

-- 5. 부서별 급여의 합이 가장 큰 부서의 
--    부서 코드, 급여의 합 조회
--    각 부서별 급여의 합 중에 가장 큰 급여의 합을 조회

-- 그룹으로 묶으면 묶을때 사용한 칼럼만 SELECT 절에 올 수 있다.
SELECT      MAX(SUM(SALARY))
FROM        EMP
GROUP BY    DEPT_CODE;

-- 전체 사원에 대한 급여의 합계 / 단일행 단일 컬럼
SELECT  SUM(SALARY)
FROM    EMP;

-- 부서별 사원의 합계 / 다중행
SELECT      SUM(SALARY)
FROM        EMP
GROUP BY    DEPT_CODE;

-- 직급별 급여의 평균
-- GROUP BY 절을 사용 하면 GROUP으로 묶을 컬럼만 조회가 가능하다.
SELECT      DEPT_CODE, JOB_CODE, AVG(SALARY), COUNT(*), COUNT(BONUS)
FROM        EMP
GROUP BY    DEPT_CODE, JOB_CODE;


SELECT      MAX(SUM(SALARY)), COUNT(SUM(SALARY))
FROM        EMP
GROUP BY    DEPT_CODE;

-- 집계함수에 대한 조건은 WHERE절에 올 수 없다!!
-- WHERE절은 단일 행에 대한 조건문을 작성 하는 곳이다. / 에러
-- ORA-00934: group function is not allowed here
SELECT  *
FROM    EMP
WHERE   SUM(SALARY) = (
    SELECT      MAX(SUM(SALARY))
    FROM        EMP
    GROUP BY    DEPT_CODE
);
-- HAVING : 집계함수에 대한 조건

SELECT  DEPT_CODE 부서코드, SUM(SALARY) 급여의합
FROM    EMP
GROUP BY    DEPT_CODE
HAVING SUM (SALARY) = (
    SELECT      MAX(SUM(SALARY))
    FROM        EMP
    GROUP BY    DEPT_CODE
);

-- 6. 부서별 평균(소수점버림)급여가 가장 작은 부서의 부서코드와 부서명 평균급여를 조회
🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔;
-- GROUP BY에서 문제 발생 DEPT_TITLE 추가로 해결
SELECT      EMP.DEPT_CODE 부서코드, DEPT.DEPT_TITLE 부서명, FLOOR(AVG(SALARY)) 평균급여
FROM        EMP, DEPT
WHERE       EMP.DEPT_CODE = DEPT.DEPT_ID
GROUP BY    DEPT_CODE, DEPT_TITLE
HAVING      FLOOR(AVG(SALARY)) = (
                SELECT      FLOOR(MIN(AVG(SALARY)))
                FROM        EMP
                GROUP BY    DEPT_CODE
);

-- T)해설
SELECT  AVG(SALARY) FROM EMP;
-- 부서별 평균급여
SELECT  AVG(SALARY) 
FROM    EMP
GROUP BY DEPT_CODE;
-- 부서별 평균급여가 가장 작은 값
SELECT  FLOOR(MIN(AVG(SALARY)))
FROM    EMP
GROUP BY DEPT_CODE;

SELECT  DEPT_CODE, DEPT_TITLE, FLOOR(AVG(SALARY))
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING  FLOOR(AVG(SALARY)) = (
                                SELECT  FLOOR(MIN(AVG(SALARY)))
                                FROM    EMP
                                GROUP BY DEPT_CODE
                              );



-- 7. 전지연 사원이 속해있는 부서원들 조회 (단, 전지연 사원은 제외)
-- 사번, 사원명, 전화번호, 직급명, 부서명, 입사일 
-- 전지연 사원이 속해있는 부서 조회 
SELECT  DEPT_CODE
FROM    EMP
WHERE   EMP_NAME = '전지연';

SELECT  JOB_NAME
FROM    JOB
WHERE   JOB_CODE = 'J1';

-- 오라클
SELECT EMP_ID 사번, EMP_NAME 사원명, PHONE 전화번호
        , (
            SELECT JOB_NAME
            FROM JOB
            WHERE JOB.JOB_CODE = EMP.JOB_CODE
        ) 직급명
        , (
            SELECT  DEPT_TITLE
            FROM    DEPT
            WHERE   DEPT.DEPT_ID = EMP.DEPT_CODE
        ) 부서명
        , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일
FROM    EMP
WHERE   DEPT_CODE = (
    SELECT  DEPT_CODE
    FROM    EMP
    WHERE   EMP_NAME = '전지연'
    )
AND EMP_NAME != '전지연';

SELECT EMP_ID 사번, EMP_NAME 사원명, PHONE 전화번호
        , DEPT_TITLE 부서명
        , JOB_NAME 직급명
        , TO_CHAR (HIRE_DATE,'YYYY-MM-DD') 입사일
FROM    EMP, JOB, DEPT
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     DEPT_CODE = DEPT_ID
AND     DEPT_CODE = (
    SELECT  DEPT_CODE
    FROM    EMP
    WHERE   EMP_NAME = '전지연'
)
AND     EMP_NAME != '전지연';

-- ANSI
SELECT EMP_ID 사번, EMP_NAME 사원명, PHONE 전화번호
        , DEPT_TITLE 부서명
        , JOB_NAME 직급명
        , TO_CHAR (HIRE_DATE,'YYYY-MM-DD') 입사일
FROM    EMP
JOIN    JOB USING (JOB_CODE)
JOIN    DEPT ON (DEPT_ID = DEPT_CODE)
WHERE   DEPT_CODE = (
    SELECT  DEPT_CODE
    FROM    EMP
    WHERE   EMP_NAME = '전지연'
)
AND     EMP_NAME != '전지연';

-- 다중행 서브쿼리 : 서브쿼리의 조회 결과 값이 여러 행인 경우

/*
    2) 다중행 서브쿼리 : 서브쿼리의 조회 결과 값이 여러행 일대
    
    IN / NOT IN (서브쿼리)
        여러개의 결과값중 하나라도 일치하면  TRUE를 리턴
        -> WHERE절에서 조건을 만족 할경우 TRUE (결과집합에 포함)

    ANY : 여러개의 값들중 한개라도 만족 하면 TRUE
            IN과 다른점 : 비교연산자를 함께 사용 할수 있다
            EX) SALARY = ANY(....) : IN과 같은 결과
                SALARY != ANY(....): NOT IN과 같은 결과
                SALARY > ANY(10000000,2000000,3000000) : 최소값 보다 크면 TRUE
                SALARY < ANY(10000000,2000000,3000000) : 최대값 보다 작으면 TRUE
            
    ALL : 여러 개의 값들 모두와 비교하여 만족해야 TRUE
                SALARY > ALL(10000000,2000000,3000000) : 최대값 보다 크면 TRUE
                SALARY < ALL(10000000,2000000,3000000) : 최소값 보다 작으면 TRUE        
*/ 

-- 1) 각 부서별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회
-- 각 부서별 최고 급여를 조회
-- (부서코드, 최고급여) IN (서브쿼리)
SELECT      EMP_NAME 직원명, JOB_CODE 직급코드, DEPT_CODE 부서코드, SALARY 급여
FROM        EMP
WHERE       (DEPT_CODE, SALARY) IN (
        SELECT      DEPT_CODE, MAX(SALARY)
        FROM        EMP
        WHERE       DEPT_CODE IS NOT NULL
        GROUP BY    DEPT_CODE   
);

-- 2) 전 직원들에 대해 사번, 이름, 부서코드, 구분 (매니저/사원)
-- 매니저의 사번을 조회 / 중복을 제거
SELECT  DISTINCT    MANAGER_ID
FROM    EMP
WHERE   MANAGER_ID  IS NOT NULL;

SELECT  DISTINCT    MANAGER_ID
FROM    EMP
WHERE   MANAGER_ID  IS NOT NULL
AND     MANAGER_ID = 200;

-- 매니저 정보
SELECT  EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, '매니저' 구분
FROM    EMP
WHERE   EMP_ID  IN  (
    SELECT  DISTINCT    MANAGER_ID
    FROM    EMP
    WHERE   MANAGER_ID IS NOT NULL
)
UNION
-- 사원 결과 집합
SELECT  EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, '사원' 구분
FROM    EMP
WHERE   EMP_ID  NOT IN  (
    SELECT  DISTINCT    MANAGER_ID
    FROM    EMP
    WHERE   MANAGER_ID IS NOT NULL
)
-- 컬럼 이름에 별칭을 사용한 경우 컬럼명으로 접근이 불가능!
ORDER BY 사번;


SELECT  '매니져'
FROM    DUAL
UNION ALL
SELECT  '사원'
FROM    DUAL;

-- SELECT 절에서 서브쿼리를 이용하여 사원/매니저를 구분
-- EMP_ID가 매니저사번에 있다면 사번이 조회
-- 없으면 조회가 안됨
SELECT  DISTINCT MANAGER_ID 매니저의사번
FROM    EMP
WHERE   MANAGER_ID IS NOT NULL
AND     MANAGER_ID  = 200;

SELECT  EMP_ID,
    DECODE ((
        SELECT  DISTINCT MANAGER_ID 매니저의사번
        -- 테이블의 이름이 똑같으므로 별칭을 주어서 구분
        FROM    EMP M
        WHERE   MANAGER_ID IS NOT NULL
        -- 서브쿼리에서 사용되는 컬럼이 메인 테이블을 참조하는 경우, 테이블 이름을 명시해야 합니다.
        AND     MANAGER_ID  = EMP.EMP_ID
    ) , NULL, '사원'
    , '매니져'
    ) RNQNS
FROM    EMP;


-- EMP ID가 관리자로 몇 번 사용되었는지 조회
SELECT  COUNT(*) FROM EMP M WHERE M.MANAGER_ID = 200;

SELECT  EMP_ID, (SELECT  COUNT(*) FROM EMP M WHERE M.MANAGER_ID = EMP.EMP_ID)
        ,   CASE WHEN (SELECT  COUNT(*) FROM EMP M WHERE M.MANAGER_ID = EMP.EMP_ID) > 0
        THEN '매니저' ELSE '사원' END 구분
FROM  EMP
ORDER BY 구분;

SELECT  DISTINCT    MANAGER_ID
FROM    EMP
WHERE   MANAGER_ID  IS NOT NULL
AND     MANAGER_ID = 200;

-- 3) 대리 직급임에도 과장 직급들의 최소 급여보다 많이 받는
-- 직원의 사번, 이름, 직급명, 급여 조회

SELECT  EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     JOB_NAME = '대리'
AND     SALARY > (
    SELECT  MIN(SALARY)
    FROM    EMP, JOB
    WHERE   EMP.JOB_CODE = JOB.JOB_CODE
    AND     JOB_NAME = '과장'
);

SELECT  SALARY
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     JOB_NAME = '과장';

-- ANY > 최소값
SELECT  EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     JOB_NAME = '대리'
AND     SALARY > ANY (
    SELECT  SALARY
    FROM    EMP, JOB
    WHERE   EMP.JOB_CODE = JOB.JOB_CODE
    AND     JOB_NAME = '과장'
);

-- ALL > 최대값
SELECT  EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     JOB_NAME = '대리'
AND     SALARY > ANY (
    SELECT  SALARY
    FROM    EMP
    WHERE   JOB_CODE = (
        SELECT  JOB_CODE
        FROM    JOB
        WHERE   JOB_NAME = '과장'
    )
);

-- 쿼리의 실행순서에 의해 SELECT -> ORDER BY
SELECT  *
FROM    (
    -- 2. 조건을 주기 위해서 / 실행이 되어야 번호가 생성이 되기때문에
    SELECT  ROWNUM RN, EMP_NAME
    FROM    (
        -- 1. 정렬 후 번호를 붙일 수 있도록 / 정렬이 조회보다 느리게 실행되기때문
            SELECT      EMP_ID, EMP_NAME
            FROM        EMP
            ORDER BY    EMP_NAME
    )
)
WHERE   RN  BETWEEN 11   AND 20;

-- 4) 과장 직급임에도 차장 직급의 최대 급여보다 더 많이 받는 
-- 직원들의 사번, 이름, 직급명, 급여 조회 

SELECT  EMP_ID 사번
        , EMP_NAME 이름
        , JOB_NAME 직급명
        , SALARY 급여
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     JOB_NAME = '과장'
AND     SALARY > (
    SELECT      MAX(SALARY)
    FROM        EMP, JOB
    WHERE       EMP.JOB_CODE = JOB.JOB_CODE
    AND         JOB_NAME = '차장'
    GROUP BY    JOB_NAME
);

SELECT  EMP_ID 사번
        , EMP_NAME 이름
        , JOB_NAME 직급명
        , SALARY 급여
FROM    EMP
JOIN    JOB USING (JOB_CODE)
WHERE   JOB_NAME = '과장'
AND     SALARY > (
    SELECT      MAX(SALARY)
    FROM        EMP
    JOIN        JOB USING (JOB_CODE)
    WHERE       JOB_NAME = '차장'
    GROUP BY    JOB_NAME
);

