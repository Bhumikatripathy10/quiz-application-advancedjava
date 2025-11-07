package com.example.quiz.servlet;

import com.example.quiz.dao.QuizDao;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditQuestionServlet")
public class EditQuestionServlet extends HttpServlet {

    private QuizDao quizDao;

    @Override
    public void init() {
        quizDao = new QuizDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int questionId = Integer.parseInt(request.getParameter("questionId"));
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        String questionText = request.getParameter("questionText");
        String optA = request.getParameter("optionA");
        String optB = request.getParameter("optionB");
        String optC = request.getParameter("optionC");
        String optD = request.getParameter("optionD");
        String correctOption = request.getParameter("correctOption");

        quizDao.updateQuestion(questionId, questionText, optA, optB, optC, optD, correctOption);

        response.sendRedirect("ManageQuestionsServlet?quizId=" + quizId);
    }
}