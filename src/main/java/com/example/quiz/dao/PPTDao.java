package com.example.quiz.dao;

import com.example.quiz.model.PPT;
import com.example.quiz.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PPTDao {
    private Connection conn;

    public PPTDao(Connection conn) {
        this.conn = conn;
    }

    // Insert PPT
    public boolean uploadPPT(PPT ppt) {
        String sql = "INSERT INTO uploaded_ppt (title, class, subject, file_name, file_data) VALUES (?,?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ppt.getTitle());
            ps.setString(2, ppt.getClassName());
            ps.setString(3, ppt.getSubject());
            ps.setString(4, ppt.getFileName());
            ps.setBytes(5, ppt.getFileData());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all uploaded PPTs
    public List<PPT> getAllPPTs() {
        List<PPT> list = new ArrayList<>();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM uploaded_ppt ORDER BY created_at DESC");
            while (rs.next()) {
                PPT ppt = new PPT();
                ppt.setId(rs.getInt("id"));
                ppt.setTitle(rs.getString("title"));
                ppt.setClassName(rs.getString("class"));
                ppt.setSubject(rs.getString("subject"));
                ppt.setFileName(rs.getString("file_name"));
                ppt.setFileData(rs.getBytes("file_data"));
                list.add(ppt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
 // Delete PPT by ID
    public boolean deletePPT(int id) {
        String sql = "DELETE FROM uploaded_ppt WHERE id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}