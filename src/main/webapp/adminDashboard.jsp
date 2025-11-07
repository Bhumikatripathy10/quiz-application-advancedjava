<%@ page import="java.util.*, com.example.quiz.model.Quiz, com.example.quiz.dao.QuizDao" %>
<%
    QuizDao dao = new QuizDao();
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
    if (quizzes == null) quizzes = dao.getAllQuizzes();
    List<String[]> results = dao.getAllResults();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | SmartQuiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #141E30, #243B55); color: white; }
        .container { margin-top: 50px; }
        .card {
            background: rgba(255,255,255,0.08);
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            transition: transform 0.2s;
        }
        .card:hover { transform: translateY(-5px); }
        .btn-custom {
            background: linear-gradient(45deg, #00c6ff, #0072ff);
            color: #fff;
            border-radius: 50px;
            font-weight: bold;
        }
        .section-title { border-bottom: 2px solid #00c6ff; display: inline-block; margin-bottom: 20px; }
        .navbar { background-color: rgba(0,0,0,0.3); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="#">SmartQuiz Admin</a>
    <div class="d-flex">
      <a href="LogoutServlet" class="btn btn-danger btn-sm">Logout</a>
    </div>
  </div>
</nav>

<div class="container">
    <h2 class="text-center mb-4">Welcome, Admin 👩‍💻</h2>

    <!-- QUIZZES SECTION -->
    <h4 class="section-title">📚 Available Quizzes</h4>
    <div class="row">
        <% for (Quiz q : quizzes) { %>
        <div class="col-md-4 mb-4">
            <div class="card p-3 text-center">
                <h5><%= q.getTitle() %></h5>
                <p>⏱ Time Limit: <%= q.getTimeLimitSeconds() %> sec</p>
                <a href="ViewQuizServlet?quizId=<%= q.getId() %>" class="btn btn-custom btn-sm">View Questions</a>
            </div>
        </div>
        <% } %>
    </div>

    <!-- RESULTS SECTION -->
    <h4 class="section-title mt-5">🏆 Student Results</h4>
    <div class="table-responsive">
        <table class="table table-striped table-dark">
            <thead>
                <tr>
                    <th>Student</th>
                    <th>Quiz</th>
                    <th>Score</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] row : results) { %>
                <tr>
                    <td><%= row[0] %></td>
                    <td><%= row[1] %></td>
                    <td><%= row[2] %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- ADD QUIZ -->
    <div class="text-center mt-5">
        <a href="addQuiz.jsp" class="btn btn-success btn-lg">➕ Add New Quiz</a>
    </div>
</div>

</body>
</html>