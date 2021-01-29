var mouseWheelEvent = 0;
var idx_lgth = $(".slider>li").length;
var srt = 1;

//첫 실행
$(document).ready(function() {
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
  // pageNumberBox
  // background: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8));
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

function moveOnePage(){
  console.log('page 1 start');
  //페이지 위치 저장
  var offsetTop = $('#page1').offset().top;
  //페이지 번호 변경, 화살표 페이드 인
  $('.pageNumberValue').text("01");
  $('.arrow').animate({opacity : '1'}, 500)
             .css('display', 'block');
  //페이지 이동
  moveScroll(offsetTop);
}

function moveTwoPage(){
  console.log('page 2 start');
  var offsetTop = $('#page2').offset().top;
  moveScroll(offsetTop);
  $('.pageNumberValue').text("02");
  $('.arrow').animate({opacity : '1'}, 500)
             .css('display', 'block');
  effectScroll('#productHeadLine', '#productMore', '#productTitle');
}

function moveThreePage(){
  console.log('page 3 start');
  var offsetTop = $('#page3').offset().top;
  moveScroll(offsetTop);
  $('.pageNumberValue').text("03");
  $('.arrow').animate({opacity : '0'}, 500)
             .css('display', 'none');
  effectScroll('#councelingHeadLine', '#councelingMore', '#councelingTitle');
}

//스크롤 이동
function moveScroll(location) {
  $('html, body').animate({
    scrollTop: location
  }, 400);
}

function effectScroll(HeadLine, More, Title){
  setTimeout(function() {
    $(HeadLine).animate({top : '0px', opacity : '1'}, 1000);
  }, 300);
  setTimeout(function() {
    $(More).animate({top : '30px', opacity : '1'}, 700);
  }, 1200);
  setTimeout(function() {
    $(Title).animate({bottom : '230px', opacity : '1'}, 800);
  }, 1600);
}

//more 마우스 오버
$(function(){
  $('.more').mouseenter(function(){
    $('.moreBorderLine').stop().animate({width : '0px'}, 200);
  });
  $('.more').mouseleave(function(){
    $('.moreBorderLine').stop().animate({width : '70px'}, 200);
  });
});

//슬라이드 인디케이터
$("section>a").click(function(){

    var idx = $(this).index();
    srt = idx;
    $(this).addClass('on').siblings().removeClass('on');
  });
  


