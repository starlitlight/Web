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
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/bootstrap/images/logo_main.ico"/>
<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath() %>/bootstrap/images/logo_main.ico" />
<link href="bootstrap/css/user_list.css" rel="stylesheet">
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
		
	<div class="col-md-8">
		<div class="row" style="padding-top: 60px; padding-left:60px; ">
                <div id="toolbar">
                	<form id="searchUser" action="SearchUserServlet" method="post">
	                    <label class="myLabel-content">用户名：</label>
	                    <div class="myText-content">
	                        <input name="searchUser" type="text" class="form-control" placeholder="输入用户名">
	                    </div>
	                	<div class="myBtn-content">
	                   		<button id="search" type="submit" class="btn btn-primary">搜索</button>
	                	</div>
                	</form>
                </div>
					<!-- Table -->
				<table class="table">
<%
						User user_info = (User) request.getAttribute("user");
%>	
						<tr>
							<th style="cursor: hand;">用户ID</th>
							<th>用户名</th>
							<th>邮箱</th>
							<th>权限</th>
							<th></th>
						</tr>
						<tr onmouseover="this.bgColor='#E6EB00'"
							onmouseout="this.bgColor='white'">
							<td><%=user_info.getUser_id()%></td>
							<td><%=user_info.getUser_name()%></td>
							<td><%=user_info.getEmail()%></td>
							<td>只读</td>
						</tr>
				</table>
		</div>
	</div>
</div>
	


</body>
<!-- END BODY -->
<!-- 模态框 用户权限 -->
<div class="modal fade" id="power" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="UpdateRoleByUserId" action="UpdateRoleByUserIdServlet" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
					<h2 class="login-heading">用户权限</h2>
				</div>
				<div class="modal-body">
					<input type="hidden" id="id" type="text" name="user_id" />
						<input class="radio" type="radio" name="role" value="1" id="readonly" />只读
						<input class="radio" type="radio" name="role" value="2" id="edit" />编辑
				</div>
				<div class="modal-footer">
					<button class="btn btn-lg btn-primary btn-block" type="submit">确定</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 关闭模态框 -->
<script>
	function resume(obj){
		var tds=$(obj).parent().parent().find('td');
		if(tds.eq(3).text()=='只读'){
			$('#readonly').prop("checked",true);
			$('#edit').prop("checked",false);
		}else{
			$('#edit').prop("checked",true);
			$('#readonly').prop("checked",false);
			//$('#edit').attr("checked","checked");
			}
		$('#id').val(tds.eq(0).text())
		$('#role').val(tds.eq(3).text());
		//$('#role').val(tds.eq(0).text());
		$('#power').modal('show');
	}
	
	function show_confirm(){
		var r=confirm("确认要删除用户吗？");
		if(r==true){
			return true;
		}else{
			return false;
		}
	}
	
		
	
</script>
</html>