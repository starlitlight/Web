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
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/bootstrap/images/logo_main.ico"/>
<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath() %>/bootstrap/images/logo_main.ico" />
<link href="bootstrap/css/new_course.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/wangEditor/dist/css/wangEditor.min.css">
<script src="<%=request.getContextPath()%>/wangEditor/dist/js/lib/jquery-1.10.2.min.js"></script>
<script src="<%=request.getContextPath()%>/wangEditor/dist/js/wangEditor.js"></script>
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
<%
				Third_catalogue tc = (Third_catalogue)request.getAttribute("third_catalogue");
				int t_id = tc.getT_id();
%>
	<div class="col-md-8">
		<div class="row" style="padding-top: 20px; padding-left:20px;"> 
			<form role="form" class="newCourse" action="addCourseContentServlet" method="post">
				<div class="form-group">
					<div class="col-md-9">
						<label class="form-label">课程名:</label>
						<input type="text" class="form-control" id="courseName" name="courseName" value="<%=tc.getT_name() %>" style="display:inline" readonly>
					</div>
                	<a href="PreviewCourseServlet?t_id=<%=t_id %>" class="btn btn-warning" 
                		style="background-color:#fff; color:#eea236; padding-top:3px;">预览</a>
					<button class="btn btn-warning" type="submit">保存</button>
				</div>
				<div class="form-group">
					<input name="t_id" value="<%=t_id%>" type="hidden"/>
					<textarea id="editor-trigger" name="edit" style="height:455px; width:90%;">
						<%=tc.getT_content() %>
					</textarea>
				</div>
			</form>
		</div>
	</div>
  </div>

<script type="text/javascript">
	// 阻止输出log
	// wangEditor.config.printLog = false;

	var editor = new wangEditor('editor-trigger');

	// 上传图片
	editor.config.uploadImgUrl = 'UploadImgServlet';

	// 表情显示项
	//editor.config.emotionsShow = 'value';

	// 跨域上传
	//editor.config.uploadImgUrl = 'http://localhost:8012/upload';

	// 第三方上传
	// editor.config.customUpload = true;

	// onchange 事件
	// editor.onchange = function () {
	//     console.log(this.$txt.html());
	// };

	// 取消过滤js
	//editor.config.jsFilter = false;

	// 取消粘贴过来
	// editor.config.pasteFilter = false;

	// 设置 z-index
	// editor.config.zindex = 20000;

	// 语言
	//editor.config.lang = wangEditor.langs['en'];

	//自定义菜单
	editor.config.menus = [ 
		'fullscreen', 
		'undo',
		'redo',
		'|',
		'fontfamily', 
		'fontsize', 
		'bold',
		'italic',
		'underline', 
		'bgcolor',
		'forecolor',
		'|',
		'orderlist',
		'lineheight',
		'indent',
		'unorderlist', 
		'alignleft',
		'aligncenter',
		'alignright',
		'|',
		'table',
		'img',
		'video',
		'source'
		];
	
	editor.create();
	$(function(){
	    //获取dom节点
	    var $uploadContainer = $('#uploadContainer'),
	            $fileList = $('#fileList'),
	          $btnUpload = $('#btnUpload');

	    var editor = wangEditor('editor-trigger')	;
	});
</script>
</body>
</html>