<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	String location = (String)request.getAttribute("location");
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main Page</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/circle_frame.css" />
</head>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<body>
	<jsp:include page="circle_header.jsp" />
	
	<div id="mainframe">
	</div>
	
	<jsp:include page="circle_footer.jsp" />
</body>
	<script>
	$(document).ready(function(e) {
		//getPage 함수정의
	    function getPage(location){
           	$('#mainframe').load(location);
		}
		
		//페이지 로드
		getPage('<%=location%>');		
		
		//헤더 - 페이지로드 이벤트
	    $(".location").click(function(){
	    	getPage($(this).attr("value"));
	    })
	});
	</script>
</html>