<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.example.quiz.model.Question, com.example.quiz.model.Option" %>
<%
    // Assume that the quiz servlet set these before forwarding:
    // request.setAttribute("quizTitle", quiz.getTitle());
    // request.setAttribute("questions", questionsList);
    String quizTitle = (String) request.getAttribute("quizTitle");
    List<Question> questions = (List<Question>) request.getAttribute("questions");

    if (questions == null || questions.isEmpty()) {
        out.println("<h3>No questions found!</h3>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= quizTitle != null ? quizTitle : "Quiz" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
        }
        .question-card {
            background: #fff;
            color: #333;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        .btn-nav {
            width: 100px;
        }
        #timer {
            font-weight: bold;
            font-size: 1.2rem;
            color: #ff5252;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2><%= quizTitle %></h2>
        <div>Time Left: <span id="timer">20:00</span></div>
    </div>

    <form action="SubmitQuizServlet" method="post" id="quizForm">
        <input type="hidden" name="quizId" value="<%= request.getAttribute("quizId") %>">
        <%
            int index = 0;
            for (Question q : questions) {
        %>
        <div class="question-card mb-4 question-block" id="question-<%= index %>" style="<%= index == 0 ? "" : "display:none;" %>">
            <h5>Question <%= index + 1 %>:</h5>
            <p><%= q.getQuestionText() %></p>
            <%
                List<Option> options = q.getOptions();
                int optIndex = 1;
                for (Option opt : options) {
            %>
            <div class="form-check">
                <input class="form-check-input" type="radio"
                       name="question_<%= q.getId() %>"
                       id="q<%= q.getId() %>_opt<%= optIndex %>"
                       value="<%= optIndex %>">
                <label class="form-check-label" for="q<%= q.getId() %>_opt<%= optIndex %>">
                    <%= opt.getOptionText() %>
                </label>
            </div>
            <%
                    optIndex++;
                }
            %>
        </div>
        <%
                index++;
            }
        %>

        <div class="d-flex justify-content-between">
            <button type="button" class="btn btn-secondary btn-nav" id="prevBtn" disabled>Previous</button>
            <button type="button" class="btn btn-primary btn-nav" id="nextBtn">Next</button>
            <button type="submit" class="btn btn-success btn-nav" id="submitBtn" style="display:none;">Submit</button>
        </div>
    </form>
</div>

<script>
    let currentIndex = 0;
    const total = <%= questions.size() %>;
    const blocks = document.querySelectorAll('.question-block');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');

    function showQuestion(i) {
        blocks.forEach((b, idx) => b.style.display = (i === idx) ? '' : 'none');
        prevBtn.disabled = (i === 0);
        if (i === total - 1) {
            nextBtn.style.display = 'none';
            submitBtn.style.display = '';
        } else {
            nextBtn.style.display = '';
            submitBtn.style.display = 'none';
        }
    }

    prevBtn.onclick = () => { if (currentIndex > 0) showQuestion(--currentIndex); };
    nextBtn.onclick = () => { if (currentIndex < total - 1) showQuestion(++currentIndex); };

    // 20-minute timer (1200 seconds)
    let timeLeft = 1200;
    const timerDisplay = document.getElementById('timer');
    const timer = setInterval(() => {
        const mins = Math.floor(timeLeft / 60);
        const secs = timeLeft % 60;
        timerDisplay.textContent = ${mins}:${secs < 10 ? '0' + secs : secs};
        if (timeLeft <= 0) {
            clearInterval(timer);
            alert("Time's up! Submitting your quiz...");
            document.getElementById('quizForm').submit();
        }
        timeLeft--;
    }, 1000);
</script>
</body>
</html>