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
	<div id="headerframe">
		<jsp:include page="circle_header.jsp"/>
	</div>
	
	<div>
		<div id="mainframe"></div>
	</div>
	
	<div id="footerframe">
		<jsp:include page="circle_footer.jsp"/>
	</div>
	
	<script>
		//메인페이지 로드
		$(document).ready(function(e) {
			$('#mainframe').empty;
	       	$('#mainframe').load("<%=location%>");
		})
	       	
      	//검색어 저장
    	$(document).on("propertychange change keyup paste input","#search-value",function() {
    		keyword = $(this).val();
            console.log(keyword);
    	})
    	
    	//검색
    	$(document).on("click","#search-button", function(){
    		$('#mainframe').empty;
    	    $('#mainframe').load("search_load.do",{"keyword":keyword});
    	})
    	
    	//페이지로드 이벤트
       $(document).on("click",".location",function(){
        	var location = $(this).attr("value");
        	console.log(location);
        	
        	$('#mainframe').empty;
           	$('#mainframe').load(location);
        });
    	
    	//플레이리스트 변경
    	$(document).on("click",".playlist",function(){
    		console.log($(this).attr("value"));
    		console.log($(this).attr("name"));
    		
        	$.ajax({
        		type : "POST",
        		url : "playlist_change_action.do",
        		data : {"playlisturl": $(this).attr("value"), "playlisttitle": $(this).attr("name") },
        		success : function(){
        			alert('플레이리스트 변경 성공');
        			location.reload()
        		}, error : function(){
        			alert('플레이리스트 변경 실패')
        		}
        	})
        })
	</script>
</body>
</html>