
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Boardbean"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//페이지정보 수신
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	//게시물정보 수신
	int num = (int)request.getAttribute("num");
	String name = (String)request.getAttribute("name");
	String subject = (String)request.getAttribute("subject");
	String regdate = (String)request.getAttribute("regdate");
	String content = (String)request.getAttribute("content");
	String filename = (String)request.getAttribute("filename");
	int filesize = (int)request.getAttribute("filesize");
	String ip = (String)request.getAttribute("ip");
	int count = (int)request.getAttribute("count");

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
	href="${pageContext.request.contextPath}/css/portfolio_read_style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">
<link href="style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	function list() {
		$('#mainframe').empty;
		$('#mainframe').load("board_load.do",{"nowPage": "<%=nowPage%>" , "keyField": "<%=keyField%>", "keyWord": "<%=keyWord%>"});
	}

	function down(filename) {
		document.downFrm.filename.value = filename;
		document.downFrm.submit();
	}
	
</script>

</head>
<body class="body">
	<div id="main" class="container_12">
		<br />
		<h1>게시물 열람</h1>
		<!-- <h1>Circle Board</h1> -->
		<table id="maintable" cellpadding="3" cellspacing="0" width="100%">
			<tr>
				<td width="10%">이름</td>
				<td><%=name%></td>
				<td width="10%">등록날짜</td>
				<td><%=regdate%></td>
			</tr>
			<tr>
				<td width="10%">제목</td>
				<td colspan="3"><%=subject%></td>
			</tr>
			<tr>
				<td colspan="4">
					<br /> 
					<pre id="content">
						<%=content%>
					</pre>
					<br />
				</td>
			</tr>
			<tr>
				<td width="10%">첨부파일</td>
				<td colspan="3">
					<%
						if (filename != null && !filename.equals("")) {
					%> <a href="javascript:down('<%=filename%>')"><%=filename%></a>
					&nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)
				</font> <%
 				} else {
 					%> 등록된 파일이 없습니다.<%
 				}%>
				</td>
			</tr>
		</table>
		<hr />
		
		[ <a href="javascript:list()">리스트</a>
		| <a class="location" value="circle_board_update.jsp?nowPage=<%=nowPage%>&num=<%=num%>" href="#">수 정</a>
		| <a class="location" value="circle_board_reply.jsp?nowPage=<%=nowPage%>" href="#">답 변</a> 
		| <a class="location" value="circle_board_delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>" href="#">삭 제</a>
		] <br />

		<form name="downFrm" action="portfolio_download.jsp" method="post">
			<input type="hidden" name="filename">
		</form>

		<form name="listFrm" method="post" action="board_load.do">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<%
				if (!(keyWord == null || keyWord.equals(""))) {
			%>
			<input type="hidden" name="keyField" value="<%=keyField%>"> 
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%
				}
			%>
		</form>
	</div>
</body>
</html>
