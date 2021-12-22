<%@ page errorPage="errorPage.jsp" %>
<%@ page import="com.tech.javatechblog.entities.User" %>
<%@ page import="com.tech.javatechblog.DAO.PostDAO" %>
<%@ page import="com.tech.javatechblog.entities.Post" %>
<%@ page import="java.util.ArrayList" %>
<%
    User user = (User) session.getAttribute("current_user");


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

    <title>java tech blog!</title>
</head>
<body>

<%@include file="components/navbar.jsp" %>

<div class="primary py-2 clip-path">
    <header class="container text-light   pb-5">
        <h1>welcome to java tech blog</h1>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sed sint corrupti
            amet repudiandae! In obcaecati rem quos rerum pariatur, cumque id sed.
        </p>

        <p>
            A programming language is a formal language comprising a set of strings that produce various kinds of
            machine code output. Programming languages are one kind of computer language, and are used in computer
            programming to implement algorithms.

            Most programming languages consist of instructions for computers. There are programmable machines that use a
            set of specific instructions, rather than general programming languages. Since the early 1800s, programs
            have been used to direct the behavior of machines such as Jacquard looms, music boxes and player pianos.[1]
            The programs for these machines (such as a player piano's scrolls) did not produce different behavior in
            response to different inputs or conditions.
        </p>

        <%
            if (user == null) {
        %>

        <a href="login.jsp" class="btn btn-outline-light"> <i class="fas fa-sign-in-alt icon"></i> Login</a>
        <a href="register.jsp" class="btn btn-outline-light"> <i class="fas fa-user-circle icon"></i> Signup</a>

        <%
            }
        %>


    </header>
</div>


<main class="container">
    <h1 class=" text-center my-4">All Blog Articles</h1>
    <div class="row gy-4">

        <%
            PostDAO dao = new PostDAO();
            ArrayList<Post> allPost = dao.getAllPost();


            if (allPost.size() > 0) {


                for (Post post : allPost) {

        %>


        <div class="col-md-3">
            <div class="card" style="width: 18rem;">

                <div class="card-body">
                    <h5 class="card-title"><%=post.getPtitle()%>
                    </h5>
                    <p class="card-text"><%=post.getPcontent().substring(0, 155)%>
                    </p>
                    <a href="blog_post.jsp?post_id=<%=post.getPid()%>" class="btn btn-sm btn-primary">Read More</a>
                </div>
            </div>
        </div>

        <%
            }

        } else {


        %>
        <p class="text-center text-danger">all posts will be appeared here, but there are no posts to read right
            now.</p>
        <%
            }
        %>


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

</body>
</html>
 