<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.ifilmo.domain.User"%>
<%@page import="com.ifilmo.domain.Catalogue_table"%>
<%@page import="com.ifilmo.domain.First_catalogue"%>
<%@page import="com.ifilmo.domain.Second_catalogue"%>
<%@page import="com.ifilmo.domain.Third_catalogue"%>
<%@page import="com.ifilmo.dao.*"%>
<%@page import="com.ifilmo.dao.impl.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" 
"http://www.w3.org/TR/html4/frameset.dtd">
<html>

<!-- BEGIN HEAD -->
<head>

<title>爱影</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="icon" type='image/png' href="<%=request.getContextPath() %>/bootstrap/images/logoOrange.png">
<link href="<%=request.getContextPath() %>/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/bootstrap/css/font-awesome.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/bootstrap/css/head.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/bootstrap/css/main.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/bootstrap/js/jquery.js"></script>
<script src="<%=request.getContextPath() %>/bootstrap/js/bootstrap.js"></script>
<script src="<%=request.getContextPath() %>/bootstrap/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/bootstrap/js/catalogue.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<%
	User user = (User)session.getAttribute("user");

%>
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="row">
			<div class="col-md-3">
				<a href="MainServlet"><img class="logo" src="<%=request.getContextPath() %>/bootstrap/images/logo_ifilmo.png" /></a>
			</div>
			<div class="col-md-6">
				<ul class="nav navbar-nav">
	                 <li><a class="login-font">全部课程</a></li>
                </ul>
				<ul class="nav navbar-nav">
	                <form class="navbar-form navbar-left" role="search" name="search" action="searchCourseServlet" method="post">
	                    <div class="form-group">
	                        <input type="text" name="keyword" style="width:300px" class="form-control" placeholder="搜索你感兴趣的课程">
	                        <a href="javascript:void(document.search.submit())" class="navbar-link">
	                        	<span class="fa fa-search fa-lg" aria-hidden="true"></span>
	                        </a>
	                    </div>
	                </form>
				</ul>
			</div>
			<div class="col-md-3">
				<ul class="nav navbar-nav">
<% 
						if(user==null){
%>
					<li><span class="fa fa-user" aria-hidden="true"></span></li>
					<li><a class="login-font" data-toggle="modal">登陆</a></li>
<% 
						//普通用户
						}else if(user.getRole()==1){
%>
						<li><span class="fa fa-user" aria-hidden="true"></span></li>
						<li class="dropdown user">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown"> <span class="login-font"><%=user.getUser_name() %></span>
								<i class="fa fa-sort-desc"></i>
							</a>
							<ul class="dropdown-menu">
								<li><a href="UserAccountServlet?user_id=<%=user.getUser_id() %>" class="dropdown-list"><i class="fa fa-info"></i>
									账户设置</a></li>
								<li><a href="LogoutServlet" class="dropdown-list"><i class="fa fa-sign-out"></i> 退出登录</a></li>
							</ul>
						</li>
<%
						//管理员用户
						}else if(user.getRole()==2){
%>
					<li><a href="showAddCourseServlet" style="color:red; font-size:18px;">添加课程/目录</a></li>
					<li><span class="fa fa-user" aria-hidden="true"></span></li>
					<li class="dropdown user"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <span class="login-font"><%=user.getUser_name() %></span>
							<i class="fa fa-sort-desc"></i>
						</a>
						<ul class="dropdown-menu">
							<li><a href="UserAccountServlet?user_id=<%=user.getUser_id() %>"><i class="fa fa-info"></i> 账户设置</a></li>
							<li><a data-toggle="modal" data-target="#addUser"><i
										class="fa fa-user-plus"></i> 添加新用户</a></li>
							<li><a href="FindAllUserServlet"><i class="fa fa-users"></i> 查看用户信息</a></li>
							<li><a href="#" onclick="changeTable()"><i class="fa fa-pencil-square-o"></i> 修改目录</a></li>
							<li><a href="LogoutServlet"><i class="fa fa-sign-out"></i> 退出登录</a></li>
						</ul>
					</li>
<% 
						//超级管理员
						}else if(user.getRole()==3){
%>
					<li><a href="showAddCourseServlet" style="color:red; font-size:18px;">添加课程/目录</a></li>
					<li><span class="fa fa-user" aria-hidden="true"></span></li>
					<li class="dropdown user"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <span class="username"><%=user.getUser_name() %></span>
							<i class="fa fa-sort-desc"></i>
						</a>
						<ul class="dropdown-menu">
							<li><a href="UserAccountServlet?user_id=<%=user.getUser_id() %>"><i class="fa fa-info"></i> 账户设置</a></li>
							<li><a data-toggle="modal" data-target="#addUser2"><i
								class="fa fa-user-plus"></i> 添加新用户</a></li>
							<li><a href="FindAllUserServlet"><i class="fa fa-users"></i> 查看用户群组</a></li>
							<li><a href="#" onclick="changeTable()"><i class="fa fa-pencil-square-o"></i> 修改目录</a></li>
							<li><a href="#" onclick="visibleDeleteIcon()"><i class="fa fa-remove"></i> 删除目录</a></li>
							<li><a href="LogoutServlet"><i class="fa fa-sign-out"></i> 退出登录</a></li>
						</ul>
					</li>
<% 
						}
