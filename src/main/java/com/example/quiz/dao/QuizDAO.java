package com.example.quiz.dao;

import java.util.*;
import com.example.quiz.model.Question;

public class QuizDAO {
    public static List<Question> getQuestions() {
        List<Question> list = new ArrayList<>();
        list.add(new Question(1, "What is Java?", "Language", "Animal", "Fruit", "Car", "Language"));
        list.add(new Question(2, "Which keyword is used to inherit a class?", "super", "this", "extends", "import", "extends"));
        return list;
    }
}
