<%@ page import="com.tech.javatechblog.DAO.PostDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tech.javatechblog.entities.Post" %>
<%@ page import="com.tech.javatechblog.DAO.UserDao" %>
<%@ page import="com.tech.javatechblog.entities.User" %>
<%@ page import="com.tech.javatechblog.DAO.LikeDAO" %>
<%
    User user = (User) session.getAttribute("current_user");
%>

<div class="row mt-2">


    <%
        PostDAO dao = new PostDAO();
        ArrayList<Post> posts = null;
        int cid = Integer.parseInt(request.getParameter("cid"));
        if (cid == 0) {
            posts = dao.getAllPost();
        } else {
            posts = dao.getAllPostByCategory(cid);
        }

        if (posts.size() > 0) {
            for (Post post : posts) {
    %>

    <div class="col-md-6">
        <div class="card">

            <img src="post_blog/<%=post.getImage() %>" class="card-img-top" alt="...">
            <div class="card-body">
                <h5 class="card-title"><%= post.getPtitle() %>
                </h5>

                <p class="card-text"><%= post.getPcontent().substring(0,150) %>
                </p>
                <div class="d-flex justify-content-between">
                    <%
                        UserDao userDao=new UserDao();
                    %>
                    <span class="badge d-block my-2 rounded-pill bg-primary"><%= userDao.getUserByPostId(post.getAuthorId()).getName()   %></span>
                    <span class="badge d-bl my-2 rounded-pill bg-dark"><%=post.getPcreated().toLocalDateTime() %></span>
                </div>
                <div class="card-footer text-center">
                    <a href="blog_post.jsp?post_id=<%=post.getPid()%>" class="btn btn-outline-primary btn-sm">Read
                        more</a>
                    <a href="javascript:void" onclick="likeButton(<%=post.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-primary btn-sm">
                        <%
                            LikeDAO likeDAO=new LikeDAO();
                             int countLike=    likeDAO.likeCountOnPost(post.getPid());;
                        %>
                        <i class="fa fa-thumbs-o-up"></i><span class="like_counter"><%=countLike%></span></a>
                    <a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>245</span></a>

                </div>

            </div>
        </div>
    </div>

    <%
        }
    } else {
    %>
    <p class="text-danger display-4 text-center text-capitalize">there is no posts</p>
    <%
        }
    %>


</div>