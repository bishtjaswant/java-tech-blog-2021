package com.tech.javatechblog.helpers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {


    public static boolean deleteFile(String path) {
        boolean isDelete  = false;
        try {
            File file = new File(path);
           isDelete= file.delete();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isDelete;
    }

    public  static boolean saveFile(InputStream inputStream, String path){
        boolean isStored=false;
        try {
           byte[] bytes= new byte[inputStream.available()];
           inputStream.read(bytes);
           FileOutputStream fos=new FileOutputStream(path);
           fos.write(bytes);
           fos.flush();
           fos.close();
           isStored=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isStored;
    }
}
