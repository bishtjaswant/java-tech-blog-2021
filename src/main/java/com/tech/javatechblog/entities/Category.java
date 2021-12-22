package com.tech.javatechblog.entities;

import lombok.Data;
import java.sql.Timestamp;
@Data
public class Category {
    private int id;
    private String name;
    private String description;
    private Timestamp added;

    public Category() {
    }

    public Category(int id, String name, String description, Timestamp added) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.added = added;
    }

    public Category(String name, String description, Timestamp added) {
        this.name = name;
        this.description = description;
        this.added = added;
    }
}
