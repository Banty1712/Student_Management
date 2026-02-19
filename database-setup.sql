-- Student Management System Database Setup Script
-- This script creates the necessary database and tables for the application

-- Create Database
CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

-- Create Branch Table
CREATE TABLE IF NOT EXISTS branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    branch_code VARCHAR(20) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Student Table
CREATE TABLE IF NOT EXISTS student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    branch_id INT,
    cgpa DECIMAL(3,2) CHECK (cgpa >= 0 AND cgpa <= 4),
    enrollment_date DATE NOT NULL,
    student_type VARCHAR(20) NOT NULL DEFAULT 'FULL_TIME' CHECK (student_type IN ('FULL_TIME', 'PART_TIME')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL,
    INDEX idx_branch_id (branch_id),
    INDEX idx_enrollment_date (enrollment_date),
    INDEX idx_student_type (student_type)
);

-- Insert Sample Data - Branches
INSERT INTO branch (branch_name, branch_code, department) VALUES
('Computer Science', 'CS', 'Engineering'),
('Information Technology', 'IT', 'Engineering'),
('Electronics and Communication', 'EC', 'Engineering'),
('Mechanical Engineering', 'ME', 'Engineering'),
('Civil Engineering', 'CE', 'Engineering'),
('Business Administration', 'BA', 'Management');

-- Insert Sample Data - Students
INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES
('John Smith', 'john.smith@university.edu', '555-0101', 1, 3.75, '2023-08-15', 'FULL_TIME'),
('Sarah Johnson', 'sarah.johnson@university.edu', '555-0102', 1, 3.90, '2023-08-15', 'FULL_TIME'),
('Michael Brown', 'michael.brown@university.edu', '555-0103', 2, 3.65, '2023-08-20', 'FULL_TIME'),
('Emily Davis', 'emily.davis@university.edu', '555-0104', 2, 3.55, '2023-08-20', 'PART_TIME'),
('Robert Wilson', 'robert.wilson@university.edu', '555-0105', 3, 3.80, '2023-09-01', 'FULL_TIME'),
('Jessica Martinez', 'jessica.martinez@university.edu', '555-0106', 3, 3.45, '2023-09-01', 'PART_TIME'),
('David Anderson', 'david.anderson@university.edu', '555-0107', 4, 3.70, '2023-09-10', 'FULL_TIME'),
('Lisa Taylor', 'lisa.taylor@university.edu', '555-0108', 4, 3.60, '2023-09-10', 'PART_TIME'),
('James Thomas', 'james.thomas@university.edu', '555-0109', 5, 3.85, '2023-09-15', 'FULL_TIME'),
('Patricia Jackson', 'patricia.jackson@university.edu', '555-0110', 6, 3.50, '2023-09-20', 'FULL_TIME');

-- Create indexes for better performance
CREATE INDEX idx_student_name ON student(name);
CREATE INDEX idx_student_email ON student(email);

-- Display created tables
SHOW TABLES;

-- Display data
SELECT * FROM branch;
SELECT * FROM student;

-- Statistics
SELECT 'Total Branches:' as info, COUNT(*) as count FROM branch
UNION ALL
SELECT 'Total Students:', COUNT(*) FROM student
UNION ALL
SELECT 'Full-time Students:', COUNT(*) FROM student WHERE student_type = 'FULL_TIME'
UNION ALL
SELECT 'Part-time Students:', COUNT(*) FROM student WHERE student_type = 'PART_TIME';
