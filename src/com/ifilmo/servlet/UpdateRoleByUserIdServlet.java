package com.ifilmo.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.domain.User;

import net.sf.json.JSONObject;

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
		
		JSONObject json = new JSONObject();
		PrintWriter pw = response.getWriter(); 
		
		System.out.println(user_id + "      " + role);
		UserDAO userdao = new UserDAOImpl();		
		
		if(userdao.UpdateRoleByUserId(role, user_id)){
			json.put("message", "修改用户权限成功！");
        }else{
        	json.put("message", "修改用户权限失败！");
        } 
		pw.print(json.toString());
		pw.close();

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
