<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
	<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/3.0.0/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" />
	
	<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.2/moment-with-locales.min.js"></script>
	
	<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/3.0.0/js/bootstrap-datetimepicker.min.js"></script>
	
	<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
	
	<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a6419e542017d8fd315556f745f29fcf"></script>
	
			<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<script type="text/javascript">
		
 		var map = null;
		var mapx = ${festival.festivalLongitude}; // 경도
		var mapy = ${festival.festivalLatitude};	//위도'
		
		$(function() {
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		   
			mapOption = { 
		        center: new daum.maps.LatLng(mapy, mapx), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
	
			map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
			var markerPosition = new daum.maps.LatLng(mapy,mapx);
			
			var marker = new daum.maps.Marker({
				position : markerPosition
			});
			
			marker.setMap(map);
	
		});
		
		function setCenter() {            
		    // 이동할 위도 경도 위치를 생성합니다 
		    var moveLatLon = new daum.maps.LatLng(mapy, mapx);
		    
		    // 지도 중심을 이동 시킵니다
		    map.setCenter(moveLatLon);
		}
	
		function panTo() {
		    // 이동할 위도 경도 위치를 생성합니다 
		    var moveLatLon = new daum.maps.LatLng(mapy, mapx);
		    
		    // 지도 중심을 부드럽게 이동시킵니다
		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		    map.panTo(moveLatLon);            
		}         
		
		$(function(){
			$("#back").on("click", function(){
				history.go(-1);
			});
		});
		
		$(function() {
			$("button:contains('삭제하기')").on("click", function() {
			self.location = "/festival/deleteFestival?festivalNo=" + ${festival.festivalNo}+"&deleteFlag=1";
		});
	});
		
		$(function() {
				$("button:contains('등록하기')").on("click", function() {
				self.location = "/festival/addFestivalView?festivalNo=" + ${festival.festivalNo};
			});
		});
			
		$(function() {
				$("button:contains('애프터파티 조회')").on("click", function() {
				self.location = "/party/getPartyList?festivalNo="+${festival.festivalNo};
			});
		});
			
		$(function() {
				$("button:contains('티켓구매')").on("click", function() {
				self.location = "/purchase/addPurchase?festivalNo="+${festival.festivalNo};
			});
		});
		
		$(function() {
			$("button:contains('수정하기')").on("click", function() {
			self.location = "/festival/updateFestivalView?festivalNo="+${festival.festivalNo}+"&isNull="+${festival.isNull};
		});
	});
		
		$(function() {
			$("button:contains('재등록')").on("click", function() {
			self.location = "/festival/updateFestivalView?festivalNo="+${festival.festivalNo}+"&isNull="+${festival.isNull};
		});
	});

		 var id = "";
		 var tag="";
		 var tag2="";
		 var met="";

		 $(function(){
			 
			 $( '#tag' ).on("click", function() {
				 
				 
					 if(${returnZzim==null}){
						 met = "addZzim";
					 }else{
						 met = "deleteZzim";
					 }
				 		
					$.ajax( 
							{
								url : "/festivalRest/json/"+met+"/${user.userId}/${festival.festivalNo}",
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {
									
									
									 if($("#tag").attr("class")=="glyphicon glyphicon-heart"){
										 tag = "glyphicon glyphicon-heart-empty";
										 tag2 = "glyphicon glyphicon-heart";
									 }else{
										 tag = "glyphicon glyphicon-heart";
										 tag2 = "glyphicon glyphicon-heart-empty";
									 }
									$( "#tag" ).removeClass(tag2);
									$( "#tag" ).addClass(tag);

								}
						});
					
					
			 });
		 }); 
		 
		 
		 
		</script>
		
<style type="text/css">
		
body {
		padding-top : 70px;
    }
		
</style>
	
</head>
<body>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

<div class="panel panel-primary">
	<div class="panel-heading text-center">
		<h3><Strong>${festival.festivalName }</Strong></h3>
	</div>
</div>

<div class="panel">
	<div class="panel-heading text-center">
  
	<c:if test="${weather.main == 'Thunderstorm' }">
		<img src = "http://openweathermap.org/img/w/11d.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Drizzle' }">
		<img src = "http://openweathermap.org/img/w/09d.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Rain' }">
		<img src = "http://openweathermap.org/img/w/10d.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Snow' }">
		<img src = "http://openweathermap.org/img/w/13d.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Atmosphere' }">
		<img src = "http://openweathermap.org/img/w/50d.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Clear' }">
		<img src = "http://openweathermap.org/img/w/01d.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Clouds' }">
		<img src = "http://openweathermap.org/img/w/03d.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Haze' }">
		<img src = "http://openweathermap.org/img/w/50d.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Mist' }">
		<img src = "http://openweathermap.org/img/w/50n.png">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Extreme' && weather.id =='900' }">
		<img src = "../../resources/image/weather/tornado.gif">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Extreme' && weather.id =='901' }">
		<img src = "../../resources/image/weather/tropicalStorm.gif">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Extreme' && weather.id =='902' }">
		<img src = "../../resources/image/weather/hurricane.gif">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Extreme' && weather.id =='903' }">
		<img src = "../../resources/image/weather/cold.gif">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Extreme' && weather.id =='904' }">
		<img src = "../../resources/image/weather/hot.gif">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Extreme' && weather.id =='905' }">
		<img src = "../../resources/image/weather/windy.gif">
		${weather.description }
	</c:if>
	
	<c:if test="${weather.main == 'Extreme' && weather.id =='906' }">
		<img src = "../../resources/image/weather/hail.gif">
		${weather.description }
	</c:if>
	<br/>
  	
	<c:if test="${festival.festivalImage.contains('http://')==true }">
		<img src="${festival.festivalImage }" width="100%" height="300" />
	</c:if>
	
	<c:if test="${festival.festivalImage.contains('http://')==false }">
		<img src="../../resources/uploadFile/${festival.festivalImage }" width="100%" height="300" />
	</c:if>
	
	<c:if test="${returnZzim == null }">
		<h1><span class="glyphicon glyphicon-heart-empty" aria-hidden="true" id="tag"></span></h1>
	</c:if>
	
	<c:if test="${returnZzim != null }">
		<h1><span class="glyphicon glyphicon-heart" aria-hidden="true" id="tag"></span></h1>
	</c:if>
	</div>
	</div>
	
	
	
<ul class="list-group">

  <li class="list-group-item">
  	<c:if test="${festival.isNull==true }">
		삭제되었던 축제입니다.
	</c:if>
  </li>
  
  <li class="list-group-item">조회수 : ${festival.readCount }</li>
  
  <li class="list-group-item">
  	<c:if test="${festival.homepage!=null}">
  		홈페이지 :  ${festival.homepage }
  	</c:if>	
  	</li>
  
  <li class="list-group-item">
  	<c:if test="${festival.festivalOverview!=null }">
  		소개 : ${festival.festivalOverview }
  	</c:if>
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.addr!=null}">
  		개최장소 : ${festival.addr }
  	</c:if>
  </li>
  
  <li class="list-group-item">축제기간 : ${festival.startDate } ~ ${festival.endDate }</li>
  
  <li class="list-group-item">
  	<c:if test="${festival.festivalDetail!=null}">
  		내용 : ${festival.festivalDetail }
  	</c:if>
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.orgPhone!=null}">
  		연락처 : ${festival.orgPhone }
  	</c:if>	
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.ageLimit!=null}">
  		연령제한 : ${festival.ageLimit }
  	</c:if>
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.bookingPlace!=null}">
  		예매처 : ${festival.bookingPlace }
  	</c:if>	  	
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.discount!=null}">
  		할인정보 : ${festival.discount }
  	</c:if>
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.program!=null}">
  		행사프로그램 : ${festival.program }
  	</c:if>
  
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.playTime!=null}">		
  		공연시간 : ${festival.playTime }
  	</c:if>
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.spendTimeFestival!=null}">
  		관람소요시간 : ${festival.spendTimeFestival }
  	</c:if>
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.subEvent!=null}">
  		부대행사 : ${festival.subEvent }
  	</c:if>
  </li>
  
  <li class="list-group-item">
  	<c:if test="${festival.useTimeFestival!=null}">
  		이용요금 : ${festival.useTimeFestival }
  	</c:if>	
  </li>
  
  <li class="list-group-item">
  	<c:if test= "${user.role=='u' }" >
		티켓가격 : ${festival.ticketPrice }
			<br/>
		티켓수량 : ${festival.ticketCount }
	</c:if></li>
	
