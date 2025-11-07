package com.example.quiz.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

import com.example.quiz.model.Question;

public class QuizNavigationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Question> questions = (List<Question>) session.getAttribute("questions");
        int currentIndex = Integer.parseInt(request.getParameter("currentIndex"));
        String action = request.getParameter("action");

        if ("next".equals(action) && currentIndex < questions.size() - 1) {
            currentIndex++;
        } else if ("prev".equals(action) && currentIndex > 0) {
            currentIndex--;
        }

        session.setAttribute("currentIndex", currentIndex);
        response.sendRedirect("quiz.jsp");
    }
}