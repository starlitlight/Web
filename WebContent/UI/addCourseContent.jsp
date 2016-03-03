<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.ifilmo.domain.User"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_editor.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_style.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/code_view.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image_manager.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/table.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>

	<%@ include file="/UI/head.jsp"%>

	<div class="row">
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
									<li><a href="#" data-toggle="collapse"><%=third_catalogue.getT_name() %></a>
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
			<div id="buttons">
			    <button id="init">打开编辑器 </button>
			    <button id="destroy">关闭编辑器</button>
			</div>
			<section id="editor">
				<form class="form-horizontal" action="AddCourseContentServlet" name="addcourse" method="post">
      				<textarea id="edit" name="edit" style="margin-top: 30px;">
     				</textarea>
     				<input type="submit" value="保存" class="btn btn-primary pull-right">
      			</form>
  			</section>
		</div>
	</div>
</body>
<!-- END BODY -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/mode/xml/xml.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/froala_editor.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/align.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/code_beautifier.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/image.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/image_manager.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/link.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/lists.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/paragraph_format.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/paragraph_style.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/table.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/video.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/url.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/entities.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/font_size.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/font_family.min.js"></script>
<!-- 生成html代码
<script type="text/javascript" src="<%=request.getContextPath() %>/editor/js/plugins/code_view.min.js"></script>
 -->


<script>
$(function(){
    $('#edit').froalaEditor({
      tableResizerOffset: 10
    })
});
    
$(function(){
	$('#init').on('click', function(e) {
    console.log("Initializing Froala Editor...");
    $('#edit').removeClass('fr-view').froalaEditor();
  })
  $('#destroy').on('click', function (e) {
    console.log("Destroying Froala Editor...");
    $('#edit').froalaEditor('destroy');
    $('#edit').addClass('fr-view');
  });
});
  </script>

</html>