SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM DEPARTMENT;
SELECT * FROM WORKS_ON;

--A1
ALTER TABLE PROJECT 
ADD CONSTRAINT BUDGET_RANGE CHECK (budget > 10000 AND budget < 1500000);

--A2
ALTER TABLE PROJECT 
ADD CONSTRAINT PROJECT_NAME_UK UNIQUE (PROJECT_NAME);

--A3
ALTER TABLE EMPLOYEE
MODIFY EMP_FNAME VARCHAR(30);
ALTER TABLE EMPLOYEE
MODIFY EMP_LNAME VARCHAR(30);

--A4
ALTER TABLE EMPLOYEE
ADD TELEPHONE_NO CHAR(10);

--A5
ALTER TABLE EMPLOYEE
DROP COLUMN TELEPHONE_NO;

--B1
SELECT EMP_FNAME, EMP_LNAME
FROM EMPLOYEE
WHERE DEPT_NO = (SELECT DEPT_NO
FROM DEPARTMENT
WHERE DEPT_NAME ='Research');

--B2
SELECT * 
FROM EMPLOYEE
WHERE DEPT_NO IN (
                    SELECT DEPT_NO
                    FROM DEPARTMENT
                    WHERE LOCATION = 'Dallas');

--B3
SELECT EMP_LNAME
FROM EMPLOYEE
WHERE EMP_NO IN
                (SELECT EMP_NO
                FROM WORKS_ON
                WHERE PROJECT_NO = 
                                (SELECT PROJECT_NO
                                FROM PROJECT
                                WHERE PROJECT_NAME = 'Apollo'));


--B4
SELECT EMP_NO, ENTER_DATE
FROM WORKS_ON
WHERE ENTER_DATE IN 
                (SELECT MIN (ENTER_DATE)
                FROM WORKS_ON);

--B5
SELECT EMP_LNAME, EMP_FNAME
FROM EMPLOYEE
WHERE EMP_NO = 
                (SELECT EMP_NO FROM WORKS_ON
                WHERE ENTER_DATE = '2017-01-04');
                

-- B6
SELECT EMP_NO 
FROM WORKS_ON
WHERE JOB = 'Clerk' OR EMP_NO IN 
                                    (SELECT EMP_NO FROM EMPLOYEE
                                     WHERE DEPT_NO = (SELECT DEPT_NO FROM DEPARTMENT
                                                      WHERE DEPT_NO = 'd3'));
                                 

-- B7
SELECT PROJECT_NO, PROJECT_NAME
FROM PROJECT
WHERE BUDGET = 
                (SELECT MAX(BUDGET) FROM PROJECT);


-- B8
SELECT PROJECT_NAME 
FROM PROJECT
WHERE PROJECT_NO =      
                        (SELECT PROJECT_NO FROM WORKS_ON
                        WHERE JOB = 'Clerk'
                        GROUP BY PROJECT_NO
                        HAVING COUNT(JOB)>1);
                        
-- B9
SELECT EMP_LNAME 
FROM EMPLOYEE
WHERE NOT EXISTs 
                    (SELECT * FROM WORKS_ON);
-- B10
SELECT EMP_LNAME 
FROM EMPLOYEE
WHERE DEPT_NO NOT IN
                        (SELECT DEPT_NO FROM DEPARTMENT
                       WHERE LOCATION = 'Seattle');


