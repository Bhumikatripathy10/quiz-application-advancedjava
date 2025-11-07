package com.example.quiz.dao;

import java.sql.*;
import com.example.quiz.model.AdminUser;
import com.example.quiz.util.DBConnection;

public class AdminUserDao {

    public boolean registerUser(AdminUser user) {
        boolean result = false;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users(username, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName()); // maps to username column
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public AdminUser loginUser(String email, String password) {
        AdminUser user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new AdminUser();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("username")); // maps to username
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean isEmailExist(String email) {
        boolean exists = false;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            exists = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    public boolean updatePassword(String email, String newPassword) {
        boolean result = false;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET password=? WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}