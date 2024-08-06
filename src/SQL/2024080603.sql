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