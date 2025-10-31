package com.example.quiz.servlet;

import com.example.quiz.dao.FlashcardDao;
import com.example.quiz.model.Flashcard;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/CreateFlashcardServlet")
@MultipartConfig(fileSizeThreshold = 1024*1024, // 1MB
                 maxFileSize = 5*1024*1024,      // 5MB per file
                 maxRequestSize = 10*1024*1024)  // 10MB
public class CreateFlascardServlet extends HttpServlet {

    private String saveDirectory;

    @Override
    public void init() throws ServletException {
        // real path inside webapp for storing images
        saveDirectory = getServletContext().getRealPath("/") + "uploads" + File.separator + "flashcards";
        File dir = new File(saveDirectory);
        if (!dir.exists()) dir.mkdirs();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String className = request.getParameter("className");
            String subject = request.getParameter("subject");
            String topic = request.getParameter("topic");
            String frontText = request.getParameter("frontText");
            String backText = request.getParameter("backText");

            String frontImagePath = handleFilePart(request.getPart("frontImage"), saveDirectory, request);
            String backImagePath = handleFilePart(request.getPart("backImage"), saveDirectory, request);

            Flashcard f = new Flashcard();
            f.setClassName(className);
            f.setSubject(subject);
            f.setTopic(topic);
            f.setFrontText(frontText);
            f.setBackText(backText);
            f.setFrontImagePath(frontImagePath);
            f.setBackImagePath(backImagePath);

            new FlashcardDao().saveFlashcard(f);

            response.sendRedirect(request.getContextPath() + "/flashcard.jsp?msg=added");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/flashcard.jsp?err=1");
        }
    }

    private String handleFilePart(Part part, String saveDir, HttpServletRequest request) throws IOException {
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
        // return path relative to web context so JSP/img tag can use it
        return request.getContextPath() + "/uploads/flashcards/" + fileName;
    }

    private String getFilename(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            cd = cd.trim();
            if (cd.startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return filename;
            }
        }
        return null;
    }
}
