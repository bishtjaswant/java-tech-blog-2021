package com.tech.javatechblog.helpers;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {

    private static Connection connection = null;

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            final String url = "jdbc:mysql://localhost:3306/javatechblog";
            connection = DriverManager.getConnection(url, "root", "root");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return connection;
    }
}
