-- 1. Donors Table
CREATE TABLE Donors (
    donor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age BETWEEN 18 AND 65),
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-') NOT NULL,
    contact_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    last_donation_date DATE
);

-- 2. Blood Inventory Table
CREATE TABLE Blood_Inventory (
    blood_id INT PRIMARY KEY AUTO_INCREMENT,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-') NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    expiry_date DATE NOT NULL
);

-- 3. Requests Table
CREATE TABLE Requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    hospital_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-') NOT NULL,
    quantity_requested INT NOT NULL CHECK (quantity_requested > 0),
    request_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Fulfilled', 'Rejected') NOT NULL DEFAULT 'Pending'
);

-- 4. Donations Table
CREATE TABLE Donations (
    donation_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT NOT NULL,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-') NOT NULL,
    donation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    quantity_donated INT NOT NULL CHECK (quantity_donated > 0),
    FOREIGN KEY (donor_id) REFERENCES Donors(donor_id) ON DELETE CASCADE
);

-- 5. Users Table (Admin & Staff Login)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Staff') NOT NULL
);
-- Insert into Donors (50 Sample Donors)
INSERT INTO Donors (name, age, blood_type, contact_number, email, address, last_donation_date) VALUES
('Rahul Sharma', 28, 'O+', '9876543210', 'rahul@example.com', 'Delhi, India', '2024-03-01'),
('Anjali Verma', 34, 'A-', '9865123470', 'anjali@example.com', 'Mumbai, India', '2024-02-10'),
('Vikram Mehta', 40, 'B+', '9856741230', 'vikram@example.com', 'Bangalore, India', '2023-12-15'),
('Priya Singh', 25, 'AB-', '9988776655', 'priya@example.com', 'Chennai, India', '2024-01-20'),
('Arjun Patel', 22, 'O-', '9998887776', 'arjun@example.com', 'Hyderabad, India', '2024-03-05'),
('Sneha Roy', 30, 'A+', '9876453212', 'sneha@example.com', 'Kolkata, India', '2024-01-28'),
('Karan Gupta', 45, 'B-', '9876543221', 'karan@example.com', 'Pune, India', '2024-03-10'),
('Nikita Sharma', 29, 'AB+', '9887766554', 'nikita@example.com', 'Ahmedabad, India', '2023-11-25'),
('Amit Tiwari', 33, 'O+', '9876512345', 'amit@example.com', 'Jaipur, India', '2024-02-14'),
('Meera Reddy', 27, 'B+', '9988223344', 'meera@example.com', 'Lucknow, India', '2024-03-03'),
-- Add 40 more donors with random details
('Person 41', 30, 'A+', '9876512341', 'person41@example.com', 'City41, India', '2024-01-15'),
('Person 42', 22, 'O-', '9876512342', 'person42@example.com', 'City42, India', '2024-02-20'),
('Person 43', 27, 'B+', '9876512343', 'person43@example.com', 'City43, India', '2024-01-30'),
('Person 44', 35, 'AB-', '9876512344', 'person44@example.com', 'City44, India', '2024-03-01'),
('Person 45', 32, 'O+', '9876512345', 'person45@example.com', 'City45, India', '2024-02-18'),
('Person 46', 40, 'A-', '9876512346', 'person46@example.com', 'City46, India', '2024-01-22'),
('Person 47', 26, 'B-', '9876512347', 'person47@example.com', 'City47, India', '2024-02-05'),
('Person 48', 31, 'AB+', '9876512348', 'person48@example.com', 'City48, India', '2024-03-10'),
('Person 49', 29, 'O-', '9876512349', 'person49@example.com', 'City49, India', '2024-01-17'),
('Person 50', 34, 'A+', '9876512350', 'person50@example.com', 'City50, India', '2024-02-25');

-- Insert into Blood Inventory (Stock of Different Blood Types)
INSERT INTO Blood_Inventory (blood_type, quantity, expiry_date) VALUES
('O+', 50, '2024-07-01'),
('A-', 30, '2024-06-20'),
('B+', 40, '2024-07-15'),
('AB-', 20, '2024-05-30'),
('O-', 35, '2024-06-25'),
('A+', 60, '2024-08-10'),
('B-', 25, '2024-07-05'),
('AB+', 15, '2024-06-15');

-- Insert into Requests (Hospitals Requesting Blood)
INSERT INTO Requests (hospital_name, contact_person, contact_number, blood_type, quantity_requested) VALUES
('AIIMS Hospital', 'Dr. Mehta', '9998887776', 'A+', 5),
('Apollo Hospital', 'Dr. Rajan', '9898989898', 'O-', 10),
('Fortis Hospital', 'Dr. Sharma', '9876541230', 'B+', 8),
('Max Hospital', 'Dr. Gupta', '9845612378', 'AB-', 6),
('Medanta Hospital', 'Dr. Verma', '9765432189', 'O+', 12),
('Nanavati Hospital', 'Dr. Reddy', '9995566778', 'A-', 4),
('Manipal Hospital', 'Dr. Nair', '9654321987', 'B-', 7);

-- Insert into Donations (Donation Records)
INSERT INTO Donations (donor_id, blood_type, quantity_donated) VALUES
(1, 'O+', 1),
(2, 'A-', 1),
(3, 'B+', 2),
(4, 'AB-', 1),
(5, 'O-', 2),
(6, 'A+', 1),
(7, 'B-', 1),
(8, 'AB+', 2),
(9, 'O+', 3),
(10, 'B+', 1),
(11, 'A+', 2),
(12, 'O-', 1),
(13, 'AB-', 1),
(14, 'B-', 1),
(15, 'A-', 1);

-- Insert into Users (Admin and Staff Accounts)
INSERT INTO Users (username, password_hash, role) VALUES
('admin', 'hashed_password1', 'Admin'),
('staff1', 'hashed_password2', 'Staff'),
('staff2', 'hashed_password3', 'Staff'),
('admin2', 'hashed_password4', 'Admin');
