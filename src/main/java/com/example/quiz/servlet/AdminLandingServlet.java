//package com.example.quiz.servlet;
//
//import java.io.IOException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//@WebServlet("/AdminLandingServlet")
//public class AdminLandingServlet extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        request.getRequestDispatcher("adminLanding.jsp").forward(request, response);
//    }
//}


/// added sonali
package com.example.quiz.servlet;

import com.example.quiz.dao.QuizDao;
import com.example.quiz.model.Quiz;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/AdminLandingServlet")
public class AdminLandingServlet extends HttpServlet {

    private QuizDao quizDao;

    @Override
    public void init() throws ServletException {
        // ✅ Proper initialization
        quizDao = new QuizDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ Fetch all quizzes from DB
            List<Quiz> quizzes = quizDao.getAllQuizzes();

            // ✅ Pass the list to JSP
            request.setAttribute("quizzes", quizzes);

            RequestDispatcher dispatcher = request.getRequestDispatcher("adminLanding.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3 style='color:red;'>Error loading admin dashboard: "
                    + e.getMessage() + "</h3>");
        }
    }
}