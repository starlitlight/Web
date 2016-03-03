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
  
@SuppressWarnings("serial")  
public class LogoutServlet extends HttpServlet {  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  

        	HttpSession session = request.getSession();
        	session.invalidate();
            //response.sendRedirect(request.getContextPath() + "/UI/main.jsp");
            request.getRequestDispatcher("/UI/main.jsp").forward(request, response);  
    }  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        doGet(request, response);  
    }  
  
} 