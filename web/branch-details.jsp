<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Branch" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Branch Details - Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Management System</h1>
            <p>Branch Details</p>
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
            <% Branch branch = (Branch) request.getAttribute("branch");
               if (branch != null) { %>
            <div class="details-container">
                <div class="details-card">
                    <h3><%= branch.getBranchName() %></h3>
                    
                    <div class="detail-group">
                        <label>Branch ID:</label>
                        <span><%= branch.getBranchId() %></span>
                    </div>

                    <div class="detail-group">
                        <label>Branch Code:</label>
                        <span><%= branch.getBranchCode() %></span>
                    </div>

                    <div class="detail-group">
                        <label>Department:</label>
                        <span><%= branch.getDepartment() %></span>
                    </div>

                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/branch/list" class="btn">Back to List</a>
                    </div>
                </div>
            </div>
            <% } else { %>
            <div class="alert alert-warning">
                Branch not found.
            </div>
            <% } %>
        </main>
    </div>

    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>
</body>
</html>
