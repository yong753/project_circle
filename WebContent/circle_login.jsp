<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>960 Grid System &mdash; Demo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/text.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portfolio_common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portfolio_main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portfolio_login_style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
    
</head>
<body class="body">
    <div class="container_12">
        <div id="login-menu" class="prefix_1 grid_10 suffix_1">
            <fieldset>
                <legend>
                    <p>로그인</p>
                </legend>
                <form name="loginform" method="post" action="member_login.do">
                	<input name="id" placeholder="아이디"><br/>
					<input type="password" name="pw" placeholder="비밀번호"><br/>
					<input type="submit" value="로그인">
				</form>
				<a href="#"><p>아직 회원이 아니신가요?</p></a>
                <a href="#"><p>아이디 혹은 비밀번호를 잊으셨나요?</p></a>
            </fieldset>
        </div>
    </div>
</body>
</html>
