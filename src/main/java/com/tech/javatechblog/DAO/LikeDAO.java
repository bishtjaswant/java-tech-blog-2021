package com.tech.javatechblog.DAO;

import com.tech.javatechblog.helpers.ConnectionProvider;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDAO {
    private Connection conn = null;

    public LikeDAO() {
        this.conn = ConnectionProvider.getConnection();
        ;
    }

    public boolean likeAdd(int postId, int userId) {
        boolean isLike = false;
        try {
           if (this.isLikedByUser(postId,userId)){
               String sql = "DELETE FROM `javatechblog`.`likes` WHERE `post_id` = ? AND user_id=?";
               PreparedStatement pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, postId);
               pstmt.setInt(2, userId);
               int rset = pstmt.executeUpdate();
               isLike=true;
           }else {
               String sql = "INSERT INTO `javatechblog`.`likes` (`post_id`, `user_id`) VALUES  (?,?)";
               PreparedStatement pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, postId);
               pstmt.setInt(2, userId);
               int rset = pstmt.executeUpdate();
               isLike = true;
           }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isLike;
    }


    public int likeCountOnPost(int postId) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS likeCount FROM likes WHERE post_id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                count = resultSet.getInt("likeCount");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean isLikedByUser(int postId, int userId) {
        boolean isLiked = false;
        try {
            String sql = "SELECT COUNT(like_id) as likedAlreadyCount FROM likes WHERE post_id=? AND user_id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            pstmt.setInt(2, userId);
            ResultSet resultSet = pstmt.executeQuery();
             
            int count = resultSet.getInt("likedAlreadyCount");
            isLiked = (count > 0) ? true : false;


        } catch (Exception e) {
            e.printStackTrace();
        }
        return isLiked;
    }


}
