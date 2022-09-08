SELECT TABLE_NAME FROM USER_TABLES

-- LIST THE STAFF FIRST NAME, LAST NAME AND THE CITY OF THE BTRANCH WHERE THEY ARE WORKING IN 

SELECT * FROM STAFF
SELECT * FROM BRANCH

--JOINING RELATIONAL TABLE (HAVING P-KEY & F-KEY)
--PREFERABLE WAY(TO AVOID LOGICAL ERROR)

SELECT FNAME, LNAME, CITY
FROM STAFF JOIN BRANCH
ON STAFF.BRANCHNO = BRANCH.BRANCHNO

--ANOTHER WAY OF JOINING COLOMN FROM MULTIPLE TABLES

SELECT FNAME, LNAME, CITY
FROM STAFF S , BRANCH B
WHERE S.BRANCHNO = B.BRANCHNO

SELECT FNAME, LNAME, B.CITY, S.BRANCHNO, ROOMS, TYPE
FROM STAFF S , BRANCH B, PROPERTYFORRENT P
WHERE S.BRANCHNO = B.BRANCHNO
AND S.STAFFNO = P.STAFFNO

SELECT * FROM CLIENT;
SELECT * FROM VIEWING;

--C.*,V.* FROM CLIENT C, VIEWING V
SELECT FNAME,LNAME, VCOMMENT
FROM CLIENT JOIN VIEWING 
ON CLIENT.CLIENTNO = VIEWING.CLIENTNO

--SELECT *
-- FROM CLIENT NATURAL JOIN VIEWING

-- LIST NUMBERS AND NAMES OF STAFF WHO MANAGES PROPERTIES, AND PROPERTIES THEY MANAGE.
SELECT * FROM STAFF;
SELECT * FROM PREPERTYFORRENT;

SELECT FNAME, LNAME, PROPERTYNO, TYPE
FROM STAFF S JOIN PROPERTYFORRENT P
ON S.STAFFNO = P.STAFFNO

--LIST NAMES OF ALL CLIENTS WHO HAVE VIEWED A PROPERTY ALONG WITH ANY COMMENT SUPPLIED AND INCLUDE THE NUMBER OF ROOMS

SELECT FNAME, LNAME, V.PROPERTYNO, VCOMMENT, ROOMS

FROM CLIENT C JOIN VIEWING V
ON C.CLIENTNO = V.CLIENTNO
JOIN PROPERTYFORRENT P
ON V.PROPERTYNO = P.PROPERTYNO

SELECT FNAME, LNAME, PROPERTYNO, VCOMMENT, ROOMS
FROM CLIENT NATURAL JOIN VIEWING NATURAL JOIN  PROPERTYFORRENT
----------------------------------------
-- JOINING 2 DIFFERENT TABLES

SELECT * FROM CLIENT
SELECT * FROM VIEWING

SELECT C.*, V.*
FROM CLIENT C LEFT JOIN VIEWING V
ON C.CLIENTNO = V.CLIENTNO
-----------------------

SELECT * FROM STAFF;
SELECT * FROM PROPERTYFORRENT;

SELECT S.*, P.*
FROM STAFF S LEFT JOIN PROPERTYFORRENT P
ON S.STAFFNO = P.STAFFNO

SELECT S.*, P.*
FROM STAFF S RIGHT JOIN PROPERTYFORRENT P
ON S.STAFFNO = P.STAFFNO

SELECT S.*, P.*
FROM STAFF S FULL JOIN PROPERTYFORRENT P
ON S.STAFFNO = P.STAFFNO

---------------------------------------






