package com.example.quiz.servlet;

import com.example.quiz.dao.QuizDao;
import com.example.quiz.model.Question;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoadQuestionServlet")
public class LoadQuestionServlet extends HttpServlet {

    private QuizDao quizDao;

    @Override
    public void init() {
        quizDao = new QuizDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int questionId = Integer.parseInt(request.getParameter("questionId"));
        Question question = quizDao.getQuestionById(questionId);

        if (question != null) {
            request.setAttribute("question", question);
            request.setAttribute("quizId", question.getQuizId());
            RequestDispatcher dispatcher = request.getRequestDispatcher("EditQuestion.jsp");
            dispatcher.forward(request, response);
        } else {
            response.getWriter().println("<h3 style='color:red;'>Question not found!</h3>");
        }
    }
}