<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quiz.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>SmartQuiz - Interactive Quiz Platform</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #667eea, #764ba2);
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
        }
        .navbar {
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
        }
        .hero {
            height: 85vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            flex-direction: column;
        }
        .hero h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .hero p {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto 25px;
        }
        .btn-custom {
            background-color: #fff;
            color: #764ba2;
            font-weight: 600;
            border-radius: 30px;
            padding: 10px 25px;
            transition: all 0.3s;
            text-decoration: none;
        }
        .btn-custom:hover {
            background-color: #764ba2;
            color: #fff;
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.4);
        }
        .features {
            background-color: #fff;
            color: #333;
            padding: 60px 20px;
        }
        .feature-card {
            background: #f9f9f9;
            border-radius: 15px;
            padding: 25px;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .footer {
            background-color: rgba(0,0,0,0.4);
            padding: 15px;
            text-align: center;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">SmartQuiz</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <%
                        User loggedUser = (User) session.getAttribute("loggedUser");
                        if (loggedUser == null) { 
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="register.jsp"><i class="fas fa-user-plus"></i> Register</a>
                        </li>
                    <% 
                        } else { 
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h1>Test Your Knowledge with SmartQuiz</h1>
            <p>Join thousands of learners and challenge yourself with dynamic, timed quizzes across multiple categories. Track your performance, earn achievements, and keep improving!</p>
            <div>
                <% if (loggedUser == null) { %>
                    <a href="login.jsp" class="btn btn-custom me-3"><i class="fas fa-user-lock"></i> Login</a>
                    <a href="register.jsp" class="btn btn-custom"><i class="fas fa-user-plus"></i> Register</a>
                <% } else { %>
                    <a href="roleLanding.jsp" class="btn btn-custom">
                        Welcome, <%= loggedUser.getName() %>
                    </a>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="container text-center">
            <h2 class="mb-5 fw-bold">Platform Highlights</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-shield-alt fa-3x mb-3 text-primary"></i>
                        <h5>Secure Authentication</h5>
                        <p>Protect your data with encrypted passwords and secure login for both users and admins.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-chart-line fa-3x mb-3 text-success"></i>
                        <h5>Performance Analytics</h5>
                        <p>Get insights into your quiz performance, accuracy trends, and progress over time.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-trophy fa-3x mb-3 text-warning"></i>
                        <h5>Instant Results</h5>
                        <p>Receive instant feedback with detailed reports of correct and incorrect answers.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-laptop-code fa-3x mb-3 text-danger"></i>
                        <h5>Dynamic Quiz Engine</h5>
                        <p>Engage with time-based, dynamically loaded quizzes from various categories.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-users-cog fa-3x mb-3 text-info"></i>
                        <h5>Admin Dashboard</h5>
                        <p>Manage users, categories, and quiz questions efficiently with built-in reporting tools.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-file-pdf fa-3x mb-3 text-secondary"></i>
                        <h5>Report Export</h5>
                        <p>Generate and download PDF quiz reports for detailed performance tracking.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <div class="footer">
        &copy; <%= java.time.Year.now() %> SmartQuiz | Designed for smart learners 🌟
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>