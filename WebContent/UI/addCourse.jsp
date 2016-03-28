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
<link href="bootstrap/css/new_course.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_editor.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_style.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/code_view.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image_manager.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/table.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>

<%@ include file="/UI/head.jsp"%>

<div class="row" style="margin-top: 60px;">
	<div class="col-md-3">
				<div class="nav-side-menu">
<%
						User user_catalogue = (User)session.getAttribute("user");
	                    CatalogueDAO cataloguedao = new CatalogueDAOImpl();
						List<First_catalogue> first_catalogues = cataloguedao.findFirst_catalogue();
						//超级管理员身份
						if(user.getRole()==3){
						if(first_catalogues!=null){
							for(First_catalogue first_catalogue : first_catalogues){
%>
				<li>
					<a href="#<%=first_catalogue.getF_name()%>" class="menu-first" data-toggle="collapse"><%=first_catalogue.getF_name() %>
						<i class="pull-left fa fa-sort-desc"></i>
						<a href="DeleteFirst_catalogueServlet?course_name=<%=first_catalogue.getF_name() %>" onclick="return delete_confirm()">
							<i  class="fa fa-times"></i></a>
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
								<a href="DeleteSecond_catalogueServlet?course_name=<%=second_catalogue.getS_name() %>" onclick="return delete_confirm()">
								<i class="fa fa-times"></i></a>
							</li>
								<ul id="<%=second_catalogue.getS_name() %>" class="collapse menu-third">
								<% 
									List<Third_catalogue> third_catalogues = cataloguedao.findThird_catalogueBys_id(second_catalogue.getS_id());
									for(Third_catalogue third_catalogue : third_catalogues){
								%>
									<li>
										<a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>&&role=<%=user.getRole()%>"><%=third_catalogue.getT_name() %></a>
										<a href="DeleteThird_catalogueServlet?course_name=<%=third_catalogue.getT_name() %>" onclick="return delete_confirm()">
											<i class="fa fa-times"></i>
										</a>
									</li>
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
						//管理员和普通用户身份
						}else{
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
									<li><a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>&&role=<%=user.getRole()%>">
											<%=third_catalogue.getT_name() %>
										</a>
									</li>
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
						}
%>
                    </div>
		</div>
		
	<div class="col-md-8">
		<div class="row user_info" style="margin-top:30px; margin-left:10px"> 
        	<form role="form" class="newCourse" action="addCourseServlet" method="post">
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
						<input class="btn btn-warning" value="保存" type="submit">   
						<input class="btn btn-warning" style="background-color:#fff; color:#eea236" value="取消" type="reset">
					</div>
				</div>
			</form> 
		</div>
	</div>
</div>

	


</body>

<script>
function delete_confirm() {
    var msg = "您确定要删除该目录吗？";
    if (confirm(msg)==true){
      return true;
    }else{
      return false;
    }
}
</script>

</html>