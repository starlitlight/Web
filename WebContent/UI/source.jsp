<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.ifilmo.domain.User"%>
<%@page import="com.ifilmo.domain.Catalogue_table"%>
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
<link href="<%=request.getContextPath() %>/bootstrap/css/new_course.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/bootstrap/js/catalogue.js"></script>
<script src="<%=request.getContextPath() %>/bootstrap/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/bootstrap/js/catalogue.js"></script>



</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>

<%@ include file="/UI/head.jsp"%>

<div class="row" style="margin-top: 60px;">
	<div class="col-md-3">
		<div class="nav-side-menu">
			<div class="catalogue_title"><i class="fa fa-tasks">&nbsp&nbsp</i>目 录</div>
			<div id="sortable1" class="menu-first">
<%
						User user_catalogue = (User)session.getAttribute("user");
	                    CatalogueDAO cataloguedao = new CatalogueDAOImpl();
						List<First_catalogue> first_catalogues = cataloguedao.findFirst_catalogue();
						//超级管理员身份
						for(First_catalogue first_catalogue : first_catalogues){
%>
				<li>
					<a href="#<%=first_catalogue.getF_name()%>" data-toggle="collapse"><%=first_catalogue.getF_name() %></a>
						<a href="#" onclick="deleteCourse1(event)">
							<i name="deleteIcon" class="fa fa-times" id="Icon1<%=first_catalogue.getF_name()%>"></i>
						</a>
					<ul id="<%=first_catalogue.getF_name()%>" class="collapse">
						<div id="sortable2<%=first_catalogue.getF_name() %>" class="menu-second">
<%  
	                       	int f_id = first_catalogue.getF_id();
	   						List<Second_catalogue> second_catalogues = cataloguedao.findSecond_catalogueByf_id(f_id);
	   						for(Second_catalogue second_catalogue : second_catalogues){
%>
							<li>
								<a href="#<%=second_catalogue.getS_name() %>" data-toggle="collapse"><%=second_catalogue.getS_name() %></a>
								<a href="#" onclick="deleteCourse2(event)">
									<i id="Icon2<%=second_catalogue.getS_name() %>" name="deleteIcon" class="fa fa-times"></i>
								</a>
								<ul id="<%=second_catalogue.getS_name() %>" class="collapse">
									<div id="sortable3<%=second_catalogue.getS_name() %>" class="menu-third">
								<% 
									List<Third_catalogue> third_catalogues = cataloguedao.findThird_catalogueBys_id(second_catalogue.getS_id());
									for(Third_catalogue third_catalogue : third_catalogues){
								%>
										<li>
											<a href="ShowCourseServlet?t_name=<%=third_catalogue.getT_name() %>"><%=third_catalogue.getT_name() %></a>
											<a href="#" onclick="deleteCourse3(event)">
												<i id="Icon3<%=third_catalogue.getT_name() %>" name="deleteIcon" class="fa fa-times"></i>
											</a>
										</li>
<%
									} 
%>
									</div>
                                </ul>
							</li> 
<%								
	   						}
%>
						</div>
					</ul>
				</li>
<%
							} 
%>
			</div>
			<button id="saveSortTable" class="changeCatalogue" onclick="saveTable()">保存目录顺序</button>
		</div>
	</div>
</div>
</body>

</html>