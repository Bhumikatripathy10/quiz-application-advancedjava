<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.example.quiz.model.Question, com.example.quiz.model.Option" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Questions | SmartQuiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            font-family: 'Poppins', sans-serif;
            color: #fff;
        }
        .container {
            margin-top: 50px;
        }
        .card-question {
            border-radius: 15px;
            transition: 0.3s ease;
            background-color: rgba(255,255,255,0.1);
        }
        .card-question:hover {
            transform: scale(1.03);
            box-shadow: 0 0 20px rgba(255,255,255,0.3);
        }
        .btn-primary, .btn-success, .btn-danger, .btn-secondary {
            border-radius: 20px;
        }
        .btn-primary:hover { background-color: #8f94fb; }
        .btn-success:hover { background-color: #28a745cc; }
        .btn-danger:hover { background-color: #dc3545cc; }
    </style>
</head>
<body>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-journal-text"></i> Manage Questions for Quiz ID: <%= request.getAttribute("quizId") %></h2>
        <div>
            <a href="addQuestion.jsp?quizId=<%= request.getAttribute("quizId") %>" class="btn btn-primary me-2">
                <i class="bi bi-plus-circle"></i> Add Question
            </a>
            <a href="AdminLandingServlet" class="btn btn-secondary"><i class="bi bi-arrow-left-circle"></i> Back</a>
        </div>
    </div>

    <div class="row">
        <%
            List<Question> questions = (List<Question>) request.getAttribute("questions");
            if (questions != null && !questions.isEmpty()) {
                for (Question q : questions) {
        %>
        <div class="col-md-6 mb-4">
            <div class="card card-question text-white">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-question-circle"></i> <%= q.getQuestionText() %></h5>
                    
                    <ul class="list-group list-group-flush mb-2">
                        <%
                            for (Option o : q.getOptions()) {
                                String optionLetter = "";
                                switch(o.getOptionNo()) {
                                    case 1: optionLetter = "A"; break;
                                    case 2: optionLetter = "B"; break;
                                    case 3: optionLetter = "C"; break;
                                    case 4: optionLetter = "D"; break;
                                }
                        %>
                        <li class="list-group-item bg-transparent text-white">
                            <strong><%= optionLetter %>:</strong> <%= o.getOptionText() %>
                        </li>
                        <%
                            }
                        %>
                    </ul>

                    <p><strong>Correct Option:</strong>
                        <%
                            String correctLetter = "-";
                            switch(q.getCorrectOption()) {
                                case 1: correctLetter = "A"; break;
                                case 2: correctLetter = "B"; break;
                                case 3: correctLetter = "C"; break;
                                case 4: correctLetter = "D"; break;
                            }
                        %>
                        <%= correctLetter %>
                    </p>

                    <div class="d-flex justify-content-end">
                        <a href="LoadQuestionServlet?questionId=<%= q.getId() %>" class="btn btn-success btn-sm me-2">
    <i class="bi bi-pencil-square"></i> Edit
</a>

                        <a href="DeleteQuestionServlet?questionId=<%= q.getId() %>&quizId=<%= request.getAttribute("quizId") %>" 
                           class="btn btn-danger btn-sm">
                            <i class="bi bi-trash"></i> Delete
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="col-12 text-center">
            <p>No questions found. Add new questions now!</p>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>