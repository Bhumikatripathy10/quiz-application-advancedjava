package com.example.quiz.model;

import java.util.List;

public class Question {
    private int id;
    private int quizId;
    private String questionText;
    private int correctOption; // 1..4
    private List<Option> options;

    // getters/setters
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public int getQuizId(){return quizId;}
    public void setQuizId(int quizId){this.quizId=quizId;}
    public String getQuestionText(){return questionText;}
    public void setQuestionText(String questionText){this.questionText = questionText;}
    public int getCorrectOption(){return correctOption;}
    public void setCorrectOption(int correctOption){this.correctOption = correctOption;}
    public List<Option> getOptions(){return options;}
    public void setOptions(List<Option> options){this.options = options;}
}