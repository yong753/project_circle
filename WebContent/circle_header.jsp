<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("idKey");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>960 Grid System &mdash; Demo</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/text.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/portfolio_common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/portfolio_main.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
function searchOpen(){
	var searcharea = document.getElementById("searcharea");
	searcharea.classList.add("active");
}

function searchClose(){
	var searcharea = document.getElementById("searcharea");
	searcharea.classList.remove("active");
}
</script>	

</head>
<body>
	<div id="header" class="grid_12">
		<div class="grid_5 alpha">
			<a class="location" value="main_load.do" href="#">
				<img src="https://www.flaticon.com/svg/static/icons/svg/459/459420.svg">
			</a>
			<a class="location" value="chart_load.do" href="#"><p>CHART</p></a> 
			<a class="location" value="library_load.do" href="#"><p>MY LIBRARY</p></a>
			<a class="location" value="board_load.do" href="#"><p>BOARD</p></a>
			<a class="location" value="search_load.do" href="#"><p onclick="searchOpen()">검색</p>
				<div id="searcharea"  class="search_area">
					<form method="post" action="search_load.do">
						<input type="text" name="keyword" placeholder="검색어를 입력하세요">
						<input type="submit" value="검색">
						<input type="button" onclick="searchClose()" value="X">
						<!-- 태그만 넘기면 됨.-->
					</form>
				</div>
			</a>
		</div>
		<div class="grid_4 omega">
			<a class="location" value="mypage_load.do" href="#">
				<p>MY PAGE</p> 
			</a> &nbsp;&nbsp;
			<%
				if (id != null) {%>
			<p><%=id%> / </p>
			<a class="location" value="member_logout.do" href='#'><p>LOGOUT</p></a>&nbsp;&nbsp;
			<%} else {%>
			<a class="location" value="login_load.do" href="#"><p>LOGIN</p></a>&nbsp;&nbsp;
			<%
				}
			%>
		</div>
	</div>
</body>
</html>