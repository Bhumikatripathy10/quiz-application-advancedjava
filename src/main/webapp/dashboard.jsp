<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.quiz.model.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.example.quiz.dao.WorksheetDao" %>
<%@ page import="com.example.quiz.model.Worksheet" %>
<%@ page import="com.example.quiz.dao.AssessmentDao" %>
<%@ page import="com.example.quiz.model.Assessment" %>
<%@ page import="com.example.quiz.dao.PPTDao" %>
<%@ page import="com.example.quiz.model.PPT" %>
<%@ page import="com.example.quiz.dao.FlashcardDao" %>
<%@ page import="com.example.quiz.model.Flashcard" %>

<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = (Connection) application.getAttribute("DBConnection");

    WorksheetDao worksheetDao = new WorksheetDao(conn);
    List<Worksheet> worksheets = worksheetDao.getAllWorksheets();

    AssessmentDao assessmentDao = new AssessmentDao(conn);
    List<Assessment> assessments = assessmentDao.getAllAssessments();

    PPTDao pptDao = new PPTDao(conn);
    List<PPT> ppts = pptDao.getAllPPTs();

    FlashcardDao flashcardDao = new FlashcardDao();
    List<Flashcard> flashcards;
    try {
        flashcards = flashcardDao.getAllFlashcards();
    } catch(Exception e) {
        flashcards = Collections.emptyList();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Dashboard – Free Resources</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body { 
            font-family: 'Poppins', sans-serif; 
            margin:0; padding:30px; 
            background: linear-gradient(135deg, #e3f2fd, #fce4ec);
            overflow-x:hidden;
            animation: fadeIn 1s ease-in;
        }
        h2, h3 { text-align:center; color:#222; letter-spacing:1px; }
        h2 { 
            font-size: 2rem;
            background: linear-gradient(90deg, #00bcd4, #8e24aa);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: glow 2s infinite alternate;
        }

        @keyframes glow {
            from { text-shadow: 0 0 10px #9c27b0; }
            to { text-shadow: 0 0 20px #03a9f4; }
        }

        .section-grid { 
            display:flex; flex-wrap:wrap; gap:30px; justify-content:center; 
            margin-bottom:40px; 
        }
        .section-card { 
            background:white; width:250px; padding:25px; border-radius:15px; 
            text-align:center;
            box-shadow:0 4px 15px rgba(0,0,0,0.2); 
            cursor:pointer; 
            transition:transform 0.4s, box-shadow 0.4s;
            transform-style: preserve-3d;
        }
        .section-card:hover { 
            transform:rotateY(10deg) rotateX(5deg) scale(1.05); 
            box-shadow:0 10px 25px rgba(0,0,0,0.25);
        }
        .section-card i { 
            font-size:50px; color:#4CAF50; margin-bottom:10px; 
            animation: bounce 1.5s infinite;
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-6px); }
        }
        .section-card h4 { margin:10px 0; color:#333; }

        .section-content { display:none; padding:20px; animation: fadeInUp 0.6s; }
        @keyframes fadeInUp {
            from { opacity:0; transform:translateY(20px); }
            to { opacity:1; transform:translateY(0); }
        }

        .topic-list { display:flex; flex-wrap:wrap; gap:20px; justify-content:center; }

        .topic-card { 
            background:white; border-radius:15px; padding:20px; width:220px;
            box-shadow:0 3px 12px rgba(0,0,0,0.15); 
            text-align:center; 
            transition:transform 0.4s, box-shadow 0.4s;
        }
        .topic-card:hover { 
            transform:translateY(-5px) scale(1.03); 
            box-shadow:0 8px 20px rgba(0,0,0,0.25);
        }
        .topic-card h4 { margin:0; font-size:18px; color:#000; }
        .topic-card p { font-size:14px; color:#555; margin:5px 0; }

        /* Flashcard Styles */
        .flashcard { 
            width:220px; background:white; border-radius:10px; padding:15px;
            box-shadow:0 2px 8px rgba(0,0,0,0.15); 
            position:relative; perspective:1000px; 
            transition: transform 0.6s;
        }
        .flashcard .front, .flashcard .back {
            backface-visibility: hidden;
            transition: transform 0.6s ease-in-out;
            transform-style: preserve-3d;
        }
        .flashcard .back { 
            position:absolute; top:0; left:0; width:100%; height:100%; 
            transform: rotateY(180deg); 
        }
        .flashcard.flipped .front { transform: rotateY(180deg); }
        .flashcard.flipped .back { transform: rotateY(0deg); }

        .flip-btn {
            margin-top: 10px;
            background: linear-gradient(90deg, #4CAF50, #00bcd4);
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            transition: all 0.3s;
        }
        .flip-btn:hover { 
            transform: scale(1.05);
            box-shadow:0 6px 14px rgba(0,0,0,0.25);
        }

        a.btn-download {
            display:inline-block;
            margin-top:8px;
            text-decoration:none;
            background: linear-gradient(90deg, #4CAF50, #8BC34A);
            color:white;
            padding:6px 10px;
            border-radius:6px;
            font-weight:500;
            transition: all 0.3s ease;
        }
        a.btn-download:hover { 
            transform: scale(1.05);
            background: linear-gradient(90deg, #43A047, #00C853);
        }

        @keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
    </style>
</head>
<body>

<h2>🎓 Teacher Dashboard – Uploaded Resources</h2>

<div class="section-grid">
    <div class="section-card" onclick="showSection('worksheets')">
        <i class="fas fa-file-alt"></i><h4>Assessment Worksheets</h4>
    </div>
    <div class="section-card" onclick="showSection('quizzes')">
        <i class="fas fa-list-ol"></i><h4>MCQ Assessments</h4>
    </div>
    <div class="section-card" onclick="showSection('presentations')">
        <i class="fas fa-chalkboard-teacher"></i><h4>Presentations</h4>
    </div>
    <div class="section-card" onclick="showSection('flashcards')">
        <i class="fas fa-clone"></i><h4>Flashcards</h4>
    </div>
</div>

<!-- Worksheets Section -->
<div id="worksheets" class="section-content">
    <h3>📘 Uploaded Worksheets</h3>
    <div class="topic-list">
        <% for(Worksheet ws : worksheets) { %>
            <div class="topic-card">
                <h4><%= ws.getFileName() %></h4>
                <p><%= ws.getSubject() %> - Grade: <%= ws.getGrade() %></p>
                <p>By: <%= ws.getUploadedBy() %></p>
                <a href="downloadWorksheet?id=<%= ws.getId() %>" class="btn-download">
                    <i class="fas fa-download"></i> Download
                </a>
            </div>
        <% } %>
    </div>
</div>

<!-- Assessments (MCQs) Section -->
<div id="quizzes" class="section-content">
    <h3>🧩 Uploaded MCQ Assessments</h3>
    <div class="topic-list">
        <% for(Assessment a : assessments) { %>
            <div class="topic-card">
                <h4><%= a.getSubject() %> - Grade: <%= a.getClassGrade() %></h4>
                <p>By: <%= a.getUploadedBy() %></p>
                <p style="font-size:13px; color:#444;">Questions: <%= a.getMcqQuestions().length() > 30 ? a.getMcqQuestions().substring(0,30)+"..." : a.getMcqQuestions() %></p>
                <a href="downloadAssessment?id=<%= a.getId() %>" class="btn-download">
                    <i class="fas fa-download"></i> Download
                </a>
            </div>
        <% } %>
    </div>
</div>

<!-- Presentations Section -->
<div id="presentations" class="section-content">
    <h3>📊 Uploaded Presentations</h3>
    <div class="topic-list">
        <% for(PPT p : ppts) { %>
            <div class="topic-card">
                <h4><%= p.getTitle() %></h4>
                <p><%= p.getSubject() %> - Class: <%= p.getClassName() %></p>
                <a href="DownloadPPT?id=<%= p.getId() %>" class="btn-download">
                    <i class="fas fa-download"></i> Download
                </a>
            </div>
        <% } %>
    </div>
</div>

<!-- Flashcards Section -->
<div id="flashcards" class="section-content">
    <h3>🃏 Uploaded Flashcards</h3>
    <div class="topic-list">
        <% for(Flashcard f : flashcards) { %>
            <div class="flashcard">
                <div class="front">
                    <strong>Front:</strong>
                    <p><%= f.getFrontText() %></p>
                    <% if(f.getFrontImagePath()!=null && !f.getFrontImagePath().isEmpty()){ %>
                        <img src="<%= f.getFrontImagePath() %>" alt="Front" style="max-width:100%"> 
                    <% } %>
                </div>
                <div class="back">
                    <strong>Back:</strong>
                    <p><%= f.getBackText() %></p>
                    <% if(f.getBackImagePath()!=null && !f.getBackImagePath().isEmpty()){ %>
                        <img src="<%= f.getBackImagePath() %>" alt="Back" style="max-width:100%"> 
                    <% } %>
                </div>
                <p style="font-size:13px; color:#444; margin-top:10px;">
                    <%= f.getClassName() %> | <%= f.getSubject() %> | <%= f.getTopic() %>
                </p>
                <button class="flip-btn" onclick="flipCard(this)">🔄 Flip</button>
            </div>
        <% } %>
    </div>
</div>

<script>
function showSection(id) {
    document.querySelectorAll('.section-content').forEach(sec => sec.style.display='none');
    document.getElementById(id).style.display='block';
}

function flipCard(btn) {
    const card = btn.closest('.flashcard');
    card.classList.toggle('flipped');
}

window.onload = function() {
    const params = new URLSearchParams(window.location.search);
    const section = params.get("section");
    if(section) showSection(section);
};
</script>

</body>
</html>