%>
				</ul>
			</div>
		</div>
	</nav>
</body>

<!-- 模态框 用户登录 -->
<div class="modal fade" id="userLogin" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;" data-backdrop="static" data-keyboard="ture">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<img class="login-logo" src="bootstrap/images/logoOrange.png" />
				<h2 class="login-heading">欢迎来到爱影培训平台!</h2>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="LoginServlet" method="post"
					id="login">
					<input class="input-style" type="text" class="form-control"
						name="user_name" placeholder="用户名" required="" autofocus="" /> <input
						class="input-style" type="password" class="form-control"
						name="user_password" placeholder="密码" required="" />
					<div>
						<p class="forgotPass">
							<a data-toggle="modal" data-target="#findPassword" class="fontsize">忘记密码</a>
						</p>
					</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-lg btn-primary btn-block" type="submit">登陆</button>
			</div>
				</form>
		</div>
	</div>
</div>
<!-- 关闭模态框 -->

<!-- 模态框 找回密码 -->
<div class="modal fade" id="findPassword" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;" data-backdrop="static" data-keyboard="ture">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<img class="login-logo" src="bootstrap/images/logoOrange.png" />
				<h2 class="login-heading">欢迎来到爱影培训平台!</h2>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="EmailServlet" method="post"
					id="login">
					<input class="input-style" type="text" class="form-control"
						name="email" placeholder="请输入注册邮箱" required="" autofocus="" /> 
			</div>
			<div class="modal-footer">
				<button class="btn btn-lg btn-primary btn-block" type="submit">发送重置密码链接到邮箱</button>
			</div>
				</form>
		</div>
	</div>
</div>
<!-- 关闭模态框 -->

<!-- 模态框 添加新用户 -->
<div class="modal fade" id="addUser" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;" data-backdrop="static" data-keyboard="ture">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加新用户</h4>
				</div>
				<div class="modal-body">
					<form name="AddUser">
						<tr>
							<input type="text" id="user_nameManager" class="input-style"
								placeholder="用户名">
						</tr>
						<tr>
							<input type="password" id="user_passwordManager" class="input-style"
								placeholder="初始密码">
						</tr>
						<tr>
							<input type="text" id="emailManager" class="input-style"
								placeholder="邮箱">
						</tr>
						<tr>
							<div id="checkUserNameEmailManager" style="color:red; visibility:hidden">用户名或者邮箱已存在，请重新输入!</div>
						</tr>
						<tr>
							<p class="authority">权限</p>
							<input class="authority" type="radio" name="role" value="1"
								checked /> 只读
						</tr>
				</div>
				<div class="modal-footer">
					<button class="btn btn-lg btn-primary btn-block" type="button" onclick="addNewUser()">添加用户</button>
				</div>
			</div>
		</div>
	</form>
	<!-- /.modal-dialog -->
</div>
<!-- 关闭模态框 -->

