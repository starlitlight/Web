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
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/bootstrap/images/logo_main.ico"/>
<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath() %>/bootstrap/images/logo_main.ico" />
<link href="bootstrap/css/new_course.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/bootstrap/js/select.js"></script>
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
		<div class="row user_info" style="margin-top:30px; margin-left:10px"> 
        	<form role="form" id="newCourse">
            	<div class="form-group row">
                	<div class="col-md-12">
						<h3>添加新课程/目录:</h3>
						<hr></hr>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-2">
						<label>课程名称/目录：</label>
						
					</div>
					<div class="col-md-6">	
                    	<input type="text" class="form-control" id="courseName" name="courseName" placeholder="新课程名称">
                    	<div id="NewCourseName" style="color:red; visibility:hidden;">请输入新课程的名称!</div>
                    	<div id="checkCourseName" style="color:red; visibility:hidden">课程名已存在，请重新输入!</div>
					</div>
				</div>
				<div class="form-group row">
                	<div class="col-md-12">
						<h3>课程分类/目录:</h3>
						<hr></hr>
					</div>
				</div>
                <div class="form-group row">
                	<div class="col-md-2">
                          <label class="control-label">一级目录:</label>
                    </div>
                    <div class="col-md-3">
						<select class="form-control" name="selectCourse1" id="selectCourse1" onChange="changeSelect()">
							<option selected="selected" value="0">请选择目录</option>                                    
<%
					List<First_catalogue> first_catalogues = cataloguedao.findFirst_catalogue();
					for(First_catalogue first_catalogue : first_catalogues){
%>
                         	<option value=<%=first_catalogue.getF_id() %>><%=first_catalogue.getF_name() %></option>
<%
                     }
%>
						</select>
					</div>
                    <div class="col-md-2">     
						<label class="control-label">二级目录:</label>
					</div>
					<div class="col-md-3">
	                    <select class="form-control" id="selectCourse2" name="selectCourse2">
							<option value="0">请选择目录</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-12">
						<div class="inserCourseWarn">提示：1.如果一级二级目录都不选，则添加一级目录</br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
						      2.如果只选择了一级目录，则添加该一级目录下的子目录</br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
						      3.如果选择了一级，二级目录，则添加该一级目录下二级目录的子目录</div>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-12">
						<input class="btn btn-warning" value="保存" type="button" onclick="insertCourse();">   
						<input class="btn btn-warning" style="background-color:#fff; color:#eea236" value="取消" type="reset">
					</div>
				</div>
			</form> 
		</div>
	</div>
</div>

	


</body>
</html>