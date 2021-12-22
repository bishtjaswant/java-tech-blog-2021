package com.tech.javatechblog.servlets;

import com.google.gson.Gson;
import com.tech.javatechblog.DAO.PostDAO;
import com.tech.javatechblog.entities.Post;
import com.tech.javatechblog.entities.User;
import com.tech.javatechblog.helpers.Helper;
import com.tech.javatechblog.services.ErrorMessage;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;


@WebServlet(name = "AddNewPostServlet", value = "/AddNewPostServlet")
@MultipartConfig
public class AddNewPostServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)  {
        try {
            PrintWriter out=resp.getWriter();
           String title= req.getParameter("title");
           String content= req.getParameter("content");
           String code= req.getParameter("code");
           String link= req.getParameter("link");
           int cats=Integer.parseInt(req.getParameter("cats"));
            Part part= req.getPart("image");

            HttpSession session= req.getSession();
            User user=(User) session.getAttribute("current_user");

            Post post=new Post(0, title, content, link,code,user.getName(), user.getId(),part.getSubmittedFileName(), cats);
            PostDAO dao=new PostDAO();

            if ( dao.addNewPost(post) ){

//                C:\Users\jaswa\IdeaProjects\JavaTechBlog\target\JavaTechBlog-1.0-SNAPSHOT\post_blog\youtube .Sheri sk (1).jpg
            String path= getServletContext().getRealPath("/")+"post_blog"+File.separator+part.getSubmittedFileName();
//               Helper.saveFile(part.getInputStream(),path);
                System.out.println("path"+path);
                System.out.println("save file "+Helper.saveFile(part.getInputStream(),path));
                out.println("done");

            }else {
                out.println("failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
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
