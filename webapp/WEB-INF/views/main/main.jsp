<%@ page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main/main_style.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/slick.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common/slick.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common/slick-theme.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modal/movie_detail.css">
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=85K3LBTERGnPmOpMLKtu&submodules=geocoder"></script>
<script type="text/javascript">
	var $userX, $userY;
</script>
<title>Main Page</title>
</head>
<body>
<div class="banner">
	<img src="${pageContext.request.contextPath}/assets/img/event/banner.jpg">
	<div class="banner_close">
		<img src="${pageContext.request.contextPath}/assets/img/icon/modal-x-mark.png">
	</div>
</div>
	<c:import url="/WEB-INF/views/include/header.jsp"></c:import>

	<!-- main banner -->
  <div class="g-contents">
    <div class="multi-banner">
      <div class="swiper-slide">	
       <c:forEach items="${theaterList}" var="theaterList" varStatus="status">
        <div id="m_list{status.index}">
          <div class="poster-box">
            <img src="${pageContext.request.contextPath}/upload/poster/${theaterList.poster}" class="poster">
            <div class="location-info">
              <div class="location-logo"><div class="logo-wrap"><img src="${pageContext.request.contextPath}/upload/${theaterList.brandlogo}"></div></div>
              <c:choose>
              	<c:when test="${fn:length(theaterList.theateraddress) > 1}">
	              <div class="location-name">
	              	<p class="con">
		              	<c:set var="splitloc" value="${fn:split(theaterList.theateraddress,' ')[1]}"></c:set> <!--locate에서 공백기준으로 배열 index[1] 받아옴 -->
		              	<c:set var="len" value="${fn:length(splitloc)}"></c:set> <!--받아온 index[1]의 단어길이 확인 -->
						<c:set var="substringloc" value="${fn:substring(splitloc,0,len-1) }"></c:set> <!--'구' 삭제위해 index 전체길이-1 -->
	              		<c:out value="${substringloc}"></c:out>
	              	</p></div>
               	</c:when>
               	<c:otherwise>
	              <div class="location-name">
	              	<p class="con">
	              		<c:out value="${theaterList.theateraddress}"></c:out>
	              	</p></div>
               	</c:otherwise>
              </c:choose>
            </div>

            <div class="limit-time">
              <div class="detail-time">
              <p class="con2">&nbsp;&nbsp;&nbsp;<span class="time" id="nowplayinglist${status.index}"></span></p></div>
            </div>
            <div class="front">
              <div class="front-btn-wrap">
                <div style="padding-top:130px;">
                  <a href="${pageContext.request.contextPath}/moive/reserve_quick" class="btn-reserve">예매하기</a>
                </div>
                <div>
                  <a href="" class="btn-view" onclick="return false;">상세보기</a>
                </div>
              </div>
            </div>
          </div>
        </div>
        </c:forEach>
       </div>
     </div>
   </div>

