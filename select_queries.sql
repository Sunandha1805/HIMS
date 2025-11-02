SELECT * FROM Department;
SELECT * FROM Gender;
SELECT * FROM Country;
SELECT * FROM State;
SELECT * FROM City;
SELECT * FROM Room;
SELECT * FROM BloodGroup;
SELECT * FROM Designation;
SELECT * FROM Functionality;

SELECT * FROM Doctor;
SELECT * FROM Patient;
SELECT * FROM Staff;
SELECT * FROM Visit;
SELECT * FROM Admission;
SELECT * FROM Bill;
SELECT * FROM AccessRights;
SELECT * FROM `User`; 

SELECT * FROM Admission LIMIT 10;

-- opd

SELECT * FROM Patient WHERE PatientID = 2820;

SELECT * FROM Visit WHERE VisitID = 4394;

SELECT * FROM Prescription p
JOIN PrescriptionMedicine pm ON p.PrescriptionID = pm.PrescriptionID
JOIN Medicine m ON pm.MedicineID = m.MedicineID
WHERE p.VisitID = 4394;

-- ipd

SELECT * FROM Patient WHERE PatientID = 4396;

SELECT v.* FROM Visit v
JOIN Admission a ON v.PatientID = a.PatientID
WHERE a.PatientID = 4396;

SELECT * FROM Admission WHERE PatientID = 4396;

-- Get all billable tests for an admission
SELECT pt.TestDate, t.TestName, t.TestCharges
FROM PatientTest pt
JOIN Test t ON pt.TestID = t.TestID
WHERE pt.AdmissionID = 2;

-- Find the final bill for the admission
SELECT * FROM Bill WHERE AdmissionID = 2;

-- Find discharge details for the admission from the Admission table itself
SELECT PatientID, AdmissionDate, DischargeDate
FROM Admission WHERE AdmissionID = 2;

-- This query lists all potential services/charges available in the hospital

-- First, get all the laboratory tests
SELECT
    'Test' AS ServiceType,
    t.TestName AS ServiceName,
    t.TestCharges AS Rate
FROM Test t
UNION ALL 
SELECT
    'Room' AS ServiceType,
    r.RoomType AS ServiceName,
    r.ChargesPerDay AS Rate
FROM Room r
GROUP BY r.RoomType, r.ChargesPerDay; 
