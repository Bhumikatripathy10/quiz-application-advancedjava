package com.example.quiz.servlet;

import com.example.quiz.dao.ResultDao;
import com.example.quiz.model.Result;
import com.example.quiz.model.Question;
import com.example.quiz.model.Quiz;
import com.example.quiz.model.AdminUser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SubmitQuizServlet")
public class SubmitQuizServlet extends HttpServlet {
    private ResultDao resultDao = new ResultDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get logged user
        AdminUser user = (AdminUser) session.getAttribute("loggedUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get quiz and questions
        Quiz quiz = (Quiz) session.getAttribute("quiz");
        List<Question> questions = (List<Question>) session.getAttribute("questions");

        if (quiz == null || questions == null) {
            response.sendRedirect("studentDashboard.jsp");
            return;
        }

        int correct = 0;
        int wrong = 0;

        // Calculate score
        for (Question q : questions) {
            String selected = request.getParameter("question_" + q.getId());
            if (selected != null) {
                int chosenOption = Integer.parseInt(selected);
                if (chosenOption == q.getCorrectOption()) {
                    correct++;
                } else {
                    wrong++;
                }
            } else {
                wrong++;
            }
        }

        int total = questions.size();
        int score = (int) ((correct * 100.0) / total); // percentage score

        // 🧠 Create Result object and save to DB
        Result result = new Result();
        result.setUserId(user.getId());
        result.setQuizId(quiz.getId());
        result.setCorrectCount(correct);
        result.setWrongCount(wrong);
        result.setTotalQuestions(total);
        result.setScore(score);
        result.setTimeTakenSeconds(0);

        resultDao.saveResult(result);

        // Send to result.jsp
        request.setAttribute("user", user);
        request.setAttribute("correct", correct);
        request.setAttribute("wrong", wrong);
        request.setAttribute("total", total);
        request.setAttribute("score", score);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}