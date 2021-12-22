package com.tech.javatechblog.DAO;

import com.tech.javatechblog.entities.User;
import com.tech.javatechblog.helpers.ConnectionProvider;
import lombok.Data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@Data
public class UserDao {
    private Connection conn;

    public UserDao() {
        this.conn = ConnectionProvider.getConnection();
    }

    public boolean saveUser(User user) {
        boolean isSave = false;

        try {
            String query = "INSERT INTO users (name, email, password, gender, terms) VALUES (?,?,?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getGender());
            stmt.setBoolean(5, user.isTerms());

            int update = stmt.executeUpdate();
            isSave = true;


        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSave;
    }

    public User getUserByEmailAndPassword(String email, String password){
        User user=null;
        try {
            String query="select * from users where email=? and password=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1,email);
            stmt.setString(2,password);
           ResultSet resultSet= stmt.executeQuery();
            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setGender(resultSet.getString("gender"));
                user.setTerms(resultSet.getBoolean("terms"));
                user.setProfile(resultSet.getString("profile"));
                user.setAboutYourself(resultSet.getString("aboutYourself"));
                user.setRegisteredAt(resultSet.getTimestamp("registeredAt"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }


    public User getUserByPostId(int userId){
        User user=null;
        try {
            String query="select * from users where id=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1,userId);
           ResultSet resultSet= stmt.executeQuery();
            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setGender(resultSet.getString("gender"));
                user.setTerms(resultSet.getBoolean("terms"));
                user.setProfile(resultSet.getString("profile"));
                user.setAboutYourself(resultSet.getString("aboutYourself"));
                user.setRegisteredAt(resultSet.getTimestamp("registeredAt"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean updateUserProfile(User user){
        boolean isUpdated=false;
        try {
            String sql="UPDATE users SET name = ?, email= ?, password=? ,gender=?, profile=?,aboutYourself=? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getGender());
            stmt.setString(5, user.getProfile());
            stmt.setString(6, user.getAboutYourself());
            stmt.setInt(7, user.getId());
            stmt.executeUpdate();
            isUpdated=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdated;
    }
}
