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
						User user_catalogue = (User)session.getAttribute("user");
	                    CatalogueDAO cataloguedao = new CatalogueDAOImpl();
						List<First_catalogue> first_catalogues = cataloguedao.findFirst_catalogue();
						//超级管理员身份
						if(user.getRole()==3){
						if(first_catalogues!=null){
							for(First_catalogue first_catalogue : first_catalogues){
%>
				<li>
					<a href="#<%=first_catalogue.getF_name()%>" class="menu-first" data-toggle="collapse"><%=first_catalogue.getF_name() %>
						<i class="pull-left fa fa-sort-desc"></i>
						<a href="DeleteFirst_catalogueServlet?course_name=<%=first_catalogue.getF_name() %>" onclick="return delete_confirm()">
							<i  class="fa fa-times"></i></a>
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
								<a href="DeleteSecond_catalogueServlet?course_name=<%=second_catalogue.getS_name() %>" onclick="return delete_confirm()">
								<i class="fa fa-times"></i></a>
							</li>
								<ul id="<%=second_catalogue.getS_name() %>" class="collapse menu-third">
								<% 
									List<Third_catalogue> third_catalogues = cataloguedao.findThird_catalogueBys_id(second_catalogue.getS_id());
									for(Third_catalogue third_catalogue : third_catalogues){
								%>
									<li>
										<a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>&&role=<%=user.getRole()%>"><%=third_catalogue.getT_name() %></a>
										<a href="DeleteThird_catalogueServlet?course_name=<%=third_catalogue.getT_name() %>" onclick="return delete_confirm()">
											<i class="fa fa-times"></i>
										</a>
									</li>
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
						//管理员和普通用户身份
						}else{
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
									<li><a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>&&role=<%=user.getRole()%>">
											<%=third_catalogue.getT_name() %>
										</a>
									</li>
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
						}
%>
                    </div>
		</div>
		
		<div class="col-md-8">
			<%
				Third_catalogue tc = (Third_catalogue)request.getAttribute("third_catalogue");
			%>
			<%=tc.getT_content() %>
		</div>
	</div>
</body>
<!-- END BODY -->


</html>