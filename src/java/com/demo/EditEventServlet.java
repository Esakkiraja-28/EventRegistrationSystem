package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditEventServlet")
public class EditEventServlet extends HttpServlet
{

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
    {

        int id =
        Integer.parseInt(
        request.getParameter("id"));

        String eventName =
        request.getParameter("eventName");

        String eventDate =
        request.getParameter("eventDate");

        String venue =
        request.getParameter("venue");

        int capacity =
        Integer.parseInt(
        request.getParameter("capacity"));

        String description =
        request.getParameter("description");

        try
        {

            Connection con =
            DBConnection.getConnection();

            String sql =
            "UPDATE events SET event_name=?, event_date=?, venue=?, capacity=?, description=? WHERE id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, eventName);
            ps.setString(2, eventDate);
            ps.setString(3, venue);
            ps.setInt(4, capacity);
            ps.setString(5, description);
            ps.setInt(6, id);

            int result =
            ps.executeUpdate();

            if(result > 0)
            {

                response.sendRedirect(
                request.getContextPath()
                + "/admin/event-list.jsp");

            }
            else
            {

                response.getWriter().println(
                "Event Update Failed!");

            }

            ps.close();

        }
        catch(Exception e)
        {

            e.printStackTrace();

            response.getWriter().println(
            "Error : " + e.getMessage());

        }

    }

}