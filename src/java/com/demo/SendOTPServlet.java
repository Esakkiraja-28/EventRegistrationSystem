package com.demo;

import java.io.IOException;
import java.sql.*;
import java.util.Properties;
import java.util.Random;

import javax.mail.*;
import javax.mail.internet.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SendOTPServlet")
public class SendOTPServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement(
            "SELECT * FROM students WHERE email=?");

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if(!rs.next()) {

                response.getWriter().println("Email not found.");
                return;

            }

            //----------------------------------------
            // Generate 6-digit OTP
            //----------------------------------------

            int otp =
            100000 + new Random().nextInt(900000);

            HttpSession session =
            request.getSession();
            Long lastOtpSent =
(Long) session.getAttribute("lastOtpSent");

long currentTime =
System.currentTimeMillis();

if(lastOtpSent != null &&
(currentTime - lastOtpSent) < 30000)
{
    response.setContentType("text/html");

    response.getWriter().println(

    "<h2 style='color:red;text-align:center;'>"

    + "Please wait 30 seconds before requesting another OTP."

    + "</h2>"

    + "<center>"

    + "<a href='forgot-password.jsp'>"

    + "Go Back"

    + "</a>"

    + "</center>"

    );

    return;
}
          session.setAttribute("otp", String.valueOf(otp));

session.setAttribute("resetEmail", email);

// Store OTP generation time
session.setAttribute("otpTime", System.currentTimeMillis());

// Store last OTP sent time (30-second cooldown)
session.setAttribute("lastOtpSent", System.currentTimeMillis());

            //----------------------------------------
            // Gmail Settings
            //----------------------------------------

            final String senderEmail =
            "eventregistrationsystem2026@gmail.com";

            final String appPassword =
            "tpvtpfrtaqgfklvm";

            Properties props =
            new Properties();

            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session mailSession =
            Session.getInstance(
            props,
            new Authenticator() {

                protected PasswordAuthentication getPasswordAuthentication() {

                    return new PasswordAuthentication(
                            senderEmail,
                            appPassword);

                }

            });

            Message message =
            new MimeMessage(mailSession);

            message.setFrom(
            new InternetAddress(senderEmail));

            message.setRecipients(
            Message.RecipientType.TO,
            InternetAddress.parse(email));

            message.setSubject(
            "Password Reset OTP");

            message.setText(
            "Your OTP is: " + otp);

           System.out.println("STEP 1 : Before Transport.send()");

Transport.send(message);

System.out.println("STEP 2 : Email Sent Successfully");

            response.sendRedirect(
            "verify-otp.jsp");

        }
        catch(Exception e)
{
    System.out.println("STEP 3 : Exception Occurred");

    e.printStackTrace();

    response.setContentType("text/plain");
    e.printStackTrace(response.getWriter());
}

    }

}