package com.example.quiz.dao;

import java.sql.*;
import com.example.quiz.model.Student;
import com.example.quiz.util.DBConnection; // your existing DB util

public class StudentDao {

    // Save student info to DB
    public boolean saveStudent(Student student) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO students (name, age) VALUES (?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, student.getName());
            ps.setInt(2, student.getAge());

            int rows = ps.executeUpdate();
            if (rows > 0) success = true;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return success;
    }
}