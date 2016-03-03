package com.ifilmo.servlet;  
  
import java.io.IOException;

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.domain.User;
import com.ifilmo.util.GenerateLinkUtils;
  
@SuppressWarnings("serial")  
public class LoginServlet extends HttpServlet {  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
    	
    	response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
    	response.setContentType("application/json");
        String user_name = request.getParameter("user_name");  
        String user_password = request.getParameter("user_password"); 
        String encrypt_password = GenerateLinkUtils.md5(user_password);
        
        //System.out.println(GenerateLinkUtils.md5("user"));
        
        HttpSession session = request.getSession();
        UserDAO userdao = new UserDAOImpl();
        //User user = userdao.login(user_name, encrypt_password);
//        PrintWriter out = response.getWriter();
//        JSONObject jsonObject = new JSONObject();
        //User user = userdao.login(user_name, encrypt_password);
        User user = userdao.login(user_name, encrypt_password);
        
        if(user != null){
        	session.setAttribute("user", user);
        	request.setAttribute("user", user);
        	request.getRequestDispatcher("/UI/userAccount.jsp").forward(request, response);
//        	try {
//				jsonObject.put("user_name", user_name);
//				jsonObject.put("user_password", user_password);
//				out.println(jsonObject);
//			} catch (JSONException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
        }else{
        	request.getRequestDispatcher("/UI/main.jsp").forward(request, response);
        	response.getWriter().write("{ 'success': false, 'message': 'Unknown login' }");
        }  
    }  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        doGet(request, response);  
    } 
} 