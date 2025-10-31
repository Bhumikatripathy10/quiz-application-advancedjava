package com.example.quiz.servlet;

import com.example.quiz.dao.AssessmentDao;
import com.example.quiz.model.Assessment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

@WebServlet("/downloadAssessment")
public class DownloadAssessmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.getWriter().write("Invalid request");
            return;
        }

        int id = Integer.parseInt(idStr);

        try {
            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
            AssessmentDao dao = new AssessmentDao(conn);

            // Get the assessment to download
            List<Assessment> all = dao.getAllAssessments();
            Assessment target = null;
            for (Assessment a : all) {
                if (a.getId() == id) {
                    target = a;
                    break;
                }
            }

            if (target == null) {
                response.getWriter().write("Assessment not found");
                return;
            }

            // Set response headers for download
            response.setContentType("text/plain");
            response.setHeader("Content-Disposition",
                    "attachment;filename=Assessment_Class_" + target.getClassGrade() + "_Subject_" + target.getSubject() + ".txt");

            PrintWriter out = response.getWriter();
            out.println("Class: " + target.getClassGrade());
            out.println("Subject: " + target.getSubject());
            out.println("Uploaded By: " + target.getUploadedBy());
            out.println();
            out.println("MCQ Questions:");
            out.println(target.getMcqQuestions());

            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error while downloading");
        }
    }
}
