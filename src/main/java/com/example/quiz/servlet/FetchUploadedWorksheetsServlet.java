package com.example.quiz.servlet;

import com.example.quiz.dao.WorksheetDao;
import com.example.quiz.model.Worksheet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

// Corrected class name and mapping
@WebServlet("/fetchUploadedWorksheets")
public class FetchUploadedWorksheetsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");

        if (conn != null) {
            WorksheetDao dao = new WorksheetDao(conn);
            List<Worksheet> worksheets = dao.getAllWorksheets();
            StringBuilder sb = new StringBuilder();

            for (Worksheet ws : worksheets) {
                sb.append("<div class='topic-card'>")
                  .append("<h4>").append(ws.getFileName()).append("</h4>")
                  .append("<p>").append(ws.getSubject()).append(" - ").append(ws.getGrade()).append("</p>")
                  .append("<p>Submitted By: ").append(ws.getUploadedBy() != null ? ws.getUploadedBy() : "Unknown").append("</p>")
                  .append("<a href='downloadWorksheet?id=").append(ws.getId())
                  .append("' style='text-decoration:none;color:#4CAF50;'>Download</a>")
                  .append("</div>");
            }

            response.getWriter().write(sb.toString());
        }
    }
}
