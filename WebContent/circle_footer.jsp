<%@page import="basic.ThumbJsonParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	ThumbJsonParser thumb = new ThumbJsonParser();

	String mostrecommendedurl = (String)session.getAttribute("mostrecommendedurl");
	String thumburl = thumb.getJson("https://www.googleapis.com/youtube/v3/playlists?id=" + mostrecommendedurl
	+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4");

	//검토
	System.out.print("푸터1" + mostrecommendedurl);
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
	href="${pageContext.request.contextPath}/css/portfolio_find_idpw_result_style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">

</head>

<body>
	<div id="palyer-area">
		<div id="player"></div>
	</div>
	<div id="footer">
		<div id="left-controller">
			<button type="button" onclick="prevsong();">이전</button>
			<button type="button" onclick="playsong();">재생</button>
			<button type="button" onclick="nextsong();">다음</button>
		</div>
		<div id="middle-controller">
			<img src="<%=thumburl%>">
		</div>
	    <div id="right-controller">
		   <a href="#">셔플</a>
		   <a href="#">볼륨</a>
		   <a href="#">플레이어열기</a>
	    </div>
    </div>
</body>
<script>
      var tag = document.createElement('script');
      tag.src = "https://www.youtube.com/iframe_api";
      
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      var player;
      function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
          height: '100%',
          width: '100%',
       	  playerVars: {
	        	autoplay: '1',
	        	listType: 'playlist',
	        	list: '<%=mostrecommendedurl%>',
	      }
        });
      }
      
      function playsong(){
    	  if(player.getPlayerState() == 1){
    		  player.pauseVideo();
    	  }else{
    		  player.playVideo();
    	  }
   		  console.log(player.getPlayerState());
      }
      
      function prevsong(){
    	  player.previousVideo();
      }
      
      function nextsong(){
   		  player.nextVideo();
      }
      
</script>
</html>

