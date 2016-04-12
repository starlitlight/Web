function delete_confirm() {
    var msg = "您确定要删除该目录吗？";
    if (confirm(msg)==true){
      return true;
    }else{
      return false;
    }
}

function changeTable() {
	var saveSortTable = document.getElementById("saveSortTable");
	saveSortTable.style.visibility = "visible";
	var IDs = [];
	$(".nav-side-menu").find("div").each(function(){ 
		IDs.push(this.id);
		});
	//alert(IDs);
	alert("请修改目录顺序");
	for(i=0;i<IDs.length;i++){
	    var ids = "#" + IDs[i];
		$(ids).sortable({
	    	axis: 'y',
	    	containment: 'parent',
	    	tolerance: "pointer",
	    	opacity: 0.6, //设置拖动时候的透明度
	    	revert: true, //缓冲效果 
	        cursor: 'move', //拖动的时候鼠标样式 
	    });
	}
}

function saveTable() {
	var saveSortTable2 = document.getElementById("saveSortTable");
	saveSortTable2.style.visibility = "hidden";
    var saveHtml = $('.nav-side-menu').html();
    var table={"content": saveHtml}
    $.ajax({
		type: "post",
		data: table,
		url: "sortableServlet",
		dataType: "json",
		success: function(data){
		},
		error: function(err){
		}
	});
    var IDs = [];
	$(".nav-side-menu").find("div").each(function(){ 
		IDs.push(this.id);
		});
	for(i=0;i<IDs.length;i++){
		var ids = "#" + IDs[i];
		$(ids).sortable("disable");
	}
    alert("成功保存目录顺序");
}

function insertCourse() {
	
	var htmlCode = $('.nav-side-menu').html();
	//alert(htmlCode);
	var courseName = $("#courseName").val();
	if (courseName == 0 || courseName == null){
		document.getElementById("NewCourseName").style.visibility = "visible";
		return;
	}
	var selectCourse1 = $("#selectCourse1").val();
	var selectCourse1Name = $("#selectCourse1").find("option:selected").text();
	var selectCourse2 = $("#selectCourse2").val();
	var selectCourse2Name = $("#selectCourse2").find("option:selected").text();
	var insertCourse={"courseName": courseName, "selectCourse1": selectCourse1, "selectCourse2": selectCourse2};
	alert("courseName: " + courseName + "course1 value: " + selectCourse1 + " and course2 value: " + selectCourse2);
	
	var checkCourseName = {"courseName": courseName};
	$.ajax({
		type: "post",
		url: "CheckCourseNameServlet",
		data: checkCourseName,
		dataType: "json",
		success: function(data){
			if(data.message=="successful"){
				var checkCourseName = document.getElementById("checkCourseName");
				checkCourseName.style.visibility = "hidden";
				alert("课程名可用");
				if(selectCourse1==0 && selectCourse2==0){
					var htmlCode1 = "<li class='ui-sortable-handle'>"
			            + "<a href='#" + courseName + "' data-toggle='collapse'>" + courseName + "</a>" 
			            +"<a href='#' onclick='deleteCourse1(event)'>"  //deleteCourse1
			            +"<i name='deleteIcon' class='fa fa-times' id='Icon1" + courseName + "' style='visibility: hidden;'></i>"// id=Icon1
			            +"</a>"
			            +"<ul id='" + courseName + "' class='collapse'>"
			            +"<div id='sortable2" + courseName + "' class='menu-second'>"
			            +"</div>"
			            +"</ul>"
			            +"</li>";
					$("#sortable1").append(htmlCode1);
				    alert("添加一级目录成功");
				    $.ajax({
						type: "post",
						url: "addCourseServlet",
						data: insertCourse,
						dataType: "json",
						success: function(data){
						},
						error: function(err){
						}
					});
					saveTable();
				}
				if(selectCourse1!=0 && selectCourse2==0){
					var htmlCode2 = "<li class='ui-sortable-handle'>"
						+ "<a href='#" + courseName + "' data-toggle='collapse'>" + courseName + "</a>" 
						+"<a href='#' onclick='deleteCourse2(event)'>"  //deleteCourse2
						+"<i name='deleteIcon' class='fa fa-times' id='Icon2" + courseName + "' style='visibility: hidden;'></i>"// id=Icon2
						+"</a>"
						+"<ul id='" + courseName + "' class='collapse'>"
						+"<div id='sortable3" + courseName + "' class='menu-third ui-sortable'>"// id=sotable3
						+"</div>"
				        +"</ul>"
				        +"</li>";
					var courseLayer2 = "#sortable2" + selectCourse1Name;
					alert(courseLayer2);
					$(courseLayer2).append(htmlCode2);
					alert("添加二级目录成功");
					
					$.ajax({
						type: "post",
						url: "addCourseServlet",
						data: insertCourse,
						dataType: "json",
						success: function(data){
						},
						error: function(err){
						}
					});
					saveTable();
				}
				if(selectCourse1!=0 && selectCourse2!=0){
					var htmlCode3 = "<li class='ui-sortable-handle'>"
						+ "<a href='ShowCourseServlet?t_name=" + courseName + "'>" +  courseName + "</a>" 
						+"<a href='#' onclick='deleteCourse3(event)'>" //deleteCourse3
						+"<i name='deleteIcon' class='fa fa-times' id='Icon3" + courseName + "' style='visibility: hidden;'></i>"// id=Icon3
						+"</a>"
						+"</li>";
					var courseLayer3 = "#sortable3" + selectCourse2Name;
					alert(courseLayer3);
					$(courseLayer3).append(htmlCode3);
					alert("添加三级目录成功");
					$.ajax({
						type: "post",
						url: "addCourseServlet",
						data: insertCourse,
						dataType: "json",
						success: function(data){
						},
						error: function(err){
						}
					});
					saveTable();
				}
			}else{
				var checkCourseName = document.getElementById("checkCourseName");
				checkCourseName.style.visibility = "visible";
			}
		},
		
		error: function(err){
			alert("添加课程失败");
		}
	});
}

