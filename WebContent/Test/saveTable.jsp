<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.ifilmo.domain.User"%>
<%@page import="com.ifilmo.domain.First_catalogue"%>
<%@page import="com.ifilmo.domain.Second_catalogue"%>
<%@page import="com.ifilmo.domain.Third_catalogue"%>
<%@page import="com.ifilmo.dao.*"%>
<%@page import="com.ifilmo.dao.impl.*"%>

<!DOCTYPE html>
<html lang="en">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
<title>爱影</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="bootstrap/css/new_course.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_editor.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_style.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/code_view.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image_manager.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/table.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
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
										<%=third_catalogue.getT_name() %>
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
						
%>
                    </div>
		</div>
</div>

	


</body>

<script>

	var saveHtml = $('.nav-side-menu').html();
	alert(saveHtml);
	var table={"content": saveHtml}
	$.ajax({
		type: "post",
		data: table,
		url: "sortableServlet",
		dataType: "json",
		success: function(data){
			
		},
		error: function(err){
			
		}
		
	})
		

</script>

</html>