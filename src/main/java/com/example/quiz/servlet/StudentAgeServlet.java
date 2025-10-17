package com.example.quiz.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.example.quiz.model.Student;
import com.example.quiz.model.User;
import com.example.quiz.dao.StudentDao;

@WebServlet("/StudentAgeServlet")
public class StudentAgeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String ageStr = request.getParameter("age");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (ageStr == null || ageStr.isEmpty() || user == null) {
            response.sendRedirect("studentAge.jsp");
            return;
        }

        int age = Integer.parseInt(ageStr);

        // Create Student model
        Student student = new Student(user.getName(), age);

        // Save to database using DAO
        StudentDao dao = new StudentDao();
        boolean saved = dao.saveStudent(student);

        if (saved) {
            // Save student in session if needed
            session.setAttribute("student", student);

            // Redirect to next page (student dashboard)
            response.sendRedirect("studentDashboard.jsp");
        } else {
            response.getWriter().println("<script>alert('Error saving student info!'); window.location='studentAge.jsp';</script>");
        }
    }
}