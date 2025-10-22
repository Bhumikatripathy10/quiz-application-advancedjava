package com.example.quiz.dao;

import com.example.quiz.model.Worksheet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WorksheetDao {
    private Connection conn;

    public WorksheetDao(Connection conn) {
        this.conn = conn;
    }

    // Get all worksheets
    public List<Worksheet> getAllWorksheets() {
        List<Worksheet> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM worksheets";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Worksheet ws = new Worksheet();
                ws.setId(rs.getInt("id"));
                ws.setFileName(rs.getString("file_name"));
                ws.setSubject(rs.getString("subject"));
                ws.setGrade(rs.getString("grade"));
                ws.setFileData(rs.getBytes("file_data"));
                ws.setUploadedBy(rs.getString("uploaded_by")); // NEW
                list.add(ws);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get a worksheet by ID
    public Worksheet getWorksheetById(int id) {
        Worksheet ws = null;
        try {
            String sql = "SELECT * FROM worksheets WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                ws = new Worksheet();
                ws.setId(rs.getInt("id"));
                ws.setFileName(rs.getString("file_name"));
                ws.setSubject(rs.getString("subject"));
                ws.setGrade(rs.getString("grade"));
                ws.setFileData(rs.getBytes("file_data"));
                ws.setUploadedBy(rs.getString("uploaded_by")); // NEW
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ws;
    }

    // Save a new worksheet
    public boolean saveWorksheet(Worksheet ws) {
        try {
            String sql = "INSERT INTO worksheets (file_name, subject, grade, file_data, uploaded_by) VALUES (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, ws.getFileName());
            pst.setString(2, ws.getSubject());
            pst.setString(3, ws.getGrade());
            pst.setBytes(4, ws.getFileData());
            pst.setString(5, ws.getUploadedBy()); // NEW
            int rows = pst.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Optional: Delete a worksheet by ID
 // Optional: Delete a worksheet by ID
    public boolean deleteWorksheet(int id) {
        String sql = "DELETE FROM worksheets WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0; // true if deleted, false if not found
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    }


