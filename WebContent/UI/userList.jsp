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
<script src="<%=request.getContextPath() %>/bootstrap/js/paging.js"></script>
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
		<div class="row" style="padding-top: 20px; padding-left:20px; ">
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
				<table class="table" id="mytable">
<%
						List<User> users = (List<User>) request.getAttribute("users");
%>	
						<tr>
							<th>用户ID</th>
							<th>用户名</th>
							<th>邮箱</th>
							<th>权限</th>
						</tr>
										
<%
							for (User user_list : users) {
								if (user.getRole() == 3 && user_list.getRole() != 3) {
%>
						<tr onmouseover="this.bgColor='#E6EB00'"
							onmouseout="this.bgColor='white'">
							<td><%=user_list.getUser_id()%></td>
							<td><%=user_list.getUser_name()%></td>
							<td><%=user_list.getEmail()%></td>
	
							<%
								if (user_list.getRole() == 2) {
							%>
							<td><a onclick="resume(this);">编辑</a></td>
							<%
								}
								if (user_list.getRole() == 1) {
							%>
							<td><a onclick="resume(this);">只读</a></td>
	
							<%
								}
							%>
							<td>
								<a href="DeleteUserServlet?user_id=<%=user_list.getUser_id()%>" onclick="return show_confirm()"><i class="fa fa-times"></i></a>
							</td>
						</tr>
						<%
							} else if (user.getRole() == 2 && user_list.getRole() == 1) {
						%>
						<tr onmouseover="this.bgColor='#E6EB00'"
							onmouseout="this.bgColor='white'">
							<td><%=user_list.getUser_id()%></td>
							<td><%=user_list.getUser_name()%></td>
							<td><%=user_list.getEmail()%></td>
							<td>只读</td>
						</tr>
						<%
							}
						}
						%>
				</table>
				<a id="btn0"></a>
					<input id="pageSize" type="text" size="1" maxlength="2" value="getDefaultValue()" />
					<a> 条 </a> 
					<a href="#" id="pageSizeSet">设置</a>&nbsp;
    				<a id="sjzl"></a>&nbsp;
    				<a href="#" id="btn1">首页</a>
				    <a href="#" id="btn2">上一页</a>
				    <a href="#" id="btn3">下一页</a>
				    <a href="#" id="btn4">尾页</a>&nbsp;
				    <a>转到&nbsp;</a>
				    <input id="changePage" type="text" size="1" maxlength="4" />
				    <a>页&nbsp;</a>
				    <a href="#" id="btn5">跳转</a>
		</div>
	</div>
</div>
	


</body>
<!-- END BODY -->
<!-- 模态框 用户权限 -->
<div class="modal fade" id="power" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="UpdateRoleByUserId" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
					<h2 class="login-heading">用户权限</h2>
				</div>
				<div class="modal-body">
						<input type="hidden" id="id" type="text" name="user_id" />
						<input class="radio" type="radio" name="roleAuthority" value="1" id="readonly" />只读
						<input class="radio" type="radio" name="roleAuthority" value="2" id="edit" />编辑
				</div>
				<div class="modal-footer">
					<button class="btn btn-lg btn-primary btn-block" type="button" onclick="changeAuthority()">确定</button>
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
			$('#edit').prop("checked",false);
			$('#readonly').prop("checked",true);
		}if(tds.eq(3).text()=='编辑'){
			$('#edit').prop("checked",true);
			$('#readonly').prop("checked",false);
			}
		$('#id').val(tds.eq(0).text())
		//$('.roleAuthority').val(tds.eq(3).text());
		//$('#role').val(tds.eq(0).text());
		$('#power').modal('show');
	}
	
	function show_confirm() {
	    var msg = "您确定要删除该用户吗？\n\n请确认！";
	    if (confirm(msg)==true){
	      return true;
	    }else{
	      return false;
	    }
	  }
	
	var pageSize = 11; //每页显示的记录条数
	var curPage = 0; //当前页
	var lastPage; //最后页
	var direct = 0; //方向
	var len; //总行数
	var page; //总页数
	var begin;
	var end;

	$(document).ready(
			function display() {
				len = $("#mytable tr").length - 1; // 求这个表的总行数，剔除第一行介绍
				page = len % pageSize == 0 ? len / pageSize : Math.floor(len
						/ pageSize) + 1; //根据记录条数，计算页数
				// alert("page==="+page);
				curPage = 1; // 设置当前为第一页
				displayPage(1); //显示第一页

				document.getElementById("btn0").innerHTML = "当前 " + curPage + "/"
						+ page + " 页    每页 "; // 显示当前多少页
				document.getElementById("sjzl").innerHTML = "数据总量 " + len + ""; // 显示数据量
				document.getElementById("pageSize").value = pageSize;

				$("#btn1").click(function firstPage() { // 首页
					curPage = 1;
					direct = 0;
					displayPage();
				});
				$("#btn2").click(function frontPage() { // 上一页
					direct = -1;
					displayPage();
				});
				$("#btn3").click(function nextPage() { // 下一页
					direct = 1;
					displayPage();
				});
				$("#btn4").click(function lastPage() { // 尾页
					curPage = page;
					direct = 0;
					displayPage();
				});
				$("#btn5").click(function changePage() { // 转页
					curPage = document.getElementById("changePage").value * 1;
					if (!/^[1-9]\d*$/.test(curPage)) {
						alert("请输入正整数");
						return;
					}
					if (curPage > page) {
						alert("超出数据页面");
						return;
					}
					direct = 0;
					displayPage();
				});

				$("#pageSizeSet").click(
						function setPageSize() { // 设置每页显示多少条记录
							pageSize = document.getElementById("pageSize").value; //每页显示的记录条数
							if (!/^[1-9]\d*$/.test(pageSize)) {
								alert("请输入正整数");
								return;
							}
							len = $("#mytable tr").length - 1;
							page = len % pageSize == 0 ? len / pageSize : Math
									.floor(len / pageSize) + 1; //根据记录条数，计算页数
							curPage = 1; //当前页
							direct = 0; //方向
							firstPage();
						});
			});	
	
	function changeAuthority(){
		var user_id = document.getElementById("id").value;
		//var role = $("input[name='roleAuthority'][checked]").val();
		var role = UpdateRoleByUserId.roleAuthority.value;
		
		
		var authority={"user_id": user_id, "role": role};
		$.ajax({
			type: "post",
			url: "UpdateRoleByUserIdServlet",
			data: authority,
			dataType: "json",
			success: function(data){
				alert(data.message);
			},
			error: function(err){
				alert(err.message);
			}
		});
	}
	
</script>
</html>