-- Part 1: Insert Rooms
INSERT INTO Room (RoomNumber, RoomType, ChargesPerDay) VALUES
('101', 'General Ward', 1500.00), ('102', 'General Ward', 1500.00),
('103', 'General Ward', 1500.00), ('104', 'General Ward', 1500.00),
('201', 'Semi-Private', 3000.00), ('202', 'Semi-Private', 3000.00),
('203', 'Semi-Private', 3000.00), ('204', 'Semi-Private', 3000.00),
('301', 'Private', 5000.00), ('302', 'Private', 5000.00),
('401', 'ICU', 8000.00), ('402', 'ICU', 8000.00);
-- using a loop to add the rest
DELIMITER $$
CREATE PROCEDURE GenerateRooms()
BEGIN
DECLARE i INT DEFAULT 13; -- Start after the 12 manually added rooms
DECLARE room_num INT;
DECLARE room_type VARCHAR(50);
DECLARE charges DECIMAL(10,2);
WHILE i <= 200 DO
SET room_num = 100 + i;
IF i <= 100 THEN
	SET room_type = 'General Ward';
	SET charges = 1500.00;
ELSEIF i <= 170 THEN
	SET room_type = 'Semi-Private';
	SET charges = 3000.00;
ELSE
	SET room_type = 'Private';
	SET charges = 5000.00;
END IF;
INSERT INTO Room(RoomNumber, RoomType, ChargesPerDay) VALUES (CAST(room_num AS CHAR), room_type, charges);
SET i = i + 1;
END WHILE;
END$$
DELIMITER ;

-- Run this first to create all rooms
CALL GenerateRooms();

-- Part 2: Generate Admissions
DELIMITER $$
CREATE PROCEDURE GenerateAdmissions()
BEGIN
DECLARE i INT DEFAULT 0;
WHILE i < 2000 DO
INSERT INTO Admission (PatientID, DoctorID, RoomID, AdmissionDate, DischargeDate)
VALUES (
	FLOOR(1 + RAND() * 5000), -- PatientID (1 to 5000)
	FLOOR(1 + RAND() * 250),  -- DoctorID (1 to 250)
	FLOOR(1 + RAND() * 200),  -- RoomID (1 to 200)
	DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY), -- AdmissionDate within last year
	-- DischargeDate (70% chance of being discharged)
	CASE WHEN RAND() > 0.3
	THEN DATE_ADD(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY), INTERVAL FLOOR(2 + RAND() * 10) DAY)
	ELSE NULL END
);
SET i = i + 1;
END WHILE;
END$$
DELIMITER ;

-- Run this second to generate admissions
CALL GenerateAdmissions();