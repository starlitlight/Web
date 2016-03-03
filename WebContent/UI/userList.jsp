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
<link href="bootstrap/css/user_list.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/bootstrap/js/paging.js"></script>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>

<%@ include file="/UI/head.jsp"%>

<div class="row" style="margin-top: 20px;">
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
									<li><a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>">
									<%=third_catalogue.getT_name() %></a></li>
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
	
</script>
</html>