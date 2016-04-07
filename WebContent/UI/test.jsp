<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
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
<script src="bootstrap/js/jquery-ui.js"></script>

</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>
<%@ include file="/UI/head.jsp"%>
<div class="row" style="margin-top: 60px;">
	
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
				System.out.println("false");
			}
%>			

				
    		<button type="button" value="submit"></button>
		</div>
</div>
	


</body>
<script>
	function catalogue(){
		var saveHtml = $('.nav-side-menu').html();
		alert(saveHtml);
		$.ajax({
			type: "post",
			url: "sortableServlet?html=" + saveHtml,
			dataType: "json",
			success: function(data){
				
			},
			error: function(err){
				
			}
			
		})
			
	}
	
		


</script>
</html>