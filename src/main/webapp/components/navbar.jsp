<%@ page import="com.tech.javatechblog.entities.User" %>

<%

    User current_user = (User) session.getAttribute("current_user");
%>

<nav class="navbar navbar-expand-lg navbar-dark primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp"><i class="fas fa-broom icon"></i> JavaTechBlog</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index.jsp"> <i class="fas fa-home icon"></i>
                        Home</a>
                </li>

                <%-- setting--%>
                <%
                    if (current_user != null) {
                %>

                <li class="nav-item">
                    <a class="nav-link"   href="do_post.jsp">Do Post</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"   href="dashboard.jsp">Dashboard</a>
                </li>


                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Settings
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">

                        <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#profileModal" href="#"><i
                                class="fas fa-user-circle"></i> <%= current_user.getName() %>
                        </a></li>
                        <li><a href="logout.jsp" class="dropdown-item"><i class="fas fa-angle-left"></i> Logout</a></li>

                        <li>
                            <hr class="dropdown-divider">
                        </li>

                    </ul>
                </li>

                <%
                    }
                %>


                <!-- Login -->
                <%
                    if (current_user == null) {
                %>
                <li class="nav-item">
                    <a href="login.jsp" class="nav-link"><i class="fas fa-angle-right"></i> Login</a>
                </li>
                <%
                    }
                %>


            </ul>

            <form class="d-flex">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search"/>
                <button class="btn btn-outline-light" type="submit"> Search</button>
            </form>
        </div>
    </div>
</nav>


<%--profile modal open--%>
<%
    if (current_user != null) {

%>
<div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary text-white">
                <h5 class="modal-title" id="exampleModalLabel">Welcome to Java Tech Blog !</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>


            <form action="" method="post" id="formData" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <label for="avatar">
                                    <%
                                        if (current_user.getProfile().equals("default.png")) {
                                    %>
                                    <img src="assets/default/<%=current_user.getProfile() %>" class="img-fluid"
                                         alt="user profile image" id="user_avatar" style="cursor: pointer;"
                                         data-bs-toggle="tooltip" data-bs-placement="top"
                                         title="click to upload new image"/>

                                    <%
                                    } else {

                                    %>
                                    <img src="pics/<%=current_user.getProfile() %>" class="img-fluid"
                                         alt="user profile image" id="user_avatar" style="cursor: pointer;"
                                         data-bs-toggle="tooltip" data-bs-placement="top"
                                         title="click to upload new image"/>

                                    <%

                                        }
                                    %>
                                    <input type="file" id="avatar" accept='image/*' onchange="openFile(this)"
                                           name="avatar" class="d-none">
                                </label>
                            </div>
                            <div class="col">
                                <p class="fw-bold">Name</p>
                                <p class="fw-bold">Email</p>
                                <p class="fw-bold">Gender</p>
                                <p class="fw-bold">About yourself</p>
                                <p class="fw-bold">RegisteredOn</p>
                            </div>


                            <%-- profile_info--%>
                            <div class="col " id="profile_info">
                                <div class="d-flex action justify-content-between"><p><%= current_user.getName() %>
                                </p>
                                </div>
                                <div class="d-flex action justify-content-between">
                                    <p><%= current_user.getEmail() %>
                                    </p>
                                </div>
                                <div class="d-flex action justify-content-between"><p><%= current_user.getGender() %>
                                </p>
                                </div>
                                <div class="d-flex action justify-content-between">
                                    <textarea name="about" placeholder="please update this field" style="height: 63px;"
                                              id="aboutYourself" class="form-control"
                                              readonly><%= current_user.getAboutYourself() %></textarea>
                                </div>


                                <div class="d-flex action justify-content-between">
                                    <p><%= current_user.getRegisteredAt().toLocalDateTime() %>
                                    </p>
                                </div>
                            </div>
                            <%-- profile_info--%


                            <%--  edit_profile_info--%>
                            <div class=" col " style="display: none;" id="edit_profile_info">
                                <div class="d-flex action justify-content-between">
                                    <input type="text" name="newName" id="newName" class="form-control"
                                           value="<%= current_user.getName() %>" placeholder="Your name"/>
                                </div>
                                <div class="d-flex action justify-content-between">
                                    <input type="text" readonly data-bs-toggle="tooltip" data-bs-placement="top"
                                           title="Email can't change" name="newEmail" id="newEmail" class="form-control"
                                           value="<%= current_user.getEmail() %>" placeholder="Email address"/>
                                </div>
                                <div class="d-flex action justify-content-between">
                                    <select class="form-select" id="newGender" name="newGender">
                                        <option value="<%=current_user.getGender()%>"
                                                selected><%=current_user.getGender()%>
                                        </option>
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                        <option value="others">Others</option>
                                    </select>
                                </div>
                                <div class="d-flex action justify-content-between">
                                    <textarea name="newAboutYourself" placeholder="<%=current_user.getAboutYourself()%>"
                                              style="height: 63px;" id="newAboutYourself"
                                              class="form-control"><%=current_user.getAboutYourself()%></textarea>
                                </div>
                                <div class="d-flex action justify-content-between">
                                    <input type="text" name="newDate" disabled class="form-control"
                                           value="<%= current_user.getRegisteredAt().toLocalDateTime() %>"/>
                                </div>
                            </div>

                            <%--         edit_profile_info  --%>

                        </div>
                    </div>

                </div>
                <div class=" container">

                    <p class="text-danger" style="display: none;" id="error">error</p>

                </div>
                <div class="modal-footer">

                    <button type="button" id="cancelBtn" style="display: none;" class="btn btn-outline-danger">Cancel
                    </button>
                    <button type="button" id="editBtn" class="btn btn-outline-info">Edit</button>
                    <button type="button" data-bs-dismiss="modal" class="btn btn-outline-primary">OK Got it</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%
    }
%>

<%--profile modal open--%>