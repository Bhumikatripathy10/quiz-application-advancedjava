package com.example.quiz.model;

public class Option {
    private int id;
    private int questionId;
    private int optionNo;
    private String optionText;

    // getters/setters
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public int getQuestionId(){return questionId;}
    public void setQuestionId(int questionId){this.questionId=questionId;}
    public int getOptionNo(){return optionNo;}
    public void setOptionNo(int optionNo){this.optionNo=optionNo;}
    public String getOptionText(){return optionText;}
    public void setOptionText(String optionText){this.optionText = optionText;}
}