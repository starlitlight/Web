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
			<ul id="sort">
		        <li id="1"><a data-target="#demo">1</a></li>
		        <li id="2"><a href="#demo"></a></li>
		        <li id="3">3</li>
		        <li id="4">4</li>
		    </ul>			
		</div>
</div>
	


</body>
<script>
	
		var saveHtml = escape($('.nav-side-menu').html());
		alert(saveHtml);
		//var url = "sortableServlet?content=" + saveHtml;
		//url = unescape(url);
		//var jsonHtml = {"content":saveHtml};
		$.ajax({
			type: "post",
			url: "sortableServlet?content=" + saveHtml,
			dataType: "json",
			contentType:"application/json;charset=utf-8",
			success: function(data){
				
			},
			error: function(err){
				
			}
			
		})
			

	
		


</script>
</html>