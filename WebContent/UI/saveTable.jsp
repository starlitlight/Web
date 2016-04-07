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
<script src="<%=request.getContextPath() %>/bootstrap/js/jquery-ui.js"></script>
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
						<input class="btn btn-warning" value="保存" type="button" onclick="insertCourse();">   
						<input class="btn btn-warning" style="background-color:#fff; color:#eea236" value="取消" type="reset">
					</div>
				</div>
			</form> 
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

function insertCourse() {
	
	var htmlCode = $('.nav-side-menu').html();
	//alert(htmlCode);
	var courseName = $("#courseName").val();
	if (courseName == 0 || courseName == null){
		document.getElementById("NewCourseName").style.visibility = "visible";
		return;
	}
	var selectCourse1 = $("#selectCourse1").val();
	var selectCourse1Name = $("#selectCourse1").find("option:selected").text();
	var selectCourse2 = $("#selectCourse2").val();
	var selectCourse2Name = $("#selectCourse2").find("option:selected").text();
	
	if(selectCourse1==0 && selectCourse2==0){
		
		var htmlCode1 = "<div class=''>"
            + "<a href='#" + courseName + "' data-toggle='collapse'>" + courseName + "</a>" 
            +"<a href='DeleteFirst_catalogueServlet?course_name=" + courseName + "' onclick='return delete_confirm()'>"
            +"<i class='fa fa-times firstLayer'></i></a>"
            +"<div id='" + courseName + "' class='collapse'>"
            +"<div id='sortable2' class='menu-second'>"
            +"</div></div></div>";
        $("#sortable1").append(htmlCode);
        alert("添加一级目录成功");
        saveTable();
	}
	if(selectCourse1!=0 && selectCourse2==0){
		var htmlCode2 = "<div class=''>"
			+ "<a href='#" + courseName + "' data-toggle='collapse'>" + courseName + "</a>" 
			+"<a href='DeleteFirst_catalogueServlet?course_name=" + courseName + "' onclick='return delete_confirm()'>"
			+"<i class='fa fa-times firstLayer'></i></a>"
			+"<div id='" + courseName + "' class='collapse'>"
			+"<div id='sortable3' class='menu-third'>"
			+"</div></div></div>";
		var courseLayer2 = "#sortable2" + selectCourse1Name;
		alert(courseLayer2);
		$(courseLayer2).append(htmlCode2);
		alert("添加二级目录成功");
		//saveTable();
	}
	if(selectCourse1!=0 && selectCourse2!=0){
		var htmlCode3 = "<div class=''>"
			+ "<a href='#" + courseName + "' data-toggle='collapse'>" + courseName + "</a>" 
			+"<a href='DeleteFirst_catalogueServlet?course_name=" + courseName + "' onclick='return delete_confirm()'>"
			+"<i class='fa fa-times firstLayer'></i></a>"
			+"<div id='" + courseName + "' class='collapse'>"
			+"<div id='sortable3' class='menu-third'>"
			+"</div></div></div>";
		var courseLayer3 = "#sortable3" + selectCourse2Name;
		alert(courseLayer3);
		$(courseLayer3).append(htmlCode3);
		alert("添加三级目录成功");
	}
	
	//alert("courseName: " + courseName + "course1 value: " + selectCourse1 + " and course2 value: " + selectCourse2);
	//var insertCourse={"htmlCode": htmlCode, "courseName": courseName, "selectCourse1": selectCourse1, "selectCourse2": selectCourse2};
	//$.ajax({
	//	type: "post",
//		url: "",
//		data: insertCourse,
//		dataType: "json",
//		success: function(data){
//		},
//		error: function(err){
//		}
////	})
		
}
</script>

</html>