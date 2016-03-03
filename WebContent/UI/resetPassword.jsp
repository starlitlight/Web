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
									<li><a href="#" data-toggle="collapse"><%=third_catalogue.getT_name() %></a></li>
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
<%
			User user_info = (User)request.getAttribute("user");
			int id = user_info.getUser_id();
%>
			<div class="col-md-8">
				<div class="row" style="padding-top: 60px; padding-left: 60px">
					<!-- left column -->
					<form class="form-horizontal" name="resetPassword" method="post" onsubmit="return resetPwd()">
						<div class="form-group">
							<label> 输入新密码:</label>
							<input name="user_id" id="user_id" value="<%=id %>" type="hidden"/>
							<input type="password" id="inputPassword1" name="user_password1" class="input-style" placeholder="新密码" required autofocus>
	            		</div>
	            		<div class="form-group">
	            			<label>确认新密码: </label>
	            			<input type="password" id="inputPassword2" name="user_password2" class="input-style" placeholder="确认新密码" required>
	            		</div>
	            		<div class="form-group">
	            			<div id="wrongPwd" style="color:red; visibility:hidden;">两次密码不一致!请重新输入</div>
	            		</div>
	            		<div class="form-group">
	            			<button class="btn btn-lg btn-primary" type="submit">确认</button>
	            			<button class="btn btn-lg btn-primary" type="reset">重设</button>
	            		</div>
					</form>
				</div>
			</div>
		</div>
</body>
<script>
function resetPwd(){
		var pwd1 = resetPassword.user_password1.value;
		var pwd2 = resetPassword.user_password2.value;
		var div1 = document.getElementById("wrongPwd");
		if (pwd1!= pwd2) {
			div1.style.visibility = "visible";
			return false;
		} else {
			div1.style.visibility = "hidden";
			document.resetPassword.action = "PasswordServlet"; 
			document.resetPassword.submit(); 
			alert("重设密码成功");
			return true;
			
		}
	}
</script>
</html>