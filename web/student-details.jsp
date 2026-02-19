<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Student" %>
<%@ page import="model.Branch" %>
<%@ page import="java.util.LinkedHashSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details - Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Management System</h1>
            <p>Student Details</p>
        </header>

        <nav class="navbar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="dropdown">
                    <a href="#">Students</a>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/student/list">View All Students</a>
                        <a href="${pageContext.request.contextPath}/student/add">Add Student</a>
                        <a href="${pageContext.request.contextPath}/student/delete">Delete Student</a>
                        <hr>
                        <a href="${pageContext.request.contextPath}/student/sortById">Sort by ID</a>
                        <a href="${pageContext.request.contextPath}/student/sortByDate">Sort by Enrollment Date</a>
                        <a href="${pageContext.request.contextPath}/student/sortByName">Sort by Name</a>
                    </div>
                </li>
                <li class="dropdown">
                    <a href="#">Branches</a>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/branch/list">View All Branches</a>
                        <a href="${pageContext.request.contextPath}/branch/add">Add Branch</a>
                        <a href="${pageContext.request.contextPath}/branch/delete">Delete Branch</a>
                    </div>
                </li>
            </ul>
        </nav>

        <main>
            <% Student student = (Student) request.getAttribute("student");
               LinkedHashSet<Branch> branches = (LinkedHashSet<Branch>) request.getAttribute("branches");
               String branchName = "N/A";
               
               if (student != null && branches != null) {
                   for (Branch branch : branches) {
                       if (branch.getBranchId() == student.getBranchId()) {
                           branchName = branch.getBranchName();
                           break;
                       }
                   }
            %>
            <div class="details-container">
                <div class="details-card">
                    <h3><%= student.getName() %></h3>
                    
                    <div class="detail-group">
                        <label>Student ID:</label>
                        <span><%= student.getStudentId() %></span>
                    </div>

                    <div class="detail-group">
                        <label>Email:</label>
                        <span><%= student.getEmail() %></span>
                    </div>

                    <div class="detail-group">
                        <label>Phone Number:</label>
                        <span><%= student.getPhoneNumber() %></span>
                    </div>

                    <div class="detail-group">
                        <label>Branch:</label>
                        <span><%= branchName %></span>
                    </div>

                    <div class="detail-group">
                        <label>CGPA:</label>
                        <span><%= student.getCgpa() %></span>
                    </div>

                    <div class="detail-group">
                        <label>Student Type:</label>
                        <span class="badge <%= student.getStudentType().equals("FULL_TIME") ? "badge-primary" : "badge-secondary" %>">
                            <%= student.getStudentType() %>
                        </span>
                    </div>

                    <div class="detail-group">
                        <label>Enrollment Date:</label>
                        <span><%= student.getEnrollmentDate() %></span>
                    </div>

                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/student/list" class="btn">Back to List</a>
                    </div>
                </div>
            </div>
            <% } else { %>
            <div class="alert alert-warning">
                Student not found.
            </div>
            <% } %>
        </main>
    </div>

    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>
</body>
</html>
