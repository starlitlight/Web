package com.ifilmo.dao;


import java.util.List;

import com.ifilmo.domain.First_catalogue;
import com.ifilmo.domain.Picture;
import com.ifilmo.domain.Second_catalogue;
import com.ifilmo.domain.Third_catalogue;

public interface CatalogueDAO {

    public boolean deleteThird_catalogue(String course_name);
    
    public boolean deleteSecond_catalogue(String course_name);
    
    public boolean deleteFirst_catalogue(String course_name);
    
    public List<First_catalogue> findFirst_catalogue();
    
    public List<Second_catalogue> findSecond_catalogueByf_id(int f_id);
    
    public List<Third_catalogue> findThird_catalogueBys_id(int s_id);
    
    public boolean insertFirst_catalogue(String courseName);
    
    public boolean insertSecond_catalogue(String courseName, int f_id);
    
    public boolean insertThird_catalogue(String courseName, String content, int s_id);
    
    public Third_catalogue findContentyById(int t_id);
    
    public Third_catalogue findThird_catalogueByName(String courseName);
    
    public List<Third_catalogue> searchThird_catalogueBykeyword(String keyword);
    
    public boolean insertPictures(Picture picture);
    
    public List<Picture> findPictureByTid(int t_id);

}