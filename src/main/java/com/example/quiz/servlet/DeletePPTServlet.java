package com.example.quiz.servlet;

import com.example.quiz.dao.PPTDao;
import com.example.quiz.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeletePPT")
public class DeletePPTServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            PPTDao dao = new PPTDao(DBConnection.getConnection());
            
            boolean deleted = dao.deletePPT(id);
            if (deleted) {
                response.sendRedirect("presentation?message=Deleted Successfully");
            } else {
                response.sendRedirect("presentation?message=Delete Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("presentation?message=Error Occurred");
        }
    }
}
