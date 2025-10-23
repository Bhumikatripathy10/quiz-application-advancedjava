package com.example.quiz.servlet;

import com.example.quiz.dao.AssessmentDao;
import com.example.quiz.model.Assessment;
import com.example.quiz.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/saveAssessment")
public class SaveAssessmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("loggedUser") : null;

        if (user == null || !"teacher".equalsIgnoreCase(user.getRole())) {
            request.setAttribute("message", "This page is only accessible by teachers.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        String classGrade = request.getParameter("classGrade");
        String subject = request.getParameter("subject");
        String mcqQuestions = request.getParameter("mcqQuestions");

        Assessment a = new Assessment();
        a.setClassGrade(classGrade);
        a.setSubject(subject); 
        a.setMcqQuestions(mcqQuestions);
        a.setUploadedBy(user.getName());

        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
        AssessmentDao dao = new AssessmentDao(conn);
        dao.saveAssessment(a);

        // Redirect back to the same page and show uploaded questions
        request.setAttribute("assessments", dao.getAllAssessments());
        request.getRequestDispatcher("createAssessment.jsp").forward(request, response);
    }
}
