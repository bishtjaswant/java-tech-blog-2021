package com.tech.javatechblog.servlets;

import com.tech.javatechblog.DAO.LikeDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LikeServlet", value = "/LikeServlet")
public class LikeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)  {
     try{
         PrintWriter out= response.getWriter();
         String operation= request.getParameter("operation");
         int user_id=Integer.parseInt(request.getParameter("user_id"));
         int post_id=Integer.parseInt(request.getParameter("post_id"));
         if (operation.equals("LIKE")){
             LikeDAO likeDAO= new LikeDAO();
              boolean result=   likeDAO.likeAdd(post_id,user_id);
              out.println(result);
         }
     }catch (Exception e){
         e.printStackTrace();
     }

    }
}
