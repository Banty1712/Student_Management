<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.LinkedHashSet" %>
<%@ page import="model.Student" %>
<%@ page import="model.Branch" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Management System</h1>
            <p>View All Students</p>
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
            <% String message = (String) request.getAttribute("message");
               if (message != null) { %>
                <div class="alert alert-success">
                    <%= message %>
                </div>
            <% } %>

            <% String sortType = (String) request.getAttribute("sortType");
               if (sortType != null) { %>
                <div class="sort-info">
                    Sorted by: <strong><%= sortType %></strong>
                    <a href="${pageContext.request.contextPath}/student/list" class="btn-small">Reset Sort</a>
                </div>
            <% } %>

            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/student/add" class="btn">Add New Student</a>
                <a href="${pageContext.request.contextPath}/student/delete" class="btn btn-danger">Delete Student</a>
            </div>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Branch</th>
                        <th>CGPA</th>
                        <th>Type</th>
                        <th>Enrollment Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% LinkedHashSet<Student> students = (LinkedHashSet<Student>) request.getAttribute("students");
                       LinkedHashSet<Branch> branches = (LinkedHashSet<Branch>) request.getAttribute("branches");
                       
                       if (students != null && !students.isEmpty()) {
                           for (Student student : students) {
                               String branchName = "N/A";
                               if (branches != null) {
                                   for (Branch branch : branches) {
                                       if (branch.getBranchId() == student.getBranchId()) {
                                           branchName = branch.getBranchName();
                                           break;
                                       }
                                   }
                               }
                    %>
                    <tr>
                        <td><%= student.getStudentId() %></td>
                        <td><%= student.getName() %></td>
                        <td><%= student.getEmail() %></td>
                        <td><%= student.getPhoneNumber() %></td>
                        <td><%= branchName %></td>
                        <td><%= student.getCgpa() %></td>
                        <td><span class="badge <%= student.getStudentType().equals("FULL_TIME") ? "badge-primary" : "badge-secondary" %>"><%= student.getStudentType() %></span></td>
                        <td><%= student.getEnrollmentDate() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/student/view?id=<%= student.getStudentId() %>" class="btn-small">View</a>
                        </td>
                    </tr>
                    <% }
                       } else { %>
                    <tr>
                        <td colspan="9" class="text-center">No students found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </main>
    </div>

    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>
</body>
</html>
