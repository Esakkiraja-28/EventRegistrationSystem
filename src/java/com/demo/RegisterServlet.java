package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet
{

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
    {

        String name =
        request.getParameter("name");

        String email =
        request.getParameter("email");

        String department =
        request.getParameter("department");

        String year =
        request.getParameter("year");

        String password =
        request.getParameter("password");

        try
        {

            Connection con =
            DBConnection.getConnection();

           String sql =
"INSERT INTO students(name,email,department,year,password,photo) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, department);
            ps.setString(4, year);
            ps.setString(5, password);
            ps.setString(6,"student1.jpg");
            int result =
            ps.executeUpdate();

            if(result > 0)
            {
               response.sendRedirect(
                request.getContextPath() + "/index.jsp"
                );
            }
            else
            {
                response.getWriter().println(
                "Registration Failed"
                );
            }

            ps.close();

        }
        catch(Exception e)
        {
            e.printStackTrace();

            response.getWriter().println(
            "Error : " + e.getMessage()
            );
        }
    }
}