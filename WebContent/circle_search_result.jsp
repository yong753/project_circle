<%@page import="bean.Listbean"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="basic.ThumbJsonParser"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="javax.net.ssl.HttpsURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.List"%>
<%@page import="bean.FavoriteListbean"%>
<%@page import="com.google.gson.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	
	/* String keyword = (String)request.getAttribute("keyword"); */
	String keyword = (String)request.getAttribute("keyword");
	List<Listbean> searchlist = (List<Listbean>)request.getAttribute("searchlist");
	Listbean data = new Listbean();
	
	System.out.println("keyword2=" + keyword);
	
	String[] playlisturl = new String[8];
	String[] title = new String[8];
	String[] thumburl = new String[8];
	String[] address_url = new String[8];
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
	href="${pageContext.request.contextPath}/css/portfolio_search_result_style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">
</head>

<body class="body">
	<div class="container_12">
		<div id="personal">
			<div id="recent-title" class="grid_12">
				<h1>"<%=keyword%>" 검색결과</h1>
			</div>
			<div id="search" class="grid_12">

				<%
					if(searchlist != null){
							for (int i = 0; i < searchlist.size(); i++) {
							playlisturl[i] = searchlist.get(i).getUrl();
							title[i] = searchlist.get(i).getTitle();
							address_url[i] = "player_load.do?url=" + playlisturl[i] + "&title=" + title[i];
						}
						for (int i = 0; i < searchlist.size(); i++) {
							ThumbJsonParser aaa = new ThumbJsonParser();
							thumburl[i] = aaa.getJson("https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl[i]
							+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4");
						}
						for (int i = 0; i < searchlist.size(); i++) {
							if (i % 4 == 0) {
				%>
				<div id="" class="grid_3 alpha">
					<a class="playlist" name="<%=title[i]%>" value="<%=playlisturl[i]%>" href="#"> 
						<img src=<%=thumburl[i]%>>
					</a>
					<div class="desc">
						<div class="title"><%=title[i]%></div>
					</div>
				</div>
				<%
					} else if (i % 4 == 3) {
				%>
				<div id="" class="grid_3 omega">
					<a class="playlist" name="<%=title[i]%>" value="<%=playlisturl[i]%>" href="#">
						<img src=<%=thumburl[i]%>>
					</a>
					<div class="desc">
						<div class="title"><%=title[i]%></div>
					</div>
				</div>
				<%
					} else {
				%>
				<div id="" class="grid_3">
					<a class="playlist" name="<%=title[i]%>" value="<%=playlisturl[i]%>" href="#">
						<img src=<%=thumburl[i]%>>
					</a>
					<div class="desc">
						<div class="title"><%=title[i]%></div>
					</div>
				</div>
				<%
					}
				}
				}else{
					%><h1>검색 결과가 없습니다.</h1><%
				}
				%>
			</div>
			
		</div>
	</div>
</body>
</html>
