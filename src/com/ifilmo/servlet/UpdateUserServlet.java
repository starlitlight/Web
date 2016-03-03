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

public class UpdateUserServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		int user_id = Integer.parseInt(request.getParameter("user_id"));
		String user_name = request.getParameter("user_name");
		String user_password = request.getParameter("user_password");
		int gender = Integer.parseInt(request.getParameter("gender"));
		String email = request.getParameter("email");
		String photo = request.getParameter("photo");
		
		System.out.println(photo);
		
		
		UserDAO userdao = new UserDAOImpl();
		User user = new User(user_id, user_name, user_password, email, gender, photo);
		
		String msg = "FAILED";
		//String returnPath = "/UserAccountServlet?user_id=" + user_id;
		
		if (userdao.updateUserAccunt(user)) {
			msg = "SUCCESSFUL";
			//returnPath = "/FindAllCustomerServlet";
			request.setAttribute("msg", "MODEFY THE user INFORMATION " + msg);
			request.setAttribute("user_id", user_id);
			request.getRequestDispatcher("/UserAccountServlet").forward(request, response);
		} else {
			request.setAttribute("msg", "MODEFY THE CUSTOMER INFORMATION " + msg);
			request.getRequestDispatcher("/UI/main.jsp").forward(request, response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
