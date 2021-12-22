package com.tech.javatechblog.entities;


import lombok.Data;

@Data
public class Like {

    private int like_id;
    private int post_id;
    private int user_id;


}
