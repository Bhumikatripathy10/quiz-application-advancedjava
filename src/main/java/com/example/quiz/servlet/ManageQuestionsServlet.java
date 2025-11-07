package com.example.quiz.servlet;

import com.example.quiz.dao.QuizDao;
import com.example.quiz.model.Question;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ManageQuestionsServlet")
public class ManageQuestionsServlet extends HttpServlet {

    private QuizDao quizDao;

    @Override
    public void init() throws ServletException {
        quizDao = new QuizDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ Get quizId from request
            int quizId = Integer.parseInt(request.getParameter("quizId"));

            // ✅ Fetch questions
            List<Question> questions = quizDao.getRandomQuestionsForQuiz(quizId); // you can create a getAllQuestionsByQuiz method instead if needed

            request.setAttribute("questions", questions);
            request.setAttribute("quizId", quizId);

            RequestDispatcher dispatcher = request.getRequestDispatcher("manageQuestions.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3 style='color:red;'>Error loading questions: "
                    + e.getMessage() + "</h3>");
        }
    }
}