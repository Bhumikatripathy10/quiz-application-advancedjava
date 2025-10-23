package com.example.quiz.servlet;

import com.example.quiz.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/TeacherLandingServlet")
public class TeacherLandingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("loggedUser");
        }

        if (user == null) {
            // User not logged in
            response.getWriter().println("You must login to access this page.");
            return;
        }

        // Check role
        if (!"teacher".equalsIgnoreCase(user.getRole())) {
            request.setAttribute("message", "This page is only accessible by teachers.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // User is teacher, allow access
        request.getRequestDispatcher("teacherLanding.jsp").forward(request, response);
    }
}
