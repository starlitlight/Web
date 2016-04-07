<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.ifilmo.domain.User"%>
<%@page import="com.ifilmo.domain.First_catalogue"%>
<%@page import="com.ifilmo.domain.Second_catalogue"%>
<%@page import="com.ifilmo.domain.Third_catalogue"%>
<%@page import="com.ifilmo.dao.*"%>
<%@page import="com.ifilmo.dao.impl.*"%>

<!DOCTYPE html>
<html lang="en">

<!-- BEGIN HEAD -->
<head>
<title>爱影</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="bootstrap/css/user_profile.css" rel="stylesheet">
<script src="bootstrap/js/md5.js"></script>
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
						if(user.getRole()==3){
						if(first_catalogues!=null){
							for(First_catalogue first_catalogue : first_catalogues){
%>
				<li>
					<a href="#<%=first_catalogue.getF_name()%>" class="menu-first" data-toggle="collapse"><%=first_catalogue.getF_name() %>
						<i class="pull-left fa fa-sort-desc"></i>
						<a href="DeleteFirst_catalogueServlet?course_name=<%=first_catalogue.getF_name() %>"><i  class="fa fa-times"></i></a>
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
								<a href="DeleteSecond_catalogueServlet?course_name=<%=second_catalogue.getS_name() %>">
								<i class="fa fa-times"></i>
							</li>
								<ul id="<%=second_catalogue.getS_name() %>" class="collapse menu-third">
								<% 
									List<Third_catalogue> third_catalogues = cataloguedao.findThird_catalogueBys_id(second_catalogue.getS_id());
									for(Third_catalogue third_catalogue : third_catalogues){
								%>
									<li>
										<a href="#" data-toggle="collapse"><%=third_catalogue.getT_name() %></a>
										<a href="DeleteThird_catalogueServlet?course_name=<%=third_catalogue.getT_name() %>">
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
										
										System.out.println("third_catalogue.getT_id(): " + third_catalogue.getT_id());
								%>
									<li><a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>">
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
<%
			User user_info = (User)request.getAttribute("user");
%>
			<div class="col-md-8">
				<div class="row user_info" style="margin-top:30px; margin-left:10px">
					<!-- left column -->
					<form class="form-horizontal" role="form" action="UpdateUserServlet" name="updateUser" method="post">
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="text-center">
							<%
								String path = request.getContextPath()  + "/bootstrap/images/" + user_info.getPhoto();
								System.out.println(path);
							%>
								<input name="user_id" id="user_id" value="<%=user_info.getUser_id()%>" type="hidden"/>
								<img src="<%=path %>" onerror="this.src='bootstrap/images/default.png'"
									class="avatar img-circle img-thumbnail" alt="avatar">
								<input name="photo" id="photo" value="<%=user_info.getPhoto() %>" type="hidden"/>
					            <tr>
					            	</br>  
					                <td><input name="file" type="file" size="20"></td>    
					                <td><input type="button" class= "btn btn-warning" onclick="uploadImg()" value="上传" /></td>
					            </tr>  
						    	
							</div>
						</div>
						<div class="col-md-8 col-sm-6 col-xs-12">
							<div class="form-group">
								<label class="col-lg-3 control-label"><h3>账户设置</h3></label> 
							</div>
							<div class="form-group">
								<label class="col-lg-3 control-label">用户名:</label>
								<div class="col-lg-5">
									<input name="user_name" class="form-control" value="<%=user_info.getUser_name()%>"
										type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-lg-3 control-label">性别:</label>
								<div class="col-lg-5">
									<%
										if (user_info.getGender()==1) {
									%>
									<input class="sex" type="radio" name="gender" value="1" checked>男
									<input class="sex" type="radio" name="gender" value="0">女
									<%
										} if(user_info.getGender()==0) {
									%>
									<input class="sex" type="radio" name="gender" value="1">男 
									<input class="sex" type="radio" name="gender" value="0" checked>女
									<%
										}
									%>
								</div>
							</div>
							<div class="form-group">
								<label class="col-lg-3 control-label">邮箱:</label>
								<div class="col-lg-5">
									<input class="form-control" name="email" value="<%=user_info.getEmail()%>"
										type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-lg-3 control-label">密码:</label>
								<div class="col-lg-5">
								<a data-toggle="modal" data-target="#changPassword">
									<input class="form-control" style="float: left" name="user_password" type="password" 
										value="<%=user_info.getUser_password()%>" readonly>修改密码</a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label"></label>
								<div class="col-md-8">
									<input class="btn btn-warning" value="保存" type="submit">   
									<input class="btn btn-warning" style="background-color:#fff; color:#eea236" value="取消" type="reset">
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
</body>
<!-- END BODY -->
<!-- 模态框 修改密码-->
<div class="modal fade" id="changPassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	            <h4 class="modal-title" id="myModalLabel" >修改密码</h4>
	        </div>
	        <div class="modal-body">
	        <form name="changePassword"  method="post" onsubmit="return checkpwd()">
	            <input type="password" id="inputPassword1" name="user_password1" class="input-style" placeholder="原密码" required autofocus>
	            <input type="password" id="inputPassword2" name="user_password2" class="input-style" placeholder="新密码" required>
	            <input type="password" id="inputPassword3" name="user_password3" class="input-style" placeholder="确认新密码" required>
	            <div id="tishi" style="color:red; visibility:hidden;">原密码不正确!</div>
	            <div id="tishi2" style="color:red; visibility:hidden;">两次密码不一致!</div>
	        </div>
	        <div class="modal-footer">
	            <button class="btn btn-lg btn-primary btn-block" type="submit">确认修改并重新登陆</button>
	        </div>
	         </form>
	    </div>
	    <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
   
</div>
<!-- 结束模态框 -->
<script>
	function uploadImg() {
		//document.updateUser.action = FileUploadServlet;
		//document.updateUser.submit();
		var user_id = document.getElementById("user_id").value;
		var form = document.forms['updateUser'];
		form.action = "FileUploadServlet?user_id=" + user_id;
		form.enctype = "multipart/form-data";
		form.submit();
	}
	
	
	function checkpwd() {
		//var pwd1 = document.getElementById("inputPassword1");
		//var pwd2 = document.getElementById("inputPassword2");
		//var user_id = updateUser.user_id.value;
		var user_id = document.getElementById("user_id").value;
		var pwd1 = changePassword.user_password1.value;
		var pwd2 = changePassword.user_password2.value;
		var pwd3 = changePassword.user_password3.value;
		var password = updateUser.user_password.value;
		var pwd1_encrypt = calcMD5(pwd1);
		var div1 = document.getElementById("tishi");
		var div2 = document.getElementById("tishi2");
		if(pwd1_encrypt != password){
			div1.style.visibility = "visible";
			div2.style.visibility = "hidden";
			return false
		}if (pwd2!= pwd3) {
			div2.style.visibility = "visible";
			div1.style.visibility = "hidden";
			return false;
		} else {
			div1.style.visibility = "hidden";
			div2.style.visibility = "hidden";
			document.changePassword.action = "ChangePasswordServlet?user_id=" + user_id; 
			document.changePassword.submit(); 
			return true;
		}
	}
</script>
</html>