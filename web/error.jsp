<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Management System</h1>
            <p>Error</p>
        </header>

        <main>
            <div class="alert alert-danger">
                <h3>An Error Occurred</h3>
                <p>
                    <% if (request.getAttribute("javax.servlet.error.message") != null) { %>
                        <%= request.getAttribute("javax.servlet.error.message") %>
                    <% } else { %>
                        We're sorry, an error occurred while processing your request.
                    <% } %>
                </p>
            </div>

            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/" class="btn">Back to Home</a>
                <a href="${pageContext.request.contextPath}/student/list" class="btn">View Students</a>
            </div>
        </main>
    </div>

    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>
</body>
</html>
