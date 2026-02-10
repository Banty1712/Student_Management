package service;

import model.Student;
import model.Branch;
import database.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.stream.Collectors;

public class StudentService {
    
    public static boolean enrollStudent(Student student) {
        String sql = "INSERT INTO student (name, email, phone_number, branch_id, cgpa, enrollment_date, student_type) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getName());
            pstmt.setString(2, student.getEmail());
            pstmt.setString(3, student.getPhoneNumber());
            pstmt.setInt(4, student.getBranchId());
            pstmt.setDouble(5, student.getCgpa());
            pstmt.setString(6, student.getEnrollmentDate());
            pstmt.setString(7, student.getStudentType());
            
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Error enrolling student: " + e.getMessage());
            return false;
        }
    }

    public static LinkedHashSet<Student> getAllStudents() {
        LinkedHashSet<Student> students = new LinkedHashSet<>();
        String sql = "SELECT * FROM student";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Student student = new Student(
                        rs.getInt("student_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getInt("branch_id"),
                        rs.getDouble("cgpa"),
                        rs.getString("enrollment_date"),
                        rs.getString("student_type")
                );
                students.add(student);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving students: " + e.getMessage());
        }
        return students;
    }

    public static LinkedHashSet<Student> getStudentsByBranch(int branchId) {
        LinkedHashSet<Student> students = new LinkedHashSet<>();
        String sql = "SELECT * FROM student WHERE branch_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, branchId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student(
                            rs.getInt("student_id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone_number"),
                            rs.getInt("branch_id"),
                            rs.getDouble("cgpa"),
                            rs.getString("enrollment_date"),
                            rs.getString("student_type")
                    );
                    students.add(student);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving students by branch: " + e.getMessage());
        }
        return students;
    }

    public static Student getStudentById(int studentId) {
        String sql = "SELECT * FROM student WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, studentId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Student(
                            rs.getInt("student_id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone_number"),
                            rs.getInt("branch_id"),
                            rs.getDouble("cgpa"),
                            rs.getString("enrollment_date"),
                            rs.getString("student_type")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving student: " + e.getMessage());
        }
        return null;
    }

    public static LinkedHashSet<Student> getStudentsByName(String name) {
        LinkedHashSet<Student> students = new LinkedHashSet<>();
        String sql = "SELECT * FROM student WHERE LOWER(name) LIKE ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + name.toLowerCase() + "%");

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student(
                            rs.getInt("student_id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone_number"),
                            rs.getInt("branch_id"),
                            rs.getDouble("cgpa"),
                            rs.getString("enrollment_date"),
                            rs.getString("student_type")
                    );
                    students.add(student);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving students by name: " + e.getMessage());
        }
        return students;
    }

    public static boolean updateStudent(Student student) {
        String sql = "UPDATE student SET name = ?, email = ?, phone_number = ?, branch_id = ?, cgpa = ?, enrollment_date = ? WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getName());
            pstmt.setString(2, student.getEmail());
            pstmt.setString(3, student.getPhoneNumber());
            pstmt.setInt(4, student.getBranchId());
            pstmt.setDouble(5, student.getCgpa());
            pstmt.setString(6, student.getEnrollmentDate());
            pstmt.setInt(7, student.getStudentId());
            
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error updating student: " + e.getMessage());
            return false;
        }
    }

    public static boolean deleteStudent(int studentId) {
        String sql = "DELETE FROM student WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, studentId);
            
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting student: " + e.getMessage());
            return false;
        }
    }

    public static void displayAllStudents() {
        LinkedHashSet<Student> students = getAllStudents();
        displayStudentsCollection(students);
    }

    public static void displayStudentsByBranch(int branchId) {
        Branch branch = BranchService.getBranchById(branchId);
        if (branch == null) {
            System.out.println("Branch not found.");
            return;
        }
        LinkedHashSet<Student> students = getStudentsByBranch(branchId);
        if (students.isEmpty()) {
            System.out.println("No students found in " + branch.getBranchName() + " branch.");
            return;
        }
        displayStudentsCollection(students);
    }

    public static void displayStudentsCollection(Set<Student> students) {
        if (students == null || students.isEmpty()) {
            System.out.println("No students found.");
            return;
        }
        System.out.println("\n========== STUDENTS ==========");
        System.out.printf("%-5s %-20s %-25s %-15s %-10s %-6s %-15s %-10s%n", 
                "ID", "Name", "Email", "Phone", "Branch", "CGPA", "Enroll Date", "Type");
        System.out.println("================================================================================");
        for (Student student : students) {
            System.out.printf("%-5d %-20s %-25s %-15s %-10d %-6.2f %-15s %-10s%n", 
                    student.getStudentId(), 
                    student.getName(), 
                    student.getEmail(), 
                    student.getPhoneNumber(), 
                    student.getBranchId(), 
                    student.getCgpa(),
                    student.getEnrollmentDate(),
                    student.getStudentType());
        }
        System.out.println("================================================================================\n");
    }

    public static LinkedHashSet<Student> getStudentsSortedByEnrollmentDate() {
        return getAllStudents().stream()
                .sorted(Comparator.comparing(s -> {
                    try {
                        return LocalDate.parse(s.getEnrollmentDate());
                    } catch (Exception e) {
                        return LocalDate.MIN;
                    }
                }))
                .collect(Collectors.toCollection(LinkedHashSet::new));
    }

    public static LinkedHashSet<Student> getStudentsSortedById() {
        return getAllStudents().stream()
                .sorted(Comparator.comparingInt(Student::getStudentId))
                .collect(Collectors.toCollection(LinkedHashSet::new));
    }

    public static LinkedHashSet<Student> getStudentsSortedByFirstName() {
        return getAllStudents().stream()
                .sorted(Comparator.comparing(s -> {
                    String n = s.getName();
                    if (n == null || n.isEmpty()) return "";
                    return n.split(" ")[0].toLowerCase();
                }))
                .collect(Collectors.toCollection(LinkedHashSet::new));
    }
}
