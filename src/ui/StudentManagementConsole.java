package ui;

import service.StudentService;
import service.BranchService;
import model.Student;
import model.Branch;
import database.DatabaseInitializer;
import database.DatabaseConnection;

import java.util.Scanner;
import java.time.LocalDate;
import java.util.List;

public class StudentManagementConsole {
    private static Scanner scanner = new Scanner(System.in);
    
    public static void main(String[] args) {
        DatabaseInitializer.initializeDatabase();
        
        boolean running = true;
        while (running) {
            displayMainMenu();
            int choice = getValidInput(1, 9);
            
            switch (choice) {
                case 1:
                    addPartTimeStudent();
                    break;
                case 2:
                    addFullTimeStudent();
                    break;
                case 3:
                    deleteStudent();
                    break;
                case 4:
                    viewStudentDetails();
                    break;
                case 5:
                    StudentService.displayAllStudents();
                    break;
                case 6:
                    StudentService.displayStudentsCollection(StudentService.getStudentsSortedByEnrollmentDate());
                    break;
                case 7:
                    StudentService.displayStudentsCollection(StudentService.getStudentsSortedById());
                    break;
                case 8:
                    StudentService.displayStudentsCollection(StudentService.getStudentsSortedByFirstName());
                    break;
                case 9:
                    System.out.println("\nThank you for using Student Management System!");
                    running = false;
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
        
        scanner.close();
        DatabaseConnection.closeConnection();
    }
    
    private static void displayMainMenu() {
        System.out.println("\n========================================");
        System.out.println("  STUDENT MANAGEMENT SYSTEM");
        System.out.println("========================================");
        System.out.println("1. Add Part Time Student");
        System.out.println("2. Add Full Time Student");
        System.out.println("3. Remove Student");
        System.out.println("4. View Student");
        System.out.println("5. View Students");
        System.out.println("6. Sort by Date of Joining");
        System.out.println("7. Sort by ID");
        System.out.println("8. Sort by First Name");
        System.out.println("9. Exit");
        System.out.print("Enter your choice: ");
    }
    
    private static void studentMenu() {
        // Deprecated: new custom single menu replaces nested student menu
    }
    
    private static void branchMenu() {
        boolean inBranchMenu = true;
        while (inBranchMenu) {
            System.out.println("\n========== BRANCH MENU ==========");
            System.out.println("1. Add New Branch");
            System.out.println("2. View All Branches");
            System.out.println("3. View Branch Details");
            System.out.println("4. Update Branch");
            System.out.println("5. Delete Branch");
            System.out.println("6. Back to Main Menu");
            System.out.print("Enter your choice: ");
            
            int choice = getValidInput(1, 6);
            
            switch (choice) {
                case 1:
                    addNewBranch();
                    break;
                case 2:
                    BranchService.displayAllBranches();
                    break;
                case 3:
                    viewBranchDetails();
                    break;
                case 4:
                    updateBranch();
                    break;
                case 5:
                    deleteBranch();
                    break;
                case 6:
                    inBranchMenu = false;
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
    
    private static void viewAllData() {
        System.out.println("\n========== COMPLETE DATA OVERVIEW ==========");
        BranchService.displayAllBranches();
        StudentService.displayAllStudents();
    }
    
    private static void enrollNewStudent(String studentType) {
        System.out.println("\n========== ENROLL NEW STUDENT (" + studentType + ") ==========");
        
        BranchService.displayAllBranches();
        
        System.out.print("Enter student name: ");
        String name = scanner.nextLine().trim();
        
        System.out.print("Enter email: ");
        String email = scanner.nextLine().trim();
        
        System.out.print("Enter phone number: ");
        String phone = scanner.nextLine().trim();
        
        System.out.print("Enter branch ID: ");
        int branchId = getIntInput();
        
        System.out.print("Enter CGPA (0.0-10.0): ");
        double cgpa = getDoubleInput();
        
        String enrollmentDate = LocalDate.now().toString();
        
        Student student = new Student(name, email, phone, branchId, cgpa, enrollmentDate, studentType);
        
        if (StudentService.enrollStudent(student)) {
            System.out.println("Student enrolled successfully!");
        } else {
            System.out.println("Failed to enroll student.");
        }
    }

    private static void addPartTimeStudent() {
        enrollNewStudent("PART_TIME");
    }

    private static void addFullTimeStudent() {
        enrollNewStudent("FULL_TIME");
    }
    
    private static void viewStudentsByBranch() {
        System.out.println("\n========== VIEW STUDENTS BY BRANCH ==========");
        BranchService.displayAllBranches();
        
        System.out.print("Enter branch ID: ");
        int branchId = getIntInput();
        
        StudentService.displayStudentsByBranch(branchId);
    }
    
    private static void viewStudentDetails() {
        System.out.println("\n========== VIEW STUDENT DETAILS ==========");
        System.out.print("Enter student name (or part of the name): ");
        String name = scanner.nextLine().trim();

        java.util.LinkedHashSet<Student> matches = StudentService.getStudentsByName(name);
        if (matches == null || matches.isEmpty()) {
            System.out.println("Student not found.");
            return;
        }
        StudentService.displayStudentsCollection(matches);
    }
    
    private static void updateStudent() {
        System.out.println("\n========== UPDATE STUDENT ==========");
        System.out.print("Enter student ID: ");
        int studentId = scanner.nextInt();
        scanner.nextLine();
        
        Student student = StudentService.getStudentById(studentId);
        if (student == null) {
            System.out.println("Student not found.");
            return;
        }
        
        System.out.println("Current details: " + student);
        
        System.out.print("Enter new name (or press Enter to skip): ");
        String name = scanner.nextLine().trim();
        if (!name.isEmpty()) student.setName(name);
        
        System.out.print("Enter new email (or press Enter to skip): ");
        String email = scanner.nextLine().trim();
        if (!email.isEmpty()) student.setEmail(email);
        
        System.out.print("Enter new phone (or press Enter to skip): ");
        String phone = scanner.nextLine().trim();
        if (!phone.isEmpty()) student.setPhoneNumber(phone);
        
        System.out.print("Enter new CGPA (or press Enter to skip): ");
        String cgpaInput = scanner.nextLine().trim();
        if (!cgpaInput.isEmpty()) {
            try {
                student.setCgpa(Double.parseDouble(cgpaInput));
            } catch (NumberFormatException e) {
                System.out.println("Invalid CGPA format.");
            }
        }
        
        if (StudentService.updateStudent(student)) {
            System.out.println("Student updated successfully!");
        } else {
            System.out.println("Failed to update student.");
        }
    }
    
    private static void deleteStudent() {
        System.out.println("\n========== DELETE STUDENT ==========");
        System.out.print("Enter student ID: ");
        int studentId = getIntInput();
        
        System.out.print("Are you sure you want to delete this student? (yes/no): ");
        String confirm = scanner.nextLine().trim().toLowerCase();
        
        if (confirm.equals("yes")) {
            if (StudentService.deleteStudent(studentId)) {
                System.out.println("Student deleted successfully!");
            } else {
                System.out.println("Failed to delete student.");
            }
        } else {
            System.out.println("Deletion cancelled.");
        }
    }

    private static int getIntInput() {
        while (true) {
            try {
                int v = scanner.nextInt();
                scanner.nextLine();
                return v;
            } catch (java.util.InputMismatchException e) {
                scanner.nextLine();
                System.out.print("Invalid input. Please enter a valid number: ");
            }
        }
    }

    private static double getDoubleInput() {
        while (true) {
            try {
                double v = scanner.nextDouble();
                scanner.nextLine();
                return v;
            } catch (java.util.InputMismatchException e) {
                scanner.nextLine();
                System.out.print("Invalid input. Please enter a valid number: ");
            }
        }
    }
    
    private static void addNewBranch() {
        System.out.println("\n========== ADD NEW BRANCH ==========");
        
        System.out.print("Enter branch name: ");
        String branchName = scanner.nextLine().trim();
        
        System.out.print("Enter branch code: ");
        String branchCode = scanner.nextLine().trim();
        
        System.out.print("Enter department: ");
        String department = scanner.nextLine().trim();
        
        Branch branch = new Branch(branchName, branchCode, department);
        
        if (BranchService.addBranch(branch)) {
            System.out.println("Branch added successfully!");
        } else {
            System.out.println("Failed to add branch.");
        }
    }
    
    private static void viewBranchDetails() {
        System.out.println("\n========== VIEW BRANCH DETAILS ==========");
        System.out.print("Enter branch ID: ");
        int branchId = scanner.nextInt();
        scanner.nextLine();
        
        Branch branch = BranchService.getBranchById(branchId);
        if (branch != null) {
            System.out.println("\n" + branch);
        } else {
            System.out.println("Branch not found.");
        }
    }
    
    private static void updateBranch() {
        System.out.println("\n========== UPDATE BRANCH ==========");
        System.out.print("Enter branch ID: ");
        int branchId = scanner.nextInt();
        scanner.nextLine();
        
        Branch branch = BranchService.getBranchById(branchId);
        if (branch == null) {
            System.out.println("Branch not found.");
            return;
        }
        
        System.out.println("Current details: " + branch);
        
        System.out.print("Enter new branch name (or press Enter to skip): ");
        String name = scanner.nextLine().trim();
        if (!name.isEmpty()) branch.setBranchName(name);
        
        System.out.print("Enter new branch code (or press Enter to skip): ");
        String code = scanner.nextLine().trim();
        if (!code.isEmpty()) branch.setBranchCode(code);
        
        System.out.print("Enter new department (or press Enter to skip): ");
        String dept = scanner.nextLine().trim();
        if (!dept.isEmpty()) branch.setDepartment(dept);
        
        if (BranchService.updateBranch(branch)) {
            System.out.println("Branch updated successfully!");
        } else {
            System.out.println("Failed to update branch.");
        }
    }
    
    private static void deleteBranch() {
        System.out.println("\n========== DELETE BRANCH ==========");
        System.out.print("Enter branch ID: ");
        int branchId = scanner.nextInt();
        scanner.nextLine();
        
        System.out.print("Are you sure you want to delete this branch? (yes/no): ");
        String confirm = scanner.nextLine().trim().toLowerCase();
        
        if (confirm.equals("yes")) {
            if (BranchService.deleteBranch(branchId)) {
                System.out.println("Branch deleted successfully!");
            } else {
                System.out.println("Failed to delete branch.");
            }
        } else {
            System.out.println("Deletion cancelled.");
        }
    }
    
    private static int getValidInput(int min, int max) {
        while (true) {
            try {
                int choice = scanner.nextInt();
                scanner.nextLine();
                if (choice >= min && choice <= max) {
                    return choice;
                } else {
                    System.out.print("Invalid input. Please enter a number between " + min + " and " + max + ": ");
                }
            } catch (java.util.InputMismatchException e) {
                scanner.nextLine();
                System.out.print("Invalid input. Please enter a valid number: ");
            }
        }
    }
}
