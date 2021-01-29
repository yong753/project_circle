<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<div id="player">
		    <script>
		      // 2. This code loads the IFrame Player API code asynchronously.
		      var tag = document.createElement('script');
		      tag.src = "https://www.youtube.com/iframe_api";
		      
		      var firstScriptTag = document.getElementsByTagName('script')[0];
		      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
		
		      // 3. This function creates an <iframe> (and YouTube player)
		      //    after the API code downloads.
		      var player;
		      function onYouTubeIframeAPIReady() {
		        player = new YT.Player('player', {
		          height: '300',
		          width: '300',
		          playerVars: {
		        	'autoplay': 1,
		        	'listType': 'playlist',
		        	'list': 'PLSj7ATinfRH0BrXMbZU8IMvGlhf2ad51q'
		          },
		          events: {
		              'onReady': onPlayerReady,
		          }
		        });
		      }
		      
		      function onPlayerReady(event) {
		          event.target.playVideo();
		        }
		    </script>
	    </div>
</body>
</html>
