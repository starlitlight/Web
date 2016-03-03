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
									<li><a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>">
									<%=third_catalogue.getT_name() %></a></li>
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
<%
			List<Third_catalogue> tcs = (List<Third_catalogue>) request.getAttribute("third_catalogues");
%>
			<div class="search_result">
				<label class="myLabel-content">搜索：</label>
				<label class="myLabel-content">表格 （共有<%=tcs.size() %>个结果）</label>
			</div>
			<div class="row">
<%
			for(Third_catalogue tc : tcs){
				String content = tc.getT_content();
				String value = getImageSrc.Html2Text(content);
				List<Picture> pictures = (List<Picture>)cataloguedao.findPictureByTid(tc.getT_id());
%>
		        <div class="col-md-12">
		            
		            <div class="thumbnail clearfix">
		  			<form>
<%
		            if(pictures!=null){
						for(int i=0; i<pictures.size(); i++){
							Picture picture = pictures.get(0);
							String path = picture.getPath();
							System.out.println(path);
%>
		                <img src="<%=path %>" class="pull-left">
<%
						}
					}
%>
		                <div class="caption" class="pull-right">
		                    <h3 class="head"><%=tc.getT_name() %></h3>
		                    <span class="content"><%=value %></span>
		                </div>
		                <div>
		                    <span class="pull-right">
		                    	<a href="ShowCourseServlet?t_id=<%=tc.getT_id() %>" type="submit" class="btn btn-warning" /> 开始学习
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
	</div>
</body>
<!-- END BODY -->


</html>