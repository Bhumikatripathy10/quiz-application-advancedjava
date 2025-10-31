package com.example.quiz.servlet;

import com.example.quiz.dao.FlashcardDao;
import com.example.quiz.model.Flashcard;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/DeleteFlashcardServlet")
public class DeleteFlashcardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            FlashcardDao dao = new FlashcardDao();
            Flashcard f = dao.getById(id);
            if (f != null) {
                // delete DB row
                dao.deleteFlashcard(id);
                // delete physical files if exist
                deletePhysicalFile(f.getFrontImagePath(), request);
                deletePhysicalFile(f.getBackImagePath(), request);
            }
            response.sendRedirect(request.getContextPath() + "/flashcard.jsp?msg=deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/flashcard.jsp?err=1");
        }
    }

    private void deletePhysicalFile(String webPath, HttpServletRequest request) {
        try {
            if (webPath == null) return;
            String contextPath = request.getContextPath();
            if (webPath.startsWith(contextPath)) {
                String relative = webPath.substring(contextPath.length());
                String real = request.getServletContext().getRealPath(relative);
                if (real != null) {
                    File f = new File(real);
                    if (f.exists()) f.delete();
                }
            }
        } catch (Exception e) {
            // ignore
        }
    }
}
