<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="dao.PlayerDAO"%>
<%@page import="bean.ReviewListbean"%>
<%@page import="java.util.List"%>
<%@page import="basic.ThumbJsonParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//기본요소
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");

	//플레이리스트 관련 요소
	ThumbJsonParser thumb = new ThumbJsonParser();
	
	//playerloadaction
			//플레이리스트 객체 생성
			String playlisturl = (String)session.getAttribute("playlisturl");
			String playlisttitle = (String)session.getAttribute("playlisttitle");
			
			String thumburl = null;
			String desc = null;
			String dataurl = "https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl
					+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4";
			String dataurlitems = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=" + playlisturl
					+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4&maxResults=50";
			
			//pDAO객체 생성
			PlayerDAO pDAO = new PlayerDAO();
			
			//제목영역 정보 받아오기.
			ThumbJsonParser thumbjsonparser = new ThumbJsonParser();
			try {
				thumburl = thumbjsonparser.getJson("https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl
						+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4");
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				desc = thumbjsonparser.getDesc("https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl
						+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//좋아요 초기화
			boolean likebool = pDAO.getLikesInfo(playlisturl, id);
			
			//리뷰 영역 데이터받아오기
			int totalrating = pDAO.getTotalRating(playlisturl);
			List<ReviewListbean> reviewlist = pDAO.getReviewList(playlisturl);
			
			//리뷰 작성여부 확인
			boolean reviewbool = pDAO.checkReview(playlisturl,id);
			System.out.println("Reviewbool" + reviewbool);
			
	//리뷰리스트 정보 추출을 위한 객체 생성
	int[] rating = new int[20];
	String[] reviewid = new String[20];
	String[] content = new String[20];
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
	href="${pageContext.request.contextPath}/css/portfolio_player_style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/portfolio_main.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/portfolio_find_idpw_result_style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap"
	rel="stylesheet">

</head>
<body>
	<div id="player-area" class="">
	<div id="player-title">
		<img src="<%=thumburl%>">
		    <div class="like">
		        <h1><%=playlisttitle%></h1>
		        <p><%=desc%></p>
		        <!-- 좋아요 버튼  -->
		        <button type="button" id="like-button" class="">♥ Like</button>
		        <div id="totalrating">
		            <p> 플레이리스트 평점 : </p>
		            <p class="rating_<%=totalrating%>">
		                <%
								if(totalrating == 0){
									%>첫 번째 리뷰를 등록해주세요<%
								}
								%>
		            </p>
		        </div>
		        <input type="hidden" name="likechange" value="change">
		    </div>
	    </div>
		<div id="center">
	        <div id="contents-title">
	            <h1>플레이어 & 사용자리뷰 💿</h1>
	        </div>
            <div id="jacket">
                   <a href="#"> 
                   	<div id="player"></div> <!-- 플레이어로드 -->
                   	<script>
                    	var tag = document.createElement('script');
                        tag.src = "https://www.youtube.com/iframe_api";
                        
                        var firstScriptTag = document.getElementsByTagName('script')[0];
                        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

                        var player;
                        var isShuffle;
                        
                       	function onYouTubeIframeAPIReady() {
                           	player = new YT.Player('player', {
   	                            height: '400px',
   	                            width: '400px',
   	                         	playerVars: {
   	                  	        	autoplay: '1',
   	                  	        	listType: 'playlist',
   	                  	        	list: '<%=playlisturl%>',
   	                  	        	origin: 'http://localhost'
   	                  	      	},
                           		events: {
                                   	'onReady': onPlayerReady,
                           		}
                            });
                        }
                           
                           function playsong(){
                         	  if(player.getPlayerState() == 1){
                         		  player.pauseVideo();
                         		 $("#play-image").attr("src","css/imgs/play.png");
                         	  }else{
                         		  player.playVideo();
                         		 $("#play-image").attr("src","css/imgs/pause.png");
                         	  }
                        		  console.log(player.getPlayerState());
                           }
                           
                           function prevsong(){
                         	   player.previousVideo();
                           }
                           
                           function nextsong(){
                        	   player.nextVideo();
                           }
                           
                           function onPlayerReady(event) {
                               event.target.playVideo();
                           }
                           
                           function mutesong(){
	                          	if(player.isMuted()){
	                          		player.unMute();
	                          		$("#volume-image").attr("src","css/imgs/volume.png");
	                          	}else{
	                          		player.mute();
	                          		$("#volume-image").attr("src","css/imgs/mute.png");
	                          	}
                           }
                           
                           function shuffle(){
                        	   if(isShuffle){
                        		   player.setShuffle(false);
                        		   isShuffle = false;
                        	   }else{
                        		   player.setShuffle(true);
                            	   isShuffle = true;
                        	   }
                           }
                           
                           function timeinfo(){
                        	   var timeinfo;
                        	   var currenttime = player.getCurrentTime();
                        	   var duration = player.getDuration();
                        	   
                        	   timeinfo = currenttime + " / " + duration; 
                        	   
                        	   console.log(timeinfo);
                        	   $("#timeinfo").text(timeinfo);
                           }
                   	</script>
                   </a>
            </div>
	        <div id="review">
	            <form name="reviewFrm">
	                <div>
	                    <span class="star-input">
	                        <span class="input">
	                            <input type="radio" name="star-input" value="1" id="p1">
	                            <label for="p1">1</label>
	                            <input type="radio" name="star-input" value="2" id="p2">
	                            <label for="p2">2</label>
	                            <input type="radio" name="star-input" value="3" id="p3">
	                            <label for="p3">3</label>
	                            <input type="radio" name="star-input" value="4" id="p4">
	                            <label for="p4">4</label>
	                            <input type="radio" name="star-input" value="5" id="p5">
	                            <label for="p5">5</label>
	                        </span>
	                        <output for="star-input">
	                            <b>0</b>점
	                        </output>
	                    </span>
	                </div>
	                <div id="forminput">
	                    <input type="text" name="star-review" value="한 줄 평을 작성해주세요." id="oneline">
	                    <input type="button" value="등록" id="reviewsubmit-button">
	                    <input type="hidden" value="<%=playlisturl %>" name="playlisturl">
	                    <input type="hidden" value="<%=playlisttitle %>" name="playlisttitle">
	                </div>
	            </form>
	            <div id="reviewlist">
	                <ul>
	                    <%
						if(reviewlist == null){
	            			%><p>등록된 리뷰가 없습니다.</p>
	                    <%
	            		}else{
	            			for(int i=0; i<reviewlist.size(); i++){
	            				rating[i] = reviewlist.get(i).getRating();
	            				reviewid[i] = reviewlist.get(i).getId();
								content[i] = reviewlist.get(i).getContent();
	            			%><li>
	                        <p class="rating_<%=rating[i] %>"> </p>
	                        <p><%=reviewid[i] %></p>
	                        <p><%=content[i] %></p>
	                    </li>
	                    <%
	            		}}
					%>
	                </ul>
	            </div>
	        </div>
	    </div>
	</div>
	<div id="footer">
		<div id="left-controller">
			<button onclick="prevsong();"><img src="css/imgs/next.png"></button>
			<button onclick="playsong();"><img id=play-image src="css/imgs/pause.png"></button>
			<button onclick="nextsong();"><img src="css/imgs/next.png"></button>
		</div>
		<div id="middle-controller">
			<img src="<%=thumburl%>">
			<p><%=playlisttitle %></p>
		</div>
	    <div id="right-controller">
		   <button onclick="shuffle();"><img src="css/imgs/shuffle.png"></button>
		   <button onclick="mutesong();"><img id=volume-image src="css/imgs/volume.png"></button>
		   <button onclick="playerOpen()"><img src="css/imgs/expand.png"></button>
	    </div>
    </div>
</body>
<script>
	      //리뷰 제출
	      var id = "<%=id%>";
	      
	      $(document).on("click","#reviewsubmit-button",function() {
	    	  if(id == "null"){
        		  alert("로그인 해주세요.")
        	  }else{
		          var formdata = $("form[name=reviewFrm]").serialize();
		          $.ajax({
		              url: "review_submit.do",
		              type: "POST",
		              data: formdata,
		              success: function() {
		            	  <%
		            	  totalrating = pDAO.getTotalRating(playlisturl);
		      			  reviewlist = pDAO.getReviewList(playlisturl);
		            	  %>
		            	  
		            	  $('#totalrating').empty;
		                  $('#totalrating').load("circle_footer.jsp #totalrating > *");
		                  
		            	  $('#review').empty;
		                  $('#review').load("circle_footer.jsp #review > *");
		              },
		              error: function() {
		                  alert("Error")
		              }
		          })
        	  }
	      });
	      
		  //리뷰 작성여부 판단
	      if (<%= reviewbool %>) {
	          $("#forminput input").attr("disabled", true);
	          $("#oneline").attr("value", "이미 리뷰를 등록하셨습니다.");
	      };
	      
          //좋아요 판별 해서 버튼 css 변경
          $(document).ready(function() {
              if ( <%= likebool %> ) {
                  $("#like-button").attr("class", "active");
              }
          })

          //좋아요 작동
          $(document).on("click","#like-button",function() {
        	  if(id == "null"){
        		  alert("로그인 해주세요.")
        	  }else{
        		  $.ajax({
                      url: "playlist_like.do",
                      type: "POST",
                      data: {
                          playlisturl: "<%=playlisturl%>",
                          playlisttitle: "<%=playlisttitle%>"
                      },
                      dataType: "text",
                      success: function() {
                          if ($("#like-button").attr("class") == "active") {
                              $("#like-button").attr("class", "");
                          } else {
                              $("#like-button").attr("class", "active");
                          }
                      },
                      error: function() {
                          alert("Error")
                      }
                  })
        	  }
          })
</script>
<script src="${pageContext.request.contextPath}/script/star.js" charset="utf-8"></script>
</html>

