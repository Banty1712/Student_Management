<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.LinkedHashSet" %>
<%@ page import="model.Branch" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student - Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Management System</h1>
            <p>Add New Student</p>
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
                <div class="form-group-tabs">
                    <button class="tab-btn active" onclick="switchForm('part-time')">Part Time Student</button>
                    <button class="tab-btn" onclick="switchForm('full-time')">Full Time Student</button>
                </div>

                <!-- Part Time Form -->
                <div id="part-time" class="form-tab active">
                    <form method="POST" action="${pageContext.request.contextPath}/student/addPartTime" class="form">
                        <h3>Add Part Time Student</h3>
                        
                        <div class="form-group">
                            <label for="name">Full Name:</label>
                            <input type="text" id="name" name="name" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number:</label>
                            <input type="text" id="phone" name="phone" required>
                        </div>

                        <div class="form-group">
                            <label for="branchId">Branch:</label>
                            <select id="branchId" name="branchId" required>
                                <option value="">Select a Branch</option>
                                <% LinkedHashSet<Branch> branches = (LinkedHashSet<Branch>) request.getAttribute("branches");
                                   if (branches != null && !branches.isEmpty()) {
                                       for (Branch branch : branches) {
                                %>
                                <option value="<%= branch.getBranchId() %>"><%= branch.getBranchName() %></option>
                                <%     }
                                   } else {
                                       // Fallback - test branches for debugging
                                %>
                                <option value="">No branches available - Database connection issue</option>
                                <%   }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="cgpa">CGPA:</label>
                            <input type="number" id="cgpa" name="cgpa" step="0.01" min="0" max="4" required>
                        </div>

                        <div class="form-group">
                            <label for="enrollmentDate">Enrollment Date:</label>
                            <input type="date" id="enrollmentDate" name="enrollmentDate" required>
                        </div>

                        <button type="submit" class="btn">Add Part Time Student</button>
                        <a href="${pageContext.request.contextPath}/student/list" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>

                <!-- Full Time Form -->
                <div id="full-time" class="form-tab">
                    <form method="POST" action="${pageContext.request.contextPath}/student/addFullTime" class="form">
                        <h3>Add Full Time Student</h3>
                        
                        <div class="form-group">
                            <label for="name2">Full Name:</label>
                            <input type="text" id="name2" name="name" required>
                        </div>

                        <div class="form-group">
                            <label for="email2">Email:</label>
                            <input type="email" id="email2" name="email" required>
                        </div>

                        <div class="form-group">
                            <label for="phone2">Phone Number:</label>
                            <input type="text" id="phone2" name="phone" required>
                        </div>

                        <div class="form-group">
                            <label for="branchId2">Branch:</label>
                            <select id="branchId2" name="branchId" required>
                                <option value="">Select a Branch</option>
                                <% if (branches != null) {
                                       for (Branch branch : branches) {
                                %>
                                <option value="<%= branch.getBranchId() %>"><%= branch.getBranchName() %></option>
                                <% }
                                   } %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="cgpa2">CGPA:</label>
                            <input type="number" id="cgpa2" name="cgpa" step="0.01" min="0" max="4" required>
                        </div>

                        <div class="form-group">
                            <label for="enrollmentDate2">Enrollment Date:</label>
                            <input type="date" id="enrollmentDate2" name="enrollmentDate" required>
                        </div>

                        <button type="submit" class="btn">Add Full Time Student</button>
                        <a href="${pageContext.request.contextPath}/student/list" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>

    <script>
        function switchForm(formId) {
            const forms = document.querySelectorAll('.form-tab');
            const buttons = document.querySelectorAll('.tab-btn');
            
            forms.forEach(form => form.classList.remove('active'));
            buttons.forEach(btn => btn.classList.remove('active'));
            
            document.getElementById(formId).classList.add('active');
            event.target.classList.add('active');
        }
    </script>
</body>
</html>
