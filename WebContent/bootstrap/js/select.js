var xhr;
//根据不同浏览器创建xhr对象的函数  
function creatXHR() {
	if (typeof (XMLHttpRequest) != "undefined") {
		return new XMLHttpRequest(); //针对IE7及四大浏览器  
	} else if (typeof ActiveXObject != "undefined") {
		if (typeof arguments.callee.activeXString != "string") {
			var versions = [ "MSXML2.XMLHttp.6.0", "MSXML2.XMLHttp.3.0",
					"MSXML2.XMLHttp" ];
			for (var i = 0, len = versions.length; i < len; i++) {
				try {
					var xhr = new ActiveXObject(versions[i]);//针对IE7以下版本  
					arguments.callee.activeXString = versions[i];
					return xhr;
				} catch (e) {
					//TODO handle the exception  
				}
			}
		}
		return new ActiveXObject(arguments.callee.activeXString);
	} else {
		throw new Error("No XHR object available");
	}
}
//当第一个下拉框的选项发生改变时调用该函数   
function changeSelect() {
	var selectCourse1 = document.getElementById('selectCourse1').value;
	var url = "SelectServlet?id=" + encodeURI(selectCourse1);
	xhr = creatXHR();
	if (xhr) {
		xhr.open("GET", url, true);
		//指定回调函数为callback   
		xhr.onreadystatechange = callback;
		xhr.send(null);
	}
}
//回调函数   
function callback() {
	if (xhr.readyState == 4) {
		if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
			parseMessage();
		} else {
			alert("Request was unsuccessful:" + xhr.status);
		}
	}
}
//解析返回xml的函数  
function parseMessage() {
	var xmlDoc = xhr.responseXML.documentElement;//获得返回的XML文档   
	var xSel = xmlDoc.getElementsByTagName('select'); //获得XML文档中的所有<select>标记   
	var select_root = document.getElementById('selectCourse2'); //获得网页中的第二个下拉框   
	select_root.options.length = 0; //每次获得新的数据的时候先把每二个下拉框架的长度清0   
	for (var i = 0; i < xSel.length; i++) {
		var xValue = xSel[i].childNodes[0].firstChild.nodeValue; //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值   
		var xText = xSel[i].childNodes[1].firstChild.nodeValue; //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值   
		var option = new Option(xText, xValue); //根据每组value和text标记的值创建一个option对象    
		select_root.add(option);//将option对象添加到第二个下拉框中   
	}
}