package com.ifilmo.servlet.catalogue;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.CatalogueDAO;
import com.ifilmo.dao.impl.CatalogueDAOImpl;
import com.ifilmo.domain.Picture;
import com.ifilmo.domain.Third_catalogue;
import com.ifilmo.util.getImageSrc;

public class addCourseServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		String courseName = request.getParameter("courseName");
		int selectCourse1 = Integer.parseInt(request.getParameter("selectCourse1"));
		int selectCourse2 = Integer.parseInt(request.getParameter("selectCourse2"));
		String content = request.getParameter("edit");
		String msg = "FAILED";
		CatalogueDAO cataloguedao = new CatalogueDAOImpl();
		
		
		if(selectCourse1==0 && selectCourse2==0){
			if(cataloguedao.insertFirst_catalogue(courseName)){
				request.getRequestDispatcher("/showAddCourseServlet").forward(request, response);
			}else{
				System.out.println("第一级目录保存成功");
			}
		}else if(selectCourse2==0 && selectCourse1!=0){
			if(cataloguedao.insertSecond_catalogue(courseName, selectCourse1)){
				request.getRequestDispatcher("/showAddCourseServlet").forward(request, response);
			}else{
				System.out.println("第二级目录保存成功");
			}
		}else if(selectCourse2!=0 && selectCourse1!=0){
			if(cataloguedao.insertThird_catalogue(courseName, selectCourse2)){
				request.getRequestDispatcher("/showAddCourseServlet").forward(request, response);
			}else{
				System.out.println("第三级目录保存成功");
			}
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
