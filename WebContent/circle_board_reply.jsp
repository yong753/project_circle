<%@page import="bean.Boardbean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String nowPage = request.getParameter("nowPage");
	Boardbean bean = (Boardbean) session.getAttribute("bean");
	String name = bean.getName();
	String subject = bean.getSubject();
	String content = bean.getContent();
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

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
<script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>

</head>
<body class="body">
	<div id="main" class="container_12">
		<div align="center">
			<h1>Circle Board</h1>
			<br />
			<form name="replyFrm" method="post" action="board_reply.do">
				<table cellpadding="3" align="center">
					<tr>
						<td align=center>
							<table id="maintable">
								<tr>
									<td width="10%">글쓴이</td>
									<td width="90%"><input name="name" value=<%=name%>>
									</td>
								</tr>
								<tr>
									<td>제 목</td>
									<td><input name="subject" value="답변 : <%=subject%>"></td>
								</tr>
								<tr>
									<td>내 용</td>
									<td>
										<textarea id="se2" name="content" rows="40" cols="120">
										<%=content%>
										========답변 글을 쓰세요.=======
      									</textarea>
      								</td>
								</tr>
								<tr>
									<td>비밀 번호</td>
									<td><input type="password" name="pass"></td>
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
				<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
				<input type="hidden" name="ref" value="<%=bean.getRef()%>"> 
				<input type="hidden" name="pos" value="<%=bean.getPos()%>"> 
				<input type="hidden" name="depth" value="<%=bean.getDepth()%>">
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
        	//id가 smarteditor인 textarea에 에디터에서 대입
        	oEditors.getById["se2"].exec("UPDATE_CONTENTS_FIELD", []);
        	inputCheck();
    	})
	});

	function inputCheck() {
		if (document.replyFrm.subject.value == "") {
			alert("제목을 입력해 주세요.");
			document.replyFrm.subject.focus();
			return;
		}
		if (document.replyFrm.content.value == "") {
			alert("내용을 입력해 주세요.");
			document.replyFrm.content.focus();
			return;
		}
		if (document.replyFrm.pass.value == "") {
			alert("비밀번호 입력해 주세요.");
			document.replyFrm.pass.focus();
			return;
		}
	}
	
	//글 등록
	$(document).on("click","#submit_button",function(){
		inputCheck()
		
		var formdata = $("form[name='replyFrm']").serialize();
		
		$('#mainframe').empty;
       	$('#mainframe').load("board_reply.do",{"formdata": formdata});
    })
</script>
</html>


