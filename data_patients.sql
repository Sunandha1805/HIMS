-- Stored procedure to generate sample patient data.
DELIMITER $$
CREATE PROCEDURE GeneratePatients()
BEGIN
DECLARE i INT DEFAULT 0;
SET @first_names = '["Aarav", "Vivaan", "Aditya", "Vihaan", "Arjun", "Sai", "Reyansh", "Ayaan", "Krishna", "Ishaan", "Anil", "Sunil", "Rajesh", "Priya", "Saanvi", "Aanya", "Aadhya", "Ananya", "Pari", "Diya", "Riya", "Anika", "Isha", "Sunita", "Geeta"]';
SET @last_names = '["Patel", "Sharma", "Kumar", "Singh", "Gupta", "Reddy", "Menon", "Joshi", "Verma", "Rao", "Nair", "Iyer", "Kulkarni", "Deshpande", "Shah", "Chauhan", "Mishra"]';

WHILE i < 5000 DO
INSERT INTO Patient (PatientName, GenderID, BloodGroupID, DateOfBirth, ContactNumber, Address, CityID, StateID, CountryID)
VALUES (
	-- PatientName
	CONCAT(
		JSON_UNQUOTE(JSON_EXTRACT(@first_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@first_names)), ']'))), ' ',
		JSON_UNQUOTE(JSON_EXTRACT(@last_names, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@last_names)), ']')))
	),
	FLOOR(1 + RAND() * 2), -- GenderID (1 or 2)
	FLOOR(1 + RAND() * 8), -- BloodGroupID (1 to 8)
	DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 30000) DAY), -- DateOfBirth (up to ~82 years ago)
	CONCAT('8', LPAD(FLOOR(RAND() * 1000000000), 9, '0')), -- ContactNumber
	CONCAT(FLOOR(100 + RAND() * 900), ' Main St, Sample Nagar'), -- Address
	FLOOR(1 + RAND() * 14), -- CityID (1 to 14)
	FLOOR(1 + RAND() * 10), -- StateID (1 to 10)
	1 -- CountryID (India)
);
SET i = i + 1;
END WHILE;
END$$
DELIMITER ;

CALL GeneratePatients();