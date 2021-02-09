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
			/* String playlisturl = request.getParameter("playlisturl");
			String playlisttitle = request.getParameter("playlisttitle"); */
			
			String playlisturl = (String)session.getAttribute("playlisturl");
			String playlisttitle = (String)session.getAttribute("playlisttitle");
			String youtubesrc = "https://www.youtube.com/embed/?autoplay=1&amp;listType=playlist&amp;list="+playlisturl+"&amp;origin=http%3A%2F%2Flocalhost&amp;enablejsapi=1&amp;widgetid=1";
			
			/* if(playlisturl == null && playlisttitle == null){//직접넘어온 url및 title없을경우
				playlisturl = (String)session.getAttribute("mostrecommendedurl");
				playlisttitle = (String)session.getAttribute("mostrecommendedtitle");
			}else{
				playlisturl = (String)request.getAttribute("playlisturl");
				playlisttitle = (String)request.getAttribute("playlisttitle");
			} */
			String thumburl = null;
			String desc = null;
			String dataurl = "https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl
					+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4";
			String dataurlitems = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=" + playlisturl
					+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4&maxResults=50";
			
			//pDAO객체 생성
			PlayerDAO pDAO = new PlayerDAO();
			
			//플레이리스트 재생되면 playlist_member 에 추가
			//pDAO.setListenInfo(playlisturl, id, playlisttitle);
			
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
			/* String likesresult = null;
			if(likebool == true) {
				likesresult = "true";
			}else {
				likesresult = "false";
			} */
			
			String likefunc = null;
			
			//좋아요 변경
			if (request.getParameter("likechange") != null) {
				pDAO.likeChange(id, playlisturl, playlisttitle);
				request.setAttribute("likechange", null);
			} else {
				System.out.println("if진입 실패");
			}
			
			//리뷰 등록
			if (request.getParameter("star-input") != null){
				int rrating = Integer.parseInt(request.getParameter("star-input"));
				String rcontent = request.getParameter("star-review");
				pDAO.setReviewInfo(rrating, id, rcontent, playlisturl);
			}
			
			//리뷰 영역 데이터받아오기
			int totalrating = pDAO.getTotalRating(playlisturl);
			List<ReviewListbean> reviewlist = pDAO.getReviewList(playlisturl);
			
			//리뷰 작성여부 확인
			boolean reviewbool = pDAO.checkReview(playlisturl,id);
			
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
		        <script>
		            //좋아요 판별 해서 버튼 css 변경
		            $(document).ready(function() {
		                if ( <%= likebool %> ) {
		                    $("#like-button").attr("class", "active");
		                }
		            })

		            //좋아요 작동
		            $("#like-button").click(function() {
		                $.ajax({
		                    url: "<%=likefunc%>",
		                    type: "POST",
		                    data: {
		                        likechange: "change"
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
		            })
		        </script>
		    </div>
	    </div>
		<div id="center">
	        <div id="contents-title">
	            <h1>플레이어 & 사용자리뷰 💿</h1>
	        </div>
            <div id="jacket">
                <a href="#"> 
                   	<iframe id="player" frameborder="0" allowfullscreen="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" title="YouTube video player" width="400px" height="400px" src="<%=youtubesrc%>">
                   	</iframe>
                   	<script>
                   		var player;
                   	
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
                        
                        function onPlayerReady(event) {
                            event.target.playVideo();
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
	                    <input type="submit" value="등록" id="reviewsubmit-button">
	                    <input type="hidden" value="<%=playlisturl %>" name="url">
	                    <input type="hidden" value="<%=playlisttitle %>" name="title">
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
			<button type="button" onclick="prevsong();">이전</button>
			<button type="button" onclick="playsong();">재생</button>
			<button type="button" onclick="nextsong();">다음</button>
		</div>
		<div id="middle-controller">
			<img src="<%=thumburl%>">
		</div>
	    <div id="right-controller">
		   <button>셔플</button>
		   <button>볼륨</button>
		   <button onclick="playerOpen()">플레이어열기</button>
	    </div>
    </div>
</body>
<script>
	      //리뷰 제출
	      $("#reviewsubmit-button").click(function() {
	          var formdata = $("form[name=reviewFrm]").serialize();
	          $.ajax({
	              url: "<%=likefunc%>",
	              type: "POST",
	              data: formdata,
	              success: function() {
	                  console.log(data)
	              },
	              error: function() {
	                  alert("Error")
	              }
	          })
	      });
	      
		  //리뷰 작성여부 판단
	      if ( <%= reviewbool %> ) {
	          $("#forminput input").attr("disabled", true);
	          $("#oneline").attr("value", "이미 리뷰를 등록하셨습니다.");
	      };
</script>
<script src="${pageContext.request.contextPath}/script/star.js" charset="utf-8"></script>
</html>

