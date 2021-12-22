<%@ page import="com.tech.javatechblog.entities.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tech.javatechblog.entities.Post" %>
<%@ page import="com.tech.javatechblog.entities.Category" %>
<%@ page import="com.tech.javatechblog.DAO.PostDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="errorPage.jsp" %>
<%
    User user = (User) session.getAttribute("current_user");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }

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

    <title>javatechblog| login into acccount</title>
</head>
<body>

<%@include file="/components/navbar.jsp" %>


<main>
    <div class="container">
       <div class="row">
        <div class="col-md-4">
            <ul class="list-group mt-1">
                <li class="list-group-item active" aria-current="true">Categories</li>
                <li class="list-group-item" onclick="fetchPost(0)">All Categories</li>
                <%
                    PostDAO dao = new PostDAO();
                    ArrayList<Category> categoryArrayList = dao.getCategories();
                    for (Category category : categoryArrayList) {
                %>
                <li onclick="fetchPost(<%=category.getId() %>)" class="list-group-item"><%=category.getName() %> </li>

                <%
                    }
                %>
            </ul>
        </div>
        <div class="col-md-8" id="post_container">
            <div class="loader mt-2 text-center" id="loader">
                <i class="fa fa-refresh fa-2x fa-spin"></i>
                <h3>Loading........</h3>
            </div>
        </div>
       </div>
    </div>
</main>


<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="assets/js/app.js"></script>
<script src="https://kit.fontawesome.com/2c0e6d07b0.js" crossorigin="anonymous"></script>
<script>

    function fetchPost(cid=0) {
        $.ajax({
             type: "GET",
             url: "./load_post.jsp",
             data:{cid},
             success: function (resp) {
               //  console.log(resp)
                 $('#loader').hide(1500);
                 $("#post_container").html(resp)
             },
             error:function(error){
                 console.error(error)
             }
         });
    }
    $(document).ready(function () {
         fetchPost(0)
    });
</script>

<script src="./assets/js/likeScript.js"> </script>
</body>
</html>
