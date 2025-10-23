<%@ page import="com.example.quiz.model.User" %>
<%@ page import="com.example.quiz.model.Assessment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null || !"teacher".equalsIgnoreCase(user.getRole())) {
        request.setAttribute("message", "This page is only accessible by teachers.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
        return;
    }

    List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments");
    Map<String, List<Assessment>> assessmentsByClass = new HashMap<>();

    if (assessments != null) {
        for (Assessment a : assessments) {
            assessmentsByClass.computeIfAbsent(a.getClassGrade(), k -> new java.util.ArrayList<>()).add(a);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Assessment</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body style="background-image: url('images/createassessment.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat; min-height: 100vh;">

<div class="container my-5" style="background-color: rgba(255,255,255,0.85); padding: 20px; border-radius: 15px;">

    <h2 class="mb-4 text-center text-primary">Create New Assessment</h2>

    <div class="card mb-5 shadow-sm">
        <div class="card-body">
            <form action="<%=request.getContextPath()%>/saveAssessment" method="post">
                <div class="mb-3">
                    <label for="classGrade" class="form-label">Class/Grade:</label>
                    <input type="text" id="classGrade" name="classGrade" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="subject" class="form-label">Subject:</label>
                    <input type="text" id="subject" name="subject" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="mcqQuestions" class="form-label">Paste your MCQ Questions here:</label>
                    <textarea id="mcqQuestions" name="mcqQuestions" class="form-control" rows="8" placeholder="Question 1: ...&#10;Option A ...&#10;Option B ...&#10;Answer: ..."></textarea>
                </div>

                <button type="submit" class="btn btn-success float-end">Save Assessment</button>
            </form>
        </div>
    </div>

    <h3 class="mb-3 text-secondary">Uploaded Questions</h3>

    <%
        int classCounter = 0;
        for (Map.Entry<String, List<Assessment>> entry : assessmentsByClass.entrySet()) {
            String classGrade = entry.getKey();
            List<Assessment> classAssessments = entry.getValue();
            String contentId = "collapse" + classCounter++;
    %>
        <div class="accordion mb-3" id="accordion<%= contentId %>">
            <div class="accordion-item">
                <h2 class="accordion-header" id="heading<%= contentId %>">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#<%= contentId %>" aria-expanded="false" aria-controls="<%= contentId %>">
                        Class: <%= classGrade %> (Click to toggle)
                    </button>
                </h2>
                <div id="<%= contentId %>" class="accordion-collapse collapse" aria-labelledby="heading<%= contentId %>" data-bs-parent="#accordion<%= contentId %>">
                    <div class="accordion-body">
                        <%
                            for (Assessment a : classAssessments) {
                        %>
                        <div class="card mb-3 shadow-sm">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <strong>Uploaded By:</strong> <%= a.getUploadedBy() %><br>
                                        <strong>Subject:</strong> <%= a.getSubject() %>
                                    </div>
                                    <div>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="deleteAssessment(<%= a.getId() %>)">Delete</button>
                                    </div>
                                </div>
                                <hr>
                                <pre><%= a.getMcqQuestions() %></pre>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    <%
        }
    %>
</div>

<script>
    function deleteAssessment(id) {
        if (!confirm("Are you sure you want to delete this assessment?")) return;

        fetch('<%=request.getContextPath()%>/deleteAssessment?id=' + id)
            .then(response => response.text())
            .then(result => {
                if (result === "success") {
                    alert("Deleted successfully");
                    location.reload();
                } else {
                    alert("Failed to delete");
                }
            });
    }
</script>
</body>
</html>
