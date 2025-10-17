package com.example.quiz.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.example.quiz.dao.UserDao;
import com.example.quiz.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDao dao = new UserDao();
        User user = dao.loginUser(email, password);

        response.setContentType("text/html");
        HttpSession session = request.getSession(); // create session

        if (user != null) {
            // Store user in session (name it 'loggedUser' to match your JSP checks)
            session.setAttribute("loggedUser", user);

            // Redirect to your existing landing page
            String redirectPage = "roleLanding.jsp";

            // Optional: show alert and redirect
            response.getWriter().println("<script>alert('Login Successful!'); window.location='" + redirectPage + "';</script>");

        } else {
            // Login failed
            response.getWriter().println("<script>alert('Invalid Email or Password!'); window.location='login.jsp';</script>");
        }
    }
}