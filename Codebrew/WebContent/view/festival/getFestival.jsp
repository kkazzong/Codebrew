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
		
		$(function() {
			$("button:contains('모달')").on("click", function() {
			self.location = "/view/festival/modalTest.jsp";
		});
	});

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
										
									console.log("JSONData...." + JSONData.totalZzim);
									
									
									
									 if($("#tag").attr("class")=="glyphicon glyphicon-heart"){
										 tag = "glyphicon glyphicon-heart-empty";
										 tag2 = "glyphicon glyphicon-heart";
									 }else{
										 tag = "glyphicon glyphicon-heart";
										 tag2 = "glyphicon glyphicon-heart-empty";
									 }
									$( "#tag" ).removeClass(tag2);
									$( "#tag" ).addClass(tag);
									
									$(".totalZzim").text(JSONData.totalZzim);
									
									

								}
						});
					
					
			 });
		 }); 
		 
		 
		 
		</script>
		
<style type="text/css">
		
body {
		padding-top : 70px;
    }
    
    img {
    	width: 100;
    	height: 100;
    }
    
   .panel-primary > .panel-heading {
	    	background-image :linear-gradient(to bottom,#333 0,#333 100%);
	    }
    
		
</style>
	
</head>
<body>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

<%-- <jsp:include page="/view/festival/modalTest.jsp"></jsp:include> --%>

<div class="container">
	
	<header>
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
				
				<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span>&nbsp;&nbsp;축제정보</h3>
		
		
				</div>
			</div>
		</div><!-- row -->
	</header>
	<!-- header 끝 -->
	
	<section>
	
	<div class="row">
		<div class="col-md-offset-2 col-md-8">
			<div class="panel panel-primary">
					<div class="panel-heading">
						
						<c:if test="${festival.festivalImage.contains('http://')==true }">
							<img src="${festival.festivalImage }" width="100%" height="300" />
						</c:if>
						
						<c:if test="${festival.festivalImage.contains('http://')==false }">
							<img src="../../resources/uploadFile/${festival.festivalImage }" width="100%" height="300" />
						</c:if>
						
					</div>
				</div>
			</div>
		</div>
		
			


	
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
				  <div class="panel-body text-center">
				  		<c:if test="${festival.isNull==true }">
							삭제되었던 축제입니다.
							</c:if>
						<c:if test="${returnZzim == null }">
							<div class="col-md-12">
								<h1><span class="glyphicon glyphicon-heart-empty" aria-hidden="true" id="tag"style = "color: red; cursor: pointer;"></span></h1>
								<%-- <input class="totalZzim" value="${totalZzim }"> --%>
								<p class="totalZzim">${totalZzim }</p>
							</div>
						</c:if>
						
						<div class="col-md-12">
							<c:if test="${returnZzim != null }">
								<h1><span class="glyphicon glyphicon-heart" style = "color: red; cursor: pointer;" aria-hidden="true" id="tag" ></span></h1>
								<%-- <input class="totalZzim" value="${totalZzim }"> --%>
								<p class="totalZzim">${totalZzim }</p>
							</c:if>
						</div>
				  	</div>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
				  <div class="panel-body text-center">
				  	<div id="map" style="width:200;height:350px;"></div>
						<p>
							<!-- <button onclick="setCenter()" class="btn btn-primary" >지도 중심좌표 이동시키기</button> --> 
							<button onclick="panTo()" class="btn btn-info" >원위치</button>
						</p>
					</div>
			  	</div>
			</div>
		</div>
		
		<!-- 축제정보  -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="col-md-12">
							<h3>
								<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
								<strong>축제정보</strong>
							</h3>
							<table class="table">
							
								<tr>
									<td class="col-md-3 active"><h4>조회수</h4></td>
									<td>${festival.readCount }</td>
								</tr>
								<tr>
									<td class="col-md-3 active"><h4>날씨</h4></td>
									<td>
										<h4>
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
										</h4>
									</td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>축제명</h4></td>
									<td><h4><Strong>${festival.festivalName }</Strong></h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>홈페이지</h4></td>
									<td>
										<h4>
											<c:if test="${festival.homepage!=null}">
										  		${festival.homepage }
										  	</c:if>	
									 	</h4>
									</td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>소개</h4></td>
									<td><h4>
									<c:if test="${festival.festivalOverview!=null }">
								  		${festival.festivalOverview }
								  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>개최장소</h4></td>
									<td><h4>
										<c:if test="${festival.addr!=null}">
									  		개최장소 : ${festival.addr }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>축제기간</h4></td>
									<td><h4>
										${festival.startDate } ~ ${festival.endDate }
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>내용</h4></td>
									<td><h4>
										<c:if test="${festival.festivalDetail!=null}">
									  		${festival.festivalDetail }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>연락처</h4></td>
									<td><h4>
										<c:if test="${festival.orgPhone!=null}">
									  		${festival.orgPhone }
									  	</c:if>	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>부대행사</h4></td>
									<td><h4>
										<c:if test="${festival.subEvent!=null}">
									  		${festival.subEvent }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>연령제한</h4></td>
									<td><h4>
										<c:if test="${festival.ageLimit!=null}">
									  		연령제한 : ${festival.ageLimit }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>예매처</h4></td>
									<td><h4>
									<c:if test="${festival.bookingPlace!=null}">
								  		${festival.bookingPlace }
								  	</c:if>	  	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>할인정보</h4></td>
									<td><h4>
									<c:if test="${festival.discount!=null}">
								  		${festival.discount }
								  	</c:if>  	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>행사프로그램</h4></td>
									<td><h4>
									<c:if test="${festival.program!=null}">
								  		${festival.program }
								  	</c:if>	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>공연시간</h4></td>
									<td><h4>
									<c:if test="${festival.playTime!=null}">		
								  		${festival.playTime }
								  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>관람소요시간</h4></td>
									<td><h4>
										<c:if test="${festival.spendTimeFestival!=null}">
									  		${festival.spendTimeFestival }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>이용요금</h4></td>
									<td><h4>
										<c:if test="${festival.useTimeFestival!=null}">
									  		${festival.useTimeFestival }
									  	</c:if>	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>티켓가격</h4></td>
									<td><h4>
											${festival.ticketPrice }
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>티켓수량</h4></td>
									<td><h4>
											${festival.ticketCount }
									</h4></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	<!-- hidden tag -->
	<input type = "hidden" class="form-control" id="festivalLongitude" name="festivalLongitude" value= "${festival.festivalLongitude }">
	<input type = "hidden" class="form-control" id="festivalLatitude" name="festivalLatitude" value= "${festival.festivalLatitude }">
	<input type = "hidden" class="form-control" id="festivalNo" name="festivalNo" value= "${festival.festivalNo }">
	<input type = "hidden" class="form-control" id="userId" name="userId" value= "${user.userId }">
	<input type = "hidden" class="form-control" id="userName" name="userName" value= "${user.userName }">
	<input type = "hidden" class="form-control" id="role" name="role" value= "${user.role }">
	<input type = "hidden" class="form-control" id="nickname" name="userId" value= "${user.nickname }">
	<input type = "hidden" class="form-control" id="isNull" name="isNull" value= "${festival.isNull }">
	
	
	
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-4 col-md-4">
			<c:if test= "${user.role=='a' }" >
			
				<c:if test="${ticket==null }">
				
					<c:if test="${festival.isNull==true }">
						<button type="button" class="btn btn-info vertical-align-middle">재등록</button>
					</c:if>
					
				</c:if>
				
			<c:if test="${ticket==null }">
			
				<c:if test="${festival.isNull==false }">
					<button type="button" class="btn btn-info vertical-align-middle">등록하기</button>
				</c:if>
				
			</c:if>
			
			<c:if test="${ticket!=null }">
			
				<button type="button" class="btn btn-info vertical-align-middle">수정하기</button>
				<button type="button" class="btn btn-info vertical-align-middle">삭제하기</button>
			</c:if>
			
				<button type="button" class="btn btn-info vertical-align-middle" id = "back" name = "back">뒤로</button>
				
			</c:if>
		</div>
		
		
		
		<div class="row">
			<div class="col-md-12">
				<div class="col-md-offset-4 col-md-4">
				  	<c:if test="${user.role!='a' }">
						<button type="button" class="btn btn-info vertical-align-middle">애프터파티 조회</button>
							<c:if test="${ticket.ticketFlag!='del'}">
								<button type="button" class="btn btn-info vertical-align-middle">티켓구매</button>
							</c:if>
						<button type="button" class="btn btn-info vertical-align-middle" id = "back" name = "back">뒤로</button>
					</c:if>
				</div>
			</div>
		</div>
		
		
	
			
		
		</div>
	</div>
	
	</section>
</div> <!--container -->
		
</body>
</html>