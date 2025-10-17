package com.example.quiz.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {


   
    private static final String URL = "jdbc:mysql://localhost:3306/quiz_app";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "bhumika2005"; // 


    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}