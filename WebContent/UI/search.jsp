<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.ifilmo.domain.User"%>
<%@page import="com.ifilmo.domain.First_catalogue"%>
<%@page import="com.ifilmo.domain.Second_catalogue"%>
<%@page import="com.ifilmo.domain.Third_catalogue"%>
<%@page import="com.ifilmo.dao.*"%>
<%@page import="com.ifilmo.dao.impl.*"%>
<%@page import="com.ifilmo.domain.Picture"%>
<%@page import="com.ifilmo.util.getImageSrc"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" 
"http://www.w3.org/TR/html4/frameset.dtd">
<html>

<!-- BEGIN HEAD -->
<head>
<title>爱影</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=request.getContextPath() %>/bootstrap/css/search.css" rel="stylesheet">

</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>

	<%@ include file="/UI/head.jsp"%>

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
		
		<div class="col-md-8">
<%
			List<Third_catalogue> tcs = (List<Third_catalogue>) request.getAttribute("third_catalogues");
%>
			<div class="search_result">
				<label class="myLabel-content">搜索：</label>
				<label class="myLabel-content">表格 （共有<%=tcs.size() %>个结果）</label>
			</div>
			
<%
			for(Third_catalogue tc : tcs){
				String content = tc.getT_content();
				String value = getImageSrc.Html2Text(content);
				List<Picture> pictures = (List<Picture>)cataloguedao.findPictureByTid(tc.getT_id());
%>
    		<div class="col-md-12" style="padding-top:20px">
        		<div class="thumbnail clearfix">
					<form>
<%
		        if(pictures!=null){
%>
            			<img src="<%=pictures.get(0).getPath() %>" class="pull-left">
<%
				}
%>
			            <div class="caption" class="pull-right">
			                <h3 class="head"><%=tc.getT_name() %></h3>
			                <span class="content"><%=value %></span>
			            </div>
			            <div>
			                <span class="pull-right">
			                	<a href="PreviewCourseServlet?t_id=<%=tc.getT_id() %>" type="submit" class="btn btn-warning" /> 开始学习
			                	</a>
			                </span>
            			</div>
         			</form>
        		</div>
        
    		</div>
<%					
			}
%>
		</div>
</div>

</body>
<!-- END BODY -->


</html>