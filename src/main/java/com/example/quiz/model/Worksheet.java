package com.example.quiz.model;

import java.util.Date;

public class Worksheet {
    private int id;
    private String fileName;
    private String filePath;
    private String uploadedBy;
    private Date uploadTime;  // ✅ add this

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public String getUploadedBy() { return uploadedBy; }
    public void setUploadedBy(String uploadedBy) { this.uploadedBy = uploadedBy; }

    public Date getUploadTime() { return uploadTime; } // ✅ getter
    public void setUploadTime(Date uploadTime) { this.uploadTime = uploadTime; } // ✅ setter
}
