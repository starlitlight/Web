package com.ifilmo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.util.GenerateLinkUtils;

public class PasswordServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String msg="FAILED";
		int user_id = Integer.parseInt(request.getParameter("user_id"));
		String user_password1 = request.getParameter("user_password1");
		String user_password2 = request.getParameter("user_password2");
		System.out.println(user_id);
		if(user_password1 != user_password2 ){
			msg="2次输入的密码不一样";
			System.out.println(msg);
		}
		String new_pass = GenerateLinkUtils.md5(user_password1);
		
		UserDAO userdao = new UserDAOImpl();
		//String returnPath = "/UserAccountServlet?user_id=" + user_id;
		
		if (userdao.UpdatePasswordByUserId(new_pass, user_id)) {
			msg = "SUCCESSFUL";
			//returnPath = "/FindAllCustomerServlet";
			request.getRequestDispatcher("/UI/main.jsp").forward(request, response);
		} else {
			request.setAttribute("msg", "MODEFY THE CUSTOMER INFORMATION " + msg);
			request.getRequestDispatcher("/UI/main.jsp").forward(request, response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
