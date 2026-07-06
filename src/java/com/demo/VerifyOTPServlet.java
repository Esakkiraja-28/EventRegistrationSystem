package com.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String enteredOTP = request.getParameter("otp");

        String originalOTP =
        (String) session.getAttribute("otp");

        Long otpTime =
        (Long) session.getAttribute("otpTime");

        // Check whether OTP exists
        if(originalOTP == null || otpTime == null)
        {
            response.setContentType("text/html");

            response.getWriter().println(

            "<h2 style='color:red;text-align:center;'>OTP Expired!</h2>"

            + "<center><a href='forgot-password.jsp'>Generate New OTP</a></center>"

            );

            return;
        }

        // OTP expires after 2 minutes
        long currentTime =
        System.currentTimeMillis();

        if(currentTime - otpTime > 120000)
        {
            session.removeAttribute("otp");
            session.removeAttribute("otpTime");
            session.removeAttribute("otpAttempts");

            response.setContentType("text/html");

            response.getWriter().println(

            "<h2 style='color:red;text-align:center;'>"

            + "OTP Expired (2 Minutes)."

            + "</h2>"

            + "<center>"

            + "<a href='forgot-password.jsp'>"

            + "Generate New OTP"

            + "</a>"

            + "</center>"

            );

            return;
        }

        // Correct OTP
        if(originalOTP.equals(enteredOTP))
        {

            // Remove everything related to this OTP
            session.removeAttribute("otp");
            session.removeAttribute("otpTime");
            session.removeAttribute("otpAttempts");

            response.sendRedirect("reset-password.jsp");

        }

        // Wrong OTP
        else
        {

            Integer attempts =
            (Integer)session.getAttribute("otpAttempts");

            if(attempts == null)
            {
                attempts = 0;
            }

            attempts++;

            session.setAttribute(
            "otpAttempts",
            attempts);

            // Maximum 5 attempts
            if(attempts >= 5)
            {

                session.removeAttribute("otp");
                session.removeAttribute("otpTime");
                session.removeAttribute("otpAttempts");

                response.setContentType("text/html");

                response.getWriter().println(

                "<h2 style='color:red;text-align:center;'>"

                + "Too many wrong OTP attempts."

                + "</h2>"

                + "<center>"

                + "<a href='forgot-password.jsp'>"

                + "Generate New OTP"

                + "</a>"

                + "</center>"

                );

                return;

            }

            response.setContentType("text/html");

            response.getWriter().println(

            "<h2 style='color:red;text-align:center;'>"

            + "Invalid OTP"

            + "<br><br>"

            + "Attempt "

            + attempts

            + " of 5"

            + "</h2>"

            + "<center>"

            + "<a href='verify-otp.jsp'>Try Again</a>"

            + "</center>"

            );

        }

    }

}