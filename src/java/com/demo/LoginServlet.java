package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet
{

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
    {

        String email =
        request.getParameter("email");

        String password =
        request.getParameter("password");

        String role =
        request.getParameter("role");

        try
        {

            Connection con =
            DBConnection.getConnection();

            // ===========================
            // ADMIN LOGIN
            // ===========================

            if(role.equals("admin"))
            {

                String sql =
                "SELECT * FROM admins WHERE username=? AND password=?";

                PreparedStatement ps =
                con.prepareStatement(sql);

                ps.setString(1,email);
                ps.setString(2,password);

                ResultSet rs =
                ps.executeQuery();

                if(rs.next())
                {

                    HttpSession session =
                    request.getSession();

                    session.setAttribute(
                    "adminUsername",
                    rs.getString("username"));

                    session.setAttribute(
                    "adminName",
                    rs.getString("name"));

                    session.setAttribute(
                    "adminEmail",
                    rs.getString("email"));

                    session.setAttribute(
                    "adminPhoto",
                    rs.getString("photo"));

                    response.sendRedirect(
                    "AdminDashboardServlet");

                }
                else
                {

                    response.getWriter().println(
                    "Invalid Admin Login");

                }

            }

            // ===========================
            // STUDENT LOGIN
            // ===========================

            else if(role.equals("student"))
            {

                String sql =
                "SELECT * FROM students WHERE email=? AND password=?";

                PreparedStatement ps =
                con.prepareStatement(sql);

                ps.setString(1,email);
                ps.setString(2,password);

                ResultSet rs =
                ps.executeQuery();

                if(rs.next())
                {

                    HttpSession session =
                    request.getSession();

                    session.setAttribute(
                    "studentName",
                    rs.getString("name"));

                    session.setAttribute(
                    "studentEmail",
                    rs.getString("email"));

                    session.setAttribute(
                    "studentDepartment",
                    rs.getString("department"));

                    session.setAttribute(
                    "studentYear",
                    rs.getString("year"));
                    session.setAttribute(
                    "studentPhoto",
                    rs.getString("photo"));
                    response.sendRedirect(
                    "StudentDashboardServlet");

                }
                else
                {

                    response.getWriter().println(
                    "Invalid Student Login");

                }

            }

            else
            {

                response.getWriter().println(
                "Please Select Role");

            }

        }
        catch(Exception e)
        {

            e.printStackTrace();

            response.getWriter().println(
            e.getMessage());

        }

    }

}