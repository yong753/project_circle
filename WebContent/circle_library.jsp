<%@page import="bean.Listbean"%>
<%@page import="bean.RecentListbean"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="basic.ThumbJsonParser"%>
<%@page import="java.util.List"%>
<%@page import="bean.FavoriteListbean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//세션에서 기본정보 로드
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	
	//리스트 로드
	List<Listbean> recentlist = (List<Listbean>)request.getAttribute("recentlist");
	List<Listbean> likedlist = (List<Listbean>)request.getAttribute("likedlist");
	
	//리스트 정보 추출을 위한 객체 생성
	String[] playlisturl = new String[16];
	String[] title = new String[16];
	String[] thumburl = new String[16];
	String[] address_url = new String[16];
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
	href="${pageContext.request.contextPath}/css/portfolio_personal_style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">
</head>

<body class="body">
	<div class="container_12">
		<div id="personal">
			<div id="recent-title" class="grid_12">
				<h1>RECENT SONGS</h1>
			</div>
			<div id="recent" class="grid_12">
				<div class="slidebox">
					<%
					if(recentlist != null){
						for (int i = 0; i < recentlist.size(); i++) {
							playlisturl[i] = recentlist.get(i).getUrl();
							title[i] = recentlist.get(i).getTitle();
							address_url[i] = "player_load.do?url=" + playlisturl[i] + "&title=" + title[i];
						}
						for (int i = 0; i < recentlist.size(); i++) {
							ThumbJsonParser aaa = new ThumbJsonParser();
							thumburl[i] = aaa.getJson("https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl[i]
							+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4");
						}
						for (int i = 0; i < recentlist.size(); i++) {
							%>
							<div class="grid_3">
								<a href="<%=address_url[i]%>"> <img src=<%=thumburl[i]%>>
								</a>
								<div class="desc">
									<div class="title"><%=title[i]%></div>
								</div>
							</div>
						<%} 
					}else{%>
						<h1>최근 감상한 플레이리스트가 없습니다.</h1>
					<%}%>
				</div>
				<span class="prev">&lt;</span>
				<span class="next">&gt;</span>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
				<script>
					$('.prev').click(function(){
						$('.slidebox > div:last').prependTo('.slidebox');
						$('.slidebox').css('margin-left',-170);
						$('.slidebox').stop().animate({marginLeft:-10},200)
					});
					$('.next').click(function(){
						$('.slidebox').stop().animate({marginLeft:-170},200, function(){
							$('.slidebox > div:first').appendTo('.slidebox');
							$('.slidebox').css({marginLeft:-10})
						})
					})
				</script>
			</div>
			<div id="chart-title" class="grid_12">
				<h1>LIKED SONGS</h1>
			</div>
			<div id="chart" class="grid_12">
				<%
					if(likedlist != null){
						for (int i = 0; i < likedlist.size(); i++) {
							playlisturl[i] = likedlist.get(i).getUrl();
							title[i] = likedlist.get(i).getTitle();
							address_url[i] = "player_load.do?url=" + playlisturl[i] + "&title=" + title[i];
						}

						for (int i = 0; i < likedlist.size(); i++) {
							ThumbJsonParser aaa = new ThumbJsonParser();
							thumburl[i] = aaa.getJson("https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl[i]
							+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4");
						}

						for (int i = 0; i < likedlist.size(); i++) {
							if (i % 4 == 0) {
								%>
								<div id="" class="grid_3 alpha">
									<a href="<%=address_url[i]%>"> <img src=<%=thumburl[i]%>>
									</a>
									<div class="desc">
										<div class="title"><%=title[i]%></div>
									</div>
								</div>
								<%
									} else if (i % 4 == 3) {
								%>
								<div id="" class="grid_3 omega">
									<a href="<%=address_url[i]%>"> <img src=<%=thumburl[i]%>>
									</a>
									<div class="desc">
										<div class="title"><%=title[i]%></div>
									</div>
								</div>
								<%
									} else {
								%>
								<div id="" class="grid_3">
									<a href="<%=address_url[i]%>"> <img src=<%=thumburl[i]%>>
									</a>
									<div class="desc">
										<div class="title"><%=title[i]%></div>
									</div>
								</div>
								<%
									}
						}
					}else{
					%>
						<h1>좋아요한 플레이리스트가 없습니다.</h1>
					<%
					}
					%>
			</div>
		</div>
	</div>
</body>
</html>
