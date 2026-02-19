package web;

import service.StudentService;
import service.BranchService;
import model.Student;
import model.Branch;
import database.DatabaseInitializer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedHashSet;

@WebServlet(urlPatterns = "/student/*")
public class StudentServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        
        if (action == null) {
            action = "/list";
        }
        
        switch (action) {
            case "/list":
                listStudents(request, response);
                break;
            case "/add":
                showAddForm(request, response);
                break;
            case "/view":
                viewStudentDetails(request, response);
                break;
            case "/delete":
                showDeleteForm(request, response);
                break;
            case "/sortByDate":
                sortByEnrollmentDate(request, response);
                break;
            case "/sortById":
                sortById(request, response);
                break;
            case "/sortByName":
                sortByName(request, response);
                break;
            default:
                listStudents(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        
        switch (action) {
            case "/addPartTime":
                addPartTimeStudent(request, response);
                break;
            case "/addFullTime":
                addFullTimeStudent(request, response);
                break;
            case "/delete":
                deleteStudent(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/student/list");
        }
    }
    
    private void listStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LinkedHashSet<Student> students = StudentService.getAllStudents();
        
        // Get branches for display
        LinkedHashSet<Branch> branches = BranchService.getAllBranches();
        
        request.setAttribute("students", students);
        request.setAttribute("branches", branches);
        request.getRequestDispatcher("/student-list.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LinkedHashSet<Branch> branches = BranchService.getAllBranches();
        request.setAttribute("branches", branches);
        request.getRequestDispatcher("/add-student.jsp").forward(request, response);
    }
    
    private void addPartTimeStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int branchId = Integer.parseInt(request.getParameter("branchId"));
            double cgpa = Double.parseDouble(request.getParameter("cgpa"));
            String enrollmentDate = request.getParameter("enrollmentDate");
            
            Student student = new Student(name, email, phone, branchId, cgpa, enrollmentDate, "PART_TIME");
            
            if (StudentService.enrollStudent(student)) {
                request.setAttribute("message", "Part-time student added successfully!");
            } else {
                request.setAttribute("message", "Failed to add student. Please try again.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
        }
        
        listStudents(request, response);
    }
    
    private void addFullTimeStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int branchId = Integer.parseInt(request.getParameter("branchId"));
            double cgpa = Double.parseDouble(request.getParameter("cgpa"));
            String enrollmentDate = request.getParameter("enrollmentDate");
            
            Student student = new Student(name, email, phone, branchId, cgpa, enrollmentDate, "FULL_TIME");
            
            if (StudentService.enrollStudent(student)) {
                request.setAttribute("message", "Full-time student added successfully!");
            } else {
                request.setAttribute("message", "Failed to add student. Please try again.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
        }
        
        listStudents(request, response);
    }
    
    private void viewStudentDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int studentId = Integer.parseInt(request.getParameter("id"));
            Student student = StudentService.getStudentById(studentId);
            
            if (student != null) {
                LinkedHashSet<Branch> branches = BranchService.getAllBranches();
                request.setAttribute("student", student);
                request.setAttribute("branches", branches);
                request.getRequestDispatcher("/student-details.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Student not found!");
                listStudents(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            listStudents(request, response);
        }
    }
    
    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LinkedHashSet<Student> students = StudentService.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("/delete-student.jsp").forward(request, response);
    }
    
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            
            if (StudentService.deleteStudent(studentId)) {
                request.setAttribute("message", "Student deleted successfully!");
            } else {
                request.setAttribute("message", "Failed to delete student. Please try again.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
        }
        
        listStudents(request, response);
    }
    
    private void sortByEnrollmentDate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LinkedHashSet<Student> students = StudentService.getStudentsSortedByEnrollmentDate();
        LinkedHashSet<Branch> branches = BranchService.getAllBranches();
        
        request.setAttribute("students", students);
        request.setAttribute("branches", branches);
        request.setAttribute("sortType", "Enrollment Date");
        request.getRequestDispatcher("/student-list.jsp").forward(request, response);
    }
    
    private void sortById(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LinkedHashSet<Student> students = StudentService.getStudentsSortedById();
        LinkedHashSet<Branch> branches = BranchService.getAllBranches();
        
        request.setAttribute("students", students);
        request.setAttribute("branches", branches);
        request.setAttribute("sortType", "Student ID");
        request.getRequestDispatcher("/student-list.jsp").forward(request, response);
    }
    
    private void sortByName(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LinkedHashSet<Student> students = StudentService.getStudentsSortedByFirstName();
        LinkedHashSet<Branch> branches = BranchService.getAllBranches();
        
        request.setAttribute("students", students);
        request.setAttribute("branches", branches);
        request.setAttribute("sortType", "First Name");
        request.getRequestDispatcher("/student-list.jsp").forward(request, response);
    }
}
