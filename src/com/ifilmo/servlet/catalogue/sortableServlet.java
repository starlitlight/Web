package com.ifilmo.servlet.catalogue;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ifilmo.dao.CatalogueDAO;
import com.ifilmo.dao.impl.CatalogueDAOImpl;


public class sortableServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		
		
		String htmlCode = request.getParameter("content");
		
		CatalogueDAO  cataloguedao = new CatalogueDAOImpl();
		if(cataloguedao.updateCatalogue(htmlCode)){
			System.out.println("保存拖拽成功");
		}else{
			System.out.println("保存拖拽失败");
		}
		
		
		//write(response, order1);
		
	}

	private void write(HttpServletResponse response, Map<String, Object> order) throws IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(new Gson().toJson(order));
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
