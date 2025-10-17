package com.example.quiz.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.example.quiz.dao.UserDao;
import com.example.quiz.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name"); // username
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setName(name); // maps to username column
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        UserDao dao = new UserDao();

        if (dao.isEmailExist(email)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('User already exists!'); window.location='register.jsp';</script>");
        } else {
            boolean success = dao.registerUser(user);
            if (success) {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Successfully Registered!'); window.location='login.jsp';</script>");
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Registration failed! Try again.'); window.location='register.jsp';</script>");
            }
        }
    }
}