CREATE TABLE borrow ( 
rollin INT, 
name VARCHAR2(20), 
dt_issue DATE, 
nameofbook VARCHAR2(50), 
status CHAR(1) 
); 
INSERT INTO borrow VALUES (1, 'aa', DATE '2024-08-20', 'dbms', 'I'); 
INSERT INTO borrow VALUES (2, 'cc', DATE '2024-07-20', 'db', 'I'); 
INSERT INTO borrow VALUES (3, 'bb', DATE '2024-07-30', 'db1', 'I'); 
CREATE TABLE fine ( 
roll INT, 
rdate DATE, 
f
 ineamt INT 
); 
DECLARE 
roll INT := 3; -- Specified roll number 
famount INT := 0; 
idate DATE; 
days INT; 
sta CHAR(1); 
record_count INT; 
BEGIN -- Count the records to ensure roll number exists 
  SELECT COUNT(*) INTO record_count FROM borrow WHERE rollin = roll; 
 
  -- If the roll number exists, proceed with fine calculation 
  IF record_count > 0 THEN 
    -- Fetch the issue date and status for the specified roll number 
    SELECT dt_issue, status INTO idate, sta FROM borrow WHERE rollin = roll AND ROWNUM = 
1; 
     
    -- Check if the book status is 'I' (Issued) 
    IF sta = 'I' THEN 
      -- Calculate the number of days overdue 
      days := TRUNC(SYSDATE) - idate; 
      DBMS_OUTPUT.PUT_LINE('No of days: ' || days); 
 
      -- Determine the fine amount based on the overdue days 
      IF days BETWEEN 15 AND 30 THEN 
        famount := (days - 15) * 5; 
      ELSIF days > 30 THEN 
        famount := ((days - 30) * 50); 
      END IF; 
 
      DBMS_OUTPUT.PUT_LINE('Fine amount: ' || famount); 
 
      -- Insert a record in the fine table 
      INSERT INTO fine VALUES (roll, SYSDATE, famount); 
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Status is R'); 
    END IF; 
 
    -- Update the borrow table to mark the book as returned 
UPDATE borrow SET status = 'R' WHERE rollin = roll; 
ELSE 
DBMS_OUTPUT.PUT_LINE('Roll no does not exist'); 
END IF; 
EXCEPTION 
WHEN NO_DATA_FOUND THEN 
DBMS_OUTPUT.PUT_LINE('Roll no does not exist'); 
END; 
/ 