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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_editor.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/froala_style.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/code_view.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/image.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/colors.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/editor/css/plugins/table.css">
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
						User user_catalogue = (User)session.getAttribute("user");
	                    CatalogueDAO cataloguedao = new CatalogueDAOImpl();
						List<First_catalogue> first_catalogues = cataloguedao.findFirst_catalogue();
						//超级管理员身份
						if(user.getRole()==3){
						if(first_catalogues!=null){
							for(First_catalogue first_catalogue : first_catalogues){
%>
				<li>
					<a href="#<%=first_catalogue.getF_name()%>" class="menu-first" data-toggle="collapse"><%=first_catalogue.getF_name() %>
						<i class="pull-left fa fa-sort-desc"></i>
						<a href="DeleteFirst_catalogueServlet?course_name=<%=first_catalogue.getF_name() %>" onclick="return delete_confirm()">
							<i  class="fa fa-times"></i></a>
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
								<a href="DeleteSecond_catalogueServlet?course_name=<%=second_catalogue.getS_name() %>" onclick="return delete_confirm()">
								<i class="fa fa-times"></i></a>
							</li>
								<ul id="<%=second_catalogue.getS_name() %>" class="collapse menu-third">
								<% 
									List<Third_catalogue> third_catalogues = cataloguedao.findThird_catalogueBys_id(second_catalogue.getS_id());
									for(Third_catalogue third_catalogue : third_catalogues){
								%>
									<li>
										<a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>&&role=<%=user.getRole()%>"><%=third_catalogue.getT_name() %></a>
										<a href="DeleteThird_catalogueServlet?course_name=<%=third_catalogue.getT_name() %>" onclick="return delete_confirm()">
											<i class="fa fa-times"></i>
										</a>
									</li>
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
						//管理员和普通用户身份
						}else{
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
									<li><a href="ShowCourseServlet?t_id=<%=third_catalogue.getT_id() %>&&role=<%=user.getRole()%>">
											<%=third_catalogue.getT_name() %>
										</a>
									</li>
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
					<div class="col-md-8"></div>
                	<a href="PreviewCourseServlet?t_id=<%=t_id %>" class="btn btn-warning" 
                		style="background-color:#fff; color:#eea236; padding-top:3px;">预览</a>
                	<button class="btn btn-warning" type="reset" style="background-color:#fff; color:#eea236">取消</button>
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

<script>
  
  function delete_confirm() {
      var msg = "您确定要删除该目录吗？";
      if (confirm(msg)==true){
        return true;
      }else{
        return false;
      }
  }
    $(function(){
      $('#edit').froalaEditor({
        toolbarButtons: ['undo', 'redo', '|', 'fontFamily', 'fontSize', 'bold', 'italic', 'underline', 'color', '|', 'formatOL', 'formatUL', 'paragraphFormat', 'indent', 'outdent', 'align', '|', 'insertTable', 'insertImage', 'insertVideo'],
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