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
<link href="bootstrap/css/new_course.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<link href="<%=request.getContextPath() %>/bootstrap/css/font-awesome.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_editor.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_style.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/char_counter.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/code_view.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/colors.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/file.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/fullscreen.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image_manager.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/line_breaker.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/quick_insert.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/table.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/video.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
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
		<div class="row" style="padding-top: 20px; padding-left:60px;"> 
			<form role="form" class="newCourse" action="addCourseContentServlet" method="post">
				<div class="form-group">
					<div class="col-md-9"></div>
                	<a href="PreviewCourseServlet?t_id=<%=t_id %>" class="btn btn-warning" 
                		style="background-color:#fff; color:#eea236; padding-top:3px;">预览</a>
                		<!--  
                	<button class="btn btn-warning" type="reset" style="background-color:#fff; color:#eea236">取消</button>
                	-->
					<button class="btn btn-warning" type="submit">保存</button>
				</div>
				<div class="form-group">
					
					<textarea id='edit' name="edit" class="fr-view">
				  		<input name="t_id" value="<%=t_id%>" type="hidden"/>
				  		<%=tc.getT_content() %>
					</textarea>
				</div>
			</form>
		</div>
	</div>
  

  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/mode/xml/xml.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/froala_editor.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/code_beautifier.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/code_beautifier.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/code_view.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/font_size.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/font_family.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/lists.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/image.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/link.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/video.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/align.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/paragraph_format.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/colors.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/table.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/fullscreen.min.js"></script>

<script>
    $(function(){
      $('#edit').froalaEditor({
        toolbarButtons: ['fullscreen','undo', 'redo', '|', 'fontFamily', 'fontSize', 'bold', 'italic', 'underline', 'color', '|', 'formatOL', 'formatUL', 'paragraphFormat', 'indent', 'outdent', 'align', '|', 'insertTable', 'insertImage', 'insertVideo'],
        // Colors list.
        colorsBackground: [
          '#15E67F', '#E3DE8C', '#D8A076', '#D83762', '#76B6D8', 'REMOVE',
          '#1C7A90', '#249CB8', '#4ABED9', '#FBD75B', '#FBE571', '#FFFFFF'
        ],
        colorsDefaultTab: 'background',
        colorsStep: 6,
        colorsText: [
          '#15E67F', '#E3DE8C', '#D8A076', '#D83762', '#76B6D8', 'REMOVE',
          '#1C7A90', '#249CB8', '#4ABED9', '#FBD75B', '#FBE571', '#FFFFFF'
        ]
      })
    });
</script>
</body>
</html>