CREATE TABLE Books (
    AccNo INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Publisher VARCHAR(255),
    Count INT
);

CREATE TABLE Library_Audit (
    AccNo INT,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Publisher VARCHAR(255),
    Count INT,
    Audit_Date DATE,
    Status VARCHAR(50)
);

-- Trigger for deletion (before deletion)
CREATE OR REPLACE TRIGGER before_delete_books
BEFORE DELETE ON Books
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (AccNo, Title, Author, Publisher, Count, Audit_Date, Status)
    VALUES (:OLD.AccNo, :OLD.Title, :OLD.Author, :OLD.Publisher, :OLD.Count, SYSDATE, 'deleted');
END;
/


-- Trigger for update (after update)
CREATE OR REPLACE TRIGGER after_update_books
AFTER UPDATE ON Books
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (AccNo, Title, Author, Publisher, Count, Audit_Date, Status)
    VALUES (:NEW.AccNo, :NEW.Title, :NEW.Author, :NEW.Publisher, :NEW.Count, SYSDATE, 'updated');
END;
/

