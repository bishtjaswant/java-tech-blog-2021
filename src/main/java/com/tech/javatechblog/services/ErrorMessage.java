package com.tech.javatechblog.services;

import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Data;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Data
public class ErrorMessage {
    private       Map<String,String> response;
    private  String content;
    private  String type;

    public ErrorMessage() {
    }

    public ErrorMessage(String content, String type) {
        this.content = content;
        this.type = type;
    }

    public ErrorMessage(Map<String, String> message) {

        response = message;
    }

}
