package com.ifilmo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.domain.User;

public class UpdateRoleByUserIdServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		int user_id = Integer.parseInt(request.getParameter("user_id"));
		int role = Integer.parseInt(request.getParameter("role"));	

		UserDAO userdao = new UserDAOImpl();		
		String msg = "FAILED";
		if(userdao.UpdateRoleByUserId(role, user_id)){
            request.getRequestDispatcher("/FindAllUserServlet").forward(request, response);
        }else{
            request.setAttribute("message", "ÐÞ¸ÄÈ¨ÏÞ´íÎó");  
            request.getRequestDispatcher("/UI/main.jsp").forward(request, response);  
        }  

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
