package com.tech.javatechblog.servlets;

import com.google.gson.Gson;
import com.tech.javatechblog.DAO.UserDao;
import com.tech.javatechblog.entities.User;
import com.tech.javatechblog.helpers.Helper;
import com.tech.javatechblog.services.ErrorMessage;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@WebServlet(name = "ProfileUpdateServlet", value = "/ProfileUpdateServlet")
@MultipartConfig
public class ProfileUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         PrintWriter out= response.getWriter();

        ServletContext servletContext = getServletContext();
        String contextPath = servletContext.getRealPath("/")+File.separator+"pics"+"jsfg.png";
        out.println("<br/>File system context path (in TestServlet): " + contextPath);

    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) {
        try {
            PrintWriter out = response.getWriter();
            out.println("post rewuest");
            String newName = request.getParameter("newName");
            String newEmail = request.getParameter("newEmail");
            String newGender = request.getParameter("newGender");
            String newAboutYourself = request.getParameter("newAboutYourself");
            Part part = request.getPart("avatar");
            String avatarName = (part.getInputStream().available()==0) ? "default.png" : part.getSubmittedFileName();

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("current_user");
            user.setName(newName);
            user.setEmail(newEmail);
            user.setGender(newGender);
            user.setAboutYourself(newAboutYourself);
            String oldUserProfile=user.getProfile();
            user.setProfile(avatarName);

            UserDao dao = new UserDao();


            if (part.getInputStream().available()<=0) {

                if ( dao.updateUserProfile(user) ){
//                    out.println("user saved with out img");
                  this.getErrorMessage(response, "profile updated", "true");
                }else {
//                    out.println("something went wrong");
                    this.getErrorMessage(response, "something went wrong", "false");

                }
            }else {
                String path = request.getServletContext().getRealPath("/")+"pics"+File.separator+user.getProfile();
                String oldProfilePath = request.getServletContext().getRealPath("/")+"pics"+File.separator+oldUserProfile;
                Helper.deleteFile(oldProfilePath);
                if ( Helper.saveFile(part.getInputStream(), path)){
           //         out.println("updated successfully with image");
                    this.getErrorMessage(response, "updated successfully with image", "true");

                }else {
               //     out.println("something went wrong with img");
                    this.getErrorMessage(response, "something went wrong with img", "false");

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.processRequest(request, response);
    }

    private void getErrorMessage(HttpServletResponse response, String errorMessage, String errorStatus) {
        try {
            Map<String, String> message = new HashMap<>();
            message.put("message", errorMessage);
            message.put("status", errorStatus);
            String json = new Gson().toJson(new ErrorMessage(message));
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
