package com.example.quiz.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.example.quiz.dao.UserDao;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        UserDao dao = new UserDao();
        boolean emailExist = dao.isEmailExist(email);

        if (emailExist) {
            boolean updated = dao.updatePassword(email, newPassword);
            if (updated) {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Password successfully reset!'); window.location='login.jsp';</script>");
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Failed to reset password!'); window.location='forgotPassword.jsp';</script>");
            }
        } else {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Email not found!'); window.location='forgotPassword.jsp';</script>");
        }
    }
}