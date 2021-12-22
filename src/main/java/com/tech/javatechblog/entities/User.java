package com.tech.javatechblog.entities;

import lombok.Data;

import java.sql.Timestamp;


@Data
public class User {
    private int id;
    private String  name;
    private String  email;
    private String  password;
    private String  gender;
    private boolean terms;
    private String profile;
    private String aboutYourself;
//    private boolean isActive;
    private Timestamp registeredAt;
}
