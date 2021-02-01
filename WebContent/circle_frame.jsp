<%@page import="bean.Listbean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 
	//세션에서 기본정보 로드
	request.setCharacterEncoding("UTF-8");
 	String location = (String)request.getAttribute("location");
 	if(location == null){
 		location = "main_load.do";
 	}
	String id = (String)session.getAttribute("idKey");
	
	//리스트 정보 및 기타 정보로드
	String mostrecommendedurl = (String)session.getAttribute("mostrecommendedurl"); //List가 아니라 url형태의 String객체임
	
	//검토
	System.out.print("프레임 로드" + mostrecommendedurl);
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
	<jsp:include page="circle_header.jsp" flush="false"/>
	
	<div>
		<div id="mainframe"></div>
	</div>
	
	<jsp:include page="circle_footer.jsp" flush="false">
		<jsp:param name="mostrecommended" value="<%=mostrecommendedurl%>"/>
	</jsp:include>	
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
	
	function searchOpen(){
		var searcharea = document.getElementById("searcharea");
		searcharea.classList.add("active");
	}
	
	function searchClose(){
		var searcharea = document.getElementById("searcharea");
		searcharea.classList.remove("active");
	}
	
	
	</script>
</html>