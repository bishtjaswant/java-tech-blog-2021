package com.tech.javatechblog.servlets;

import com.google.gson.Gson;
import com.tech.javatechblog.DAO.UserDao;
import com.tech.javatechblog.entities.User;
import com.tech.javatechblog.services.ErrorMessage;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@MultipartConfig
public class RegistrationServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        PrintWriter out= response.getWriter();
        if ( request.getParameter("terms")   != null ) {
            String name=request.getParameter("name");
            String email=request.getParameter("email");
            String password=request.getParameter("password");
            String gender=request.getParameter("gender");

            User user= new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setGender(gender);
            user.setTerms(true);

            //save into db;;
            UserDao dao= new UserDao();
            boolean saved= dao.saveUser(user);

            if (saved) {
               this.getErrorMessage(response, "inserted", "true"    );

            }

        }
        else {
            this.getErrorMessage(response, "please accept our terms  and conditions ", "false");
        }
    }

    public    void getErrorMessage(HttpServletResponse response, String errorMessage, String errorStatus)  {
        try {
            Map<String , String> message=new HashMap<>();
            message.put("message", errorMessage);
            message.put("status",errorStatus);
            String json = new Gson().toJson(new ErrorMessage(message));
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }


}
