<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.quiz.model.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.quiz.dao.WorksheetDao" %>
<%@ page import="com.example.quiz.model.Worksheet" %>
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
<title>Teacher Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
/* Your previous styles (unchanged) */
body { font-family: 'Poppins', sans-serif; margin:0; padding:0; background:#f3f6fa; }
.popup-overlay { position: fixed; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.6); display:flex; justify-content:center; align-items:center; z-index:1000; }
.popup { background:white; width:60%; border-radius:20px; padding:30px; text-align:center; box-shadow:0 5px 20px rgba(0,0,0,0.2); }
.subjects, .grades { display:flex; flex-wrap:wrap; justify-content:center; gap:15px; margin-bottom:20px; }
.subject-card, .grade-card { background:#fff; border:2px solid #ddd; border-radius:15px; width:120px; padding:15px; cursor:pointer; transition:all 0.3s; text-align:center; }
.subject-card:hover, .grade-card:hover, .selected { border-color:#4CAF50; transform:translateY(-3px); }
.subject-card i { font-size:30px; margin-bottom:10px; color:#4CAF50; }
.continue-btn { background:#4CAF50; color:#fff; border:none; padding:12px 30px; border-radius:10px; cursor:pointer; }
.continue-btn:hover { background:#45a049; }

.dashboard { display:none; padding:20px 50px; }
.top-icons { display:flex; justify-content:center; gap:50px; margin-top:30px; }
.top-icons div { text-align:center; cursor:pointer; }
.top-icons i { font-size:40px; color:#4CAF50; }
.top-icons p { margin-top:5px; font-weight:500; }

.search-section { margin:30px auto; text-align:center; }
.search-section input { width:60%; padding:10px; border-radius:10px; border:1px solid #ccc; font-size:16px; }

.dropdowns { display:flex; justify-content:center; gap:30px; margin:20px 0; }
select { padding:10px; border-radius:10px; border:1px solid #ccc; font-size:16px; }

.topics { margin-top:30px; text-align:center; }
.topics h3 { font-size:24px; color:#333; margin-bottom:25px; }
.topic-list { display:flex; flex-wrap:wrap; justify-content:center; gap:20px; overflow:visible; }
.topic-card { background:#fff; color:#000; border-radius:10px; padding:20px; width:200px; box-shadow:0 2px 8px rgba(0,0,0,0.1); transition:0.3s; text-align:center; position:relative; }
.topic-card:hover { transform:translateY(-3px); box-shadow:0 6px 15px rgba(0,0,0,0.15); }
.topic-card h4 { margin:0; font-size:18px; color:#000; }
.topic-card p { font-size:14px; color:#666; margin:5px 0; }

.create-section { display:none; margin-top:40px; text-align:center; }
.create-options { display:flex; justify-content:center; gap:30px; flex-wrap:wrap; }
.create-card { background:white; border-radius:15px; box-shadow:0 2px 8px rgba(0,0,0,0.1); width:250px; padding:25px; cursor:pointer; transition:0.3s; }
.create-card:hover { transform:translateY(-3px); box-shadow:0 6px 15px rgba(0,0,0,0.15); }
.create-card i { font-size:40px; color:#4CAF50; margin-bottom:10px; }
.create-card h4 { margin:10px 0 5px; }
.create-card p { color:#666; font-size:14px; }

.assessment-submenu { display:none; margin-top:30px; text-align:center; }
.upload-box { background:#fff; border:2px dashed #4CAF50; padding:30px; border-radius:15px; width:60%; margin:20px auto; display:none; text-align:center; }
.upload-box input[type="file"] { display:block; margin:10px auto; }
.action-btn { background:#4CAF50; color:#fff; border:none; padding:12px 25px; border-radius:10px; cursor:pointer; margin:10px; }
.action-btn:hover { background:#45a049; }
.upload-success { color:green; font-weight:600; margin-top:10px; display:none; }
</style>
</head>
<body>

<!-- POPUP -->
<div class="popup-overlay" id="popupOverlay">
    <div class="popup">
        <h2>Select Your Subjects and Grades</h2>
        <div class="subjects">
            <div class="subject-card"><i class="fas fa-square-root-alt"></i><p>Mathematics</p></div>
            <div class="subject-card"><i class="fas fa-book"></i><p>English</p></div>
            <div class="subject-card"><i class="fas fa-flask"></i><p>Science</p></div>
            <div class="subject-card"><i class="fas fa-atom"></i><p>Physics</p></div>
            <div class="subject-card"><i class="fas fa-laptop-code"></i><p>IT</p></div>
            <div class="subject-card"><i class="fas fa-landmark"></i><p>History</p></div>
        </div>
        <h3>Select Grade</h3>
        <div class="grades">
            <div class="grade-card">1st</div><div class="grade-card">2nd</div><div class="grade-card">3rd</div>
            <div class="grade-card">4th</div><div class="grade-card">5th</div><div class="grade-card">6th</div>
            <div class="grade-card">7th</div><div class="grade-card">8th</div><div class="grade-card">9th</div>
            <div class="grade-card">10th</div><div class="grade-card">11th</div><div class="grade-card">12th</div>
        </div>
        <button class="continue-btn" id="continueBtn">Continue</button>
    </div>
</div>

<!-- DASHBOARD -->
<div class="dashboard" id="dashboard">
    <div class="top-icons">
        <div id="createIcon"><i class="fas fa-plus-circle"></i><p>Create</p></div>
        <div><i class="fas fa-search"></i><p>Search</p></div>
        <div id="uploadIcon"><i class="fas fa-upload"></i><p>Upload</p></div>
    </div>

    <div class="create-section" id="createSection">
        <h3>Create New Content</h3>
        <div class="create-options">
            <div class="create-card" id="createAssessment">
                <i class="fas fa-clipboard-list"></i>
                <h4>Assessment</h4>
                <p>Quick and interactive questions</p>
            </div>
            <div class="create-card">
                <i class="fas fa-chalkboard-teacher"></i>
                <h4>Presentation</h4>
                <p>Engage your students visually</p>
            </div>
            <div class="create-card">
                <i class="fas fa-clone"></i>
                <h4>Flashcards</h4>
                <p>Boost memory with fun practice</p>
            </div>
        </div>
    </div>

    <div class="assessment-submenu" id="assessmentSubmenu">
        <h3>Assessment Options</h3>
        <div>
            <button class="action-btn" id="importBtn"><i class="fas fa-file-import"></i> Import Worksheet</button>
            <button class="action-btn"><i class="fas fa-plus"></i> Create New Assessment</button>
        </div>

        <div class="upload-box" id="uploadBox">
            <h4>Upload Worksheet File</h4>
            <p>Supported formats: .xls, .xlsx, .csv</p>

            <input type="file" id="worksheetFile" accept=".xls,.xlsx,.csv">
            <button class="action-btn" id="uploadBtn"><i class="fas fa-upload"></i> Upload</button>
            <p class="upload-success" id="uploadSuccess">✅ Worksheet uploaded successfully!</p>
        </div>
    </div>

    <div class="search-section">
        <input type="text" placeholder="Search topics or worksheets..." id="searchInput">
    </div>

    <div class="dropdowns">
        <select id="subjectDropdown">
            <option>Mathematics</option>
            <option>English</option>
            <option>Science</option>
            <option>Physics</option>
            <option>IT</option>
            <option>History</option>
        </select>
        <select id="gradeDropdown">
            <option>1st</option><option>2nd</option><option>3rd</option><option>4th</option>
            <option>5th</option><option>6th</option><option>7th</option><option>8th</option>
            <option>9th</option><option>10th</option><option>11th</option><option>12th</option>
        </select>
    </div>

    <!-- Uploaded Worksheets -->
    <div class="topics">
        <h3>Uploaded Worksheets</h3>
        <div class="topic-list" id="uploadedList">
            <%
                Connection conn = (Connection) application.getAttribute("DBConnection");
                WorksheetDao dao = new WorksheetDao(conn);
                List<Worksheet> worksheets = dao.getAllWorksheets();
                for(Worksheet ws : worksheets) {
            %>
            <div class="topic-card" data-id="<%= ws.getId() %>">
                <h4><%= ws.getFileName() %></h4>
                <p>Subject: <%= ws.getSubject() %></p>
                <p>Grade: <%= ws.getGrade() %></p>
                <a href="downloadWorksheet?id=<%= ws.getId() %>" style="text-decoration:none;color:#4CAF50;margin-right:10px;">
                    <i class="fas fa-download"></i> Download
                </a>
                <i class="fas fa-trash-alt" style="color:red; cursor:pointer;"></i>
            </div>
            <% } %>
        </div>
    </div>

</div>

<script>

document.addEventListener('DOMContentLoaded', function() {
    // POPUP CONTINUE BUTTON
    const popupOverlay = document.getElementById('popupOverlay');
    const continueBtn = document.getElementById('continueBtn');
    const dashboard = document.getElementById('dashboard');

    if(!sessionStorage.getItem('popupShown')) {
        popupOverlay.style.display = 'flex';
    } else {
        dashboard.style.display = 'block';
    }

    continueBtn.addEventListener('click', function() {
        popupOverlay.style.display = 'none';
        dashboard.style.display = 'block';
        sessionStorage.setItem('popupShown', 'true');
    });

    // CREATE SECTION TOGGLE
    const createIcon = document.getElementById('createIcon');
    const createSection = document.getElementById('createSection');
    createIcon.addEventListener('click', () => {
        createSection.style.display = createSection.style.display === "block" ? "none" : "block";
    });

    // ASSESSMENT SUBMENU TOGGLE
    const createAssessment = document.getElementById('createAssessment');
    const assessmentSubmenu = document.getElementById('assessmentSubmenu');
    createAssessment.addEventListener('click', () => {
        createSection.style.display = "none";
        assessmentSubmenu.style.display = "block";
    });

    // UPLOAD BOX TOGGLE
    const importBtn = document.getElementById('importBtn');
    const uploadBox = document.getElementById('uploadBox');
    importBtn.addEventListener('click', () => {
        uploadBox.style.display = uploadBox.style.display === "block" ? "none" : "block";
    });

    // UPLOAD WORKSHEET
    const uploadBtn = document.getElementById('uploadBtn');
    const uploadSuccess = document.getElementById('uploadSuccess');
    const worksheetFile = document.getElementById('worksheetFile');

    uploadBtn.addEventListener('click', function() {
        const file = worksheetFile.files[0];
        if(!file) { alert('Please select a file'); return; }

        const subject = document.getElementById('subjectDropdown').value;
        const grade = document.getElementById('gradeDropdown').value;

        const formData = new FormData();
        formData.append('worksheetFile', file);
        formData.append('subject', subject);
        formData.append('grade', grade);

        fetch('<%=request.getContextPath()%>/uploadWorksheet', {
            method: 'POST',
            body: formData
        })
        .then(res => res.text())
        .then(result => {
            if(result.trim() !== 'fail') {
                uploadSuccess.style.display = 'block';
                setTimeout(() => uploadSuccess.style.display = 'none', 3000);
                worksheetFile.value = '';
            } else {
                alert('Failed to upload worksheet');
            }
        })
        .catch(err => { console.error(err); alert('Error uploading worksheet'); });
    });



    // Delete worksheet
    document.getElementById('uploadedList').addEventListener('click', function(e) {
        if(e.target.closest('.fa-trash-alt')) {
            const card = e.target.closest('.topic-card');
            const id = card.dataset.id;
            if(confirm('Are you sure you want to delete this worksheet?')) {
                fetch('<%=request.getContextPath()%>/deleteWorksheet?id=' + id)
                .then(res => res.text())
                .then(result => {
                    if(result.trim() === 'success') {
                        card.remove();
                    } else {
                        alert('Failed to delete worksheet');
                    }
                })
                .catch(err => { console.error(err); alert('Error deleting worksheet'); });
            }
        }
    });
});
</script>


</body>
</html>
