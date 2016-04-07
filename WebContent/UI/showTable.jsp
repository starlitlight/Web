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
				System.out.println("false");
			}
%>			
		</div>
	</div>
	<div class="col-md-8">
		<div class="row user_info" style="margin-top:30px; margin-left:10px"> 
        	<form role="form" id="newCourse">
            	<div class="form-group row">
                	<div class="col-md-12">
						<h3>添加新课程:</h3>
						<hr></hr>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-2">
						<label>课程名称：</label>
					</div>
					<div class="col-md-6">	
                    	<input type="text" class="form-control" id="courseName" name="courseName" placeholder="新课程名称">
                    	<div id="NewCourseName" style="color:red; visibility:hidden;">请输入新课程的名称!</div>
					</div>
				</div>
				<div class="form-group row">
                	<div class="col-md-12">
						<h3>课程分类:</h3>
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
						<input class="btn btn-warning" value="保存" type="button" onClick="insertCourse()">   
						<input class="btn btn-warning" style="background-color:#fff; color:#eea236" value="取消" type="reset">
					</div>
				</div>
			</form> 
		</div>
	</div>
</div>

</body>
<script>
	function insertCourse(){
		var htmlCode = $('.nav-side-menu').html();
		alert(htmlCode);
		var courseName = $("#courseName").val();
		if (courseName == 0 || courseName == null){
			document.getElementById("NewCourseName").style.visibility = "visible";
			return;
		}
		var selectCourse1 = $("#selectCourse1").val();
		var selectCourse2 = $("#selectCourse2").val();
		
		alert("courseName: " + courseName + "course1 value: " + selectCourse1 + " and course2 value: " + selectCourse2);
		var insertCourse={"htmlCode": htmlCode, "courseName": courseName, "selectCourse1": selectCourse1, "selectCourse2": selectCourse2};
		$.ajax({
			type: "post",
			url: "addCourseServlet",
			data: insertCourse,
			dataType: "json",
			success: function(data){
				
			},
			error: function(err){
				
			}
			
		})
			
	}
	
		


</script>
</html>