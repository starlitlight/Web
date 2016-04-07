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
import com.ifilmo.util.getImageSrc;

public class addCourseContentServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		String content = request.getParameter("edit");
		int t_id = Integer.parseInt(request.getParameter("t_id"));
		String msg = "FAILED";
		CatalogueDAO cataloguedao = new CatalogueDAOImpl();
		
		if(cataloguedao.UpdateCourseContentById(content, t_id)){
			List<String> imgs = getImageSrc.getImageSrc(content);
			for(String img: imgs){
				Picture picture = new Picture(img, t_id);
				if(cataloguedao.updatePictures(picture.getPath(), picture.getT_id())){
					msg = "SUCCESSFUL";
				}
			}
		}else{
			System.out.println("无法存储课程内容");
		}
		
		request.getRequestDispatcher("/showAddCourseServlet").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
