package com.example.quiz.dao;

import com.example.quiz.model.Option;
import com.example.quiz.model.Question;
import com.example.quiz.model.Quiz;
import com.example.quiz.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDao {

    // ✅ Fetch quiz info
    public Quiz getQuizById(int id) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "SELECT id, title, time_limit_seconds FROM quizzes WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Quiz q = new Quiz();
                    q.setId(rs.getInt("id"));
                    q.setTitle(rs.getString("title"));
                    q.setTimeLimitSeconds(rs.getInt("time_limit_seconds"));
                    return q;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Fetch 20 random questions (directly from questions table)
    public List<Question> getRandomQuestionsForQuiz(int quizId) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT id, question_text, option_a, option_b, option_c, option_d, correct_option " +
                     "FROM questions WHERE quiz_id = ? ORDER BY RAND() LIMIT 20";

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, quizId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Question q = new Question();
                    q.setId(rs.getInt("id"));
                    q.setQuizId(quizId);
                    q.setQuestionText(rs.getString("question_text"));

                    // Prepare list of 4 options (A, B, C, D)
                    List<Option> opts = new ArrayList<>();
                    String[] optTexts = {
                        rs.getString("option_a"),
                        rs.getString("option_b"),
                        rs.getString("option_c"),
                        rs.getString("option_d")
                    };

                    for (int i = 0; i < optTexts.length; i++) {
                        Option o = new Option();
                        o.setQuestionId(q.getId());
                        o.setOptionNo(i + 1);
                        o.setOptionText(optTexts[i]);
                        opts.add(o);
                    }

                    // Convert correct option (A/B/C/D → 1/2/3/4)
                    String correctLetter = rs.getString("correct_option");
                    int correctNo = switch (correctLetter.toUpperCase()) {
                        case "A" -> 1;
                        case "B" -> 2;
                        case "C" -> 3;
                        case "D" -> 4;
                        default -> 0;
                    };
                    q.setCorrectOption(correctNo);
                    q.setOptions(opts);

                    list.add(q);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // added sonali new method 
    
    
 // ✅ Fetch all quizzes
    public List<Quiz> getAllQuizzes() {
        List<Quiz> list = new ArrayList<>();
        String sql = "SELECT id, title, time_limit_seconds FROM quizzes";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Quiz q = new Quiz();
                q.setId(rs.getInt("id"));
                q.setTitle(rs.getString("title"));
                q.setTimeLimitSeconds(rs.getInt("time_limit_seconds"));
                list.add(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Fetch all results with user info
    public List<String[]> getAllResults() {
        List<String[]> list = new ArrayList<>();
        String sql = "SELECT u.name AS user_name, q.title AS quiz_title, r.score " +
                     "FROM results r JOIN users u ON r.user_id=u.id " +
                     "JOIN quizzes q ON r.quiz_id=q.id ORDER BY q.title";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new String[]{
                    rs.getString("user_name"),
                    rs.getString("quiz_title"),
                    String.valueOf(rs.getInt("score"))
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    
    
 // Fetch all questions for a specific quiz (for admin)
    public List<Question> getAllQuestionsByQuiz(int quizId) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT id, question_text, option_a, option_b, option_c, option_d, correct_option " +
                     "FROM questions WHERE quiz_id = ? ORDER BY id";

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, quizId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Question q = new Question();
                    q.setId(rs.getInt("id"));
                    q.setQuizId(quizId);
                    q.setQuestionText(rs.getString("question_text"));

                    // Prepare options list
                    List<Option> opts = new ArrayList<>();
                    String[] optTexts = {
                        rs.getString("option_a"),
                        rs.getString("option_b"),
                        rs.getString("option_c"),
                        rs.getString("option_d")
                    };
                    for (int i = 0; i < optTexts.length; i++) {
                        Option o = new Option();
                        o.setQuestionId(q.getId());
                        o.setOptionNo(i + 1);
                        o.setOptionText(optTexts[i]);
                        opts.add(o);
                    }

                    // Correct option conversion (A/B/C/D → 1/2/3/4)
                    String correctLetter = rs.getString("correct_option");
                    int correctNo = switch (correctLetter.toUpperCase()) {
                        case "A" -> 1;
                        case "B" -> 2;
                        case "C" -> 3;
                        case "D" -> 4;
                        default -> 0;
                    };
                    q.setCorrectOption(correctNo);
                    q.setOptions(opts);

                    list.add(q);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    
    // add question
    public void addQuestion(int quizId, String questionText, String optA, String optB, String optC, String optD, String correct) {
        String sql = "INSERT INTO questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            ps.setString(2, questionText);
            ps.setString(3, optA);
            ps.setString(4, optB);
            ps.setString(5, optC);
            ps.setString(6, optD);
            ps.setString(7, correct);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Update question
    public void updateQuestion(int questionId, String questionText, String optA, String optB, String optC, String optD, String correct) {
        String sql = "UPDATE questions SET question_text=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_option=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, questionText);
            ps.setString(2, optA);
            ps.setString(3, optB);
            ps.setString(4, optC);
            ps.setString(5, optD);
            ps.setString(6, correct);
            ps.setInt(7, questionId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Delete question
    public void deleteQuestion(int questionId) {
        String sql = "DELETE FROM questions WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, questionId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

 // ✅ Fetch single question by ID
    public Question getQuestionById(int questionId) {
        Question q = null;
        String sql = "SELECT * FROM questions WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, questionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    q = new Question();
                    q.setId(rs.getInt("id"));
                    q.setQuizId(rs.getInt("quiz_id"));
                    q.setQuestionText(rs.getString("question_text"));

                    List<Option> opts = new ArrayList<>();
                    String[] optTexts = {
                        rs.getString("option_a"),
                        rs.getString("option_b"),
                        rs.getString("option_c"),
                        rs.getString("option_d")
                    };
                    for (int i = 0; i < optTexts.length; i++) {
                        Option o = new Option();
                        o.setQuestionId(q.getId());
                        o.setOptionNo(i + 1);
                        o.setOptionText(optTexts[i]);
                        opts.add(o);
                    }
                    q.setOptions(opts);

                    String correctLetter = rs.getString("correct_option");
                    int correctNo = 0;
                    switch (correctLetter.toUpperCase()) {
                        case "A": correctNo = 1; break;
                        case "B": correctNo = 2; break;
                        case "C": correctNo = 3; break;
                        case "D": correctNo = 4; break;
                    }
                    q.setCorrectOption(correctNo);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return q;
    }

    
    
    
    
    // ended sonali method
    
    
    
       
    
    
    // ✅ Save user answer
    public void saveUserAnswer(int userId, int quizId, int questionId, String selectedOption, String correctOption, boolean isCorrect) {
        String sql = "INSERT INTO user_answers (user_id, quiz_id, question_id, selected_option, correct_option, is_correct) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, quizId);
            ps.setInt(3, questionId);
            ps.setString(4, selectedOption);
            ps.setString(5, correctOption);
            ps.setBoolean(6, isCorrect);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    
    

    // ✅ Save quiz result
    public void saveResult(int userId, int quizId, int score) {
        String sql = "INSERT INTO results (user_id, quiz_id, score) VALUES (?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, quizId);
            ps.setInt(3, score);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}