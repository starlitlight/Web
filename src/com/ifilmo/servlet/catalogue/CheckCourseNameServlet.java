package com.ifilmo.servlet.catalogue;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.CatalogueDAO;
import com.ifilmo.dao.impl.CatalogueDAOImpl;
import com.ifilmo.domain.First_catalogue;
import com.ifilmo.domain.Second_catalogue;
import com.ifilmo.domain.Third_catalogue;

import net.sf.json.JSONObject;

public class CheckCourseNameServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		JSONObject json = new JSONObject();
		PrintWriter pw = response.getWriter();
		System.out.println("进入CheckCourseNameServlet");
		
		String courseName = request.getParameter("courseName");
		System.out.println("课程名字是" + courseName);
		String message = "";
		
		CatalogueDAO cataloguedao = new CatalogueDAOImpl();
		First_catalogue fc = cataloguedao.findFirst_catalogueName(courseName);
		Second_catalogue sc = cataloguedao.findSecond_catalogueName(courseName);
		Third_catalogue tc = cataloguedao.findThird_catalogueName(courseName);
		if(fc==null && sc==null && tc==null){
			System.out.println("课程名字可用");
			json.put("message", "successful");
		}else{
			json.put("message", "failed");
		}
		
		pw.print(json.toString());
		pw.close();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
