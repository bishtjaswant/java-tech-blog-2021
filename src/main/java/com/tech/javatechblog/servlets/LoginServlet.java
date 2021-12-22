package com.tech.javatechblog.servlets;

import com.google.gson.Gson;
import com.tech.javatechblog.DAO.UserDao;
import com.tech.javatechblog.entities.User;
import com.tech.javatechblog.services.ErrorMessage;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)  {
        try {
            PrintWriter out= response.getWriter();
            String email=request.getParameter("email");
            String password=request.getParameter("password");
            UserDao dao= new UserDao();
            User user= dao.getUserByEmailAndPassword(email,password);;

            if (user==null){
                ErrorMessage message= new ErrorMessage("Invalid email or password","error");
                HttpSession session= request.getSession();
                session.setAttribute("message", message);
                response.sendRedirect("login.jsp");
            }
            else {
                  HttpSession session= request.getSession();
                 session.setAttribute("current_user", user);
                 response.sendRedirect("dashboard.jsp");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void getErrorMessage(HttpServletResponse response, String errorMessage, String errorStatus)  {
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
