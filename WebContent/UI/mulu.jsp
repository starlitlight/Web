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
<script src="<%=request.getContextPath() %>/bootstrap/js/Sortable.js"></script>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>
	<%@ include file="/UI/head.jsp"%>
		<div class="row" style="margin-top: 60px;">
		<div class="col-md-3">
			<div class="nav-side-menu">
			<ul id="foo">
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
</ul>
                    </div>
		</div>

		</div>
	</div>
</body>

	<script>
		(function (){
			var console = window.console;

			if( !console.log ){
				console.log = function (){
					alert([].join.apply(arguments, ' '));
				};
			}


			window.x = new Sortable(foo, {
				group: "words",
				store: {
					get: function (sortable) {
						var order = localStorage.getItem(sortable.options.group);
						return order ? order.split('|') : [];
					},
					set: function (sortable) {
						var order = sortable.toArray();
						localStorage.setItem(sortable.options.group, order.join('|'));
					}
				},
				onAdd: function (evt){ console.log('onAdd.foo:', evt.item); },
				onUpdate: function (evt){ console.log('onUpdate.foo:', evt.item); },
				onRemove: function (evt){ console.log('onRemove.foo:', evt.item); },
				onStart:function(evt){ console.log('onStart.foo:',evt.item);},
				onEnd: function(evt){ console.log('onEnd.foo:', evt.item);}
			});


			new Sortable(bar, {
				group: "words",
				onAdd: function (evt){ console.log('onAdd.bar:', evt.item); },
				onUpdate: function (evt){ console.log('onUpdate.bar:', evt.item); },
				onRemove: function (evt){ console.log('onRemove.bar:', evt.item); },
				onStart:function(evt){ console.log('onStart.foo:', evt.item);},
				onEnd: function(evt){ console.log('onEnd.foo:', evt.item);}
			});


			new Sortable(multi, {
				draggable: '.tile',
				handle: '.tile__name'
			});


			[].forEach.call(multi.getElementsByClassName('tile__list'), function (el){
				new Sortable(el, { group: 'photo' });
			});
		})();
	</script>



</html>