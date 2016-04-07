package com.ifilmo.servlet.catalogue;

import java.io.File;
import java.io.IOException;
import java.util.List;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
//import org.apache.tomcat.util.http.fileupload.FileUploadException;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
//import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;

public class SavePictureServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 上传图片
	 */
	// private static final long serialVersionUID = 1L;
	// private ServletContext sc;
	// private String savePath;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		System.out.println("我到这里了");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		// upload.setSizeMax(-1);//
		UserDAO userdao = new UserDAOImpl();
		//System.out.println(user_id);
		try {
			@SuppressWarnings("unchecked")
			List<FileItem> items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem item = items.get(i);
				// isFormField为true，表示这不是文件上传表单域
				if (!item.isFormField()) {
					ServletContext sctx = getServletContext();
					// 获得存放文件的物理路径
					// upload下的某个文件夹 得到当前在线的用户 找到对应的文件夹
					String path = sctx.getRealPath("/bootstrap/images");
					System.out.println(path);
					// 获得文件名
					String fileName = item.getName();
					System.out.println(fileName);
					//System.out.println("The type of the file: " + item.getContentType());
					// 该方法在某些平台(操作系统),会返回路径+文件名
					fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
					File file = new File(path + "\\" + fileName);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("上传失败");
			request.setAttribute("upload.message", "Upload failed");
		}
		//request.getRequestDispatcher("UserAccountServlet").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}