<!-- 模态框 添加新用户Admin-->
<div class="modal fade" id="addUser2" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;" data-backdrop="static" data-keyboard="ture">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加新用户</h4>
				</div>
				<div class="modal-body">
				<form name="AddUserAdmin">
					<tr>
						<input type="text" id="user_nameAdmin" class="input-style"
							placeholder="用户名" required="" autofocus>
					</tr>
					<tr>
						<input type="password" id="user_passwordAdmin" class="input-style"
							placeholder="初始密码">
					</tr>
					<tr>
						<input type="text" id="emailAdmin" class="input-style"
							placeholder="邮箱">
					</tr>
					<tr>
						<div id="checkUserNameEmail" style="color:red; visibility:hidden">用户名或者邮箱已存在，请重新输入!</div>
					</tr>
					<tr>
						<p class="authority">权限</p>
						<input class="authority" type="radio" name="role" value="1" /> 只读
						<input class="authority" type="radio" name="role" value="2" /> 编辑
						
					</tr>
				</div>
				<div class="modal-footer">
					<button class="btn btn-lg btn-primary btn-block" type="button" onclick="addNewUserAdmin()" >添加用户</button>
				</div>
			</div>
			
			<!-- /.modal-content -->
		</div>
	</form>
	<!-- /.modal-dialog -->
</div>
<!-- 关闭模态框 -->

<script type="text/javascript">
function addNewUserAdmin(){
	
	var userName = $('#user_nameAdmin').val();
	var password = $('#user_passwordAdmin').val();
	var email = $('#emailAdmin').val();
	var role = AddUserAdmin.role.value;
	
	if(userName == "" || password==""){
		alert("用户名密码不能为空，请重新输入！");
		return false;
	}else if(email == ""){
		alert("邮箱不能为空，请重新输入！");
		return false;
	}else if(role == ""){
		alert("权限不能为空，请重新输入！");
		return false;
	}else{
	var userInfo={"user_name": userName, "email": email};
	$.ajax({
		type: "post",
		url: "CheckUserServlet",
		data: userInfo,
		dataType: "json",
		success: function(data){
			var msg = data.message;
			if(msg=="successful"){
				var checkUserNameEmail = document.getElementById("checkUserNameEmail");
				checkUserNameEmail.style.visibility = "visible";
				
			}else{
				alert("可以添加");
				var checkUserNameEmail = document.getElementById("checkUserNameEmail");
				checkUserNameEmail.style.visibility = "hidden";
				alert("判断成功");
				document.AddUserAdmin.method = "post";
				document.AddUserAdmin.action = "AddUserServlet?user_name=" + userName + " &user_password=" + password
						+" &email=" + email + " &role="  + role;
				document.AddUserAdmin.submit();
			}
		},
		error: function(err){
			alert("登陆失败");
		}
	});
	}
}

function addNewUser(){
	
	var userName = $('#user_nameManager').val();
	var password = $('#user_passwordManager').val();
	var email = $('#emailManager').val();
	var role = AddUser.role.value;
	
	if(userName == "" || password==""){
		alert("用户名密码不能为空，请重新输入！");
		return false;
	}else if(email == ""){
		alert("邮箱不能为空，请重新输入！");
		return false;
	}else if(role == ""){
		alert("权限不能为空，请重新输入！");
		return false;
	}else{
	var userInfo={"user_name": userName, "email": email};
	$.ajax({
		type: "post",
		url: "CheckUserServlet",
		data: userInfo,
		dataType: "json",
		success: function(data){
			var msg = data.message;
			if(msg=="successful"){
				var checkUserNameEmailManager = document.getElementById("checkUserNameEmailManager");
				checkUserNameEmailManager.style.visibility = "visible";
				
			}else{
				alert("可以添加");
				var checkUserNameEmailManager = document.getElementById("checkUserNameEmailManager");
				checkUserNameEmailManager.style.visibility = "hidden";
				alert("判断成功");
				document.AddUser.method = "post";
				document.AddUser.action = "AddUserServlet?user_name=" + userName + " &user_password=" + password
						+" &email=" + email + " &role="  + role;
				document.AddUser.submit();
			}
		},
		error: function(err){
			alert("登陆失败");
		}
	});
	}
}
</script>
</html>