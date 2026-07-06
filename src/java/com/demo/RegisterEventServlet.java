package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.mail.PasswordAuthentication;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;
@WebServlet("/RegisterEventServlet")
public class RegisterEventServlet extends HttpServlet
{
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
    {

        String eventName =
        request.getParameter("eventName");

        HttpSession session =
        request.getSession();

        String studentEmail =
        (String) session.getAttribute("studentEmail");
        String studentName =
(String) session.getAttribute("studentName");

        try
        {

            Connection con =
            DBConnection.getConnection();

            // Check duplicate registration
            PreparedStatement check =
            con.prepareStatement(
            "SELECT * FROM registrations WHERE student_email=? AND event_name=?");

            check.setString(1, studentEmail);
            check.setString(2, eventName);

            ResultSet rs =
            check.executeQuery();

            if(rs.next())
            {
                session.setAttribute(
                "message",
                "⚠ You have already registered for this event.");

                response.sendRedirect(
                request.getContextPath()+"/student/events.jsp");

                return;
            }
// ----------------------------------------
// Check Event Capacity
// ----------------------------------------

PreparedStatement capacityPS =
con.prepareStatement(
"SELECT capacity FROM events WHERE event_name=?");

capacityPS.setString(1,eventName);

ResultSet capacityRS =
capacityPS.executeQuery();

int capacity = 0;

if(capacityRS.next())
{
    capacity =
    capacityRS.getInt("capacity");
}

// Count registered students

PreparedStatement countPS =
con.prepareStatement(
"SELECT COUNT(*) FROM registrations WHERE event_name=?");

countPS.setString(1,eventName);

ResultSet countRS =
countPS.executeQuery();

int registered = 0;

if(countRS.next())
{
    registered =
    countRS.getInt(1);
}

// Check whether event is full

if(registered >= capacity)
{

    session.setAttribute(

    "message",

    "❌ Registration Closed! Event is Full."

    );

    response.sendRedirect(

    request.getContextPath()+"/student/events.jsp"

    );

    return;

}
            // Register student
            PreparedStatement ps =
            con.prepareStatement(
            "INSERT INTO registrations(student_email,event_name) VALUES(?,?)");

            ps.setString(1, studentEmail);
            ps.setString(2, eventName);

            int result =
            ps.executeUpdate();
            // Get event details

PreparedStatement eventPS =
con.prepareStatement(
"SELECT event_date, venue FROM events WHERE event_name=?");

eventPS.setString(1, eventName);

ResultSet eventRS =
eventPS.executeQuery();

String eventDate = "";
String venue = "";

if(eventRS.next())
{
    eventDate = eventRS.getString("event_date");
    venue = eventRS.getString("venue");
}

            if(result > 0)
{

    // ==============================
    // Send Registration Email
    // ==============================

     final String senderEmail =
"eventregistrationsystem2026@gmail.com";

final String smtpLogin =
"b11e0b001@smtp-brevo.com";

final String smtpPassword =
"IAKTfmWkvxdq7XgM";

    java.util.Properties props =
    new java.util.Properties();

    props.put("mail.smtp.auth","true");
    props.put("mail.smtp.starttls.enable","true");
   props.put("mail.smtp.host","smtp-relay.brevo.com");
    props.put("mail.smtp.port","587");

    javax.mail.Session mailSession =
    javax.mail.Session.getInstance(
    props,
    new javax.mail.Authenticator()
    {
        protected javax.mail.PasswordAuthentication
        getPasswordAuthentication()
        {
          return new javax.mail.PasswordAuthentication(
    smtpLogin,
    smtpPassword
);
        }
    });

    javax.mail.Message message =
    new javax.mail.internet.MimeMessage(mailSession);

    message.setFrom(
    new javax.mail.internet.InternetAddress(senderEmail));

    message.setRecipients(
    javax.mail.Message.RecipientType.TO,
    javax.mail.internet.InternetAddress.parse(studentEmail));

    message.setSubject(
    "Event Registration Successful");

    String body =

    "Hello " + studentName + ",\n\n"

    + "Congratulations!\n\n"

    + "You have successfully registered for:\n\n"

    + "Event : " + eventName + "\n"

    + "Venue : " + venue + "\n"

    + "Date : " + eventDate + "\n\n"

    + "Thank you for registering.\n\n"

    + "Regards,\n"

    + "Event Registration Management System";

    message.setText(body);

    javax.mail.Transport.send(message);

    session.setAttribute(
    "message",
    "✅ Event Registered Successfully!");

}
else
{

    session.setAttribute(
    "message",
    "❌ Registration Failed!");

}
          

            ps.close();
            check.close();

            response.sendRedirect(
            request.getContextPath()+"/student/events.jsp");

        }
        catch(Exception e)
        {
            e.printStackTrace();

            session.setAttribute(
            "message",
            "❌ Error : "+e.getMessage());

            response.sendRedirect(
            request.getContextPath()+"/student/events.jsp");
        }

    }

}