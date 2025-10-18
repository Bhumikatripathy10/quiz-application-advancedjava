package com.example.quiz.dao;

import java.sql.*;
import com.example.quiz.model.Worksheet;
import java.time.LocalDate;

public class WorksheetDao {

    public void saveWorksheet(Worksheet worksheet) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/quizapp", "root", "root");

            String sql = "INSERT INTO worksheets (file_name, file_path, uploaded_by, upload_date) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, worksheet.getFileName());
            ps.setString(2, worksheet.getFilePath());
            ps.setString(3, worksheet.getUploadedBy());
            ps.setDate(4, java.sql.Date.valueOf(LocalDate.now()));

            ps.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
