<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
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
	href="${pageContext.request.contextPath}/css/portfolio_write_style.css" />

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>

</head>
<body class="body">
	<div id="main" class="container_12">
		<div align="center">
			<h1>Circle Board</h1>
			<br />
			<form name="postFrm" method="post" action="board_write.do" enctype="multipart/form-data">
				<table cellpadding="3" align="center">
					<tr>
						<td align=center>
							<table id="maintable">
								<tr>
									<td width="10%">글쓴이</td>
									<td width="90%"><input name="name" value="<%=id%>">
									</td>
								</tr>
								<tr>
									<td>제 목</td>
									<td><input name="subject"></td>
								</tr>
								<tr>
									<td>내 용</td>
									<td>
										<textarea id="se2" name="content" rows="40"	cols="120">
										</textarea>
									</td>
								</tr>
								<tr>
									<td>비밀 번호</td>
									<td><input type="password" name="pass"></td>
								</tr>
								<tr>
									<td>파일찾기</td>
									<td><input type="file" name="filename"></td>
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
				<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			</form>
		</div>
	</div>
</body>

<script type="text/javascript">
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
        	inputCheck();
    	})
	});

	function inputCheck() {
		if (document.postFrm.subject.value == "") {
			alert("제목을 입력해 주세요.");
			document.postFrm.subject.focus();
			return;
		}
		if (document.postFrm.content.value == "") {
			alert("내용을 입력해 주세요.");
			document.postFrm.content.focus();
			return;
		}
		if (document.postFrm.pass.value == "") {
			alert("비밀번호 입력해 주세요.");
			document.postFrm.pass.focus();
			return;
		}
	}
	
	//글 등록
	$(document).on("click","#submit_button",function(){
		inputCheck()
		
		var formdata = $("form[name='postFrm']").serialize();
		
		$('#mainframe').empty;
       	$('#mainframe').load("board_write.do",{"formdata": formdata});
    })
</script>
</html>
