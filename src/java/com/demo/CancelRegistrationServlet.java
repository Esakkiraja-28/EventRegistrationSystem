package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CancelRegistrationServlet")
public class CancelRegistrationServlet extends HttpServlet
{

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
    {

        HttpSession session =
        request.getSession();

        String studentName =
        (String)session.getAttribute("studentName");

        String studentEmail =
        (String)session.getAttribute("studentEmail");

        int id =
        Integer.parseInt(
        request.getParameter("id"));

        try
        {

            Connection con =
            DBConnection.getConnection();

            //---------------------------------
            // Get Event Details
            //---------------------------------

            PreparedStatement ps1 =
            con.prepareStatement(

            "SELECT e.event_name,e.event_date,e.venue " +

            "FROM registrations r " +

            "JOIN events e ON r.event_name=e.event_name " +

            "WHERE r.id=?"

            );

            ps1.setInt(1,id);

            ResultSet rs =
            ps1.executeQuery();

            String eventName="";
            String eventDate="";
            String venue="";

            if(rs.next())
            {

                eventName =
                rs.getString("event_name");

                eventDate =
                rs.getString("event_date");

                venue =
                rs.getString("venue");

            }

            //---------------------------------
            // Delete Registration
            //---------------------------------

            PreparedStatement ps2 =
            con.prepareStatement(

            "DELETE FROM registrations WHERE id=?"

            );

            ps2.setInt(1,id);

            int result =
            ps2.executeUpdate();

            if(result>0)
            {

                //---------------------------------
                // Send Email
                //---------------------------------

               
                final String senderEmail =
"eventregistrationsystem2026@gmail.com";

final String smtpLogin =
"b11e0b001@smtp-brevo.com";

final String smtpPassword =
"IAKTfmWkvxdq7XgM";

                Properties props =
                new Properties();

                props.put("mail.smtp.auth","true");
                props.put("mail.smtp.starttls.enable","true");
                props.put("mail.smtp.host","smtp-relay.brevo.com");
                props.put("mail.smtp.port","587");

                Session mailSession =
                Session.getInstance(
                props,
                new Authenticator()
                {

                    protected PasswordAuthentication
                    getPasswordAuthentication()
                    {

                       return new PasswordAuthentication(
smtpLogin,
smtpPassword);

                    }

                });

                Message message =
                new MimeMessage(mailSession);

                message.setFrom(
                new InternetAddress(senderEmail));

                message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(studentEmail));

                message.setSubject(
                "Event Registration Cancelled");

                String body =

                "Hello "+studentName+",\n\n"

                +"Your registration has been cancelled successfully.\n\n"

                +"Event : "+eventName+"\n"

                +"Venue : "+venue+"\n"

                +"Date : "+eventDate+"\n\n"

                +"We hope to see you in another event.\n\n"

                +"Regards,\n"

                +"Event Registration Management System";

                message.setText(body);

                Transport.send(message);

                session.setAttribute(
                "message",
                "✅ Registration Cancelled Successfully!");

            }
            else
            {

                session.setAttribute(
                "message",
                "❌ Cancellation Failed!");

            }

            response.sendRedirect(
            request.getContextPath()+"/student/myregistrations.jsp");

        }
        catch(Exception e)
        {

            e.printStackTrace();

            session.setAttribute(
            "message",
            "❌ "+e.getMessage());

            response.sendRedirect(
            request.getContextPath()+"/student/myregistrations.jsp");

        }

    }

}