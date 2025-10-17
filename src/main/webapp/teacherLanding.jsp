<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.quiz.model.User" %>
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
        body { font-family: 'Poppins', sans-serif; margin:0; padding:0; background:#f3f6fa; }

        /* POPUP */
        .popup-overlay {
            position: fixed; top:0; left:0; width:100%; height:100%;
            background: rgba(0,0,0,0.6);
            display:flex; justify-content:center; align-items:center;
            z-index:1000;
        }
        .popup {
            background:white; width:60%; border-radius:20px; padding:30px;
            text-align:center; box-shadow:0 5px 20px rgba(0,0,0,0.2);
        }
        .subjects, .grades { display:flex; flex-wrap:wrap; justify-content:center; gap:15px; margin-bottom:20px; }
        .subject-card, .grade-card {
            background:#fff; border:2px solid #ddd; border-radius:15px;
            width:120px; padding:15px; cursor:pointer; transition:all 0.3s; text-align:center;
        }
        .subject-card:hover, .grade-card:hover, .selected {
            border-color:#4CAF50; transform:translateY(-3px);
        }
        .subject-card i { font-size:30px; margin-bottom:10px; color:#4CAF50; }
        .continue-btn {
            background:#4CAF50; color:#fff; border:none; padding:12px 30px; border-radius:10px; cursor:pointer;
        }
        .continue-btn:hover { background:#45a049; }

        /* DASHBOARD */
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
        .topic-card {
            background:#fff; color:#000; border-radius:10px; padding:20px; width:200px;
            box-shadow:0 2px 8px rgba(0,0,0,0.1); transition:0.3s; text-align:center;
        }
        .topic-card:hover { transform:translateY(-3px); box-shadow:0 6px 15px rgba(0,0,0,0.15); }
        .topic-card h4 { margin:0; font-size:18px; color:#000; }

        /* CREATE SECTION */
        .create-section {
            display:none;
            margin-top:40px;
            text-align:center;
        }
        .create-options {
            display:flex;
            justify-content:center;
            gap:30px;
            flex-wrap:wrap;
        }
        .create-card {
            background:white;
            border-radius:15px;
            box-shadow:0 2px 8px rgba(0,0,0,0.1);
            width:250px;
            padding:25px;
            cursor:pointer;
            transition:0.3s;
        }
        .create-card:hover { transform:translateY(-3px); box-shadow:0 6px 15px rgba(0,0,0,0.15); }
        .create-card i { font-size:40px; color:#4CAF50; margin-bottom:10px; }
        .create-card h4 { margin:10px 0 5px; }
        .create-card p { color:#666; font-size:14px; }

        /* ASSESSMENT SUBMENU */
        .assessment-submenu {
            display:none;
            margin-top:30px;
            text-align:center;
        }
        .upload-box {
            background:#fff; border:2px dashed #4CAF50; padding:30px; border-radius:15px;
            width:60%; margin:20px auto;
        }
        .upload-box input[type="file"] { display:block; margin:10px auto; }
        .action-btn {
            background:#4CAF50; color:#fff; border:none; padding:12px 25px;
            border-radius:10px; cursor:pointer; margin:10px;
        }
        .action-btn:hover { background:#45a049; }

        /* Upload success text */
        .upload-success { color:green; font-weight:600; margin-top:10px; }
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
        <div><i class="fas fa-upload"></i><p>Upload</p></div>
    </div>

    <!-- CREATE SECTION -->
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

    <!-- ASSESSMENT SUBMENU -->
    <div class="assessment-submenu" id="assessmentSubmenu">
        <h3>Assessment Options</h3>
        <div>
            <button class="action-btn" id="importBtn"><i class="fas fa-file-import"></i> Import Worksheet</button>
            <button class="action-btn"><i class="fas fa-plus"></i> Create New Assessment</button>
        </div>

        <div class="upload-box" id="uploadBox" style="display:none;">
            <h4>Upload Worksheet File</h4>
            <p>Supported formats: .xls, .xlsx, .csv</p>

            <!-- ✅ Upload Form: updated with context path -->
            <form action="<%=request.getContextPath()%>/uploadWorksheet" method="post" enctype="multipart/form-data">
                <input type="file" name="worksheetFile" accept=".xls,.xlsx,.csv" required>
                <button type="submit" class="action-btn"><i class="fas fa-upload"></i> Upload</button>
            </form>

            <!-- ✅ Success Message -->
            <%
                if (request.getParameter("uploadSuccess") != null) {
            %>
                <p class="upload-success">✅ Worksheet uploaded successfully!</p>
            <%
                }
            %>
        </div>
    </div>

    <div class="search-section">
        <input type="text" placeholder="Search topics or quizzes...">
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
            <option>1st</option><option>2nd</option><option>3rd</option><option>4th</option><option>5th</option>
            <option>6th</option><option>7th</option><option>8th</option><option>9th</option><option>10th</option>
            <option>11th</option><option>12th</option>
        </select>
    </div>

    <div class="topics">
        <h3>Browse Topics</h3>
        <div class="topic-list" id="topicList"></div>
    </div>
</div>

<script>
// --- JS remains unchanged ---
const topicsData = {
    "Mathematics": { "1st":["Counting","Addition","Subtraction","Shapes","Patterns"], "2nd":["Multiplication","Division","Fractions","Measurements","Time"] },
    "Science": { "1st":["Living Things","Plants","Animals","Weather","Seasons"], "2nd":["Matter","Energy","Forces","Water","Air"] },
    "English": { "1st":["Alphabets","Reading","Writing","Rhymes","Stories"], "2nd":["Grammar","Comprehension","Tenses","Vocabulary","Speaking"] },
    "Physics": { "9th":["Motion","Force","Work & Energy","Gravitation","Sound"], "10th":["Light","Electricity","Magnetism","Energy","Waves"] },
    "IT": { "9th":["Basics of Computers","Internet","Coding Fundamentals","Databases","AI Intro"], "10th":["Web Design","Networking","Cyber Security","Python","Cloud Computing"] },
    "History": { "6th":["Ancient India","Early Civilizations","Kings & Empires","Culture","Trade"], "7th":["Medieval Period","Mughals","Revolts","British Era","Freedom Struggle"] }
};

function renderTopics(subject, grade){
    const list = document.getElementById("topicList");
    list.innerHTML = "";
    const topics = topicsData[subject]?.[grade];
    if(!topics || topics.length===0){
        list.innerHTML = `<p style="color:#888;">No topics available for ${subject} ${grade}</p>`;
        return;
    }
    topics.forEach(t => {
        const div = document.createElement("div");
        div.className = "topic-card";
        const h4 = document.createElement("h4");
        h4.textContent = t;
        div.appendChild(h4);
        list.appendChild(div);
    });
}

document.querySelectorAll('.subject-card').forEach(card=>{
    card.addEventListener('click',()=>{
        document.querySelectorAll('.subject-card').forEach(c=>c.classList.remove('selected'));
        card.classList.add('selected');
    });
});
document.querySelectorAll('.grade-card').forEach(card=>{
    card.addEventListener('click',()=>{
        document.querySelectorAll('.grade-card').forEach(c=>c.classList.remove('selected'));
        card.classList.add('selected');
    });
});

document.getElementById('continueBtn').addEventListener('click',()=>{
    const subject=document.querySelector('.subject-card.selected p')?.innerText.trim();
    const grade=document.querySelector('.grade-card.selected')?.innerText.trim();
    if(!subject || !grade){ alert('Select subject & grade'); return; }

    document.getElementById('popupOverlay').style.display='none';
    document.getElementById('dashboard').style.display='block';
    document.getElementById('subjectDropdown').value=subject;
    document.getElementById('gradeDropdown').value=grade;
    renderTopics(subject,grade);
});

document.getElementById('subjectDropdown').addEventListener('change',()=>{
    renderTopics(document.getElementById('subjectDropdown').value, document.getElementById('gradeDropdown').value);
});
document.getElementById('gradeDropdown').addEventListener('change',()=>{
    renderTopics(document.getElementById('subjectDropdown').value, document.getElementById('gradeDropdown').value);
});

window.addEventListener('load',()=>{
    document.getElementById('popupOverlay').style.display='flex';
    document.getElementById('dashboard').style.display='none';
});

const createIcon = document.getElementById('createIcon');
const createSection = document.getElementById('createSection');
const assessmentSubmenu = document.getElementById('assessmentSubmenu');
const importBtn = document.getElementById('importBtn');
const uploadBox = document.getElementById('uploadBox');

createIcon.addEventListener('click',()=>{
    createSection.style.display = "block";
    assessmentSubmenu.style.display = "none";
});

document.getElementById('createAssessment').addEventListener('click',()=>{
    createSection.style.display="none";
    assessmentSubmenu.style.display="block";
});

importBtn.addEventListener('click',()=>{
    uploadBox.style.display = uploadBox.style.display === "none" ? "block" : "none";
});
</script>

</body>
</html>