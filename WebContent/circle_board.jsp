<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bean.Boardbean"%>
<%@page import="java.util.Vector"%>
<%
	request.setCharacterEncoding("UTF-8");

	//게시판 객체 로드
	Vector<Boardbean> vlist = (Vector<Boardbean>)request.getAttribute("vlist");
	Boardbean bean = null;
	
	String boardtype = (String)session.getAttribute("boardtype");
	
	int pagePerBlock = (int)request.getAttribute("pagePerBlock");
	int totalRecord = (int)request.getAttribute("totalRecord");
	int totalPage = (int)request.getAttribute("totalPage");
	int nowPage = (int)request.getAttribute("nowPage");
	int nowBlock = (int)request.getAttribute("nowBlock");
	int totalBlock = (int)request.getAttribute("totalBlock");
	int numPerPage = (int)request.getAttribute("numPerPage");
	String keyWord = (String)request.getAttribute("keyWord");
	String keyField = (String)request.getAttribute("keyField");

%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
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
	href="${pageContext.request.contextPath}/css/portfolio_board_style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">

<script type="text/javascript">
	function list() {
		document.listFrm.action = "board_load.do";
		document.listFrm.submit();
	}

	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}

	function block(value) {
		document.readFrm.nowPage.value = <%=pagePerBlock%> * (value - 1) + 1;
		document.readFrm.submit();
	}

	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "board_read_load.do";
		document.readFrm.submit();
	}

	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
</script>

</head>
<body class="body">
	<div id="board" class="container_12">
		<div align="center">
			<h1><%=boardtype %></h1>
			<br/>
			<p>
				Total : <%=totalRecord%>Articles(<font color="red"><%=nowPage%>/<%=totalPage%>Pages</font>)
			</p>
			<form method="post" action="board_load.do" name="notice">
				<input class="boardtype_button" type="submit" name="boardtype" value="공지사항">
			</form>
			<form method="post" action="board_load.do" name="board">
				<input class="boardtype_button" type="submit" name="boardtype" value="자유게시판">
			</form>
			<table align="center" width="600" cellpadding="3">
				<tr>
					<td align="center" colspan="2">
						<%
							int listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
							
							if (vlist.isEmpty()) {
								out.println("등록된 게시물이 없습니다.");
							}else{
						%>
						<table id="maintable" cellpadding="2" cellspacing="0">
							<tr>
								<th>번 호</th>
								<th>제 목</th>
								<th>이 름</th>
								<th>날 짜</th>
								<th>조회수</th>
							</tr>
							<%
							for (int i = 0; i < numPerPage; i++) {
								if (i == listSize)
									break;
								bean = vlist.get(i);
								int num = bean.getNum();
								String name = bean.getName();
								String subject = bean.getSubject();
								String regdate = bean.getRegdate().substring(0,10);
								int depth = bean.getDepth();
								int count = bean.getCount();
							%>
							<tr>
								<td align="center"><%=totalRecord - ((nowPage - 1) * numPerPage) - i%>
								</td>
								<td>
									<%
										if (depth > 0) {
										for (int j = 0; j < depth; j++) {
											out.println("&nbsp;&nbsp;");
										}
									}
									%> 
									<a href="javascript:read('<%=num%>')"><%=subject%></a>
								</td>
								<td align="center"><%=name%></td>
								<td align="center"><%=regdate%></td>
								<td align="center"><%=count%></td>
							</tr>
							<%
								} //for
							%>
						</table> 
						<%}%>
					</td>
				</tr>
				<tr>
					<td>
<!-- 페이징 및 블럭 처리 Start--> <%
 	int pageStart = (nowBlock - 1) * pagePerBlock + 1; //하단 페이지 시작번호
 	int pageEnd = ((pageStart + pagePerBlock) <= totalPage) ? (pageStart + pagePerBlock) : totalPage + 1;
 	
 	//하단 페이지 끝번호
 	if (totalPage != 0) {
	 	if (nowBlock > 1) {
	 		%> <a href="javascript:block('<%=nowBlock - 1%>')">prev...</a> <%
	 	}%>&nbsp; <%
	 	for (; pageStart < pageEnd; pageStart++) {
	 		%> <a href="javascript:pageing('<%=pageStart%>')"> <%
		 	if (pageStart == nowPage) {
		 		%><font color="blue"> <%
		 	}
		 	%> [<%=pageStart%>] <%
		 	if (pageStart == nowPage) {
		 		%></font> <%
		 	}
		 	%></a> <%
	 	} //for
	 	%>&nbsp; <%
	 	if (totalBlock > nowBlock) {
	 	%> <a href="javascript:block('<%=nowBlock + 1%>')">.....next</a> <%
	 	}
		 %>&nbsp; <%
 	}
 %> 
 <!-- 페이징 및 블럭 처리 End-->
					</td>
					<td id="write-menu" align="right">
						<a href="#" class="location" value="board_write_load.do">
							[글쓰기]
						</a> 
						<a href="javascript:list()">
							[처음으로]
						</a>
					</td>
				</tr>
			</table>
			<hr width="960px" />
			<form class="searchform" name="searchFrm" method="get" action="board_load.do">
				<table width="600" cellpadding="4" cellspacing="0">
					<tr>
						<td align="center" valign="bottom">
						<select name="keyField" size="1">
								<option value="name">이 름</option>
								<option value="subject">제 목</option>
								<option value="content">내 용</option>
						</select> 
						<input type="text" name="keyWord"> 
						<input type="button" value="찾기" onClick="javascript:check()"> 
						<input type="hidden" name="nowPage" value="1">
						<input type="hidden" name="boardtype" value="<%=boardtype%>">
						</td>
					</tr>
				</table>
			</form>
			<form name="listFrm" method="post">
				<input type="hidden" name="reload" value="true"> <input type="hidden" name="nowPage" value="1">
			</form>
			<form name="readFrm" method="get">
				<input type="hidden" name="num"> 
				<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
				<input type="hidden" name="keyField" value="<%=keyField%>">
				<input type="hidden"name="keyWord" value="<%=keyWord%>">
				<input type="hidden"name="boardtype" value="<%=boardtype%>">
			</form>
		</div>
	</div>
	
</body>
</html>
