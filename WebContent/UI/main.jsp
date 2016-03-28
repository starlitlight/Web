<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.ifilmo.domain.User"%>
<%@page import="com.ifilmo.domain.First_catalogue"%>
<%@page import="com.ifilmo.domain.Second_catalogue"%>
<%@page import="com.ifilmo.domain.Third_catalogue"%>
<%@page import="com.ifilmo.dao.*"%>
<%@page import="com.ifilmo.dao.impl.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" 
"http://www.w3.org/TR/html4/frameset.dtd">
<html>

<!-- BEGIN HEAD -->
<head>
<title>爱影</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=request.getContextPath() %>/bootstrap/css/login.css" rel="stylesheet">
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>
	<%@ include file="/UI/head.jsp"%>
		<div class="row" style="margin-top: 60px;">
		<div class="col-md-3">
			<div class="nav-side-menu">
<%
	                    CatalogueDAO cataloguedao = new CatalogueDAOImpl();
						List<First_catalogue> first_catalogues = cataloguedao.findFirst_catalogue();
						if(first_catalogues!=null){
							for(First_catalogue first_catalogue : first_catalogues){
%>
				<li>
					<a href="#<%=first_catalogue.getF_name()%>" class="menu-first" data-toggle="collapse"><%=first_catalogue.getF_name() %>
						<i class="pull-left fa fa-sort-desc"></i>
					</a>
				</li>
						<ul id="<%=first_catalogue.getF_name()%>" class="collapse menu-second">
<% 
	                       	int f_id = first_catalogue.getF_id();
	   						List<Second_catalogue> second_catalogues = cataloguedao.findSecond_catalogueByf_id(f_id);
	   						for(Second_catalogue second_catalogue : second_catalogues){
%>
							<li>
								<a href="#<%=second_catalogue.getS_name() %>" data-toggle="collapse"><%=second_catalogue.getS_name() %></a>
							</li>
								<ul id="<%=second_catalogue.getS_name() %>" class="collapse menu-third">
								<% 
									List<Third_catalogue> third_catalogues = cataloguedao.findThird_catalogueBys_id(second_catalogue.getS_id());
									for(Third_catalogue third_catalogue : third_catalogues){
								%>
									<li><a href="#" data-toggle="collapse"><%=third_catalogue.getT_name() %></a>
<%
									} 
%>
                                </ul> 
<%								
	   						}
%>
                        </ul>
<%
							} 
    					}
%>
                    </div>
			</div>
			<div class="col-md-8">
				<section class="login-form">
				<form method="post" action="LoginServlet" role="login">
					<img class="login-logo" style="margin-left: 130px" src="bootstrap/images/logoOrange.png" />
					<p class="login-heading">欢迎来到爱影培训平台</p>
					<input type="text" name="user_name" placeholder="用户名" oninvalid="this.setCustomValidity('请输入用户名')"
						required="" class="form-control input-lg" autofocus="" /> 
					<input type="password" name="user_password" placeholder="密码" oninvalid="this.setCustomValidity('请输入密码')"
						required="" class="form-control input-lg" /> 
					<a data-toggle="modal" data-target="#findPassword" class="primary" style="font-size: 14px">忘记密码</a>
					<button type="submit" class="btn btn-lg btn-block btn-primary">登陆</button>
				</form>
				</section>
			</div>
		</div>
</body>
<!-- END BODY -->



</html>