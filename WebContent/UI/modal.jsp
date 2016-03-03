<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" 
"http://www.w3.org/TR/html4/frameset.dtd">
<html>

<!-- BEGIN HEAD -->
<head>
<title>爱影</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="bootstrap/css/font-awesome.css" rel="stylesheet">
<link href="bootstrap/css/head.css" rel="stylesheet">
<link href="bootstrap/css/main.css" rel="stylesheet">
<script src="bootstrap/js/jquery.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>

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
								<a href="#" class="fontsize">忘记密码</a>
							</p>
						</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-lg btn-primary btn-block" type="submit">登陆</button>
				</div>
				</form>
				</
			</div>
		</div>
	</div>
	<!-- 关闭模态框 -->

	<!-- 模态框 添加新用户 -->
	<div class="modal fade" id="addUser" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;" data-backdrop="static" data-keyboard="ture">
		<form action="AddUserServlet" name="AddUser" method="post">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">添加新用户</h4>
					</div>
					<div class="modal-body">
						<tr>
							<input type="text" name="user_name" class="input-style"
								placeholder="用户名" required autofocus>
						</tr>
						<tr>
							<input type="text" name="email" class="input-style"
								placeholder="邮箱" required>
						</tr>
						<tr>
							<input type="password" name="user_password" class="input-style"
								placeholder="初始密码" required>
						</tr>
						<tr>
							<p class="authority">权限</p>
							<input class="authority" type="radio" name="role" value="1"
								checked /> 只读
						</tr>
					</div>
					<div class="modal-footer">
						<button class="btn btn-lg btn-primary btn-block" type="submit">添加用户</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
		</form>
		<!-- /.modal-dialog -->
	</div>
	<!-- 关闭模态框 -->
</body>
</html>