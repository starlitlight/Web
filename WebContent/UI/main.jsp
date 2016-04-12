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
					<form role="login" name="userLoginForm" >
						<img class="login-logo" style="margin-left: 130px" src="bootstrap/images/logoOrange.png" />
						<p class="login-heading">欢迎来到爱影培训平台</p>
						<input type="text" id="user_nameLogin" placeholder="用户名" oninvalid="this.setCustomValidity('请输入用户名')"
							required="" class="form-control input-lg" autofocus="" /> 
						<input type="password" id="user_passwordLogin" placeholder="密码" oninvalid="this.setCustomValidity('请输入密码')"
							required="" class="form-control input-lg" /> 
						<div id="checkLogin" style="color:red; visibility:hidden;">用户名密码密码不正确!请重新输入</div>
						<a data-toggle="modal" data-target="#findPassword" class="primary" style="font-size: 14px">忘记密码</a>
						<button onclick="userLogin()" type="button" class="btn btn-lg btn-block btn-primary">登陆</button>
						
					</form>
				</section>
			</div>
		</div>
</body>
<!-- END BODY -->
<script type="text/javascript">
function userLogin(){
	
	var userName = $('#user_nameLogin').val();
	var password = $('#user_passwordLogin').val();
	alert(userName + password);
	if(userName =="" || password == ""){
		alert("用户名密码不能为空，请重新输入！");
		return false;
	}else{
	var userInfo={"user_name": userName, "user_password": password};
	$.ajax({
		type: "post",
		url: "CheckLoginServlet",
		data: userInfo,
		dataType: "json",
		success: function(data){
			var msg = data.message;
			if(msg=="successful"){
				var checkLogin = document.getElementById("checkLogin");
				checkLogin.style.visibility = "hidden";
				document.userLoginForm.method = "post";
				document.userLoginForm.action = "LoginServlet?user_name=" + userName + " &user_password=" + password; 
				document.userLoginForm.submit();
			}else{
				var checkLogin = document.getElementById("checkLogin");
				checkLogin.style.visibility = "visible";
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