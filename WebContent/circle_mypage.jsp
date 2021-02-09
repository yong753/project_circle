<%@page import="dao.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	
	//회원정보 가져오기.
	String name = (String)request.getAttribute("name");
	String email = (String)request.getAttribute("email");
	String address = (String)request.getAttribute("address");
	
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/portfolio_mypage.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">

</head>

<body class="body">
	<div class="container_12">
		<div id="mypage-menu" class="prefix_1 grid_10 suffix_1">
			<fieldset>
				<legend>
					<p>회원 정보</p>
				</legend>
				<form method="post" action="member_updateaddress.do">
					<table>
						<tr>
							<td><p>이름</p></td>
							<td><p><%=name%></p></td>
							<td></td>
						</tr>
						<tr>
							<td><p>아이디</p></td>
							<td><p><%=id%></p></td>
							<td></td>
						</tr>
						<tr>
							<td><p>메일주소</p></td>
							<td><p><%=email%></p></td>
							<td></td>
						</tr>
						<tr>
							<td><p>주소</p></td>
							<td><p><%=address%></p></td>
							<td>
								<input type="button" id="postcodify_search_button" value="주소변경"> 
								
							</td>
						</tr>
						<tr>
							<td><p>새 주소</p></td>
							<td colspan="2">
								<input type="text" name="address1" class="postcodify_address" value=""> 
								<input type="text" placeholder="상세주소입력" name="address2" class="postcodify_details" value="">
							</td>
						</tr>
						<tr>
							<td><p>비밀번호</p></td>
							<td colspan="2"><a class="location" value="circle_update_pw_prev_load.do" href="#"><input type="button" value="비밀번호변경"></a></td>
						</tr>
					</table>
					<input id="submit_button" type="submit" value="변경 완료">
					<a class="location" value="main_load.do" id="cancel_button" href="#"><p>취소</p></a>
				</form>
			</fieldset>
		</div>
		<!-- jQuery와 Postcodify를 로딩한다 -->
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
		<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

		<!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
		<script>
			$(function() {
				$("#postcodify_search_button").postcodifyPopUp();
			});
		</script>
	</div>
</body>
</html>
