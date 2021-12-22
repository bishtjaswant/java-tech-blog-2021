package com.tech.javatechblog.DAO;

import com.tech.javatechblog.entities.Category;
import com.tech.javatechblog.entities.Post;
import com.tech.javatechblog.helpers.ConnectionProvider;

import java.sql.*;
import java.util.ArrayList;

public class PostDAO {


    private static Connection conn;

    public PostDAO() {
        conn = ConnectionProvider.getConnection();
    }

    public ArrayList<Category> getCategories() {
        ArrayList<Category> categoryList = new ArrayList<>();

        try {
            String sql = "select * from categories";
            Statement stmt = conn.createStatement();
            stmt.executeQuery(sql);
            ResultSet resultSet = stmt.getResultSet();
            while (resultSet.next()) {
                int cid = resultSet.getInt("cid");
                String cname = resultSet.getString("cname");
                String cdescription = resultSet.getString("cdescription");
                Timestamp cadded = resultSet.getTimestamp("cadded");
                Category category = new Category(cid, cname, cdescription, cadded);
                categoryList.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoryList;
    }


    public boolean addNewPost(Post post) {
        boolean isAdded = false;
        try {
            String query = "INSERT INTO `javatechblog`.`posts` (  `ptitle`,`pcontent`, `pcode`,  `plink`, `pcat`,  `author_id`,`image`) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, post.getPtitle());
            stmt.setString(2, post.getPcontent());
            stmt.setString(3, post.getPcode());
            stmt.setString(4, post.getPlink());
            stmt.setInt(5, post.getPcatid());
            stmt.setInt(6, post.getAuthorId());
            stmt.setString(7, post.getImage());
            stmt.executeUpdate();
            isAdded = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isAdded;
    }

    public ArrayList<Post> getAllPost() {
        ArrayList<Post> posts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM posts AS p ORDER BY p.`pid` DESC";
            Statement stmt = conn.createStatement();
            stmt.executeQuery(sql);
            ResultSet rSet = stmt.getResultSet();
            while (rSet.next()) {
                Post post = new Post(rSet.getInt("pid"), rSet.getString("ptitle"), rSet.getString("pcontent"), rSet.getString("plink"), rSet.getString("pcode"), rSet.getString("image"), rSet.getInt("author_id"), rSet.getInt("pcat"), rSet.getTimestamp("pcreated"));
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return posts;

    }

    public ArrayList<Post> getAllPostByCategory(int catId) {
        ArrayList<Post> posts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM `javatechblog`.`posts` WHERE  `pcat`=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, catId);
            ResultSet rSet = pstmt.executeQuery();
            while (rSet.next()) {
                Post post = new Post(rSet.getInt("pid"), rSet.getString("ptitle"), rSet.getString("pcontent"), rSet.getString("plink"), rSet.getString("pcode"), rSet.getString("image"), rSet.getInt("author_id"), rSet.getInt("pcat"), rSet.getTimestamp("pcreated"));
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return posts;

    }

    public Post getAllPostById(int postId) {
        Post post = null;

        try {
            String sql = "SELECT *  FROM posts AS p WHERE `p`.`pid`=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            ResultSet rSet = pstmt.executeQuery();
            if (rSet.next()) {
                post = new Post(rSet.getInt("pid"), rSet.getString("ptitle"), rSet.getString("pcontent"), rSet.getString("plink"), rSet.getString("pcode"), rSet.getInt("author_id"), rSet.getString("image"), rSet.getInt("pcat"), rSet.getTimestamp("pcreated"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return post;
    }
}