</ul>

<div id="map" style="width:200;height:350px;"></div>
	<p>
		<button onclick="setCenter()">지도 중심좌표 이동시키기</button> 
		<button onclick="panTo()">지도 중심좌표 부드럽게 이동시키기</button>
	</p>


	
	<!-- hidden tag -->
	<input type = "hidden" class="form-control" id="festivalLongitude" name="festivalLongitude" value= "${festival.festivalLongitude }">
	<input type = "hidden" class="form-control" id="festivalLatitude" name="festivalLatitude" value= "${festival.festivalLatitude }">
	<input type = "hidden" class="form-control" id="festivalNo" name="festivalNo" value= "${festival.festivalNo }">
	<input type = "hidden" class="form-control" id="userId" name="userId" value= "${user.userId }">
	<input type = "hidden" class="form-control" id="userName" name="userName" value= "${user.userName }">
	<input type = "hidden" class="form-control" id="role" name="role" value= "${user.role }">
	<input type = "hidden" class="form-control" id="nickname" name="userId" value= "${user.nickname }">
	<input type = "hidden" class="form-control" id="isNull" name="isNull" value= "${festival.isNull }">
	
	
	
	
	<c:if test= "${user.role=='a' }" >
		
		<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">

				
				<c:if test="${ticket==null }">
					<c:if test="${festival.isNull==true }">
						<button type="button" class="btn btn-primary">재등록</button>
					</c:if>
				</c:if>
				
				<c:if test="${ticket==null }">
					<c:if test="${festival.isNull==false }">
						<button type="button" class="btn btn-primary">등록하기</button>
					</c:if>
				</c:if>
				
				<c:if test="${ticket!=null }">
					<button type="button" class="btn btn-primary">수정하기</button>
					<button type="button" class="btn btn-primary">삭제하기</button>
				</c:if>
			
					<input type = "button" id = "back" name = "back" value = "뒤로"/>
			
				</div>
			</div>
			
	</c:if>
	
			
	<c:if test="${user.role!='a' }">
		<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" class="btn btn-primary">애프터파티 조회</button>
						<c:if test="${ticket.ticketFlag!='del'}">
							<button type="button" class="btn btn-primary">티켓구매</button>
						</c:if>
					
					<input type = "button" id = "back" name = "back" value = "뒤로"/>
					
				</div>
			</div>
			
	</c:if>
	
	
	
	
	
	
</body>
</html>