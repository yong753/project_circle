<%@ page contentType="text/html; charset=EUC-KR"%>
<%@page import="bean.Boardbean"%>
<%
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	request.setCharacterEncoding("UTF-8");
	String alertmsg = (String)request.getAttribute("alert");
%>

<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	<%if(alertmsg != null){%>
		alert("<%=alertmsg%>");
	<%}%>
</script>
</head>
<body class="body">
	<div align="center">
		<br/><br/>
		<table width="600" cellpadding="3">
			<tr>
				<td bgcolor=#dddddd height="21" align="center">
					������� ��й�ȣ�� �Է����ּ���.
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="board_delete.do">
			<table width="600" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td align="center">
									<input type="password" name="pass" size="17" maxlength="15">
								</td>
							</tr>
							<tr>
								<td><hr size="1" color="#eeeeee"/></td>
							</tr>
							<tr>
								<td align="center">
									<input id="submit_button" type="button" value="�����Ϸ�"> 
									<input type="reset" value="�ٽþ���">
									<input type="button" value="�ڷ�" onClick="history.go(-1)">
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
</body>
<script>
	//�� ���
	$(document).on("click","#submit_button",function(){
		if (document.delFrm.pass.value == "") {
			alert("�н����带 �Է��ϼ���.");
			document.delFrm.pass.focus();
			return false;
		}
		
		var formdata = $("form[name='delFrm']").serialize();
		
		$('#mainframe').empty;
       	$('#mainframe').load("board_delete.do",{"formdata": formdata});
    })
</script>
</html>