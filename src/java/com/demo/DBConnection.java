package com.demo;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection
{
    private static Connection con;

    public static Connection getConnection()
    {
        try
        {
            if(con == null || con.isClosed())
            {
                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection(
                    "jdbc:mysql://acela.proxy.rlwy.net:37405/railway?useSSL=true&serverTimezone=UTC",
                    "root",
                    "JAefZTSpPJncBAfhRaMfUNUIzTtqHzwy"
                );

                System.out.println("Database Connected Successfully!");
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        return con;
    }
}