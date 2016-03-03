package com.ifilmo.servlet.catalogue;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.CatalogueDAO;
import com.ifilmo.dao.impl.CatalogueDAOImpl;


public class DeleteSecond_catalogueServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//String course_name = new String(request.getParameter("course_name").getBytes("iso8859-1"), "utf-8");
		String course_name = request.getParameter("course_name");
		System.out.println(course_name);
		CatalogueDAO  cataloguedao = new CatalogueDAOImpl();
		if(cataloguedao.deleteSecond_catalogue(course_name)){
			//request.setAttribute("", );
		}else{
			System.out.println("删除第二级目录失败");
		}
		request.getRequestDispatcher("UI/main.jsp").forward(request, response);
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		}
}


