package com.demo;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet
{
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
    {

        HttpSession session =
        request.getSession(false);

        int totalStudents = 0;
        int totalEvents = 0;
        int totalRegistrations = 0;

        ArrayList<String[]> latestStudents =
        new ArrayList<>();

        ArrayList<String[]> latestEvents =
        new ArrayList<>();

        try
        {

            Connection con =
            DBConnection.getConnection();

            //---------------------------------
            // Total Students
            //---------------------------------

            PreparedStatement ps1 =
            con.prepareStatement(
            "SELECT COUNT(*) FROM students");

            ResultSet rs1 =
            ps1.executeQuery();

            if(rs1.next())
            {
                totalStudents =
                rs1.getInt(1);
            }

            //---------------------------------
            // Total Events
            //---------------------------------

            PreparedStatement ps2 =
            con.prepareStatement(
            "SELECT COUNT(*) FROM events");

            ResultSet rs2 =
            ps2.executeQuery();

            if(rs2.next())
            {
                totalEvents =
                rs2.getInt(1);
            }

            //---------------------------------
            // Total Registrations
            //---------------------------------

            PreparedStatement ps3 =
            con.prepareStatement(
            "SELECT COUNT(*) FROM registrations");

            ResultSet rs3 =
            ps3.executeQuery();

            if(rs3.next())
            {
                totalRegistrations =
                rs3.getInt(1);
            }

            //---------------------------------
            // Latest Students
            //---------------------------------

            PreparedStatement ps4 =
            con.prepareStatement(
            "SELECT name,email FROM students ORDER BY id DESC LIMIT 5");

            ResultSet rs4 =
            ps4.executeQuery();

            while(rs4.next())
            {

                latestStudents.add(
                new String[]
                {
                    rs4.getString("name"),
                    rs4.getString("email")
                });

            }

            //---------------------------------
            // Latest Events
            //---------------------------------

            PreparedStatement ps5 =
            con.prepareStatement(
            "SELECT event_name,event_date FROM events ORDER BY id DESC LIMIT 5");

            ResultSet rs5 =
            ps5.executeQuery();

            SimpleDateFormat sdf =
            new SimpleDateFormat("dd-MM-yyyy");

            while(rs5.next())
            {

                java.sql.Date eventDate =
                rs5.getDate("event_date");

                String formattedDate =
                sdf.format(eventDate);

                latestEvents.add(
                new String[]
                {
                    rs5.getString("event_name"),
                    formattedDate
                });

            }

            //---------------------------------
            // Send Data to JSP
            //---------------------------------

            request.setAttribute(
            "totalStudents",
            totalStudents);

            request.setAttribute(
            "totalEvents",
            totalEvents);

            request.setAttribute(
            "totalRegistrations",
            totalRegistrations);

            request.setAttribute(
            "latestStudents",
            latestStudents);

            request.setAttribute(
            "latestEvents",
            latestEvents);

            request.getRequestDispatcher(
            "admin/dashboard.jsp")
            .forward(request,response);

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

    }

}