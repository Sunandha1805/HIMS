-- Common Medical Tests
INSERT INTO Test (TestName, TestCharges) VALUES
('Complete Blood Count (CBC)', 350.00), ('Lipid Profile', 800.00),
('Liver Function Test (LFT)', 750.00), ('Kidney Function Test (KFT)', 700.00),
('Thyroid Profile (T3, T4, TSH)', 600.00), ('Blood Sugar (Fasting)', 150.00),
('Urinalysis', 200.00), ('X-Ray Chest', 500.00), ('ECG', 400.00), ('Ultrasound (Abdomen)', 1200.00);

-- Medicines (Sample of 15 out of 500)
INSERT INTO Medicine (MedicineName, Type, Price) VALUES
('Paracetamol 500mg', 'Tablet', 2.50), ('Amoxicillin 250mg', 'Capsule', 8.00),
('Ibuprofen 400mg', 'Tablet', 3.00), ('Azithromycin 500mg', 'Tablet', 25.00),
('Metformin 500mg', 'Tablet', 4.00), ('Atorvastatin 10mg', 'Tablet', 7.50),
('Omeprazole 20mg', 'Capsule', 6.00), ('Cough Syrup', 'Syrup', 80.00),
('Cetirizine 10mg', 'Tablet', 2.00), ('Vitamin C 500mg', 'Tablet', 1.50),
('Multivitamin', 'Capsule', 5.00), ('Insulin', 'Injection', 350.00),
('Saline Drip 500ml', 'IV Fluid', 120.00), ('Ondansetron 4mg', 'Injection', 45.00),
('Diclofenac Gel', 'Ointment', 90.00);
-- (NOTE: Manually add more medicines or use a script/import for the full 500)

-- Suppliers (Sample of 5 out of 80)
INSERT INTO Supplier (SupplierName, ContactNumber, Address) VALUES
('Sun Pharma Distributors', '9876543210', 'Mumbai, MH'),
('Cipla Med Supplies', '9876543211', 'Pune, MH'),
('Mankind Health', '9876543212', 'Delhi'),
('Apollo Pharmacy Chain', '9876543213', 'Chennai, TN'),
('Generic Meds Inc.', '9876543214', 'Hyderabad, TS');
-- (NOTE: Add more suppliers manually or import)

-- Inventory (Procedure to add random stock)
DELIMITER $$
CREATE PROCEDURE GenerateInventory()
BEGIN
-- Declare variables to hold cursor data and a flag for the loop
DECLARE done INT DEFAULT FALSE;
DECLARE med_id BIGINT;

-- Declare the cursor to select all MedicineIDs
DECLARE med_cursor CURSOR FOR SELECT MedicineID FROM Medicine;

-- Declare a handler to set the 'done' flag when the cursor reaches the end
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

-- Open the cursor to start fetching
OPEN med_cursor;

-- Start the loop
read_loop: LOOP
	-- Fetch the next MedicineID from the cursor into the variable
	FETCH med_cursor INTO med_id;

	-- If the 'done' flag is true, exit the loop
	IF done THEN
		LEAVE read_loop;
	END IF;

	-- Insert the inventory record for the current medicine ID
	INSERT INTO Inventory (MedicineID, SupplierID, Quantity, PurchaseDate)
	VALUES(
		med_id,
		FLOOR(1 + RAND() * 5), -- Assuming 5 suppliers for this sample
		FLOOR(100 + RAND() * 900), -- Quantity between 100 and 1000
		DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 90) DAY) -- Purchased within last 3 months
	);

END LOOP;

-- Close the cursor
CLOSE med_cursor;
END$$
DELIMITER ;

-- Run this to populate inventory for existing medicines
CALL GenerateInventory();