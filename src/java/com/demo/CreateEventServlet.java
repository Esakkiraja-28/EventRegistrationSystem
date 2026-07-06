package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CreateEventServlet")
public class CreateEventServlet extends HttpServlet
{
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
    {
        String eventName =
        request.getParameter("eventName");

        String eventDate =
        request.getParameter("eventDate");

        String venue =
        request.getParameter("venue");

        String capacity =
        request.getParameter("capacity");

        String description =
        request.getParameter("description");

        try
        {
            Connection con =
            DBConnection.getConnection();

            String sql =
            "INSERT INTO events(event_name,event_date,venue,capacity,description) VALUES(?,?,?,?,?)";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, eventName);
            ps.setString(2, eventDate);
            ps.setString(3, venue);
            ps.setInt(4, Integer.parseInt(capacity));
            ps.setString(5, description);

            int result =
            ps.executeUpdate();

            if(result > 0)
            {
                response.sendRedirect(
                request.getContextPath() +
                "/admin/event-list.jsp"
                );
            }
            else
            {
                response.getWriter().println(
                "Event Creation Failed"
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