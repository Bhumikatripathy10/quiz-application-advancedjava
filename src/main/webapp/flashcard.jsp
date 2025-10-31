<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.quiz.dao.FlashcardDao" %>
<%@ page import="com.example.quiz.model.Flashcard" %>
<%@ page import="java.util.*" %>
<%
    FlashcardDao dao = new FlashcardDao();
    List<Flashcard> flashcards = new ArrayList<>();
    try {
        flashcards = dao.getAllFlashcards();
    } catch (Exception e) { e.printStackTrace(); }
    int total = flashcards.size();

    Set<String> cats = new HashSet<>();
    for (Flashcard f : flashcards) {
        cats.add((f.getClassName()==null?"":f.getClassName()) + "||" + 
                 (f.getSubject()==null?"":f.getSubject()) + "||" + 
                 (f.getTopic()==null?"":f.getTopic()));
    }
    int categories = cats.size();

    Flashcard editing = (Flashcard) request.getAttribute("flashcardToEdit");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flashcards</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            padding: 20px;
            background: linear-gradient(135deg, #fef6ff, #f0faff);
            color: #333;
            animation: fadeIn 0.8s ease-in-out;
        }

        h2 {
            color: #003366;
            text-align: center;
            letter-spacing: 1px;
            margin-bottom: 25px;
        }

        h3 {
            color: #007bff;
            margin-bottom: 10px;
        }

        .summary {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .cardSummary {
            background: linear-gradient(120deg, #b3e5fc, #e1bee7);
            color: #333;
            padding: 18px 24px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            font-weight: 600;
            transition: transform 0.3s ease, background 0.4s ease;
        }
        .cardSummary:hover {
            transform: translateY(-5px);
            background: linear-gradient(120deg, #80deea, #ce93d8);
        }

        .create {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

        .panel {
            background: white;
            padding: 20px;
            border-radius: 14px;
            flex: 1;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }
        .panel:hover {
            transform: translateY(-4px);
        }

        textarea, input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border 0.3s ease;
            font-size: 14px;
        }
        textarea:focus, input:focus, select:focus {
            border-color: #007bff;
            outline: none;
        }

        .actions {
            margin-top: 12px;
            text-align: right;
        }

        .btn {
            display: inline-block;
            padding: 8px 14px;
            border-radius: 8px;
            background: linear-gradient(90deg, #007bff, #00c6ff);
            color: white;
            text-decoration: none;
            font-size: 14px;
            border: none;
            transition: background 0.4s ease, transform 0.2s ease;
            cursor: pointer;
        }
        .btn:hover {
            background: linear-gradient(90deg, #0056b3, #0099ff);
            transform: scale(1.05);
        }
        .btn-danger {
            background: linear-gradient(90deg, #e53935, #ff5252);
        }
        .btn-danger:hover {
            background: linear-gradient(90deg, #b71c1c, #ff1744);
        }
        .btn-secondary {
            background: linear-gradient(90deg, #6c757d, #adb5bd);
        }
        .btn-secondary:hover {
            background: linear-gradient(90deg, #5a6268, #8d99ae);
        }

        .flashcard-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            justify-content: center;
        }

        .flashcard {
            width: 240px;
            background: white;
            border-radius: 14px;
            padding: 14px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            position: relative;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .flashcard:hover {
            transform: translateY(-6px);
            box-shadow: 0 6px 18px rgba(0,0,0,0.12);
        }

        .flashcard strong {
            color: #007bff;
        }

        .flashcard .preview img {
            max-width: 100%;
            max-height: 120px;
            display: block;
            margin-top: 8px;
            border-radius: 6px;
        }

        .meta {
            font-size: 13px;
            color: #444;
            margin-top: 10px;
            background: #f0faff;
            padding: 6px;
            border-radius: 6px;
            font-weight: 600;
            text-align: center;
        }

        .flip-area {
            margin-top: 10px;
            text-align: center;
        }

        .hidden {
            display: none;
        }

        hr {
            border: 0;
            border-top: 2px solid #007bff22;
            margin: 25px 0;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <h2>✨ Flashcards Collection ✨</h2>

    <div class="summary">
        <div class="cardSummary">
            <strong>Total Flashcards</strong>
            <div style="font-size:22px;"><%= total %></div>
        </div>
        <div class="cardSummary">
            <strong>Total Categories</strong>
            <div style="font-size:22px;"><%= categories %></div>
        </div>
    </div>

    <div class="create">
        <div class="panel">
            <h3><%= (editing!=null) ? "✏️ Edit Flashcard" : "➕ Create New Flashcard" %></h3>
            <form action="<%= (editing!=null) ? "EditFlashcardServlet" : "CreateFlashcardServlet" %>" method="post" enctype="multipart/form-data">
                <% if (editing != null) { %>
                    <input type="hidden" name="id" value="<%= editing.getId() %>">
                <% } %>

                <label>Class</label>
                <select name="className" required>
                    <option value="">-- Select Class --</option>
                    <option value="Class 1" <%= (editing!=null && "Class 1".equals(editing.getClassName()) ? "selected":"") %>>Class 1</option>
                    <option value="Class 2" <%= (editing!=null && "Class 2".equals(editing.getClassName()) ? "selected":"") %>>Class 2</option>
                    <option value="Class 3" <%= (editing!=null && "Class 3".equals(editing.getClassName()) ? "selected":"") %>>Class 3</option>
                    <option value="Class 4" <%= (editing!=null && "Class 4".equals(editing.getClassName()) ? "selected":"") %>>Class 4</option>
                    <option value="Class 5" <%= (editing!=null && "Class 5".equals(editing.getClassName()) ? "selected":"") %>>Class 5</option>
                    <option value="Class 6" <%= (editing!=null && "Class 6".equals(editing.getClassName()) ? "selected":"") %>>Class 6</option>
                    <option value="Class 7" <%= (editing!=null && "Class 7".equals(editing.getClassName()) ? "selected":"") %>>Class 7</option>
                    <option value="Class 8" <%= (editing!=null && "Class 8".equals(editing.getClassName()) ? "selected":"") %>>Class 8</option>
                    <option value="Class 9" <%= (editing!=null && "Class 9".equals(editing.getClassName()) ? "selected":"") %>>Class 9</option>
                    <option value="Class 10" <%= (editing!=null && "Class 10".equals(editing.getClassName()) ? "selected":"") %>>Class 10</option>
                    <option value="Class 11" <%= (editing!=null && "Class 11".equals(editing.getClassName()) ? "selected":"") %>>Class 11</option>
                    <option value="Class 12" <%= (editing!=null && "Class 12".equals(editing.getClassName()) ? "selected":"") %>>Class 12</option>
                    <option value="Class university" <%= (editing!=null && "Class university".equals(editing.getClassName()) ? "selected":"") %>>University</option>
                </select>

                <label>Subject</label>
                <select name="subject" required>
                    <option value="">-- Select Subject --</option>
                    <option value="English" <%= (editing!=null && "English".equals(editing.getSubject()) ? "selected":"") %>>English</option>
                    <option value="Science" <%= (editing!=null && "Science".equals(editing.getSubject()) ? "selected":"") %>>Science</option>
                    <option value="Math" <%= (editing!=null && "Math".equals(editing.getSubject()) ? "selected":"") %>>Math</option>
                    <option value="History" <%= (editing!=null && "History".equals(editing.getSubject()) ? "selected":"") %>>History</option>
                    <option value="Geography" <%= (editing!=null && "Geography".equals(editing.getSubject()) ? "selected":"") %>>Geography</option>
                    <option value="Polity" <%= (editing!=null && "Polity".equals(editing.getSubject()) ? "selected":"") %>>Polity</option>
                    <option value="Physics" <%= (editing!=null && "Physics".equals(editing.getSubject()) ? "selected":"") %>>Physics</option>
                    <option value="IT" <%= (editing!=null && "IT".equals(editing.getSubject()) ? "selected":"") %>>IT</option>
                    <option value="Angular" <%= (editing!=null && "Angular".equals(editing.getSubject()) ? "selected":"") %>>Angular</option>
                    <option value="Springboot" <%= (editing!=null && "Springboot".equals(editing.getSubject()) ? "selected":"") %>>SpringBoot</option>
                    <option value="Advancedjava" <%= (editing!=null && "Advancedjava".equals(editing.getSubject()) ? "selected":"") %>>AdvancedJava</option>
                </select>

                <label>Topic</label>
                <input type="text" name="topic" value="<%= (editing!=null? editing.getTopic() : "") %>" placeholder="Enter topic" required>

                <div style="display:flex; gap:12px; margin-top:10px; flex-wrap:wrap;">
                    <div style="flex:1; min-width:280px;">
                        <label>Front side (text)</label>
                        <textarea name="frontText" placeholder="Front side..."><%= (editing!=null? editing.getFrontText() : "") %></textarea>
                        <label>Front image (optional)</label>
                        <input type="file" name="frontImage" accept="image/*">
                        <% if (editing!=null && editing.getFrontImagePath()!=null) { %>
                            <div>Current: <img src="<%= editing.getFrontImagePath() %>" style="max-width:80px; display:block; margin-top:6px;"></div>
                        <% } %>
                    </div>
                    <div style="flex:1; min-width:280px;">
                        <label>Back side (text)</label>
                        <textarea name="backText" placeholder="Back side..."><%= (editing!=null? editing.getBackText() : "") %></textarea>
                        <label>Back image (optional)</label>
                        <input type="file" name="backImage" accept="image/*">
                        <% if (editing!=null && editing.getBackImagePath()!=null) { %>
                            <div>Current: <img src="<%= editing.getBackImagePath() %>" style="max-width:80px; display:block; margin-top:6px;"></div>
                        <% } %>
                    </div>
                </div>

                <div class="actions">
                    <button type="submit" class="btn"><%= (editing!=null) ? "Update Flashcard" : "Upload Flashcard" %></button>
                    <a href="flashcard.jsp" class="btn btn-secondary">Reset / New</a>
                </div>
            </form>
        </div>
    </div>

    <hr>

    <h3>📚 Uploaded Flashcards</h3>
    <div class="flashcard-grid">
        <% for (Flashcard f : flashcards) { %>
            <div class="flashcard" data-id="<%= f.getId() %>">
                <div class="frontArea">
                    <div class="preview">
                        <strong>Front</strong>
                        <p style="min-height:48px;"><%= (f.getFrontText()==null?"":f.getFrontText().replaceAll("\\r?\\n","<br/>")) %></p>
                        <% if (f.getFrontImagePath() != null) { %>
                            <img src="<%= f.getFrontImagePath() %>" alt="front image">
                        <% } %>
                    </div>
                </div>

                <div class="backArea hidden">
                    <strong>Back</strong>
                    <p style="min-height:48px;"><%= (f.getBackText()==null?"":f.getBackText().replaceAll("\\r?\\n","<br/>")) %></p>
                    <% if (f.getBackImagePath() != null) { %>
                        <img src="<%= f.getBackImagePath() %>" alt="back image">
                    <% } %>
                </div>

                <div class="meta"><%= f.getClassName() %> | <%= f.getSubject() %> | <%= f.getTopic() %></div>

                <div class="flip-area">
                    <a href="javascript:void(0)" class="btn btn-secondary flipBtn">Flip</a>
                    <a href="EditFlashcardServlet?id=<%= f.getId() %>" class="btn">Edit</a>
                    <a href="DeleteFlashcardServlet?id=<%= f.getId() %>" class="btn btn-danger" onclick="return confirm('Delete this flashcard?');">Delete</a>
                </div>
            </div>
        <% } %>
    </div>

    <script>
        document.querySelectorAll('.flipBtn').forEach(function(btn){
            btn.addEventListener('click', function(){
                var card = btn.closest('.flashcard');
                var front = card.querySelector('.frontArea');
                var back = card.querySelector('.backArea');
                if (back.classList.contains('hidden')) {
                    back.classList.remove('hidden');
                    front.classList.add('hidden');
                } else {
                    back.classList.add('hidden');
                    front.classList.remove('hidden');
                }
            });
        });
    </script>
</body>
</html>
