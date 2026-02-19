<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.LinkedHashSet" %>
<%@ page import="model.Branch" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Branch List - Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Management System</h1>
            <p>View All Branches</p>
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

            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/branch/add" class="btn">Add New Branch</a>
                <a href="${pageContext.request.contextPath}/branch/delete" class="btn btn-danger">Delete Branch</a>
            </div>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>Branch ID</th>
                        <th>Branch Name</th>
                        <th>Branch Code</th>
                        <th>Department</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% LinkedHashSet<Branch> branches = (LinkedHashSet<Branch>) request.getAttribute("branches");
                       
                       if (branches != null && !branches.isEmpty()) {
                           for (Branch branch : branches) {
                    %>
                    <tr>
                        <td><%= branch.getBranchId() %></td>
                        <td><%= branch.getBranchName() %></td>
                        <td><%= branch.getBranchCode() %></td>
                        <td><%= branch.getDepartment() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/branch/details?id=<%= branch.getBranchId() %>" class="btn-small">View</a>
                        </td>
                    </tr>
                    <% }
                       } else { %>
                    <tr>
                        <td colspan="5" class="text-center">No branches found.</td>
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
