package com.example.quiz.model;

public class Assessment {
    private int id;
    private String classGrade;
    private String mcqQuestions;
    private String uploadedBy;
    private String subject;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getClassGrade() { return classGrade; }
    public void setClassGrade(String classGrade) { this.classGrade = classGrade; }

    public String getMcqQuestions() { return mcqQuestions; }
    public void setMcqQuestions(String mcqQuestions) { this.mcqQuestions = mcqQuestions; }

    public String getUploadedBy() { return uploadedBy; }
    public void setUploadedBy(String uploadedBy) { this.uploadedBy = uploadedBy; }
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
}
