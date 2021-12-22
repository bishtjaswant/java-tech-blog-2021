package com.tech.javatechblog.entities;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class Post {
    private int pid;
    private String ptitle;
    private String pcontent;
    private String plink;
    private String pcode;
    private String author ;
    private int authorId;
    private int pcatid ;
    private String image ;
    private Timestamp pcreated ;

    public Post() {
    }


  public Post(int pid, String ptitle, String pcontent, String plink, String pcode, String image, int authorId, int pcatid, Timestamp pcreated) {
        this.pid = pid;
        this.ptitle = ptitle;
        this.pcontent = pcontent;
        this.plink = plink;
        this.pcode = pcode;
        this.authorId = authorId;
        this.pcatid = pcatid;
        this.image = image;
        this.pcreated = pcreated;
    }


    public Post(int pid, String ptitle, String pcontent, String plink, String pcode, String name, String image, int pcatid, Timestamp pcreated) {
        this.pid = pid;
        this.ptitle = ptitle;
        this.pcontent = pcontent;
        this.plink = plink;
        this.pcode = pcode;
        this.author = name;
        this.pcatid = pcatid;
        this.image = image;
        this.pcreated = pcreated;
    }

    public Post(int pid, String ptitle, String pcontent, String plink, String pcode, String image, int pcat, Timestamp pcreated) {
        this.pid = pid;
        this.ptitle = ptitle;
        this.pcontent = pcontent;
        this.plink = plink;
        this.pcode = pcode;
        this.pcatid = pcatid;
        this.image = image;
        this.pcreated = pcreated;
    }

    public Post(int pid, String ptitle, String pcontent, String plink, String pcode, int author_id, String image, int pcatid, Timestamp pcreated) {
        this.pid = pid;
        this.ptitle = ptitle;
        this.pcontent = pcontent;
        this.plink = plink;
        this.pcode = pcode;
        this.authorId=author_id;
        this.pcatid = pcatid;
        this.image = image;
        this.pcreated = pcreated;
    }

    public Post(int pid, String ptitle, String pcontent, String plink, String pcode, String author,int author_id, String image, int pcatid) {
        this.pid = pid;
        this.ptitle = ptitle;
        this.pcontent = pcontent;
        this.plink = plink;
        this.author=author;
        this.pcode = pcode;
        this.authorId=author_id;
        this.pcatid = pcatid;
        this.image = image;
    }
}
