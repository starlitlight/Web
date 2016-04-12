package com.ifilmo.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadImgServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public UploadImgServlet() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		/** 上传文件处理内容 **/
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		//upload.setHeaderEncoding("UTF-8"); // 处理中文问题
		
		try {
			List<FileItem> items = upload.parseRequest(request); // 解码请求
			for (int i=0;i<items.size(); i++) {
				FileItem item = items.get(i);
				if (!item.isFormField()) {
					
					ServletContext sc = getServletContext();
					String path = sc.getRealPath("/images");
					String fileName = item.getName();
					System.out.println("图片名是" + fileName);
					fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
					File file = new File(path + File.separator + fileName);
				
					if (!file.exists()) {
						item.write(file);
						// 将上传图片的名字记录到数据库中
						String imgUrl = request.getContextPath() + File.separator + "images" + File.separator + fileName;
						response.setContentType("text/text;charset=utf-8");
						PrintWriter out = response.getWriter();
						out.print(imgUrl); // 返回url地址
						out.flush();
						out.close();
					} else {
						System.out.println("上传文件失败");
						}
					}
				}
		}catch (Exception e) {
						e.printStackTrace();
					}
		/**********************/

		// 获取图片url地址
		
		
	}

	public void init() throws ServletException {
		// Put your code here
	}
}