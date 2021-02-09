<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>960 Grid System &mdash; Demo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/text.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portfolio_common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portfolio_main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portfolio_login_success_style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>

<body class="body">
    <div class="container_12">
        <div id="login-menu" class="prefix_1 grid_10 suffix_1">
            <fieldset>
                <legend>
                    <p>로그인</p>
                </legend>
                <p>로그인 되었습니다.</p>
                <p><%=id %>님 환영합니다.</p>
                <a class="location" value="main_load.do" href="#">
                <input type="button" value="홈으로"></a>
            </fieldset>
        </div>
    </div>
</body>
<script>
	$(document).ready(function(e) {
		$('#headerframe').empty;
		$('#totalrating').empty;
		$('#review').empty;
		
		$('#headerframe').load("circle_header.jsp");
	    $('#player-title').load("circle_footer.jsp #player-title > *");
	    $('#review').load("circle_footer.jsp #review > *");
	})
	
</script>

</html>
