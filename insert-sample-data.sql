-- Insert sample branches
INSERT INTO branch (branch_name, branch_code, department) VALUES 
('Computer Science', 'CS', 'Engineering'),
('Information Technology', 'IT', 'Engineering'),
('Electronics & Communication', 'EC', 'Engineering'),
('Mechanical Engineering', 'ME', 'Engineering'),
('Electrical Engineering', 'EE', 'Engineering');

-- Insert sample students
INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES
('Rajesh Kumar', 'rajesh.kumar@email.com', '9876543210', 1, 8.5, '2023-08-15', 'FULL_TIME'),
('Priya Singh', 'priya.singh@email.com', '9876543211', 1, 9.2, '2023-08-15', 'FULL_TIME'),
('Amit Patel', 'amit.patel@email.com', '9876543212', 2, 7.8, '2023-08-20', 'FULL_TIME'),
('Neha Sharma', 'neha.sharma@email.com', '9876543213', 2, 8.9, '2023-08-20', 'PART_TIME'),
('Vikram Singh', 'vikram.singh@email.com', '9876543214', 3, 7.5, '2023-09-01', 'FULL_TIME'),
('Anjali Gupta', 'anjali.gupta@email.com', '9876543215', 3, 8.7, '2023-09-01', 'FULL_TIME'),
('Rahul Verma', 'rahul.verma@email.com', '9876543216', 4, 8.1, '2023-09-10', 'PART_TIME'),
('Divya Nair', 'divya.nair@email.com', '9876543217', 4, 8.8, '2023-09-10', 'FULL_TIME'),
('Sanjay Desai', 'sanjay.desai@email.com', '9876543218', 5, 7.9, '2023-09-15', 'FULL_TIME'),
('Pooja Rao', 'pooja.rao@email.com', '9876543219', 5, 9.1, '2023-09-15', 'PART_TIME');
