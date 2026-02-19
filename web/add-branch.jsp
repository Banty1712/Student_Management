<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Branch - Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Management System</h1>
            <p>Add New Branch</p>
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
            <div class="form-container">
                <form method="POST" action="${pageContext.request.contextPath}/branch/add" class="form">
                    <h3>Add New Branch</h3>
                    
                    <div class="form-group">
                        <label for="branchName">Branch Name:</label>
                        <input type="text" id="branchName" name="branchName" required>
                    </div>

                    <div class="form-group">
                        <label for="branchCode">Branch Code:</label>
                        <input type="text" id="branchCode" name="branchCode" required>
                    </div>

                    <div class="form-group">
                        <label for="department">Department:</label>
                        <input type="text" id="department" name="department" required>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn">Add Branch</button>
                        <a href="${pageContext.request.contextPath}/branch/list" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>
</body>
</html>
