<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="java.io.File"%>

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
			CatalogueDAO  cataloguedao = new CatalogueDAOImpl();
			Catalogue_table catalogue= cataloguedao.selectCatalogue();
			if(catalogue!=null){
				String table = catalogue.getContent();
%>
			<input name="userRole" id="userRole" value="<%=user.getRole()%>" type="hidden"/>
			<%=table%>
<% 
			}else{
				System.out.println("读取目录失败");
			}
%>			
				</div>
			</div>
<%
			User user_info = (User)request.getAttribute("user");
%>
			<div class="col-md-8">
				<div class="row user_info" style="margin-top:20px; margin-left:5px">
					<!-- left column -->
					<form role="form" action="UpdateUserServlet" name="updateUser" method="post">
						<div class="form-group">
							<div class="col-md-1"></div>
							<h3>账户设置:</h3>
							<hr class="hr_style"></hr>
						</div>
						<%
								String path = request.getContextPath() + File.separator + "images" + File.separator + user_info.getPhoto();
								System.out.println("上传头像路径：" + path);
								
							%>
						<div class="form-group row">
							<div class="col-md-1"></div>
							<label class="col-md-2 form-control-label">头像:</label>
							<div class="col-md-3">
								<input name="user_id" id="user_id" value="<%=user_info.getUser_id()%>" type="hidden"/>
								<img src="<%=path %>" onerror="showPhoto()" class="avatar img-circle img-thumbnail" alt="">
								<input name="photo" id="photo" value="<%=user_info.getPhoto() %>" type="hidden"/>
					        </div>
					        <div class="col-md-6">
					        	<br/>
					        	<br/>
					        	<input name="file" type="file" size="20" style="display:none;" />
					        	<a href="javascript:fn_browse();"><span class="choosePhoto">选择图片</span></a>
					        	<p class="uploadFileFont">(最大尺寸1MB, JPG, GIF或PNG.)</p>
					            <input type="button" class= "btn btn-warning" onclick="uploadImg()" value="上传" />
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-1"></div>
							<label class="col-md-2 form-control-label">用户名:</label>
							<div class="col-md-6">
								<input name="user_name" class="form-control" value="<%=user_info.getUser_name()%>" type="text" readonly>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-1"></div>
							<label class="col-md-2 control-label">性别:</label>
							<div class="col-md-6">
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
						<div class="form-group row">
							<div class="col-md-1"></div>
							<label class="col-md-2 control-label">邮箱:</label>
							<div class="col-md-6">
								<input class="form-control" name="email" value="<%=user_info.getEmail()%>"
									type="text">
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-1"></div>
							<label class="col-md-2 control-label">密码:</label>
							<div class="col-md-6">
								<input class="form-control" style="float: left" name="user_password" type="password" 
									value="<%=user_info.getUser_password()%>" readonly>
							</div>
							<div class="col-md-2 changepassword">
								<a class="password" data-toggle="modal" data-target="#changPassword">更改密码</a>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-3"></div>
							<div class="col-md-9">
								<input class="btn btn-warning" value="保存" type="submit"/>   
								<input class="btn btn-warning" style="background-color:#fff; color:#eea236" value="取消" type="reset"/>
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
	            <h4 class="modal-title" id="myModalLabel" >更改密码</h4>
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

function fn_browse() 
{ 
	document.updateUser.file.click(); 
	document.updateUser.file.value = document.all.updateUser.file.value; 
}

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

function showPhoto(){
	var img=event.srcElement;
	img.src="bootstrap/images/default.png";
	img.onerror=null; //取消它的onerror事件
}
</script>
</html>