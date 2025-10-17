<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.quiz.model.User" %>
<%
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
    <title>School Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        body { 
            font-family: 'Poppins', sans-serif; 
            margin:0; 
            padding:0; 
            /* Mathematics-themed background */
            background: url('images/landingpage.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #333;
        }
        .container { 
            max-width: 1200px; 
            margin: 50px auto; 
            padding: 0 20px; 
        }
        h1 { 
            margin-bottom:40px; 
            color:#fff; 
            text-shadow: 1px 1px 5px rgba(0,0,0,0.6);
        }
        .role-section { 
            display:flex; 
            justify-content:space-between; 
            align-items:center; 
            background: rgba(255,255,255,0.9); /* slightly transparent */
            padding:30px 40px; 
            margin-bottom:30px; 
            border-radius:20px; 
            box-shadow:0 4px 15px rgba(0,0,0,0.1);
            cursor:pointer; 
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .role-section:hover { 
            transform: translateY(-5px); 
            box-shadow:0 6px 20px rgba(0,0,0,0.15);
        }
        .role-text { flex:1; padding-right:20px; }
        .role-text h2 { margin:0 0 15px 0; color:#333; }
        .role-text p { margin:0; font-size:16px; color:#555; }
        .role-icon { font-size:80px; }
        .student-icon { color:#4CAF50; }
        .teacher-icon { color:#FFA500; }
        .admin-icon { color:#FF4C4C; }
    </style>
</head>
<body>
<div class="container">
    <h1>Welcome, <%= user.getName() %>!</h1>

    <div class="role-section" onclick="location.href='StudentLandingServlet'">
        <div class="role-text">
            <h2>Student</h2>
            <p>Participate in classroom activities, quizzes, discussions, and submit assignments to enhance learning.</p>
        </div>
        <div class="role-icon"><i class="fas fa-user-graduate student-icon"></i></div>
    </div>

    <div class="role-section" onclick="location.href='TeacherLandingServlet'">
        <div class="role-text">
            <h2>Teacher</h2>
            <p>Engage students, manage classroom activities, access student progress, and support learning.</p>
        </div>
        <div class="role-icon"><i class="fas fa-chalkboard-teacher teacher-icon"></i></div>
    </div>

    <div class="role-section" onclick="location.href='AdminLandingServlet'">
        <div class="role-text">
            <h2>Administrator</h2>
            <p>Oversee school operations, support teachers, and ensure smooth academic processes.</p>
        </div>
        <div class="role-icon"><i class="fas fa-user-shield admin-icon"></i></div>
    </div>
</div>
</body>
</html>