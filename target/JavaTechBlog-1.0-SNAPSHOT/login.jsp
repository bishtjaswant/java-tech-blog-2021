<%@ page errorPage="errorPage.jsp" %>
<%@ page import="com.tech.javatechblog.services.ErrorMessage" %>

<%
    User user= (User) session.getAttribute("current_user");
    if (user != null){
        response.sendRedirect("index.jsp");
    }

%>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <link rel="stylesheet" href="assets/css/style.css">

    <title>javatechblog| login into acccount</title>
</head>
<body>

<%@include file="/components/navbar.jsp"%>

  <div class="container d-flex justify-content-center align-items-center" style="height: 75vh;">
    <div class="card" style="width: 18rem;">
        <i class="fas fa-theater-masks theater icon"></i>

        <div class="card-body">

           <%
             ErrorMessage message=(ErrorMessage)   session.getAttribute("message");
               if (message != null){
                   %>
                    <div class="alert alert-danger" role="alert">
                      <%= message.getContent() %>
                    </div>
            <%

                    session.removeAttribute("message");
               }

           %>


            <form action="LoginServlet" method="post">


                <div class="form-group  mb-2">
                    <input type="email" required name="email" class=" form-control" placeholder="login mail id">
                </div>
                <div class="form-group mb-2">
                    <input type="password" required name="password" class=" form-control" placeholder="****************">
                </div>
           
            <button type="submit" class="btn text-white primary"> <i class="fas fa-sign-in-alt icon"></i>  Login</button>
            <a href="register.jsp" class="link-info text-capitalize d-block">create new account?</a>
         </form>
        </div>
      </div>

  </div>



<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="assets/js/app.js"></script>
<script src="https://kit.fontawesome.com/2c0e6d07b0.js" crossorigin="anonymous"></script>
 
</body>
</html>
 
