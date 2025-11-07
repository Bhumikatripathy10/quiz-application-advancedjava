package com.example.quiz.dao;

import com.example.quiz.model.Result;
import com.example.quiz.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResultDao {
    public void saveResult(Result r) {
        String sql = "INSERT INTO results (user_id, quiz_id, correct_count, wrong_count, total_questions, score, time_taken_seconds) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, r.getUserId());
            ps.setInt(2, r.getQuizId());
            ps.setInt(3, r.getCorrectCount());
            ps.setInt(4, r.getWrongCount());
            ps.setInt(5, r.getTotalQuestions());
            ps.setInt(6, r.getScore());
            ps.setInt(7, r.getTimeTakenSeconds());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) r.setId(keys.getInt(1));
            }
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Result> getTopResults(int limit) {
        List<Result> out = new ArrayList<>();
        String sql = "SELECT * FROM results ORDER BY score DESC, time_taken_seconds ASC LIMIT ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Result r = new Result();
                    r.setId(rs.getInt("id"));
                    r.setUserId(rs.getInt("user_id"));
                    r.setQuizId(rs.getInt("quiz_id"));
                    r.setCorrectCount(rs.getInt("correct_count"));
                    r.setWrongCount(rs.getInt("wrong_count"));
                    r.setTotalQuestions(rs.getInt("total_questions"));
                    r.setScore(rs.getInt("score"));
                    r.setTimeTakenSeconds(rs.getInt("time_taken_seconds"));
                    out.add(r);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return out;
    }
}