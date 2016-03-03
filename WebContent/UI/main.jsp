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
		
				<div class="modal-dialog">
					<div class="modal-content">
					
						<div class="modal-header">
							<img class="login-logo" src="bootstrap/images/logoOrange.png" />
							<h2 class="login-heading">欢迎来到爱影培训平台!</h2>
						</div>
						<div class="modal-body">
						<form class="form-signin" action="LoginServlet" method="post" id="login">
								<input class="input-style" type="text" class="form-control"
									name="user_name" placeholder="用户名" required="" autofocus="" />
								<input class="input-style" type="password" class="form-control"
									name="user_password" placeholder="密码" required="" />
								<div>
									<p class="forgotPass">
										<a data-toggle="modal" data-target="#findPassword"
											class="fontsize">忘记密码</a>
									</p>
								</div>
						</div>
						<div class="modal-footer">
							<button class="btn btn-lg btn-primary btn-block" type="submit">登陆</button>
						</div>
						</form>
					</div>
				</div>
			</div>

		</div>
	</div>
</body>
<!-- END BODY -->



</html>