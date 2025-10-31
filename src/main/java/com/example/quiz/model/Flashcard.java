package com.example.quiz.model;

public class Flashcard {
    private int id;
    private String className;
    private String subject;
    private String topic;
    private String frontText;
    private String backText;
    private String frontImagePath;
    private String backImagePath;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getTopic() { return topic; }
    public void setTopic(String topic) { this.topic = topic; }
    public String getFrontText() { return frontText; }
    public void setFrontText(String frontText) { this.frontText = frontText; }
    public String getBackText() { return backText; }
    public void setBackText(String backText) { this.backText = backText; }
    public String getFrontImagePath() { return frontImagePath; }
    public void setFrontImagePath(String frontImagePath) { this.frontImagePath = frontImagePath; }
    public String getBackImagePath() { return backImagePath; }
    public void setBackImagePath(String backImagePath) { this.backImagePath = backImagePath; }
}
