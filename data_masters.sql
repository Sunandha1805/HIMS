USE HIMS;

INSERT INTO Country (CountryName) VALUES ('India');

INSERT INTO State (StateName) VALUES
('Maharashtra'), ('Karnataka'), ('Delhi'), ('Tamil Nadu'), ('Uttar Pradesh'),
('Gujarat'), ('West Bengal'), ('Rajasthan'), ('Kerala'), ('Telangana');

INSERT INTO City (CityName) VALUES
('Mumbai'), ('Pune'), ('Nagpur'), ('Bengaluru'), ('Delhi'),
('Chennai'), ('Lucknow'), ('Ahmedabad'), ('Kolkata'), ('Jaipur'),
('Kochi'), ('Hyderabad'), ('Thane'), ('Pimpri-Chinchwad');

INSERT INTO Gender (GenderName) VALUES ('Male'), ('Female'), ('Other');

INSERT INTO BloodGroup (BloodGroupName) VALUES
('A+'), ('A-'), ('B+'), ('B-'), ('AB+'), ('AB-'), ('O+'), ('O-');

INSERT INTO Department (DepartmentName) VALUES
('Cardiology'), ('Neurology'), ('Orthopedics'), ('Pediatrics'), ('Oncology'),
('Gastroenterology'), ('Dermatology'), ('General Surgery'), ('Radiology'), ('ENT');

INSERT INTO Designation (DesignationName) VALUES
('Consultant'), ('Senior Resident'), ('Junior Resident'), ('Medical Officer'), ('Head of Department'),
('Nurse'), ('Ward Boy'), ('Receptionist'), ('Pharmacist'), ('Lab Technician'), ('Accountant'), ('Administrator');

INSERT INTO Functionality (FunctionalityName, Description) VALUES
('Patient Registration', 'Can add and edit patient details.'),
('Appointment Scheduling', 'Can book, reschedule, and cancel appointments.'),
('Billing and Invoicing', 'Can generate and process patient bills.'),
('EMR Access', 'Can view and edit Electronic Medical Records.'),
('Prescription Management', 'Can create and manage prescriptions.'),
('Inventory Management', 'Can manage pharmacy and general store inventory.'),
('User Management', 'Can add, edit, and remove system users.'),
('Reporting', 'Can generate administrative and clinical reports.');