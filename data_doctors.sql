DELIMITER $$
CREATE PROCEDURE GenerateDoctors()
BEGIN
DECLARE i INT DEFAULT 0;
DECLARE doc_name VARCHAR(100);
DECLARE gender_id BIGINT;
DECLARE dept_id BIGINT;
DECLARE desig_id BIGINT;
DECLARE contact_num VARCHAR(15);
DECLARE email_addr VARCHAR(100);

SET @first_names = '["Aarav", "Vivaan", "Aditya", "Vihaan", "Arjun", "Sai", "Reyansh", "Ayaan", "Krishna", "Ishaan", "Priya", "Saanvi", "Aanya", "Aadhya", "Ananya", "Pari", "Diya", "Riya", "Anika", "Isha"]';
SET @last_names = '["Patel", "Sharma", "Kumar", "Singh", "Gupta", "Reddy", "Menon", "Joshi", "Verma", "Rao", "Nair", "Iyer", "Kulkarni", "Deshpande", "Shah"]';

WHILE i < 250 DO
-- Generate random data
SET doc_name = CONCAT(
	JSON_UNQUOTE(JSON_EXTRACT(@first_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@first_names)), ']'))), ' ',
	JSON_UNQUOTE(JSON_EXTRACT(@last_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@last_names)), ']')))
);
SET gender_id = FLOOR(1 + RAND() * 2); -- Assuming 1:Male, 2:Female
SET dept_id = FLOOR(1 + RAND() * 10); -- Assuming 10 departments
SET desig_id = FLOOR(1 + RAND() * 5); -- Assuming first 5 are doctor designations
SET contact_num = CONCAT('9', LPAD(FLOOR(RAND() * 1000000000), 9, '0'));
SET email_addr = CONCAT(LOWER(REPLACE(doc_name, ' ', '.')), i, '@hims.com');

-- Insert into Doctor table
INSERT INTO Doctor (DoctorName, GenderID, DepartmentID, DesignationID, ContactNumber, Email, Address)
VALUES (doc_name, gender_id, dept_id, desig_id, contact_num, email_addr, '123 Hospital Road, Pune');

SET i = i + 1;
END WHILE;
END$$
DELIMITER ;

-- To run the procedure and generate the data:
CALL GenerateDoctors();