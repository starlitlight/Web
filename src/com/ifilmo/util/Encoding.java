package com.ifilmo.util;

import java.io.*;
import javax.servlet.*;

public class Encoding implements Filter {
	private String charSet; // 设置字符编码

	public void init(FilterConfig config) throws ServletException {
		this.charSet = config.getInitParameter("charset");// 取得初始化参数
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {// 执行过滤
		request.setCharacterEncoding(this.charSet);// 设置统一编码
	}

	public void destroy() {
	}
}