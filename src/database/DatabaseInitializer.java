package database;

import java.sql.*;

public class DatabaseInitializer {
    
    public static void initializeDatabase() {
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            createBranchTable(conn);
            createStudentTable(conn);
            ensureStudentTypeColumn(conn);
            insertSampleBranches(conn);
            insertSampleStudents(conn);
            
            System.out.println("Database initialized successfully!");
        } catch (SQLException e) {
            System.err.println("Error initializing database: " + e.getMessage());
        }
    }

    private static void ensureStudentTypeColumn(Connection conn) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='STUDENT' AND COLUMN_NAME='STUDENT_TYPE'";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(checkSql)) {
            if (rs.next() && rs.getInt(1) == 0) {
                String alter = "ALTER TABLE student ADD COLUMN student_type VARCHAR(20) DEFAULT 'FULL_TIME'";
                stmt.execute(alter);
                System.out.println("Added student_type column to student table.");
            }
        }
    }

    private static void createBranchTable(Connection conn) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS branch (" +
                "branch_id INT PRIMARY KEY AUTO_INCREMENT," +
                "branch_name VARCHAR(100) NOT NULL," +
                "branch_code VARCHAR(20) UNIQUE NOT NULL," +
                "department VARCHAR(100) NOT NULL)";
        
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
            System.out.println("Branch table created/verified.");
        }
    }

    private static void createStudentTable(Connection conn) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS student (" +
                "student_id INT PRIMARY KEY AUTO_INCREMENT," +
                "name VARCHAR(100) NOT NULL," +
                "email VARCHAR(100) UNIQUE NOT NULL," +
                "phone_number VARCHAR(15)," +
                "branch_id INT NOT NULL," +
                "cgpa REAL DEFAULT 0.0," +
                "enrollment_date VARCHAR(20)," +
                "student_type VARCHAR(20) DEFAULT 'FULL_TIME'," +
                "FOREIGN KEY (branch_id) REFERENCES branch(branch_id))";
        
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
            System.out.println("Student table created/verified.");
        }
    }

    private static void insertSampleBranches(Connection conn) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM branch";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(checkSql)) {
            if (rs.next() && rs.getInt(1) == 0) {
                String[] branches = {
                    "INSERT INTO branch (branch_name, branch_code, department) VALUES ('Computer Science', 'CS', 'Engineering')",
                    "INSERT INTO branch (branch_name, branch_code, department) VALUES ('Electronics', 'ECE', 'Engineering')",
                    "INSERT INTO branch (branch_name, branch_code, department) VALUES ('Mechanical', 'ME', 'Engineering')",
                    "INSERT INTO branch (branch_name, branch_code, department) VALUES ('Electrical', 'EE', 'Engineering')",
                    "INSERT INTO branch (branch_name, branch_code, department) VALUES ('Civil', 'CE', 'Engineering')"
                };
                
                try (Statement insertStmt = conn.createStatement()) {
                    for (String branch : branches) {
                        insertStmt.execute(branch);
                    }
                    System.out.println("Sample branches inserted.");
                }
            }
        }
    }

    private static void insertSampleStudents(Connection conn) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM student";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(checkSql)) {
            if (rs.next() && rs.getInt(1) == 0) {
                String[] students = {
                    "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES ('John Doe', 'john.doe@email.com', '9876543210', 1, 8.5, '2024-01-15','FULL_TIME')",
                        "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES ('Jane Smith', 'jane.smith@email.com', '9876543211', 1, 8.9, '2024-01-20','FULL_TIME')",
                        "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES ('Mike Johnson', 'mike.johnson@email.com', '9876543212', 2, 7.8, '2024-02-01','PART_TIME')",
                        "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES ('Sarah Williams', 'sarah.williams@email.com', '9876543213', 3, 8.2, '2024-02-05','FULL_TIME')",
                        "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES ('Robert Brown', 'robert.brown@email.com', '9876543214', 4, 7.5, '2024-02-10','PART_TIME')",
                        "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES ('Emily Davis', 'emily.davis@email.com', '9876543215', 1, 8.7, '2024-02-15','FULL_TIME')",
                        "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES ('James Wilson', 'james.wilson@email.com', '9876543216', 5, 7.9, '2024-02-20','PART_TIME')",
                        "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES ('Lisa Anderson', 'lisa.anderson@email.com', '9876543217', 2, 8.4, '2024-02-25','FULL_TIME')"
                };
                
                try (Statement insertStmt = conn.createStatement()) {
                    for (String student : students) {
                        insertStmt.execute(student);
                    }
                    System.out.println("Sample students inserted.");
                }
            }
        }
    }
}
