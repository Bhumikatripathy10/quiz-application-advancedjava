package com.example.quiz.dao;

import com.example.quiz.model.Flashcard;
import com.example.quiz.util.DBConnection;
import java.sql.*;
import java.util.*;

public class FlashcardDao {

    public void saveFlashcard(Flashcard f) throws Exception {
        String sql = "INSERT INTO flashcards(className, subject, topic, frontText, backText, frontImagePath, backImagePath) VALUES (?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, f.getClassName());
            ps.setString(2, f.getSubject());
            ps.setString(3, f.getTopic());
            ps.setString(4, f.getFrontText());
            ps.setString(5, f.getBackText());
            ps.setString(6, f.getFrontImagePath());
            ps.setString(7, f.getBackImagePath());
            ps.executeUpdate();
        }
    }

    public List<Flashcard> getAllFlashcards() throws Exception {
        List<Flashcard> list = new ArrayList<>();
        String sql = "SELECT * FROM flashcards ORDER BY created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Flashcard f = new Flashcard();
                f.setId(rs.getInt("id"));
                f.setClassName(rs.getString("className"));
                f.setSubject(rs.getString("subject"));
                f.setTopic(rs.getString("topic"));
                f.setFrontText(rs.getString("frontText"));
                f.setBackText(rs.getString("backText"));
                f.setFrontImagePath(rs.getString("frontImagePath"));
                f.setBackImagePath(rs.getString("backImagePath"));
                list.add(f);
            }
        }
        return list;
    }

    public Flashcard getById(int id) throws Exception {
        String sql = "SELECT * FROM flashcards WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Flashcard f = new Flashcard();
                    f.setId(rs.getInt("id"));
                    f.setClassName(rs.getString("className"));
                    f.setSubject(rs.getString("subject"));
                    f.setTopic(rs.getString("topic"));
                    f.setFrontText(rs.getString("frontText"));
                    f.setBackText(rs.getString("backText"));
                    f.setFrontImagePath(rs.getString("frontImagePath"));
                    f.setBackImagePath(rs.getString("backImagePath"));
                    return f;
                }
            }
        }
        return null;
    }

    public void updateFlashcard(Flashcard f) throws Exception {
        String sql = "UPDATE flashcards SET className=?, subject=?, topic=?, frontText=?, backText=?, frontImagePath=?, backImagePath=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, f.getClassName());
            ps.setString(2, f.getSubject());
            ps.setString(3, f.getTopic());
            ps.setString(4, f.getFrontText());
            ps.setString(5, f.getBackText());
            ps.setString(6, f.getFrontImagePath());
            ps.setString(7, f.getBackImagePath());
            ps.setInt(8, f.getId());
            ps.executeUpdate();
        }
    }

    public void deleteFlashcard(int id) throws Exception {
        String sql = "DELETE FROM flashcards WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
