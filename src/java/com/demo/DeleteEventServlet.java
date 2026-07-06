package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet
{

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
    {

        int id =
        Integer.parseInt(
        request.getParameter("id"));

        try
        {

            Connection con =
            DBConnection.getConnection();

            // Delete registrations related to this event first
            PreparedStatement ps1 =
            con.prepareStatement(
            "DELETE FROM registrations WHERE event_name=(SELECT event_name FROM events WHERE id=?)");

            ps1.setInt(1, id);
            ps1.executeUpdate();

            // Delete the event
            PreparedStatement ps2 =
            con.prepareStatement(
            "DELETE FROM events WHERE id=?");

            ps2.setInt(1, id);

            int result =
            ps2.executeUpdate();

            if(result > 0)
            {

                response.sendRedirect(
                request.getContextPath()
                + "/admin/event-list.jsp");

            }
            else
            {

                response.getWriter().println(
                "Event Delete Failed!");

            }

            ps1.close();
            ps2.close();

        }
        catch(Exception e)
        {

            e.printStackTrace();

            response.getWriter().println(
            "Error : " + e.getMessage());

        }

    }

}