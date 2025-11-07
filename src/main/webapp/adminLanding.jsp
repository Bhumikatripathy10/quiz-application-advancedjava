<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.example.quiz.model.Quiz" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | SmartQuiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #fff;
            font-family: 'Poppins', sans-serif;
        }
        .dashboard-container {
            margin: 50px auto;
            max-width: 1100px;
        }
        .card {
            border-radius: 15px;
            transition: 0.3s ease;
        }
        .card:hover {
            transform: scale(1.03);
            box-shadow: 0 0 20px rgba(255,255,255,0.2);
        }
        .btn-primary {
            background-color: #4e54c8;
            border: none;
            border-radius: 20px;
        }
        .btn-primary:hover {
            background-color: #8f94fb;
        }
    </style>
</head>
<body>
<div class="container dashboard-container">
    <h2 class="text-center mb-4"><i class="bi bi-person-gear"></i> Admin Dashboard</h2>

    <div class="text-end mb-3">
        <a href="addQuiz.jsp" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Add New Quiz</a>
    </div>

    <div class="row">
        <%
            List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
            if (quizzes != null && !quizzes.isEmpty()) {
                for (Quiz quiz : quizzes) {
        %>
        <div class="col-md-4 mb-4">
            <div class="card text-dark">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-question-circle"></i> <%= quiz.getTitle() %></h5>
                    <p class="card-text">Time Limit: <%= quiz.getTimeLimitSeconds() %> seconds</p>
                    <div class="d-flex justify-content-between">
                        <a href="ManageQuestionsServlet?quizId=<%= quiz.getId() %>" class="btn btn-success btn-sm"><i class="bi bi-pencil-square"></i> Manage</a>
                        <a href="ViewResultsServlet?quizId=<%= quiz.getId() %>" class="btn btn-warning btn-sm"><i class="bi bi-bar-chart"></i> View Results</a>
                        <a href="DeleteQuizServlet?id=<%= quiz.getId() %>" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Delete</a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="text-center">
            <p>No quizzes found. Add one now!</p>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>