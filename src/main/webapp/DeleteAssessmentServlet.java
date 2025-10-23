package com.example.quiz.servlet;

import com.example.quiz.dao.AssessmentDao;
import com.example.quiz.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/deleteAssessment")
public class DeleteAssessmentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("loggedUser") : null;
        if (user == null || !"teacher".equalsIgnoreCase(user.getRole())) {
            out.print("fail");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null) { out.print("fail"); return; }

        int id;
        try { id = Integer.parseInt(idStr); } catch (NumberFormatException e) { out.print("fail"); return; }

        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
        AssessmentDao dao = new AssessmentDao(conn);

        boolean deleted = dao.deleteAssessment(id);
        out.print(deleted ? "success" : "fail");
    }
}
