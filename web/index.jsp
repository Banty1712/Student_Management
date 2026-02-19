<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Management System</h1>
            <p>Manage Students and Branches</p>
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

        <main class="home-content">
            <section class="welcome">
                <h2>Welcome to Student Management System</h2>
                <p>This application allows you to manage student and branch information efficiently.</p>
            </section>

            <section class="dashboard-cards">
                <div class="card">
                    <h3>Students</h3>
                    <p>Manage student enrollment, view details, and organize student records.</p>
                    <a href="${pageContext.request.contextPath}/student/list" class="btn">Manage Students</a>
                </div>

                <div class="card">
                    <h3>Branches</h3>
                    <p>Add new branches, update branch information, and manage departments.</p>
                    <a href="${pageContext.request.contextPath}/branch/list" class="btn">Manage Branches</a>
                </div>

                <div class="card">
                    <h3>Quick Actions</h3>
                    <p>Quick access to common operations.</p>
                    <a href="${pageContext.request.contextPath}/student/add" class="btn">Add New Student</a>
                </div>
            </section>
        </main>
    </div>

    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>
</body>
</html>
