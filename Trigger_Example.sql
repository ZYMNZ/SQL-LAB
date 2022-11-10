
/*Create a trigger that will write the correct value to DETAIL_DAYSLATE in the DETAILRENTAL 
table whenever a video is returned. The trigger should execute as a BEFORE trigger when the 
DETAIL_RETURNDATE or DETAIL_DUEDATE attributes are updated. The trigger should satisfy 
the following conditions.
a) If the return date is null, then the days late should also be null.
b) If the return date is after the due date, then the video is considered late so the number 
of days late must be calculated and stored (the number of days late = 
DETAIL_RETURNDATE - DETAIL_DUEDATE). 
c) Test your trigger.*/

CREATE OR REPLACE TRIGGER TRG_LATE_RETURN
BEFORE UPDATE OF DETAIL_RETURNDATE , DETAIL_DUEDATE ON DETAILRENTAL
FOR EACH ROW
BEGIN
--A 
 IF :NEW.DETAIL_RETURNDATE IS NULL THEN
  :NEW.DETAIL_DAYSLATE := NULL;
--B
ELSIF :NEW.DETAIL_RETURNDATE >= :NEW.DETAIL_DUEDATE THEN
        :NEW.DETAIL_DAYSLATE := :NEW.DETAIL_RETURNDATE - :NEW.DETAIL_DUEDATE ;
ELSE 
  :NEW.DETAIL_DAYSLATE :=0;
END IF;
END;

SELECT * FROM DETAILRENTAL;
--C TRIGGER TEST (1) AHEAD OF TIME 2) ON TIME 3) OVERDUE)
UPDATE DETAILRENTAL
SET DETAIL_RETURNDATE = TO_DATE ('01-03-09', 'DD-MM-YY')
WHERE RENT_NUM = '1001' AND VID_NUM = '34342';

UPDATE DETAILRENTAL
SET DETAIL_RETURNDATE = TO_DATE ('01-04-09', 'DD-MM-YY')
WHERE RENT_NUM = '1001' AND VID_NUM = '34342';

UPDATE DETAILRENTAL
SET DETAIL_RETURNDATE = TO_DATE ('04-03-09', 'DD-MM-YY')
WHERE RENT_NUM = '1001' AND VID_NUM = '34342';

UPDATE DETAILRENTAL
SET DETAIL_RETURNDATE = NULL
WHERE RENT_NUM = '1001' AND VID_NUM = '34342';

CREATE OR REPLACE TRIGGER TRG_MEM_BALANCE
AFTER UPDATE OF DETAIL_RETURNDATE , DETAIL_DUEDATE ON DETAILRENTAL
FOR EACH ROW
DECLARE
PRIOR_LATEFEE NUMBER(8,2);
NEW_LATEFEE NUMBER (8,2);
NEW_AMOUNT NUMBER (8,2);
MEMNO MEMBERSHIP.MEM_NUM%TYPE;
BEGIN
--a) Calculate the value of the late fee prior to the update that triggered this execution of 
--the trigger. The value of the late fee is the days late times the daily late fee. If the 
--previous value of the late fee was null, then treat it as zero (0). 
PRIOR_LATEFEE := :OLD.DETAIL_DAYSLATE * :OLD.DETAIL_DALYLATEFEE;
IF PRIOR_LATEFEE IS NULL THEN PRIOR_LATEFEE := 0;
END IF;
--b) Calculate the value of the late fee after the update that triggered this execution of the 
-- trigger. If the value of the late fee is now null, then treat it as zero (0).
NEW_LATEFEE := :NEW.DETAIL_DAYSLATE * :NEW.DETAIL_DALYLATEFEE;
IF NEW_LATEFEE IS NULL THEN NEW_LATEFEE := 0;
END IF;
--c) Subtract the prior value of the late fee from the current value of the late fee to 
-- determine the change in late fee for this video rental.
NEW_AMOUNT := NEW_LATEFEE - PRIOR_LATEFEE;
--d) If the amount calculated in part c is not zero (0), then update the membership balance 
--by the amount calculated for the membership associated the rental that this detail is 
--a part of.
IF NEW_AMOUNT <> 0 THEN 
-- TO GET THE MEM_NUM
SELECT MEM_NUM INTO MEMNO
FROM RENTAL
WHERE RENT_NUM = :NEW.RENT_NUM;
-- UPDATE THE MEMBER BALANCE
UPDATE MEMBERSHIP
SET MEM_BALANCE = MEM_BALANCE + NEW_AMOUNT
WHERE MEM_NUM = MEMNO;
END IF;
END;


--C TRIGGER TEST (1) AHEAD OF TIME 2) ON TIME 3) OVERDUE)
UPDATE DETAILRENTAL
SET DETAIL_RETURNDATE = TO_DATE ('01-03-09', 'DD-MM-YY')
WHERE RENT_NUM = '1001' AND VID_NUM = '34342';

UPDATE DETAILRENTAL
SET DETAIL_RETURNDATE = TO_DATE ('01-06-09', 'DD-MM-YY')
WHERE RENT_NUM = '1001' AND VID_NUM = '34342';

UPDATE DETAILRENTAL
SET DETAIL_RETURNDATE = TO_DATE ('04-03-09', 'DD-MM-YY')
WHERE RENT_NUM = '1001' AND VID_NUM = '34342';

UPDATE DETAILRENTAL
SET DETAIL_RETURNDATE = NULL
WHERE RENT_NUM = '1001' AND VID_NUM = '34342';

SELECT * FROM MEMBERSHIP;
SELECT * FROM RENTAL;
