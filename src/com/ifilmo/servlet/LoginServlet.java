package com.ifilmo.servlet;  
  
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.domain.User;
import com.ifilmo.util.GenerateLinkUtils;

import net.sf.json.JSONObject;
  
@SuppressWarnings("serial")  
public class LoginServlet extends HttpServlet {  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
    	
    	response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		
    	String user_name = request.getParameter("user_name");  
    	String user_password = request.getParameter("user_password");
    	String encrypt_password = GenerateLinkUtils.md5(user_password);
    	
    	System.out.println("用户名是" + user_name + "密码是" + user_password);
        
        
        
        
        HttpSession session = request.getSession();
        UserDAO userdao = new UserDAOImpl();
        User user = userdao.login(user_name, encrypt_password);
        if(user != null){
        	session.setAttribute("user", user);
        	request.setAttribute("user", user);
        	request.getRequestDispatcher("/UI/userAccount.jsp").forward(request, response);
        }else{
        	request.getRequestDispatcher("/UI/main.jsp").forward(request, response);
        }
       
    }  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        doGet(request, response);  
    } 
} 