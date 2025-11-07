<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Question | SmartQuiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg,#667eea,#764ba2); color: #fff; font-family: 'Poppins',sans-serif; }
        .container { margin-top: 50px; max-width: 700px; }
        .card { border-radius: 15px; background-color: rgba(255,255,255,0.1); }
        .btn-primary { border-radius: 20px; }
        .btn-primary:hover { background-color: #8f94fb; }
    </style>
</head>
<body>
<div class="container">
    <div class="card p-4">
        <h3 class="mb-4"><i class="bi bi-plus-circle"></i> Add Question</h3>
        <form action="AddQuestionServlet" method="post">
            <input type="hidden" name="quizId" value="<%= request.getParameter("quizId") %>">
            <div class="mb-3">
                <label class="form-label">Question Text</label>
                <textarea class="form-control" name="questionText" rows="3" required></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Option A</label>
                <input type="text" class="form-control" name="optionA" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Option B</label>
                <input type="text" class="form-control" name="optionB" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Option C</label>
                <input type="text" class="form-control" name="optionC" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Option D</label>
                <input type="text" class="form-control" name="optionD" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Correct Option</label>
                <select class="form-select" name="correctOption" required>
                    <option value="">Select Correct Option</option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                </select>
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-circle"></i> Add Question</button>
                <a href="ManageQuestionsServlet?quizId=<%= request.getParameter("quizId") %>" class="btn btn-secondary">Back</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>