<!-- middle banner -->
	<div class="middle-banner">
		<div class="middle-banner-title">
			<h2>
				<span>영화 티켓은 SITE WIN THE MOVIE.</span>
			</h2>
		</div>
		<div class="middle-banner-logo">
			<img src="${pageContext.request.contextPath}/assets/img/event/introduce.jpg" alt="">
		</div>

		<div class="boxoffice-box">
			<div class="officeTop">
				<h2>BOX OFFICE</h2>
				<ul class="officeTab">
					<li class="sale on"><a href="#1">예매순</a></li>
					<li class="star "><a href="#2">평점순</a></li>
				</ul>
			</div>
			<div class="officeCont">
				<ol class="officeRk salecontent">
					<c:forEach
						items="${dailyResult.boxOfficeResult.dailyBoxOfficeList}"
						var="boxoffice">
						<li><a href="" class="tit"> <em>${boxoffice.rank}</em> 
						<span class="grade" data-movieCd='${boxoffice.movieCd}'><img src="${pageContext.request.contextPath}/assets/img/grade/bg_grade_12.png"></span>
						 <span class="myTit">${boxoffice.movieNm}</span>
						</a> <span class="memRk">예매율<em>${boxoffice.salesShare} %</em></span>
						</li>
					</c:forEach>
				</ol>

				<ol class="officeRk starcontent">
					<c:forEach
						items="${dailyResult.boxOfficeResult.dailyBoxOfficeList}"
						var="boxoffice">
						<li><a href="" class="tit"> <em>${boxoffice.rank}</em> 
						<span class="grade_15">15</span> <span class="myTit">${boxoffice.movieNm}</span>
						</a> <span class="memRk">평점 <em>${boxoffice.salesShare} </em></span></li>
					</c:forEach>
				</ol>
			</div>
		</div>
		<div class="map-box" id="naver_map" style="text-align: center;">
		</div>

		 <div class="recommand-box">
			<div class="plus">
				<span>오늘의 추천 영화</span>
				<a href="${pageContext.request.contextPath}/">+ 더보기</a>
			</div>
			<div class="inner-box">
				<div class="first-movie">
					<div class="inner-poster">
						<img
							src="${pageContext.request.contextPath}/assets/img/movie_poster/poster_2.jpg"
							alt="">
					</div>
					<div class="inner-content">
						<div>제목 : 헤어화</div>
						<div>장르 : 사극</div>
						<div>배우 : 천우희, 한효주, 유연석</div>
					</div>
				</div>
				<div class="second-movie">
					<div class="inner-poster">
						<img
							src="${pageContext.request.contextPath}/assets/img/movie_poster/poster_2.jpg">
					</div>
					<div class="inner-content">
						<div>제목 : 헤어화</div>
						<div>장르 : 사극</div>
						<div>배우 : 천우희, 한효주, 유연석</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--footer-notice -->
	<div class="footer-notice">
		<div class="footer-div">
			<div class="footer-notice-title"><a href="#" class="text01">공지사항</a></div>
			<ul class="rolling">
				<li><a href="#">안드로이드 태블릿 가로보드 지원 안내1</a></li>
				<li><a href="#">안드로이드 태블릿 가로보드 지원 안내2</a></li>
				<li><a href="#">안드로이드 태블릿 가로보드 지원 안내3</a></li>
				<li><a href="#">안드로이드 태블릿 가로보드 지원 안내4</a></li>
				<li><a href="#">안드로이드 태블릿 가로보드 지원 안내5</a></li>
			</ul>
		</div>
	</div>
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
  
	<!-- <div class="detail"></div> -->
	<c:import url="/WEB-INF/views/modal/movie_detail.jsp"></c:import>
	<c:import url="/WEB-INF/views/modal/location.jsp"></c:import>


	<div class="detail"></div>
	<%-- <c:import url="/WEB-INF/views/modal/movie_detail.jsp"></c:import> --%>
</body>

