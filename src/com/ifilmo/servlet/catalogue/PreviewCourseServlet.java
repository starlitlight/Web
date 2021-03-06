package com.ifilmo.servlet.catalogue;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.CatalogueDAO;
import com.ifilmo.dao.impl.CatalogueDAOImpl;
import com.ifilmo.domain.Third_catalogue;



public class PreviewCourseServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int t_id = Integer.parseInt(request.getParameter("t_id"));
		CatalogueDAO  cataloguedao = new CatalogueDAOImpl();
		Third_catalogue third_catalogue = cataloguedao.findContentyById(t_id);
		if(third_catalogue!=null){
			request.setAttribute("third_catalogue", third_catalogue);
		}else{
			System.out.println("读取课程内容失败");
		}
		request.setAttribute("t_id", t_id);
		request.getRequestDispatcher("/UI/showCourse.jsp").forward(request, response);
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doGet(request, response);
		}
}


