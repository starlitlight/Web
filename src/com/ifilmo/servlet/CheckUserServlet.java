package com.ifilmo.servlet;  
  
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.domain.User;
import com.ifilmo.util.GenerateLinkUtils;

import net.sf.json.JSONObject;
  
@SuppressWarnings("serial")  
public class CheckUserServlet extends HttpServlet {  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
    	
    	response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
    	JSONObject json = new JSONObject();
		PrintWriter pw = response.getWriter();
		
    	String userName = request.getParameter("user_name");  
        String email = request.getParameter("email"); 

        UserDAO userdao = new UserDAOImpl();
        List<User> users = userdao.findUserNameAndEmail(userName, email);
        for(User user: users){
        	 if(user!=null){
             	System.out.println(user);
             	System.out.println("successful");
             	json.put("message", "successful");
             }else{
             	json.put("message", "failed");
             }
        }
       
        pw.print(json.toString());
		pw.close();
    }  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        doGet(request, response);  
    } 
} 