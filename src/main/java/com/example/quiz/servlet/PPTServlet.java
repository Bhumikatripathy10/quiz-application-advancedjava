package com.example.quiz.servlet;

import com.example.quiz.dao.PPTDao;
import com.example.quiz.model.PPT;
import com.example.quiz.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Connection;

@WebServlet("/presentation")
@MultipartConfig(maxFileSize = 1024*1024*50) // 50MB max
public class PPTServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // uploadExisting or addBlank
        String title = request.getParameter("title");
        String className = request.getParameter("class");
        String subject = request.getParameter("subject");

        Part filePart = request.getPart("file");
        byte[] fileBytes = null;

        if(filePart != null && filePart.getSize() > 0) {
            fileBytes = filePart.getInputStream().readAllBytes();
        }

        PPT ppt = new PPT();
        ppt.setTitle(title);
        ppt.setClassName(className);
        ppt.setSubject(subject);

        if("addBlank".equals(action) && fileBytes != null) {
            // Save the slides JSON as file (no PPTX conversion)
            ppt.setFileName(title + ".json");
            ppt.setFileData(fileBytes);
        } else if("uploadExisting".equals(action) && fileBytes != null) {
            ppt.setFileName(filePart.getSubmittedFileName());
            ppt.setFileData(fileBytes);
        }

        // Save to database
        Connection conn = DBConnection.getConnection();
        PPTDao dao = new PPTDao(conn);
        boolean success = dao.uploadPPT(ppt);

        request.setAttribute("message", success ? "File uploaded successfully!" : "File upload failed!");
        request.setAttribute("pptList", dao.getAllPPTs());
        request.getRequestDispatcher("presentation.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = DBConnection.getConnection();
        PPTDao dao = new PPTDao(conn);
        request.setAttribute("pptList", dao.getAllPPTs());
        request.getRequestDispatcher("presentation.jsp").forward(request, response);
    }
}