<script type="text/javascript">
	function rolling(){
		var height = 50, // div 태그 높이를 가져 오면 되는데 약간 높이가 다르게 나와서 이렇게 함 $('footer-notice').height(); << 높이 구하기
			num = $('.rolling li').length,
			max = height * num,
			move = 0;
			
		function noticerolling(){
			move += height;
			$('.rolling').animate({'top':-move}, 600, function(){
				if(move >= max){
					
					$(this).css('top', 0);
					move = 0;
				}
			});
		}
		
		$(".rolling").append($(".rolling li").first().clone());
		setInterval(noticerolling, 4000);
	}
	// Box Office
	$(document).ready(function() {
		$('#header_wrap').css('top', '70px');
		$('.sale').on("click", function() {
			$('.sale').addClass("on");
			$('.salecontent').show();
			$('.star').removeClass("on");
			$('.starcontent').hide();
		});
		$('.star').on("click", function() {
			$('.star').addClass("on");
			$('.starcontent').show();
			$('.sale').removeClass("on");
			$('.salecontent').hide();
		});

		rolling();
		reverse_counter();
		check_geolocation();
		
		$(".btn-address").on("click", function(){
			$('.body-loc').toggle();
		});
		$('.popup-close-loc').on('click', function(){
			$('.body-loc').toggle();	   		
	   	});
		
		$('.banner_close').on('click',function(){
			$(".banner").hide();
			$('#header_wrap').css('top', '0');
		});
	});
	
	 // slick library
    $('.swiper-slide').slick({
        dots: false,
        infinite: false,
        speed: 500,
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: false,
        autoplaySpeed: 2000,
        arrows: true,
        dots: true,
        responsive: [{
          breakpoint: 600,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 1
          }
        },
        {
           breakpoint: 400,
           settings: {
              arrows: false,
              slidesToShow: 1,
              slidesToScroll: 1
           }
        }]
    });

	  // modal function
	  $('.btn-view').on("click",function(){
	      $('.modal_body').toggle(400);
	      $('body').css('overflow','hidden');
		  $('body').css('margin-right', (window.innerWidth - $('body').width()) + 'px');
		  console.log("확인");
		  detailrender();
	  });	 
		 
	  $('.popup-close').on("click",function(){
		  $('.modal_body').toggle(400);
		  $('body').css('overflow','auto');
	  });	 
		
	// geolocation 사용 여부
	function check_geolocation(){
		if(window.navigator.geolocation){
			 navigator.geolocation.getCurrentPosition(current, showError);
		 } else{
			 alert("현재 브라우저는 위치 서비스를 지원하지 않습니다.");
			 naver_func();
		 }
	}
	
	function showError(error){
		switch (error.code) {
			case error.PERMISSION_DENIED:
				break;
			case error.POSITION_UNAVAILABLE:
		   		break;
			case error.TIMEOUT:
		   		break;
			case error.UNKNOWN_ERROR:
		   		break;
		}
		naver_func();
	}
	
	//geolocation 사용할 경우
	function current(position){
		var $xgps, $ygps, $markers=[], $infoWindow=[];
		var lat = position.coords.latitude;
	    var longi = position.coords.longitude;
	    
	    var naver_map = new naver.maps.Map('naver_map', {
			center : new naver.maps.LatLng(lat, longi),
			zoom : 8
		});
	    
	    var my_marker = new naver.maps.Marker({
			position : new naver.maps.LatLng(lat, longi),
			map : naver_map,
			icon :{
				content : '<img src="${pageContext.request.contextPath}/assets/img/logo/loc_etc.png" >',
				anchor : new naver.maps.Point(25,0)
			}
		});
	    
	    $('#success').on('click', function(){
			bounds = new naver.maps.LatLng($userX, $userY);
			naver_map.panTo(bounds);
			
			my_marker = new naver.maps.Marker({
				position : new naver.maps.LatLng($userX, $userY),
				map : naver_map,
				icon :{
					content : '<img src="${pageContext.request.contextPath}/assets/img/logo/loc_etc.png" >',
					anchor : new naver.maps.Point(25,0)
				}
			});
			
			var contentString = [
				'<div class="iw_inner">',
				' <h3>현재 위치</h3>',
				'</div>'
			].join('');
			
			var infoWindow = new naver.maps.InfoWindow({
		        content: contentString
			});
			$('.body-loc').hide();
	    });
		$.ajax({
			url : "${pageContext.request.contextPath}/selectTheater",
			success : function(list){
				 for(var i=0;i<list.length;i++){
					 $xgps = Number(list[i].theaterygps),
					 $ygps = Number(list[i].theaterxgps);
					 var $brandno = Number(list[i].brandno),
					 	 logoname, website, logo;
					 
					 if($brandno == 2){
						 logoname = "loc_cgv.png";
						 website = "http://www.cgv.co.kr/";
						 logo = "cgv.png";
					 }else if($brandno == 3){
						 logoname = "loc_lotte.png";
						 website = "http://www.lottecinema.co.kr";
						 logo = "lotte.png";
					 }else if($brandno == 1){
						 logoname = "loc_mega.png";
						 website = "http://www.megabox.co.kr/";
						 logo = "mega.png";
					 }
					 
					 var marker = new naver.maps.Marker({
						position : new naver.maps.LatLng($xgps , $ygps),
						map : naver_map,
						icon : {
							content : '<img src="${pageContext.request.contextPath}/assets/img/logo/'+logoname+'" >',
							anchor : new naver.maps.Point(25,0)
						}
					});
					
					var contentString = [
						'<div style="width:334px; position: absolute; background-color: #fff; padding: 15px 16px 0;" >',
						  '<div style="border-bottom: 2px solid #000000; margin-bottom: 10px;">',
						    '<img src="${pageContext.request.contextPath}/assets/img/logo/'+logo+'" style="margin: -8px 0 0 -60px; position:absolute;width:60px;height:30px;"/>',
						    '<h3 style="padding-left:10px; font-size: 19px; letter-spacing: -1px;margin-bottom:10px; text-align:left;">'+list[i].theatername+'</h3>',
						   '</div>',
						  '<div style="font-size: 12px; text-align:left; height:80px;">',
						    '<div>'+list[i].theateraddress+'</div>',
						    '<div style="margin:0">',
						      '<a href="'+website+'" style="text-decoration:none; color:black;">홈페이지 : '+website+'</a>',
						    '</div>',
						     '<div style="text-align:right; ">',
						    	'<a href="${pageContext.request.contextPath}/movie/reserve?theaterno='+list[i].theaterno+'" style="width:70px;display:inline-block; text-align:center; vertical-align:middle; height:25px; line-height:25px; border:1px solid #000; text-decoration:none; color:black;">예매하기</a>',
						    '</div>', 
						  '</div>',
						  '<div style="text-decoration: none; position: absolute; top: 15px; right: 17px; ">',
						    '<button class="close_btn" style="border: none; backgoround: white; cursor:pointer;"><img style="background-color:white;" src="${pageContext.request.contextPath}/assets/img/icon/x-mark-black.png"/></a>',
						  '</div>',
						'</div>'
					].join('');
					
					var infoWindow = new naver.maps.InfoWindow({
				        content: contentString,
						maxWidth : 334,
				        anchorSize : new naver.maps.Size(20,20)
					});
					
					$markers.push(marker);
					$infoWindow.push(infoWindow);
				 }
				
				for (var i=0, ii=$markers.length; i<ii; i++) {
				    naver.maps.Event.addListener($markers[i], 'click', getClickHandler(i));
				} 
				naver.maps.Event.addListener(naver_map, 'idle', function() {
				    updateMarkers(naver_map, $markers);
				});


				function updateMarkers(map, markers) {
				    var mapBounds = map.getBounds();
				    var marker, position;

				    for (var i = 0; i < markers.length; i++) {
				        marker = markers[i]
				        position = marker.getPosition();

				        if (mapBounds.hasLatLng(position)) {
				            showMarker(map, marker);
				        } else {
				            hideMarker(map, marker);
				        }
				    }
				}

				function showMarker(map, marker) {
				    if (marker.setMap()) return;
				    marker.setMap(map);
				}

				function hideMarker(map, marker) {
				    if (!marker.setMap()) return;
				    marker.setMap(null);
				}
				
				function getClickHandler(seq) {
				    return function(e) {
				        var marker = $markers[seq],
				            infoWindow = $infoWindow[seq];
						
				        if (infoWindow.getMap()) {
				            infoWindow.close();
				        } else {
				            infoWindow.open(naver_map, marker);
				        }
				        
				        $('.close_btn').on('click', function(){
							infoWindow.close();
						});
				   }
				} 
			}
		});
	}
	
	// naver_map geolocation을 사용하지 않는 경우
	function naver_func(){
		var bounds, $xgps, $ygps, $markers=[], $infoWindow=[];
		
		if(typeof $userX == "undefined" && typeof $userY == "undefined"){
			$userX = 37.56647;
			$userY = 126.977963;
		} 

		var naver_map = new naver.maps.Map('naver_map', {
			center : new naver.maps.LatLng($userX, $userY),
			zoom : 8
		});
		
		var my_marker = new naver.maps.Marker({
			position : new naver.maps.LatLng($userX, $userY),
			map : naver_map
		});

		$('#success').on('click', function(){
			bounds = new naver.maps.LatLng($userX, $userY);
			naver_map.panTo(bounds);
			
			var my_marker = new naver.maps.Marker({
				position : new naver.maps.LatLng($userX, $userY),
				map : naver_map
			});
			var contentString = [
				'<div class="iw_inner">',
				' <h3>현재 위치</h3>',
				'</div>'
			].join('');
			
			var infoWindow = new naver.maps.InfoWindow({
		        content: contentString
			});
			
			$('.body-loc').hide();
	    });
		

		$.ajax({
			url : "${pageContext.request.contextPath}/selectTheater",
			success : function(list){
				 for(var i=0;i<list.length;i++){
					 $xgps = Number(list[i].theaterygps),
					 $ygps = Number(list[i].theaterxgps);
					 var $brandno = Number(list[i].brandno),
					 	 logoname, website, logo;
					 
					 if($brandno == 2){
						 logoname = "loc_cgv.png";
						 website = "http://www.cgv.co.kr/";
						 logo = "cgv.png";
					 }else if($brandno == 3){
						 logoname = "loc_lotte.png";
						 website = "http://www.lottecinema.co.kr";
						 logo = "lotte.png";
					 }else if($brandno == 1){
						 logoname = "loc_mega.png";
						 website = "http://www.megabox.co.kr/";
						 logo = "mega.png";
					 }
					 
					 var marker = new naver.maps.Marker({
						position : new naver.maps.LatLng($xgps , $ygps),
						map : naver_map,
						icon : {
							content : '<img src="${pageContext.request.contextPath}/assets/img/logo/'+logoname+'" >',
							anchor : new naver.maps.Point(25,0)
						}
					});

					var contentString = [
							'<div style="width:334px; position: absolute; background-color: #fff; padding: 15px 16px 0;" >',
							  '<div style="border-bottom: 2px solid #000000; margin-bottom: 10px;">',
							    '<img src="${pageContext.request.contextPath}/assets/img/logo/'+logo+'" style="margin: -8px 0 0 -60px; position:absolute;width:60px;height:30px;"/>',
							    '<h3 style="padding-left:10px; font-size: 19px; letter-spacing: -1px;margin-bottom:10px; text-align:left;">'+list[i].theatername+'</h3>',
							   '</div>',
							  '<div style="font-size: 12px; text-align:left; height:80px;">',
							    '<div>'+list[i].theateraddress+'</div>',
							    '<div style="margin:0">',
							      '<a href="'+website+'" style="text-decoration:none; color:black;">홈페이지 : '+website+'</a>',
							    '</div>',
							    '<div style="text-align:right; ">',
							    	'<a href="${pageContext.request.contextPath}/movie/reserve?theaterno='+list[i].theaterno+'" style="width:70px;display:inline-block; text-align:center; vertical-align:middle; height:25px; line-height:25px; border:1px solid #000; text-decoration:none; color:black;">예매하기</a>',
							    '</div>', 
							  '</div>',
							  '<div style="text-decoration: none; position: absolute; top: 15px; right: 17px; ">',
							    '<button class="close_btn" style="border: none; backgoround: white; cursor:pointer;"><img style="background-color:white;" src="${pageContext.request.contextPath}/assets/img/icon/x-mark-black.png"/></a>',
							  '</div>',
							'</div>'
						].join('');
						
						var infoWindow = new naver.maps.InfoWindow({
					        content: contentString,
							maxWidth : 334,
					        anchorSize : new naver.maps.Size(20,20)
						});
						
					

					$markers.push(marker);
					$infoWindow.push(infoWindow);
				 }

				for (var i=0, ii=$markers.length; i<ii; i++) {
				    naver.maps.Event.addListener($markers[i], 'click', getClickHandler(i));
				}
				naver.maps.Event.addListener(naver_map, 'idle', function() {
				    updateMarkers(naver_map, $markers);
				});

				function updateMarkers(map, markers) {
				    var mapBounds = map.getBounds();
				    var marker, position;

				    for (var i = 0; i < markers.length; i++) {
				        marker = markers[i]
				        position = marker.getPosition();

				        if (mapBounds.hasLatLng(position)) {
				            showMarker(map, marker);
				        } else {
				            hideMarker(map, marker);
				        }
				    }
				}

				function showMarker(map, marker) {
				    if (marker.setMap()) return;
				    marker.setMap(map);
				}

				function hideMarker(map, marker) {
				    if (!marker.setMap()) return;
				    marker.setMap(null);
				}

				function getClickHandler(seq) {
				    return function(e) {
				        var marker = $markers[seq],
				            infoWindow = $infoWindow[seq];

				        if (infoWindow.getMap()) {
				            infoWindow.close();
				        } else {
				            infoWindow.open(naver_map, marker);
				        }
				        $('.close_btn').on('click', function(){
							infoWindow.close();
						});
				    }
				}
			}
		});
	} 
	
	  //nowplaying timer
	  function reverse_counter(){
		    var list = [];
			
		    <c:forEach items="${theaterList}" var="theaterList" varStatus="status">
			 list.push("${theaterList.playingtime}");
			 console.log("${status.index}" + "-"+ "${theaterList.playingtime}"); 
			</c:forEach>
	
			for (var i = 0; i < list.length; i++) {
				   console.log("js_push:" + list[i]); 
					   
			       var today = new Date();
				   var d_day = new Date(list[i]);
				   console.log("jstl_list:" + d_day); 
				   console.log("sysdate:" + today); 
						  
				   days = (d_day - today) / 1000 / 60 / 60 / 24;
				   daysRound = Math.floor(days);
				   hours = (d_day - today) / 1000 / 60 / 60 - (24 * daysRound);
				   hoursRound = Math.floor(hours);
				   minutes = (d_day - today) / 1000 /60 - (24 * 60 * daysRound) - (60 * hoursRound);
				   minutesRound = Math.floor(minutes);
				   seconds = (d_day - today) / 1000 - (24 * 60 * 60 * daysRound) - (60 * 60 * hoursRound) - (60 * minutesRound);
				   secondsRound = Math.round(seconds);
				   sec = " "
				   min = " : "
				   hr = " : "
				   dy = "   "
				   console.log("남은시간:" + hoursRound + hr + minutesRound + min + secondsRound);
						  
				   /*한자리 수 : +0*/
				   if(hoursRound < 10) hoursRound = "0" + hoursRound;
				   if(minutesRound < 10) minutesRound = "0" + minutesRound;
				   if(secondsRound < 10) secondsRound = "0" + secondsRound;
						  
						 
				   /*분,초가 60 : 59로 초기화*/
				   if(minutesRound == 60) minutesRound = 59;
				   if(secondsRound == 60) secondsRound = 59;
						
				
				   /*남은시간 0:0:0*/
				 		
				  if(daysRound < 0) { 
					$('#nowplayinglist'+i).html("예매종료"); 
					$("#btn-reserve"+i).remove("a");
					$("#btn-view"+i).remove("a");
				  } else {
					 $('#nowplayinglist'+i).text("[남은시간]" + dy + hoursRound + hr + minutesRound + min + secondsRound);
				  }
		   }
		newtime = window.setTimeout("reverse_counter();", 1000); 
    }
	  
	  
	 
	  // mouseover function
      $(".poster-box").mouseover(function(){
        $(this).children('.front').addClass('hover');
      });
      $('.poster-box').mouseleave(function(){
        $(this).children('.front').removeClass('hover');
      });

      // modal function
	  $('.btn-view').on("click",function(){
		  //ajax로 데이터 값 매칭
		  $('#age').removeClass();
		  $('#age').addClass("age_l age_15"); //if문 활용해서 age 클래스명에 매칭
		  
	      $('.modal_body').toggle(400);
	      $('body').css('overflow','hidden');
		  $('body').css('margin-right', (window.innerWidth - $('body').width()) + 'px'); 
	  });	 

	  $('.popup-close').on("click",function(){
		  $('body').css('overflow','auto');
	  });	

</script>
</html>