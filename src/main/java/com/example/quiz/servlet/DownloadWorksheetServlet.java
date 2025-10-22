package com.example.quiz.servlet;

import com.example.quiz.dao.WorksheetDao;
import com.example.quiz.model.Worksheet;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadWorksheet")
public class DownloadWorksheetServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
        WorksheetDao dao = new WorksheetDao(conn);
        Worksheet ws = dao.getWorksheetById(id);

        if (ws != null) {
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + ws.getFileName());
            response.getOutputStream().write(ws.getFileData());
        }
    }
}
