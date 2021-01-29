 $(function () {
     if (!!navigator.geolocation) {
         navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
     } else {
         alert("이 브라우저는 Geolocation를 지원하지 않습니다");
     }

     function successCallback(position) {
         var lat = Math.floor(position.coords.latitude);
         var lng = Math.floor(position.coords.longitude);
         
         //좌표 받기//

         var url = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lng + "&appid=d0a998ccc694266743134194917c17f0";
         
         //좌표로 지역명 받아서 헤더 수정//
         
         //get weather//
         //main화면 날씨 데이터 받아오기//
         
         function getweather() {
             var weather = null;
             
             $.getJSON(url, function (data) {
                 var wid = data.weather[0].id;
                 var code;

                 //추후에 id값을 기반으로 음악 선택
                 //https://openweathermap.org/weather-conditions 아이콘 및 아이디 값 참고용.

                 var temp = data.main.temp;
                 var feels_like = data.main.feels_like;
                 var wmain = data.weather[0].main;
                 var wdesc = data.weather[0].description;
                 var time = data.dt;
                 var wicon = data.weather[0].icon;
                 var iconurl = "https://openweathermap.org/img/wn/" + wicon + "@2x";
                 
                 $("#weather-info .today .temp").text("Temp: " + parseInt(temp - 273.15) + "°C");
                 $("#weather-info .today .feels").text("Feels like: " + parseInt(feels_like - 273.15) + "°C");
                 $("#weather-info .today .wmain").text(wmain);
                 $("#weather-info .today .wdesc").text(wdesc);
                 $("#weather-info .today .icon").html("<img src=" + iconurl + ".png>");

                 //main화면 리스트 제목 바꾸기//
                 
                 if (wdesc.indexOf("clear") == 0) {
                     $("#lower .desc .title p").text("For Sunny day");
                 } else if (wdesc.indexOf("cloud") == 0) {
                     $("#lower .desc .title p").text("For Cloudy day");
                 } else if (wdesc.indexOf("rain") == 0) {
                     $("#lower .desc .title p").text("For Rainy day");
                 } else if (wdesc.indexOf("snow") == 0) {
                     $("#lower .desc .title p").text("For Snowy day");
                 }
             });
         }
         getweather();
     }
     function errorCallback(error) {
         alert(error.message);
     }
 });
