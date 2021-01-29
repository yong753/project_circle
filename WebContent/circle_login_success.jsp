<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	request.setCharacterEncoding("EUC-KR");
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
    
</head>

<body class="body">
    <div class="container_12">
        <div id="login-menu" class="prefix_1 grid_10 suffix_1">
            <fieldset>
                <legend>
                    <p>�α���</p>
                </legend>
                
                <p>�α��� �Ǿ����ϴ�.</p>
                <p><%=id %>�� ȯ���մϴ�.</p>
                <a href="goto_action.do?location=main_load.do">
                <input type="button" value="Ȩ����"></a>
            </fieldset>
        </div>
    </div>
</body></html>
