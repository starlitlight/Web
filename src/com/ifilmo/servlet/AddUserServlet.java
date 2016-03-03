package com.ifilmo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.domain.User;
import com.ifilmo.util.GenerateLinkUtils;

public class AddUserServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		String user_name = request.getParameter("user_name");
		String user_password = request.getParameter("user_password");
		String email = request.getParameter("email");
		int role = Integer.parseInt(request.getParameter("role"));
		int gender = 0;
		String photo = null;
		String encrypt_password = GenerateLinkUtils.md5(user_password);
		
		UserDAO userdao = new UserDAOImpl();
		User user = new User(user_name, encrypt_password, email, gender, photo, role);
		
		String msg = "FAILED";
		//String returnPath = "/UI/userAccount.jsp";
		if (userdao.insertUser(user)) {
			msg = "SUCCESSFUL";
			//returnPath = "/LoginServlet";
		}
		request.setAttribute("msg", msg);
		//request.getRequestDispatcher("FindAllUserServlet").forward(request, response);
		response.sendRedirect("FindAllUserServlet");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
