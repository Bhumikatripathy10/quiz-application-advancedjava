package com.example.quiz.servlet;

import com.example.quiz.dao.FlashcardDao;
import com.example.quiz.model.Flashcard;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.*;

@WebServlet("/EditFlashcardServlet")
@MultipartConfig(fileSizeThreshold = 1024*1024, maxFileSize = 5*1024*1024, maxRequestSize = 10*1024*1024)
public class EditFlashcardServlet extends HttpServlet {

    private String saveDirectory;

    @Override
    public void init() {
        saveDirectory = getServletContext().getRealPath("/") + "uploads" + File.separator + "flashcards";
        File dir = new File(saveDirectory);
        if (!dir.exists()) dir.mkdirs();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // For prefill when clicking edit link (optional)
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Flashcard f = new FlashcardDao().getById(id);
            request.setAttribute("flashcardToEdit", f);
            request.getRequestDispatcher("/flashcard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/flashcard.jsp?err=1");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String className = request.getParameter("className");
            String subject = request.getParameter("subject");
            String topic = request.getParameter("topic");
            String frontText = request.getParameter("frontText");
            String backText = request.getParameter("backText");

            FlashcardDao dao = new FlashcardDao();
            Flashcard existing = dao.getById(id);
            if (existing == null) {
                response.sendRedirect(request.getContextPath() + "/flashcard.jsp?err=notfound");
                return;
            }

            String newFrontImage = handleFilePart(request.getPart("frontImage"), saveDirectory, request);
            String newBackImage = handleFilePart(request.getPart("backImage"), saveDirectory, request);

            // If new image uploaded, delete old physical file (optional)
            if (newFrontImage != null && existing.getFrontImagePath() != null) {
                deletePhysicalFile(existing.getFrontImagePath(), request);
            }
            if (newBackImage != null && existing.getBackImagePath() != null) {
                deletePhysicalFile(existing.getBackImagePath(), request);
            }

            existing.setClassName(className);
            existing.setSubject(subject);
            existing.setTopic(topic);
            existing.setFrontText(frontText);
            existing.setBackText(backText);
            if (newFrontImage != null) existing.setFrontImagePath(newFrontImage);
            if (newBackImage != null) existing.setBackImagePath(newBackImage);

            dao.updateFlashcard(existing);
            response.sendRedirect(request.getContextPath() + "/flashcard.jsp?msg=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/flashcard.jsp?err=1");
        }
    }

    private String handleFilePart(javax.servlet.http.Part part, String saveDir, HttpServletRequest request) throws IOException {
        if (part == null) return null;
        String submitted = getFilename(part);
        if (submitted == null || submitted.trim().isEmpty()) return null;

        String ext = "";
        int idx = submitted.lastIndexOf('.');
        if (idx >= 0) ext = submitted.substring(idx);
        String fileName = System.currentTimeMillis() + "_" + Math.abs(submitted.hashCode()) + ext;

        File file = new File(saveDir, fileName);
        try (InputStream is = part.getInputStream();
             FileOutputStream os = new FileOutputStream(file)) {
            byte[] buffer = new byte[4096];
            int len;
            while ((len = is.read(buffer)) != -1) os.write(buffer,0,len);
        }
        return request.getContextPath() + "/uploads/flashcards/" + fileName;
    }

    private String getFilename(javax.servlet.http.Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String token : cd.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private void deletePhysicalFile(String webPath, HttpServletRequest request) {
        // webPath like '/context/uploads/flashcards/16345_xxx.jpg'
        try {
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
