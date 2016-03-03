function displayPage() {
	if (curPage <= 1 && direct == -1) {
		direct = 0;
		alert("已经是第一页了");
		return;
	} else if (curPage >= page && direct == 1) {
		direct = 0;
		alert("已经是最后一页了");
		return;
	}

	lastPage = curPage;

	// 修复当len=1时，curPage计算得0的bug
	if (len > pageSize) {
		curPage = ((curPage + direct + len) % len);
	} else {
		curPage = 1;
	}

	document.getElementById("btn0").innerHTML = "当前 " + curPage + "/" + page
			+ " 页    每页 "; // 显示当前多少页

	begin = (curPage - 1) * pageSize + 1; // 起始记录号
	end = begin + 1 * pageSize - 1; // 末尾记录号

	if (end > len)
		end = len;
	$("#mytable tr").hide(); // 首先，设置这行为隐藏
	$("#mytable tr").each(function(i) { // 然后，通过条件判断决定本行是否恢复显示
		if ((i >= begin && i <= end) || i == 0) //显示begin<=x<=end的记录
			$(this).show();
	});

}