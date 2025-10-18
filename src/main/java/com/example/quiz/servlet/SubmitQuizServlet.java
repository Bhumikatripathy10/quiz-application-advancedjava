package com.example.quiz.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import com.example.quiz.dao.QuizDAO;
import com.example.quiz.model.Question;

public class SubmitQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Question> questions = QuizDAO.getQuestions();
        int score = 0;

        for (Question q : questions) {
            String answer = request.getParameter("q" + q.getId());
            if (answer != null && answer.equals(q.getCorrectAnswer())) {
                score++;
            }
        }

        request.setAttribute("score", score);
        RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
        rd.forward(request, response);
    }
}
