package com.example.quiz.util;

import java.sql.Connection;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Connection conn = DBConnection.getConnection();
        ServletContext ctx = sce.getServletContext();
        ctx.setAttribute("DBConnection", conn);
        System.out.println("Database connection initialized.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        Connection conn = (Connection) sce.getServletContext().getAttribute("DBConnection");
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Database connection closed.");
    }
}
