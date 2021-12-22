<%@ page errorPage="errorPage.jsp" %>
<%@ page import="com.tech.javatechblog.helpers.ConnectionProvider" %>
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
           <i class="fas fa-biohazard theater"></i>

        <div class="card-body">
            <form id="RegistrationServletForm" action="RegistrationServlet" method="post">
                <div class="form-group  mb-2">
                    <input type="text" required name="name" class=" form-control" placeholder="enter name ">
                </div>
                <div class="form-group  mb-2">
                    <input type="email" required name="email" class=" form-control" placeholder="enter mail id">
                </div>
                <div class="form-group mb-2">
                    <input type="password" required name="password" class=" form-control" placeholder="enter password">
                </div>
                <select class="form-select  mb-2" name="gender">
                    <option selected>choose Gender</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="others">Others</option>
                </select>
                <div class="form-check mb-2">
                    <input class="form-check-input" type="checkbox" name="terms" id="flexCheckChecked" checked>
                    <label class="form-check-label" for="flexCheckChecked">
                     Accept Terms & Conditions
                    </label>
                  </div>
                  <div class=" d-none  " id="refresh">
                    <i class="fa text-center   fa-refresh fa-spin fa-2x"></i>  <br/>
                    <p>please wait </p>
                  </div>
            
                    <button id="registerBtn" type="submit" class="btn text-white primary"> <i class="fas fa-user-circle icon"></i>  Signup</button>
                    <a href="login.jsp" class="link-info text-capitalize d-block">Already've account?</a>
              
           </form>
        </div>
      </div>

  </div>

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="assets/js/app.js"></script>
<script src="https://kit.fontawesome.com/2c0e6d07b0.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.2.1/dist/sweetalert2.all.min.js"></script>
<script>
    $(document).ready(()=>{
         
         $("#RegistrationServletForm").on("submit", function(e) {
             e.preventDefault();
    
             //hide the button
             $("#refresh").removeClass("d-none");
             $("#registerBtn").addClass('d-none');
           
 
             let formData=   new FormData(this);
    
             //ajax
             $.ajax({
                 url:"RegistrationServlet",
                 cache:false,
                 async:true,
                 type:"POST",
                 data:formData,
                 success:function(data, xhr,status){
                     console.log(data);
                     if (data.response.status==='true') {
                                            
                        $('#RegistrationServletForm').trigger("reset");


                        Swal.fire({
                            position: 'top-end',
                            icon: 'success',
                            title: `user registered`,
                            showConfirmButton: false,
                            timer: 1500
                        });;
                        
                        $("#refresh").addClass("d-none");
                        $("#registerBtn").removeClass('d-none');
                        
                     }
                     else if (data.response.status==='false') {
                    
                        Swal.fire({
                            position: 'top-end',
                            title: 'Failed!',
                            text: data.response.message,
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33', 
                        });;
                        $("#refresh").addClass("d-none");
                        $("#registerBtn").removeClass('d-none');
                        
                     }
                 },
                 error:function(xhr,status,err){
                     console.log(err)
                 },
                 contentType:false,
                 processData:false,
             });
             
         });



    });
</script>
</body>
</html>
