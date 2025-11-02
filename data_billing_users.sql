-- Part 1: Generate Staff (~500) & Users (~300)
DELIMITER $$
CREATE PROCEDURE GenerateStaffAndUsers()
BEGIN
DECLARE i INT DEFAULT 0;
DECLARE staff_name VARCHAR(100);
DECLARE new_staff_id BIGINT;
SET @first_names = '["Amit", "Bharat", "Chetan", "Deepak", "Gaurav", "Harish", "Jyoti", "Kavita", "Lata", "Meena", "Neha", "Pooja"]';
SET @last_names = '["Jain", "Mehta", "Chopra", "Das", "Yadav", "Saxena", "Agarwal"]';

-- Generate Staff
WHILE i < 500 DO
	SET staff_name = CONCAT(
		JSON_UNQUOTE(JSON_EXTRACT(@first_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@first_names)), ']'))), ' ',
		JSON_UNQUOTE(JSON_EXTRACT(@last_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@last_names)), ']')))
	);
	INSERT INTO Staff (StaffName, GenderID, DesignationID, ContactNumber, Address)
	VALUES (
		staff_name,
		FLOOR(1 + RAND() * 2),
		FLOOR(6 + RAND() * 7), -- Designations 6 through 12 are non-doctor staff
		CONCAT('7', LPAD(FLOOR(RAND() * 1000000000), 9, '0')),
		'456 Staff Quarters, Pune'
	);
	SET i = i + 1;
END WHILE;

-- Generate Users for the first 300 staff members
SET i = 1;
WHILE i <= 300 DO
	INSERT INTO `User` (Username, PasswordHash, Role, StaffID)
	VALUES (
		LOWER(REPLACE((SELECT StaffName FROM Staff WHERE StaffID = i), ' ', '')),
		'hashed_password_placeholder', -- Use a proper hash in a real application
		(SELECT DesignationName FROM Designation d JOIN Staff s ON d.DesignationID = s.DesignationID WHERE s.StaffID = i),
		i
	);
	SET i = i + 1;
END WHILE;
END$$
DELIMITER ;

CALL GenerateStaffAndUsers();

-- Part 2: Generate Visits, Prescriptions, Tests, Notes, and Bills
DELIMITER $$
CREATE PROCEDURE GenerateStaffAndUsers()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE staff_name VARCHAR(100);
    SET @first_names = '["Amit", "Bharat", "Chetan", "Deepak", "Gaurav", "Harish", "Jyoti", "Kavita", "Lata", "Meena", "Neha", "Pooja"]';
    SET @last_names = '["Jain", "Mehta", "Chopra", "Das", "Yadav", "Saxena", "Agarwal"]';

    -- Generate Staff
    WHILE i < 500 DO
        SET staff_name = CONCAT(
            JSON_UNQUOTE(JSON_EXTRACT(@first_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@first_names)), ']'))), ' ',
            JSON_UNQUOTE(JSON_EXTRACT(@last_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@last_names)), ']')))
        );
        INSERT INTO Staff (StaffName, GenderID, DesignationID, ContactNumber, Address)
        VALUES (
            staff_name,
            FLOOR(1 + RAND() * 2),
            FLOOR(6 + RAND() * 7), -- Designations 6 through 12 are non-doctor staff
            CONCAT('7', LPAD(FLOOR(RAND() * 1000000000), 9, '0')),
            '456 Staff Quarters, Pune'
        );
        SET i = i + 1;
    END WHILE;

    -- Generate Users for the first 300 staff members
    SET i = 1;
    WHILE i <= 300 DO
        INSERT INTO `User` (Username, PasswordHash, Role, StaffID)
        VALUES (
            LOWER(REPLACE((SELECT StaffName FROM Staff WHERE StaffID = i), ' ', '')),
            'hashed_password_placeholder', -- Use a proper hash in a real application
            (SELECT DesignationName FROM Designation d JOIN Staff s ON d.DesignationID = s.DesignationID WHERE s.StaffID = i),
            i
        );
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

-- Run the staff and user generation
CALL GenerateStaffAndUsers();

DROP PROCEDURE IF EXISTS GenerateStaffAndUsers;
DROP PROCEDURE IF EXISTS GenerateTransactionalData;

