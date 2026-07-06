package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
        request.getSession();

        String email =
        (String)session.getAttribute("resetEmail");

        String newPassword =
        request.getParameter("newPassword");

        String confirmPassword =
        request.getParameter("confirmPassword");

        if(email == null)
        {
            response.getWriter().println(
            "<h2>Session Expired. Please try again.</h2>");
            return;
        }

        if(!newPassword.equals(confirmPassword))
        {
            response.getWriter().println(
            "<h2 style='color:red;'>Passwords do not match.</h2>"
            + "<br><center><a href='reset-password.jsp'>Try Again</a></center>");
            return;
        }

        try
        {
            Connection con =
            DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement(
            "UPDATE students SET password=? WHERE email=?");

            ps.setString(1,newPassword);
            ps.setString(2,email);

            int rows =
            ps.executeUpdate();

            if(rows > 0)
            {
                session.removeAttribute("otp");
                session.removeAttribute("resetEmail");

                response.getWriter().println(

                "<html>"
              + "<head>"
              + "<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet'>"
              + "</head>"

              + "<body class='bg-light'>"

              + "<div class='container mt-5'>"

              + "<div class='alert alert-success text-center shadow'>"

              + "<h2>Password Reset Successful!</h2>"

              + "<p>You can now login using your new password.</p>"

              + "<a href='index.jsp' class='btn btn-success'>Go To Login</a>"

              + "</div>"

              + "</div>"

              + "</body>"

              + "</html>"

                );
            }
            else
            {
                response.getWriter().println(
                "<h2>Unable to reset password.</h2>");
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();

            response.getWriter().println(e.getMessage());
        }

    }

}