SELECT * FROM EMPLOYEE
SELECT * FROM DEPARTMENT
SELECT * FROM PROJECT
SELECT * FROM WORKS_ON


--1. Get full details of all employees, including the location of their department
SELECT *
FROM EMPLOYEE JOIN DEPARTMENT
ON EMPLOYEE.DEPT_NO = DEPARTMENT.DEPT_NO


--2. Get the enter dates of all clerks who belong to the department d1.

SELECT ENTER_DATE, JOB, DEPT_NO
FROM WORKS_ON W JOIN EMPLOYEE E
ON W.EMP_NO = E.EMP_NO
WHERE UPPER(JOB) = 'CLERK' AND UPPER(DEPT_NO) = 'D1'

--3. Get full details of all employees who work on the project Gemini.

SELECT E.*, PROJECT_NAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN PROJECT P
ON P.PROJECT_NO = W.PROJECT_NO
WHERE UPPER(PROJECT_NAME) = 'GEMINI'


--4. Get the department number for all employees who entered their projects on October 15, 2017

SELECT *
FROM EMPLOYEE JOIN WORKS_ON
ON EMPLOYEE.EMP_NO = WORKS_ON.EMP_NO
WHERE ENTER_DATE = '2017-10-15'


--5. Get full details of each employee; that is, besides the employee’s number, first and last 
--names, and corresponding department number, also get the name of his or her 
--department and its location.

SELECT *
FROM EMPLOYEE JOIN DEPARTMENT
ON EMPLOYEE.DEPT_NO = DEPARTMENT.DEPT_NO


--6. Get the first and last names of all analysts whose department is located in Seattle:

SELECT * 
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN DEPARTMENT D
ON E.DEPT_NO = D.DEPT_NO
WHERE UPPER(JOB) = 'ANALYST' AND UPPER(LOCATION) = 'SEATTLE'


--7. Get the names of projects (with redundant duplicates eliminated) being worked on by 
--employees in the Accounting department.
SELECT DISTINCT PROJECT_NAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN PROJECT P
ON P.PROJECT_NO = W.PROJECT_NO
JOIN DEPARTMENT D
ON E.DEPT_NO = D.DEPT_NO
WHERE UPPER(DEPT_NAME) = 'ACCOUNTING'


--8. Get the first and last names of all employees who work for department Research or Accounting.

SELECT EMP_FNAME, EMP_LNAME
FROM EMPLOYEE E JOIN DEPARTMENT D
ON E.DEPT_NO = D.DEPT_NO
WHERE UPPER(DEPT_NAME) = 'RESEARCH' OR UPPER(DEPT_NAME) = 'ACCOUNTING'


--9. Get the names of projects on which two or more clerks are working. 

SELECT PROJECT_NAME, COUNT(EMP_NO) AS "CLERKS EMPLOYEES"
FROM PROJECT P JOIN WORKS_ON W
ON P.PROJECT_NO = W.PROJECT_NO
WHERE UPPER(JOB) = 'CLERK'
GROUP BY PROJECT_NAME
HAVING COUNT(EMP_NO) >= 2


--10. Get the first and last names of the employees who are managers and work on project Apollo.

SELECT EMP_FNAME, EMP_LNAME
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.EMP_NO = W.EMP_NO
JOIN PROJECT P
ON W.PROJECT_NO = P.PROJECT_NO
WHERE UPPER(JOB) = 'MANAGER' AND UPPER(PROJECT_NAME) = 'APOLLO'

