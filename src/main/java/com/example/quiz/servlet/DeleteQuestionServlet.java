package com.example.quiz.servlet;

import com.example.quiz.dao.QuizDao;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {

    private QuizDao quizDao;

    @Override
    public void init() {
        quizDao = new QuizDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int questionId = Integer.parseInt(request.getParameter("questionId"));
        int quizId = Integer.parseInt(request.getParameter("quizId"));

        quizDao.deleteQuestion(questionId);

        response.sendRedirect("ManageQuestionsServlet?quizId=" + quizId);
    }
}