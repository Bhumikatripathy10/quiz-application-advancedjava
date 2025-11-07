package com.example.quiz.model;

public class Result {
    private int id;
    private int userId;
    private int quizId;
    private int correctCount;
    private int wrongCount;
    private int totalQuestions;
    private int score;
    private int timeTakenSeconds;

    // getters/setters
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public int getUserId(){return userId;}
    public void setUserId(int userId){this.userId=userId;}
    public int getQuizId(){return quizId;}
    public void setQuizId(int quizId){this.quizId=quizId;}
    public int getCorrectCount(){return correctCount;}
    public void setCorrectCount(int correctCount){this.correctCount=correctCount;}
    public int getWrongCount(){return wrongCount;}
    public void setWrongCount(int wrongCount){this.wrongCount=wrongCount;}
    public int getTotalQuestions(){return totalQuestions;}
    public void setTotalQuestions(int totalQuestions){this.totalQuestions=totalQuestions;}
    public int getScore(){return score;}
    public void setScore(int score){this.score=score;}
    public int getTimeTakenSeconds(){return timeTakenSeconds;}
    public void setTimeTakenSeconds(int timeTakenSeconds){this.timeTakenSeconds=timeTakenSeconds;}
}


//
//package com.example.quiz.model;
//
//public class Result {
//    private int id;
//    private int userId;
//    private int quizId;
//    private int score;
//    private int totalQuestions;
//    private int correctAnswers;
//    private int wrongAnswers;
//    private String studentName;
//
//    // ✅ Getters and Setters
//    public int getId() {
//        return id;
//    }
//    public void setId(int id) {
//        this.id = id;
//    }
//
//    public int getUserId() {
//        return userId;
//    }
//    public void setUserId(int userId) {
//        this.userId = userId;
//    }
//
//    public int getQuizId() {
//        return quizId;
//    }
//    public void setQuizId(int quizId) {
//        this.quizId = quizId;
//    }
//
//    public int getScore() {
//        return score;
//    }
//    public void setScore(int score) {
//        this.score = score;
//    }
//
//    public int getTotalQuestions() {
//        return totalQuestions;
//    }
//    public void setTotalQuestions(int totalQuestions) {
//        this.totalQuestions = totalQuestions;
//    }
//
//    public int getCorrectAnswers() {
//        return correctAnswers;
//    }
//    public void setCorrectAnswers(int correctAnswers) {
//        this.correctAnswers = correctAnswers;
//    }
//
//    public int getWrongAnswers() {
//        return wrongAnswers;
//    }
//    public void setWrongAnswers(int wrongAnswers) {
//        this.wrongAnswers = wrongAnswers;
//    }
//
//    public String getStudentName() {
//        return studentName;
//    }
//    public void setStudentName(String studentName) {
//        this.studentName = studentName;
//    }
//}