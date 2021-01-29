<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.servlet.*"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link href="https://fonts.googleapis.com/css?family=Archivo+Black&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lalezar&display=swap" rel="stylesheet">
    <link href="css/portfolio_intro_style.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
    var mouseWheelEvent = 0;
    var idx_lgth = $(".slider>li").length;
    var srt = 0;
    var lat = 37.564;
	var lng = 127.001;
	
    //첫 실행
    $(document).ready(function() {
    	
    	$("#locform > input[name='lat']").attr("value",lat);
	    $("#locform > input[name='lng']").attr("value",lng);
    	
/*     	if (!!navigator.geolocation) {
    	       navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
    	   } else {
    	       alert("이 브라우저는 Geolocation를 지원하지 않습니다");
    	   }

    	   function successCallback(position) {
    	       lat = Math.floor(position.coords.latitude);
    	       lng = Math.floor(position.coords.longitude);
    	       $("#locform > input[name='lat']").attr("value",lat);
    	       $("#locform > input[name='lng']").attr("value",lng);
    	   }function errorCallback(error) {
    	       alert(error.message);
    	   } */
    	
      var documentHeight = $(document).height() / 3;
      console.log(documentHeight);
      moveScroll(0);
      //첫 오프닝
      $('.razor').animate({
          width: '2000px'
        }, 250)
        .fadeOut(200);
      //뒷배경 삭제
      setTimeout(function() {
        $('.blackBackground').fadeOut(200);
      }, 200);
      //뒷배경 blur
      setTimeout(function() {
        blurElement('.page', 0);
      }, 400);
      //헤드라인 표시
      setTimeout(function() {
        $('#introHeadLine').animate({top : '0px', opacity : '1'}, 1000);
      }, 300);
      setTimeout(function() {
        $('#introMore').animate({top : '30px', opacity : '1'}, 700);
      }, 1200);
      //title 표시
      setTimeout(function() {
        $('#introTitle').animate({bottom : '230px', opacity : '1'}, 800);
      }, 1600);
      // Icon 표시 동시 출력
      setTimeout(function() {
        $('#facebook').animate({left : '48px', opacity : '1'}, 800);
      }, 1600);
      setTimeout(function() {
        $('#instagram').animate({left : '48px', opacity : '1'}, 800);
      }, 1600);
      //로고 / 번호표 표시
      setTimeout(function() {
        $('.menuButton').animate({top : '40px'}, 600);
      }, 2200);
      setTimeout(function() {
        $('.companyIcon').animate({top : '40px'}, 600);
      }, 2200);
      setTimeout(function() {
        $('.pageNumberBox').animate({top : String(documentHeight - 89)+'px'}, 600);
      }, 2200);
      setTimeout(function() {
        $('.arrow').animate({opacity : '1'}, 600);
      }, 2200);
    });
    
    //blur 애니메이션
    function blurElement(element, size) {
      var filterVal = 'blur(' + size + 'px)';
      $(element).css({
        'filter': filterVal,
        'webkitFilter': filterVal,
        'mozFilter': filterVal,
        'oFilter': filterVal,
        'msFilter': filterVal,
        'transition': 'all 0.5s ease-out',
        '-webkit-transition': 'all 0.5s ease-out',
        '-moz-transition': 'all 0.5s ease-out',
        '-o-transition': 'all 0.5s ease-out'
      });
    }

    //마우스의 휠 여부 판단
    $("html").on("mousewheel", function(event) {
      if (event.originalEvent.wheelDelta < 0 && mouseWheelEvent < 20) {
        mouseWheelEvent++;
      } else if (event.originalEvent.wheelDelta > 0 && mouseWheelEvent > 0) {
        mouseWheelEvent--;
      }
      // console.log(mouseWheelEvent);
      if (mouseWheelEvent == 0) {
        moveOnePage();
      } else if (mouseWheelEvent == 10) {
        moveTwoPage();
      } else if (mouseWheelEvent == 20) {
        moveThreePage();
      }
    });

    //첫페이지 이동
    function moveOnePage(){
      console.log('page 1 start');
      //페이지 위치 저장
      var offsetTop = $('#page1').offset().top;
      //페이지 이동
      moveScroll(offsetTop);
      $("section>a:first-of-type").addClass('on').siblings().removeClass('on');
      
    }

  	//두번째 페이지 이동
    function moveTwoPage(){
      console.log('page 2 start');
      var offsetTop = $('#page2').offset().top;
      moveScroll(offsetTop);
      effectScroll('#productHeadLine', '#productMore', '#productTitle');
      $("section>a:nth-of-type(2)").addClass('on').siblings().removeClass('on');
    }

  	//세번째 페이지 이동
    function moveThreePage(){
      console.log('page 3 start');
      var offsetTop = $('#page3').offset().top;
      moveScroll(offsetTop);
      effectScroll('#councelingHeadLine', '#councelingMore', '#councelingTitle');
      $("section>a:nth-of-type(3)").addClass('on').siblings().removeClass('on');
    }

    //스크롤 이동
    function moveScroll(location) {
      $('html, body').animate({
        scrollTop: location
      }, 400);
    }

    function effectScroll(HeadLine, More, Title){
      setTimeout(function() {
        $(HeadLine).animate({top : '0px', opacity : '1'}, 300);
      }, 300);
      setTimeout(function() {
        $(More).animate({top : '30px', opacity : '1'}, 300);
      }, 300);
      setTimeout(function() {
        $(Title).animate({bottom : '230px', opacity : '1'}, 300);
      }, 300);
    }

    //more 마우스 오버
    $(function(){
    	$("section>a").click(function(){
            switch($(this).index()){
            	case 0 : moveOnePage();
            	break;
            	case 1 : moveTwoPage();
            	break;
            	case 2 : moveThreePage();
            	break;
            }
        });
    	
    });
    
    function locformsubmit(){
    	if($("#locform > input[name='lat']").attr("value")==null){
    		alert("위치 정보 수신중입니다. 잠시 후 다시 시도해주세요.")
    	}
    	document.locform.submit()
    }
    </script>
</head>
<body>
    <ul class="slider">
<!--       페이지1-------------------------------->
        <li class="page" id="page1" alt="">
            <p class="headLine" id="introHeadLine">
                무슨 음악을
                <br>
                들을지
                <br>
                고민하지 마세요
                <br>
                <br>
                <a href="#"><span id="submit-button" class="bdText" onclick="locformsubmit()">CIRCLE</span></a>
                <br>
            </p>
        </li>
<!--        페이지2------------------------------->
        <li class="page" id="page2" alt="">
            <p class="headLine" id="productHeadLine">
                당신이<br>
                어디에 있든<br>
                어울리는 음악이<br>
                재생됩니다.
            </p>
        </li>
<!--        페이지3------------------------------->
        <li class="page" id="page3" alt="">
            <p class="headLine" id="councelingHeadLine">
                지금<br>
                시작해보세요<br>
                <br>
                <a href="#"><span id="submit-button" class="bdText" onclick="locformsubmit()">CIRCLE</span></a>
            </p>
        </li>
        <section id="control">
        	<a class="on" href="#"></a>
        	<a href="#"></a>
        	<a href="#"></a>
        </section>
    </ul>
    <form method="post" id="locform" name="locform" action="basic_location.do">
    	<input name="lat" value="1">
    	<input name="lng" value="2">
    </form>
</body>
</html>
