package com.example.quiz.model;

public class Worksheet {
    private int id;
    private String fileName;
    private String subject;
    private String grade;
    private byte[] fileData;
    private String uploadedBy; // add this

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }

    public byte[] getFileData() { return fileData; }
    public void setFileData(byte[] fileData) { this.fileData = fileData; }

    public String getUploadedBy() { return uploadedBy; } // getter
    public void setUploadedBy(String uploadedBy) { this.uploadedBy = uploadedBy; } // setter
}
