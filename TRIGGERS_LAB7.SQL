--LAB7--

--1. Create the following table named "Employee”: -
CREATE TABLE EMPLOYEE
(
EMP_ID INTEGER PRIMARY KEY,
NAME VARCHAR(30),
SALARY numeric(8,2),
GENDER VARCHAR(10),
DEPARTMENT_NAME VARCHAR(20)
)
-- Insert data into Employee table
INSERT INTO Employee VALUES (1,'Papero', 5000, 'Male', 'Finance');
INSERT INTO Employee VALUES (2,'Priyanka', 5400, 'Female', 'IT');
INSERT INTO Employee VALUES (3,'Anurag', 6500, 'male', 'IT');
INSERT INTO Employee VALUES (4,'Samon', 4700, 'Male', 'HR');
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 'Finance');

--2. Create the following table named "Logs" that will contain the activity of the trigger.
CREATE TABLE LOGS 
( 
ACTIVITY VARCHAR(30), 
ACTIVITY_DATE TIMESTAMP
)

-- 3. Create After Trigger named trg_activity_log. This trigger will be fired whenever a change has 
-- been made in the Employee table. The trigger adds the row in the "Logs" table after the 
-- triggering statement executes, and uses the conditional predicates INSERTING, UPDATING, 
-- and DELETING to determine which of the three possible DML statements fired the trigger. 
-- For example, in your trigger if the action is inserting the values ('Data is inserted', Sysdate) 
-- will be inserted into the Logs table.

CREATE OR REPLACE TRIGGER trg_activity_log 
AFTER UPDATE OR INSERT OR DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOGS VALUES('Data is inserted', Sysdate);
ELSIF UPDATING THEN
INSERT INTO LOGS VALUES('Data is UPDATED', Sysdate);
ELSE
INSERT INTO LOGS VALUES('Data is DELETED', Sysdate);
END IF;
END;


-- 4. Test your trigger by Inserting the following row in the "Employee" table: (Insert into Employee 
-- the 
VALUES(6,'Rahul',20000,'Female','Finance')
-- . The trigger will be executed
-- automatically. Check both tables and see. Try to UPDATE and DELETE Employee table and 
-- report the results

INSERT INTO EMPLOYEE VALUES(6,'Rahul',20000,'Female','Finance');

SELECT * FROM EMPLOYEE;
SELECT * FROM LOGS;


-- 5. Create a trigger named trg_delemployee_record that raisesthe application error 'DONT have 
-- permission to delete from that table' before deleting the row containing the employee name
-- 'Anurag' from Employee table. Test your trigger

CREATE OR REPLACE TRIGGER trg_delemployee_record
BEFORE DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
RAISE_APPLICATION_ERROR (-20001, 'YOU CANT DELETE AN EMPLOYEE NAME');
END;


-- 6. Create the following Department table:

CREATE TABLE Department
( 
Dept_name VARCHAR(20) primary key, 
Dept_location VARCHAR(30) 
)
INSERT INTO Department VALUES ('Finance', 'LONDON');
INSERT INTO Department VALUES ('IT','NEW YORK');
INSERT INTO Department VALUES ('HR','MONTREAL');
INSERT INTO Department VALUES ('ADMIN.','MONTREAL');


-- a) Alter Employee table by adding a foreign key constraint on DEPARTMENT_NAME
 ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_DEPT_NAME FOREIGN KEY (Department_Name) REFERENCES Department;

-- b) Now let’s create a trigger that shall fire upon the DELETE statement on 
-- the DEPARTMENT table. Your trigger must satisfy the following requirement:

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM LOGS;

CREATE OR REPLACE TRIGGER DEPT_DEL
BEFORE DELETE ON DEPARTMENT
FOR EACH ROW
DECLARE 
INTEGEXCEPTION EXCEPTION;
VCOUNT VARCHAR(30);
BEGIN
SELECT COUNT(*) INTO VCOUNT FROM EMPLOYEE 
WHERE NAME = :OLD.DEPT_NAME;
IF (VCOUNT > 0) THEN
RAISE INTEGEXCEPTION;
END IF;
EXCEPTION 
WHEN INTEGEXCEPTION THEN
RAISE_APPLICATION_ERROR (-20001,'CANT BE DELETED');
END;

-- a. Perform the action before DELETE
-- b. Use the IF statement to determine if the row should or should not be deleted. If 
-- it should, the DELETE statement will be performed, and if should not, thrown an 
-- exception
-- c. Run the below statement (why or why not it went without an error)
 DELETE FROM DEPARTMENT WHERE DEPT_NAME = 'ADMIN'
-- d. If we run this statement, what will you have?
 
 DELETE FROM DEPARTMENT WHERE DEPT_NAME = 'IT';





