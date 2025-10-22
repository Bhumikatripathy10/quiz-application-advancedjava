package com.example.quiz.servlet;

import com.example.quiz.dao.WorksheetDao;
import com.example.quiz.model.User;
import com.example.quiz.model.Worksheet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;

@WebServlet("/uploadWorksheet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10MB
public class UploadWorksheetServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");

        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            response.getWriter().write("fail");
            return;
        }

        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
        if (conn == null) {
            response.getWriter().write("fail");
            return;
        }

        String subject = request.getParameter("subject");
        String grade = request.getParameter("grade");
        Part filePart = request.getPart("worksheetFile");

        if (filePart == null || filePart.getSize() == 0 || subject == null || grade == null) {
            response.getWriter().write("fail");
            return;
        }

        String fileName = filePart.getSubmittedFileName();
        byte[] fileData = filePart.getInputStream().readAllBytes();

        Worksheet ws = new Worksheet();
        ws.setFileName(fileName);
        ws.setSubject(subject);
        ws.setGrade(grade);
        ws.setFileData(fileData);

        WorksheetDao dao = new WorksheetDao(conn);
        boolean saved = dao.saveWorksheet(ws);

        if(saved) {
            // Return the ID of the newly saved worksheet
            response.getWriter().write(String.valueOf(ws.getId()));
        } else {
            response.getWriter().write("fail");
        }
    }
}
