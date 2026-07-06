package com.demo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UploadPhotoServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5
)
public class UploadPhotoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
        request.getSession();

        String email =
        (String) session.getAttribute("studentEmail");

        try {

            Part part =
            request.getPart("photo");

            String fileName =
            Paths.get(part.getSubmittedFileName())
                 .getFileName()
                 .toString();

            // Project images folder
            String uploadPath =
            getServletContext().getRealPath("/images");

            File folder =
            new File(uploadPath);

            if(!folder.exists())
            {
                folder.mkdirs();
            }

           InputStream input = part.getInputStream();

Files.copy(
    input,
    new File(uploadPath, fileName).toPath(),
    StandardCopyOption.REPLACE_EXISTING
);

input.close();
            Connection con =
            DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement(

            "UPDATE students SET photo=? WHERE email=?"

            );

            ps.setString(1,fileName);
            ps.setString(2,email);

            int result =
            ps.executeUpdate();

            if(result>0)
            {
                session.setAttribute(
                "studentPhoto",
                fileName);

                session.setAttribute(
                "message",
                "✅ Profile Photo Updated Successfully.");
            }
            else
            {
                session.setAttribute(
                "message",
                "❌ Upload Failed.");
            }

            response.sendRedirect(
            request.getContextPath()
            + "/student/profile.jsp");

        }
        catch(Exception e)
        {
            e.printStackTrace();

            session.setAttribute(
            "message",
            "❌ " + e.getMessage());

            response.sendRedirect(
            request.getContextPath()
            + "/student/profile.jsp");
        }

    }

}