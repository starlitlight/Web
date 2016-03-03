package com.ifilmo.servlet.catalogue;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.CatalogueDAO;
import com.ifilmo.dao.impl.CatalogueDAOImpl;
import com.ifilmo.domain.Second_catalogue;

public class SelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		int targetId = Integer.parseInt(request.getParameter("id")); // 获得武侠大师编号

		CatalogueDAO cataloguedao = new CatalogueDAOImpl();
		List<Second_catalogue> second_catalogues = cataloguedao.findSecond_catalogueByf_id(targetId);

		System.out.println(targetId);
		String xml_start = "<selects>";
		String xml_end = "</selects>";
		String xml = "";
		if (targetId == 0) {
		} else {
			xml = "<select><value>0</value><text>请选择目录</text></select>";
			for (Second_catalogue second_catalogue : second_catalogues) {
				
				xml += "<select><value>" + second_catalogue.getS_id() + "</value><text>" + second_catalogue.getS_name()
						+ "</text></select>";
			}
		}
		String last_xml = xml_start + xml + xml_end;
		response.getWriter().write(last_xml);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}