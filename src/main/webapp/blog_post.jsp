<%@ page import="com.tech.javatechblog.entities.User" %>
<%@ page import="com.tech.javatechblog.DAO.PostDAO" %>
<%@ page import="com.tech.javatechblog.entities.Post" %>
<%@ page import="java.io.File" %>
<%@ page import="com.tech.javatechblog.DAO.UserDao" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="com.tech.javatechblog.DAO.LikeDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="errorPage.jsp" %>
<%
    User user = (User) session.getAttribute("current_user");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }

%>


<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDAO dao = new PostDAO();
    Post post = dao.getAllPostById(postId);


%>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <link rel="stylesheet" href="assets/css/style.css">

    <title>javatechblog|<%=post.getPtitle() %>
    </title>
</head>
<body>

<%@include file="/components/navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="card mt-5">
                <div class="card-header">
                    <h4><%=post.getPtitle() %>  </h4>
                </div>
<%--          <img src="<%=application.getRealPath("/")+"post_blog"+File.separator+post.getImage() %>" class="card-img-top" alt="...">--%>
          <img src="post_blog/<%=post.getImage() %>" class="card-img-top" alt="...">

                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <%
                            UserDao userDao=new UserDao();
                        %>
                        <div style="display: inline-block;">  <strong><%=userDao.getUserByPostId(post.getAuthorId()).getName()  %> </strong> <p class="text-muted">has posted:</p> </div>
                        <p class="text-muted"><%= DateFormat.getDateTimeInstance().format(post.getPcreated() ) %>
                        </p>
                    </div>


                    <p class="card-text"><%=post.getPcontent() %> </p>
                    <code class="card-text"><%=post.getPcode() %> </code>
                    <br/>

                    <%
                        if (!post.getPlink().equals("")) {
                    %>
                    <a target="_blank" href="<%=post.getPlink() %>"> link to reference </a>
                    <%
                        }
                    %>

                </div>

                <div class="p-2">
                    <a href="javascript:void" onclick="likeButton(<%=post.getPid()%>,<%=user.getId()%>)"  class="btn btn-outline-primary btn-sm">
                        <%
                            LikeDAO likeDAO=new LikeDAO();
                            int countLike=    likeDAO.likeCountOnPost(post.getPid());;
                        %>
                        <i class="fa fa-thumbs-o-up"></i><span class="like_counter"><%=countLike%></span> </a>
                    <a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>245</span></a>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="assets/js/app.js"></script>
<script src="https://kit.fontawesome.com/2c0e6d07b0.js" crossorigin="anonymous"></script>
<script src="assets/js/likeScript.js"></script>
</body>
</html>