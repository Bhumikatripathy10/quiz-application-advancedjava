package com.example.quiz.servlet;

import com.example.quiz.dao.WorksheetDao;
import com.example.quiz.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/deleteWorksheet")
public class DeleteWorksheetServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            out.print("fail");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null) {
            out.print("fail");
            return;
        }

        int id = 0;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            out.print("fail");
            return;
        }

        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
        WorksheetDao dao = new WorksheetDao(conn);

        boolean deleted = dao.deleteWorksheet(id);
        if (deleted) {
            out.print("success");
        } else {
            out.print("fail");
        }
    }
}
