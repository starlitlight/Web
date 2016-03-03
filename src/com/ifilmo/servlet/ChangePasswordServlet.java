package com.ifilmo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.util.GenerateLinkUtils;

public class ChangePasswordServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		int user_id = Integer.parseInt(request.getParameter("user_id"));
		String user_password2 = request.getParameter("user_password2");
		String encrypt_password2 = GenerateLinkUtils.md5(user_password2);

		UserDAO userdao = new UserDAOImpl();
		if(userdao.UpdatePasswordByUserId(encrypt_password2, user_id)){
            request.getRequestDispatcher("/UserAccountServlet?user_id").forward(request, response);
        }else{
            request.setAttribute("message", "ÐÞ¸ÄÃÜÂë´íÎó");  
            request.getRequestDispatcher("/UI/main.jsp").forward(request, response);  
        }
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
