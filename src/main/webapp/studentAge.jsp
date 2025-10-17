<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.quiz.model.User" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Info</title>

    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            /* Mathematics-themed background image */
            background: url("images/STUDENTAGE.jpg") no-repeat center center fixed;
            background-size: cover;
        }
        .container {
            background: rgba(255, 255, 255, 0.9); /* slightly transparent */
            backdrop-filter: blur(8px); /* optional frosted effect */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            text-align: center;
            width: 350px;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            background: #007BFF;
            color: #fff;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
        .nota-student {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 30px;
            cursor: pointer;
            color: #555;
            text-decoration: none;
            font-size: 16px;
        }
        .nota-student i {
            margin-right: 10px;
            font-size: 24px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Hello <%= user.getName() %>!</h2>
    <p>Please enter your age:</p>

    <!-- Form to submit age -->
    <form action="StudentAgeServlet" method="post">
        <select name="age" required>
            <option value="" disabled selected>Select your age</option>
            <% for (int i = 3; i <= 25; i++) { %>
                <option value="<%= i %>"><%= i %></option>
            <% } %>
        </select>
        <button type="submit">Continue</button>
    </form>

    <!-- Not a student link -->
    <a href="roleLanding.jsp" class="nota-student">
        <i class="fas fa-user"></i> Not a Student
    </a>
</div>
</body>
</html>