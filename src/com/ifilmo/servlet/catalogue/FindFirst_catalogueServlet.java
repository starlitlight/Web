package com.ifilmo.servlet.catalogue;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.CatalogueDAO;
import com.ifilmo.dao.impl.CatalogueDAOImpl;
import com.ifilmo.domain.First_catalogue;
import com.ifilmo.domain.Second_catalogue;


public class FindFirst_catalogueServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CatalogueDAO  cataloguedao = new CatalogueDAOImpl();
		List<First_catalogue> first_catalogue = cataloguedao.findFirst_catalogue();
		
		request.setAttribute("first_catalogue", first_catalogue);
		request.getRequestDispatcher("/UI/addCourse.jsp").forward(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doGet(request, response);
		}
}


