<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.quiz.model.Question, com.example.quiz.model.Option, java.util.*" %>
<%
    Question q = (Question) request.getAttribute("question");
    List<Option> opts = q.getOptions();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Question | SmartQuiz</title>
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
        <h3 class="mb-4"><i class="bi bi-pencil-square"></i> Edit Question</h3>
        <form action="EditQuestionServlet" method="post">
            <input type="hidden" name="questionId" value="<%= q.getId() %>">
            <input type="hidden" name="quizId" value="<%= q.getQuizId() %>">
            <div class="mb-3">
                <label class="form-label">Question Text</label>
                <textarea class="form-control" name="questionText" rows="3" required><%= q.getQuestionText() %></textarea>
            </div>
            <%
                for(int i=0;i<opts.size();i++){
                    String optLetter="";
                    switch(opts.get(i).getOptionNo()){
                        case 1: optLetter="A"; break;
                        case 2: optLetter="B"; break;
                        case 3: optLetter="C"; break;
                        case 4: optLetter="D"; break;
                    }
            %>
            <div class="mb-3">
                <label class="form-label">Option <%= optLetter %></label>
                <input type="text" class="form-control" name="option<%= optLetter %>" value="<%= opts.get(i).getOptionText() %>" required>
            </div>
            <%
                }
            %>
            <div class="mb-3">
                <label class="form-label">Correct Option</label>
                <select class="form-select" name="correctOption" required>
                    <option value="">Select Correct Option</option>
                    <option value="A" <%= q.getCorrectOption()==1?"selected":"" %>>A</option>
                    <option value="B" <%= q.getCorrectOption()==2?"selected":"" %>>B</option>
                    <option value="C" <%= q.getCorrectOption()==3?"selected":"" %>>C</option>
                    <option value="D" <%= q.getCorrectOption()==4?"selected":"" %>>D</option>
                </select>
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Save Changes</button>
                <a href="ManageQuestionsServlet?quizId=<%= q.getQuizId() %>" class="btn btn-secondary">Back</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>