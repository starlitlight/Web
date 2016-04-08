<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" 
"http://www.w3.org/TR/html4/frameset.dtd">
<html>

<!-- BEGIN HEAD -->
<head>
<title>爱影</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=request.getContextPath() %>/bootstrap/css/login.css" rel="stylesheet">

</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>
	<%@ include file="/UI/head.jsp"%>
		<div class="row" style="margin-top: 60px;">
			<div class="col-md-12">
				<section class="login-form">
					<form method="post" action="LoginServlet" role="login">
						<img class="login-logo" style="margin-left: 130px" src="bootstrap/images/logoOrange.png" />
						<p class="login-heading">欢迎来到爱影培训平台</p>
						<input type="text" name="user_name" placeholder="用户名" oninvalid="this.setCustomValidity('请输入用户名')"
							required="" class="form-control input-lg" autofocus="" /> 
						<input type="password" name="user_password" placeholder="密码" oninvalid="this.setCustomValidity('请输入密码')"
							required="" class="form-control input-lg" /> 
						<a data-toggle="modal" data-target="#findPassword" class="primary" style="font-size: 14px">忘记密码</a>
						<button type="submit" class="btn btn-lg btn-block btn-primary">登陆</button>
					</form>
				</section>
			</div>
		</div>
</body>
<!-- END BODY -->

</html>