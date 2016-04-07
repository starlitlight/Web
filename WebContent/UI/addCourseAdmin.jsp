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
<link href="<%=request.getContextPath() %>/bootstrap/css/new_course.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/bootstrap/js/catalogue.js"></script>
<script src="<%=request.getContextPath() %>/bootstrap/js/jquery-ui.js"></script>



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
						<a href="DeleteFirst_catalogueServlet?course_name=<%=first_catalogue.getF_name() %>" onclick="return delete_confirm()">
							<i class="fa fa-times firstLayer"></i></a>
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
								<a href="DeleteSecond_catalogueServlet?course_name=<%=second_catalogue.getS_name() %>" onclick="return delete_confirm()">
								<i class="fa fa-times secondLayer"></i></a>
							
								<ul id="<%=second_catalogue.getS_name() %>" class="collapse">
									<div id="sortable3<%=second_catalogue.getS_name() %>" class="menu-third">
								<% 
									List<Third_catalogue> third_catalogues = cataloguedao.findThird_catalogueBys_id(second_catalogue.getS_id());
									for(Third_catalogue third_catalogue : third_catalogues){
								%>
										<li>
											<a><%=third_catalogue.getT_name() %></a>
											<a href="DeleteThird_catalogueServlet?course_name=<%=third_catalogue.getT_name() %>" onclick="return delete_confirm()">
												<i class="fa fa-times thirdLayer"></i>
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
			<div class="changeCatalogue" onclick="changeTable()">修改目录</div>
			<div class="changeCatalogue" onclick="saveTable()">保存</div>
		</div>
	</div>
</div>
</body>

<script>



function changeTable() {
	var IDs = [];
	$(".nav-side-menu").find("div").each(function(){ 
		IDs.push(this.id);
		});
	alert(IDs);
	alert("请修改目录顺序");
	for(i=0;i<IDs.length;i++){
	    var ids = "#" + IDs[i];
		$(ids).sortable({
	    	axis: 'y',
	    	containment: 'parent',
	    	tolerance: "pointer",
	    	opacity: 0.6, //设置拖动时候的透明度
	    	revert: true, //缓冲效果 
	        cursor: 'move', //拖动的时候鼠标样式 
	    });
	}
}

function saveTable() {
    var saveHtml = $('.nav-side-menu').html();
    alert(saveHtml);
    var table={"content": saveHtml}
    $.ajax({
		type: "post",
		data: table,
		url: "sortableServlet",
		dataType: "json",
		success: function(data){
			alert("存储成功");
		},
		error: function(err){
		}
		
	});
    var IDs = [];
	$(".nav-side-menu").find("div").each(function(){ 
		IDs.push(this.id);
		});
	for(i=0;i<IDs.length;i++){
		var ids = "#" + IDs[i];
		$(ids).sortable("disable");
	}
    alert("停止挪动");
    
}
</script>

</html>