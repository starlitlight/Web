package com.ifilmo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.domain.User;

public class ResetPasswordServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		String email = request.getParameter("email");
		String s_id = request.getParameter("s_id");
		String msg = "";
		if(s_id.equals("") || email.equals("")){  
	           msg="链接不完整,请重新生成";
	           System.out.println(msg);
	       }
		
		UserDAO userdao = new UserDAOImpl();
		User user = userdao.findUserByEmail(email);
		if(user == null){  
	           msg = "链接错误,无法找到匹配用户,请重新申请找回密码.";
	           System.out.println(msg);
	       }else{
	    	   System.out.println(user.getUser_name());
	       }
		//Timestamp outDate = user.getDate();
//		if(outDate.getDateTime() <= System.currentTimeMillis()){         //表示已经过期  
//	           msg = "链接已经过期,请重新申请找回密码."; 
//	           System.out.println(msg);
//	       } 
		
//		String key = user.getUser_name()+"$"+outDate.getTime()+"$"+user.getRandomCode();          //数字签名
//		String digitalSignature = GenerateLinkUtils.md5(key);
//		System.out.println(key+"\t"+digitalSignature);
//		if(!digitalSignature.equals(s_id)) {  
//	           msg = "链接不正确,是否已经过期了?重新申请吧";
//	           System.out.println(msg);
//	       }
		request.setAttribute("msg", msg);
		request.setAttribute("user", user);
		request.getRequestDispatcher("/UI/resetPassword.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
