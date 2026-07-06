package com.demo;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("studentEmail") == null)
        {
            response.sendRedirect("index.jsp");
            return;
        }

        String email =
        (String) session.getAttribute("studentEmail");

        int totalEvents = 0;
        int myRegistrations = 0;

        ArrayList<String[]> upcomingEvents =
        new ArrayList<>();

        try
        {
            Connection con =
            DBConnection.getConnection();

            //----------------------------------
            // Load Latest Student Photo
            //----------------------------------

            PreparedStatement photoPs =
            con.prepareStatement(
            "SELECT photo FROM students WHERE email=?");

            photoPs.setString(1, email);

            ResultSet photoRs =
            photoPs.executeQuery();

            if(photoRs.next())
            {
                session.setAttribute(
                "studentPhoto",
                photoRs.getString("photo"));
            }

            //----------------------------------
            // Total Events
            //----------------------------------

            PreparedStatement ps1 =
            con.prepareStatement(
            "SELECT COUNT(*) FROM events");

            ResultSet rs1 =
            ps1.executeQuery();

            if(rs1.next())
            {
                totalEvents = rs1.getInt(1);
            }

            //----------------------------------
            // My Registrations
            //----------------------------------

            PreparedStatement ps2 =
            con.prepareStatement(
            "SELECT COUNT(*) FROM registrations WHERE student_email=?");

            ps2.setString(1, email);

            ResultSet rs2 =
            ps2.executeQuery();

            if(rs2.next())
            {
                myRegistrations =
                rs2.getInt(1);
            }

            //----------------------------------
            // Upcoming Events
            //----------------------------------

            PreparedStatement ps3 =
            con.prepareStatement(
            "SELECT event_name,event_date,venue FROM events ORDER BY event_date ASC LIMIT 5");

            ResultSet rs3 =
            ps3.executeQuery();

            SimpleDateFormat sdf =
            new SimpleDateFormat("dd-MM-yyyy");

            while(rs3.next())
            {
                String data[] =
                {
                    rs3.getString("event_name"),
                    sdf.format(rs3.getDate("event_date")),
                    rs3.getString("venue")
                };

                upcomingEvents.add(data);
            }

            //----------------------------------
            // Close Resources
            //----------------------------------

            photoRs.close();
            photoPs.close();

            rs1.close();
            ps1.close();

            rs2.close();
            ps2.close();

            rs3.close();
            ps3.close();

            //----------------------------------
            // Send Data to JSP
            //----------------------------------

            request.setAttribute(
            "totalEvents",
            totalEvents);

            request.setAttribute(
            "myRegistrations",
            myRegistrations);

            request.setAttribute(
            "upcomingEvents",
            upcomingEvents);

            request.getRequestDispatcher(
            "student/dashboard.jsp")
            .forward(request, response);

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
}