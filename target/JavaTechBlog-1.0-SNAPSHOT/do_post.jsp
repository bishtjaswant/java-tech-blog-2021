<%@ page import="com.tech.javatechblog.entities.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tech.javatechblog.entities.Category" %>
<%@ page import="com.tech.javatechblog.DAO.PostDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="errorPage.jsp" %>

<% User user= (User)
session.getAttribute("current_user"); if (user ==null){
response.sendRedirect("login.jsp"); } %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
      crossorigin="anonymous"
    />

    <link rel="stylesheet" href="assets/css/style.css" />

    <title>javatechblog|create new post</title>
  </head>
  <body>
    <%@include file="/components/navbar.jsp"%>

    <div class="container">
      <div class="card mt-1 p-2">
        <h1 class="display-4">
          Create new post
          <span style="font-size: 0.8rem" class="badge bg-primary">
            JavaTechBlog</span
          >
        </h1>

        <form id="AddPostForm" action="AddNewPostServlet" enctype="multipart/form-data" method="post">
          <div class="row mb-2">
            <div class="col-md-6">
              <input
                type="text"
                class="form-control"
                placeholder="Enter new title"
                name="title"
                required
              />
            </div>
            <div class="col-md-6">
              <input
                type="text"
                data-bs-toggle="tooltip"
                title="you are logged as <%=current_user.getName()%>! you can not change it."
                value="<%=current_user.getName()%>"
                readonly
                class="form-control"
                placeholder="AUTHOR"
              />
              
            </div>
          </div>
          <div class="row mb-2">
            <div class="col-md-12">
              <textarea
                name="content"
                placeholder="Post descriiption"
                class="form-control"
                cols="30"
                rows="5"
                id="content"
                required
              ></textarea>
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-12">
              <textarea
                name="code"
                placeholder="any programming related snippets (optional)"
                class="form-control"
                cols="30"
                rows="1"
              ></textarea>
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-12">
              <input
                type="url"
                name="link"
                placeholder="any URL (optional)"
                class="form-control"
              />
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-12">
              <select class="form-select" name="cats" aria-label="Default select example">
                <option selected>Choose category</option>
                <%
                  PostDAO dao=new PostDAO();
                  ArrayList<Category> categories= dao.getCategories();
                  System.out.println(categories);
                  for (Category c: categories     ) {
                    %>
                        <option value="<%=c.getId()%>"> <%=c.getName()%> </option>
                <%
                  }
                %>

              </select>
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-12">
              <label for="formFileSm" class="form-label"
                >Choose post's image</label
              >
              <input
                class="form-control form-control-sm"
                id="formFileSm"
                type="file"
                name="image"
              />
            </div>
          </div>

          <div class="row">
            <div class="col-md-4">
              <button type="submit" class="btn btn-outline-primary">
                Submit
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>

    <script
      src="https://kit.fontawesome.com/2c0e6d07b0.js"
      crossorigin="anonymous"
    ></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.2.1/dist/sweetalert2.all.min.js"></script>




    <script>

       $("#AddPostForm").submit(function (e) { 
           e.preventDefault();
           let formData=new FormData(this);
 
           $.ajax({
               url: $(this).attr("action"),
               type: "POST",
               data:formData,            
               success: function (response) {
                 console.log(response) ;

                 if (response.trim()==='done') {
                   
                  Swal.fire({
                            position: 'top-end',
                            icon: 'success',
                            title: `post added`,
                            showConfirmButton: false,
                            timer: 1500
                        });;
                        
                 } 

                 $('#AddPostForm').trigger("reset");

               },
               error:function(error){
                       console.error(error)
               },
               cache:false,
               processData:false,
               contentType:false
           });
           
       });

    </script>


  </body>
</html>