function visibleDeleteIcon(){
	alert("请删除目录功能");
	var iconValue = document.getElementsByName("deleteIcon");
	for(var i=0; i<iconValue.length;i++)
    {
        iconValue[i].style.visibility="visible";
    }
}

function deleteCourse1(event){
	if (delete_confirm()){
	    var deleteIconId = $(event.target).attr('id'); // 获取id
	    alert(deleteIconId);
	    $("#" + deleteIconId).parent().parent().remove(); //删除HTML中的课程
	    
	    var deleteCourseId = deleteIconId.replace(/Icon1/, ""); //去掉前缀Icon1
	    alert(deleteCourseId);
	    
		alert("删除一级目录课程成功");
		var iconValue = document.getElementsByName("deleteIcon");
		for(var i=0; i<iconValue.length;i++)
	    {
	        iconValue[i].style.visibility="hidden";
	    }
		//saveTable();  //保存当前HTML
	    
	    var delCourseName={"delCourseName": deleteCourseId};
		$.ajax({
			type: "post",
			url: "DeleteFirst_catalogueServlet",
			data: delCourseName,
			dataType: "json",
			success: function(data){
			},
			error: function(err){
			}
		});
		saveTable();
	}
}

function deleteCourse2(event){
	if (delete_confirm()){
	    var deleteIconId = $(event.target).attr('id'); // 获取id
	    alert(deleteIconId);
	    $("#" + deleteIconId).parent().parent().remove();//删除HTML中的课程
	    
	    var deleteCourseId = deleteIconId.replace(/Icon2/, ""); //去掉前缀Icon2
	    alert(deleteCourseId);
	    
	    alert("删除二级目录课程成功");
		var iconValue = document.getElementsByName("deleteIcon");
		for(var i=0; i<iconValue.length;i++)
	    {
	        iconValue[i].style.visibility="hidden";
	    }
	    
	    var delCourseName={"delCourseName": deleteCourseId};
		$.ajax({
			type: "post",
			url: "DeleteSecond_catalogueServlet",
			data: delCourseName,
			dataType: "json",
			success: function(data){
			},
			error: function(err){
			}
		});
	    saveTable();
	}
}

function deleteCourse3(event){
	if (delete_confirm()){
	    var deleteIconId = $(event.target).attr('id'); // 获取id
	    alert(deleteIconId);
	    $("#" + deleteIconId).parent().parent().remove(); //删除HTML中的课程
	    
	    var deleteCourseId = deleteIconId.replace(/Icon3/, ""); //去掉前缀Icon3
	    alert(deleteCourseId);
	    
	    alert("删除三级目录课程成功");
		var iconValue = document.getElementsByName("deleteIcon");
		for(var i=0; i<iconValue.length;i++)
	    {
	        iconValue[i].style.visibility="hidden";
	    }
	    
	    var delCourseName={"delCourseName": deleteCourseId};
		$.ajax({
			type: "post",
			url: "DeleteThird_catalogueServlet",
			data: delCourseName,
			dataType: "json",
			success: function(data){
			},
			error: function(err){
			}
		})
	    saveTable();
	}
}

function showCourse(){
	alert("进入showCourse");
	var name = $(event.target).html(); // 课程名称
	alert(name);
	var courseName = {"courseName": name};
	//var upperName = $(event.target).parent().parent().attr("id").replace(/sortable3/,"");
	//alert(upperName);
	
	
	$.ajax({
		type: "post",
		url: "ShowCourseServlet",
		data: courseName,
		dataType: "json",
		success: function(data){
			if(data=='success'){
				alter(1);
				window.location.href="showTable.jsp";
			}
			
		},
		error: function(err){
		}
	});
	
}