-- Part 1: Generate Staff (~500) & Users (~300)
DELIMITER $$
CREATE PROCEDURE GenerateStaffAndUsers()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE staff_name VARCHAR(100);
    SET @first_names = '["Amit", "Bharat", "Chetan", "Deepak", "Gaurav", "Harish", "Jyoti", "Kavita", "Lata", "Meena", "Neha", "Pooja"]';
    SET @last_names = '["Jain", "Mehta", "Chopra", "Das", "Yadav", "Saxena", "Agarwal"]';

    -- Generate Staff
    WHILE i < 500 DO
        SET staff_name = CONCAT(
            JSON_UNQUOTE(JSON_EXTRACT(@first_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@first_names)), ']'))), ' ',
            JSON_UNQUOTE(JSON_EXTRACT(@last_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@last_names)), ']')))
        );
        INSERT INTO Staff (StaffName, GenderID, DesignationID, ContactNumber, Address)
        VALUES (
            staff_name,
            FLOOR(1 + RAND() * 2),
            FLOOR(6 + RAND() * 7), -- Designations 6 through 12 are non-doctor staff
            CONCAT('7', LPAD(FLOOR(RAND() * 1000000000), 9, '0')),
            '456 Staff Quarters, Pune'
        );
        SET i = i + 1;
    END WHILE;

    -- Generate Users for the first 300 staff members
    SET i = 1;
    WHILE i <= 300 DO
        INSERT INTO `User` (Username, PasswordHash, Role, StaffID)
        VALUES (
            LOWER(REPLACE((SELECT StaffName FROM Staff WHERE StaffID = i), ' ', '')),
            'hashed_password_placeholder', -- Use a proper hash in a real application
            (SELECT DesignationName FROM Designation d JOIN Staff s ON d.DesignationID = s.DesignationID WHERE s.StaffID = i),
            i
        );
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

-- Part 2: Generate Visits, Prescriptions, Tests, Notes, and Bills
DELIMITER $$
CREATE PROCEDURE GenerateTransactionalData()
BEGIN
    -- Declare variables for cursor data and loop control
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_admission_id BIGINT;
    DECLARE v_patient_id BIGINT;
    DECLARE v_doctor_id BIGINT;
    DECLARE v_admission_date DATETIME;
    DECLARE v_admission_days INT;

    -- Declare other variables for logic
    DECLARE i INT;
    DECLARE current_visit_id BIGINT;
    DECLARE current_prescription_id BIGINT;
    DECLARE room_charges DECIMAL(10,2);
    DECLARE test_charges DECIMAL(10,2);
    DECLARE total_bill DECIMAL(10,2);
    DECLARE num_visits INT;

    -- Declare the cursor to iterate through admissions
    DECLARE adm_cursor CURSOR FOR
        SELECT AdmissionID, PatientID, DoctorID, AdmissionDate, DATEDIFF(IFNULL(DischargeDate, CURDATE()), AdmissionDate)
        FROM Admission;

    -- Declare a handler to exit the loop
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN adm_cursor;

    -- Start the loop
    read_loop: LOOP
        -- Fetch data from cursor into variables
        FETCH adm_cursor INTO v_admission_id, v_patient_id, v_doctor_id, v_admission_date, v_admission_days;

        -- Exit if no more rows
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF v_admission_days <= 0 THEN
           SET v_admission_days = 1;
        END IF;

        INSERT INTO ClinicalNote (AdmissionID, NoteText) VALUES (v_admission_id, 'Patient admitted with stable vitals.');

        SET num_visits = FLOOR(1 + RAND() * v_admission_days);
        SET i = 0;
        WHILE i < num_visits DO
            INSERT INTO Visit (PatientID, DoctorID, VisitDate, Symptoms, Diagnosis)
            VALUES (v_patient_id, v_doctor_id, DATE_ADD(v_admission_date, INTERVAL i DAY), 'Fever, Cough', 'Viral Infection');
            SET current_visit_id = LAST_INSERT_ID();

            IF RAND() < 0.8 THEN
                INSERT INTO Prescription (VisitID, MedicineName, Dosage, Duration)
                VALUES (current_visit_id, 'To be filled from pharmacy', 'As directed', '5 days');
                SET current_prescription_id = LAST_INSERT_ID();

                INSERT INTO PrescriptionMedicine (PrescriptionID, MedicineID, Quantity)
                VALUES
                    (current_prescription_id, FLOOR(1 + RAND() * 15), FLOOR(5 + RAND() * 5)),
                    (current_prescription_id, FLOOR(1 + RAND() * 15), FLOOR(5 + RAND() * 10));
            END IF;
            SET i = i + 1;
        END WHILE;

        IF RAND() < 0.6 THEN
            INSERT INTO PatientTest (AdmissionID, TestID, Result)
            VALUES (v_admission_id, FLOOR(1 + RAND() * 10), 'Results pending.');
        END IF;

        SELECT SUM(r.ChargesPerDay) * v_admission_days INTO room_charges FROM Room r JOIN Admission a ON r.RoomID = a.RoomID WHERE a.AdmissionID = v_admission_id;
        SELECT IFNULL(SUM(t.TestCharges), 0) INTO test_charges FROM Test t JOIN PatientTest pt ON t.TestID = pt.TestID WHERE pt.AdmissionID = v_admission_id;
        SET total_bill = room_charges + test_charges + (500 + RAND() * 2000);

        INSERT INTO Bill (AdmissionID, TotalAmount, PaymentMode)
        VALUES (v_admission_id, total_bill, 'Cash/Card');

    END LOOP;

    CLOSE adm_cursor;
END$$
DELIMITER ;

-- Execute the procedures to populate the data
CALL GenerateStaffAndUsers();
CALL GenerateTransactionalData();