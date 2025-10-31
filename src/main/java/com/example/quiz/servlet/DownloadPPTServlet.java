package com.example.quiz.servlet;

import com.example.quiz.dao.PPTDao;
import com.example.quiz.model.PPT;
import com.example.quiz.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/DownloadPPT")
public class DownloadPPTServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            PPTDao dao = new PPTDao(DBConnection.getConnection());
            PPT pptToDownload = null;

            // Find PPT by ID from getAllPPTs()
            List<PPT> pptList = dao.getAllPPTs();
            for (PPT p : pptList) {
                if (p.getId() == id) {
                    pptToDownload = p;
                    break;
                }
            }

            if (pptToDownload != null) {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + pptToDownload.getFileName() + "\"");
                OutputStream out = response.getOutputStream();
                out.write(pptToDownload.getFileData());
                out.flush();
                out.close();
            } else {
                response.getWriter().println("File not found!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
