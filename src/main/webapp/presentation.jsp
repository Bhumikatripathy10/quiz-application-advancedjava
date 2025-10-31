<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.quiz.model.PPT" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Presentation</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #ccff00
            ;
        }
        .section-card {
            cursor: pointer;
            border: 2px solid #ddd;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
            background-color: #fff;
        }
        .section-card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 5px 15px rgba(0,0,0,0.2);
        }
        .section-logo {
            font-size: 50px;
            margin-bottom: 10px;
            color: #007bff;
        }
        .section-title {
            font-weight: bold;
            font-size: 1.3rem;
        }
        .section-content {
            margin-top: 20px;
            display: none;
        }
        #pptEditor textarea {
            width: 100%;
            resize: vertical;
        }
        #slidePreview {
            border:1px solid #ddd; 
            width:100%; 
            height:250px; 
            margin-top:10px; 
            padding:10px; 
            background-color: #f8f9fa;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<div class="container my-5">

    <h1 class="text-center mb-5 text-primary">Presentation</h1>

    <% String message = (String) request.getAttribute("message");
       if(message != null) { %>
        <p class="text-success text-center"><%= message %></p>
    <% } %>

    <!-- ===== Section Cards ===== -->
    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="section-card" onclick="showSection('existingSection')">
                <div class="section-logo"><i class="bi bi-file-earmark-ppt"></i></div>
                <div class="section-title">Upload PPT from Existing Document</div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="section-card" onclick="showSection('blankSection')">
                <div class="section-logo"><i class="bi bi-plus-square"></i></div>
                <div class="section-title">Add Blank PPT / Slides</div>
            </div>
        </div>
    </div>

    <!-- ===== Upload Existing PPT ===== -->
    <div id="existingSection" class="section-content">
        <h3 class="mb-3">Upload PPT from Existing Document</h3>
        <form method="post" enctype="multipart/form-data" action="presentation" class="border p-4 rounded bg-white shadow-sm">
            <input type="hidden" name="action" value="uploadExisting"/>
            <div class="mb-3">
                <label>Title:</label>
                <input type="text" name="title" class="form-control" required/>
            </div>
            <div class="mb-3">
                <label>Class:</label>
                <input type="text" name="class" class="form-control" required/>
            </div>
            <div class="mb-3">
                <label>Subject:</label>
                <input type="text" name="subject" class="form-control" required/>
            </div>
            <div class="mb-3">
                <label>Select PPT:</label>
                <input type="file" name="file" accept=".ppt,.pptx,.json" class="form-control" required/>
            </div>
            <button type="submit" class="btn btn-primary">Upload</button>
        </form>
    </div>

    <!-- ===== Add Blank PPT ===== -->
    <div id="blankSection" class="section-content">
        <h3 class="mb-3">Add Blank PPT</h3>
        <div class="border p-4 rounded bg-white shadow-sm mb-3">
            <div class="mb-3">
                <label>Title:</label>
                <input type="text" id="blankTitle" class="form-control" required/>
            </div>
            <div class="mb-3">
                <label>Class:</label>
                <input type="text" id="blankClass" class="form-control" required/>
            </div>
            <div class="mb-3">
                <label>Subject:</label>
                <input type="text" id="blankSubject" class="form-control" required/>
            </div>
            <div class="mb-3">
                <label>File Name:</label>
                <input type="text" id="blankFileName" class="form-control" placeholder="Enter file name" required/>
            </div>

            <div id="pptEditor" class="mb-3">
                <div class="mb-2">
                    <button type="button" class="btn btn-success btn-sm me-2" onclick="addSlide()">Add Slide</button>
                    <button type="button" class="btn btn-danger btn-sm me-2" onclick="removeSlide()">Remove Slide</button>
                    <button type="button" class="btn btn-secondary btn-sm me-2" onclick="prevSlide()">Previous Slide</button>
                    <button type="button" class="btn btn-secondary btn-sm" onclick="nextSlide()">Next Slide</button>
                </div>
                <div id="slidePreview">
                    <h5 id="previewTitle">Slide Title</h5>
                    <p id="previewContent">Slide content...</p>
                </div>
                <textarea id="slideEditor" rows="4" placeholder="Edit slide content here" class="form-control mt-2" oninput="updateSlideContentFromEditor()"></textarea>
            </div>

            <form id="blankPPTForm" method="post" enctype="multipart/form-data" action="presentation">
                <input type="hidden" name="action" value="addBlank"/>
                <input type="hidden" name="title" id="formTitle"/>
                <input type="hidden" name="class" id="formClass"/>
                <input type="hidden" name="subject" id="formSubject"/>
                <input type="file" name="file" id="formFile" style="display:none"/>
                <button type="button" class="btn btn-primary" onclick="submitBlankPPT()">Create and Upload Blank PPT</button>
            </form>
        </div>
    </div>

    <!-- ===== Uploaded PPTs ===== -->
    <h3 class="mb-3 mt-5">Uploaded PPTs</h3>
    <table class="table table-bordered table-striped bg-white shadow-sm">
        <thead class="table-light">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Class</th>
            <th>Subject</th>
            <th>File Name</th>
            <th>Download</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<PPT> pptList = (List<PPT>) request.getAttribute("pptList");
            if (pptList != null) {
                for (PPT p : pptList) {
        %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getTitle() %></td>
            <td><%= p.getClassName() %></td>
            <td><%= p.getSubject() %></td>
            <td><%= p.getFileName() %></td>
            <td><a href="DownloadPPT?id=<%=p.getId()%>" class="btn btn-success btn-sm"><i class="bi bi-download"></i> Download</a></td>
            <td><a href="DeletePPT?id=<%=p.getId()%>" onclick="return confirm('Are you sure to delete?')" class="btn btn-danger btn-sm"><i class="bi bi-trash-fill"></i> Delete</a></td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<script>
    // Toggle section display
    function showSection(id) {
        document.getElementById('existingSection').style.display = 'none';
        document.getElementById('blankSection').style.display = 'none';
        document.getElementById(id).style.display = 'block';
    }

    // Slides editor logic
    let slides = [];
    let currentSlide = -1;

    function addSlide() {
        const slideIndex = slides.length + 1;
        const slide = {title: "Slide " + slideIndex, content: ""};
        slides.push(slide);
        currentSlide = slides.length - 1;
        renderSlide();
    }

    function removeSlide() {
        if (slides.length > 0) {
            slides.splice(currentSlide, 1);
            if (slides.length === 0) clearPreview();
            else currentSlide = Math.min(currentSlide, slides.length-1);
            renderSlide();
        }
    }

    function prevSlide() { if(currentSlide>0){currentSlide--; renderSlide();} }
    function nextSlide() { if(currentSlide<slides.length-1){currentSlide++; renderSlide();} }

    function renderSlide() {
        if(currentSlide>=0){
            const slide = slides[currentSlide];
            document.getElementById("previewTitle").innerText = slide.title;
            document.getElementById("previewContent").innerText = slide.content;
            document.getElementById("slideEditor").value = slide.content;
        }
    }

    function clearPreview() {
        document.getElementById("previewTitle").innerText = "Slide Title";
        document.getElementById("previewContent").innerText = "Slide content...";
        document.getElementById("slideEditor").value = "";
    }

    function updateSlideContentFromEditor() {
        if(currentSlide>=0){
            slides[currentSlide].content = document.getElementById("slideEditor").value;
            document.getElementById("previewContent").innerText = slides[currentSlide].content;
        }
    }

    function submitBlankPPT() {
        if(slides.length===0){alert("Please add at least one slide."); return;}
        document.getElementById('formTitle').value = document.getElementById('blankTitle').value;
        document.getElementById('formClass').value = document.getElementById('blankClass').value;
        document.getElementById('formSubject').value = document.getElementById('blankSubject').value;

        const slidesJson = JSON.stringify(slides);
        const blob = new Blob([slidesJson], {type:"application/json"});
        const fileName = document.getElementById('blankFileName').value.trim() || document.getElementById('blankTitle').value;
        const dt = new DataTransfer();
        dt.items.add(new File([blob], fileName + ".json"));
        document.getElementById('formFile').files = dt.files;

        document.getElementById('blankPPTForm').submit();
    }
</script>
</body>
</html>
