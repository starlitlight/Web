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

<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_editor.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_style.css">
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>

	<%@ include file="/UI/head.jsp"%>
	<input name="userRole" id="userRole" value="<%=user.getRole()%>" type="hidden"/>
	<div class="row" style="margin-top: 60px;">
		<div class="col-md-3">
		<div class="nav-side-menu">
<% 
			CatalogueDAO  cataloguedao = new CatalogueDAOImpl();
			Catalogue_table catalogue= cataloguedao.selectCatalogue();
			if(catalogue!=null){
				String table = catalogue.getContent();
%>
			<%=table%>
<% 
			}else{
				System.out.println("读取目录失败");
			}
%>			
		</div>
	</div>
		
		<div class="col-md-8 fr-view">
			<div class="form-group">
<%
				Third_catalogue tc = (Third_catalogue)request.getAttribute("third_catalogue");
%>
					<div class="col-md-11"></div>
                	<a href="EditCourseServlet?t_id=<%=tc.getT_id() %>" class="btn btn-warning" id="editPage"
                		style="background-color:#fff; color:#eea236; padding-top:3px; visibility:hidden">编辑</a>
			</div>
			
			<%=tc.getT_content() %>
		</div>
	</div>
</body>
<!-- END BODY -->
<script type="text/javascript">
$(document).ready(function() {
	var role = $("#userRole").attr("value");
	//alert(role);
	if(role==2 || role==3){
		$("#editPage").css({visibility:"visible"});	
	}else{
		$("#editPage").css({visibility:"hidden"});
	}
});

</script>
</html>