<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bean.Boardbean"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
  	String nowPage = request.getParameter("nowPage");
  	
 	Boardbean bean = (Boardbean) session.getAttribute("bean");
 	String subject = bean.getSubject();
  	String name = bean.getName(); 
  	String content = bean.getContent();
  	
  	request.setCharacterEncoding("UTF-8");
	String alertmsg = (String)request.getAttribute("alert");
	
	System.out.println(alertmsg);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
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
	href="${pageContext.request.contextPath}/css/portfolio_update_style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
	<%if(alertmsg != null){%>
		alert("<%=alertmsg%>");
	<%}%>
</script>
</head>
<body class="body">
	<div id="main" class="container_12">
		<div align="center">
			<h1>Circle Board</h1>
			<br />
			<form name="updateFrm" method="post" action="board_update.do">
				<table cellpadding="3" align="center">
					<tr>
						<td align=center>
							<table id="maintable">
								<tr>
									<td width="10%">글쓴이</td>
									<td width="90%"><input name="name" value="<%=name%>">
									</td>
								</tr>
								<tr>
									<td>제 목</td>
									<td>
										<input name="subject" value="<%=subject%>">
									</td>
								</tr>
								<tr>
									<td>내 용</td>
									<td>
										<textarea id="se2" name="content" rows="40" cols="120">
											<%=content%>
										</textarea>
									</td>
								</tr>
								<tr>
									<td>비밀 번호</td>
									<td><input type="password" name="pass"> 수정 시에는 비밀번호가 필요합니다.</td>
								</tr>
								<tr>
									<td colspan="2">
										<input id="submit_button" type="button" value="등록">
										<input type="reset" value="다시쓰기">
										<a class="location" value="board_load.do" href="#"><p>리스트</p></a>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
				<input type="hidden" name="num" value="<%=num%>">
			</form>
		</div>
	</div>
</body>
<script>
	$(document).ready(function() {
		var oEditors = [];
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors, 
			elPlaceHolder: "se2", 
			sSkinURI: "se2/SmartEditor2Skin.html", 
			fCreator: "createSEditor2"
		});
		
		$("#submit_button").click(function(){
	    	oEditors.getById["se2"].exec("UPDATE_CONTENTS_FIELD", []);
	    	check();
		})
	});
	
	function check() {
	   if (document.updateFrm.pass.value == "") {
		 alert("수정을 위해 패스워드를 입력하세요.");
		 document.updateFrm.pass.focus();
		 return false;
		 }
	   document.updateFrm.submit();
	}
	
	//글 수정
	$(document).on("click","#submit_button",function(){
		var formdata = $("form[name='updateFrm']").serialize();
		
		$('#mainframe').empty;
       	$('#mainframe').load("board_update.do",{"formdata": formdata});
    })
</script>
</html>
