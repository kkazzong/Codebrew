<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <%@include file="/view/festival/admin.jsp"%> --%>

<%-- <%@include file="/view/festival/user.jsp"%> --%>



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
			self.location = "/festival/updateFestivalView?festivalNo="+${festival.festivalNo};
		});
	});
			
		 $(function(){
			 
			 $("p:contains('♡')").on("click", function() {
				 		
					$.ajax( 
							{
								url : "/festivalRest/json/addZzim/${user.userId}/${festival.festivalNo}",
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {
	
											var displayValue = "<p>♥</p>";
								
									$(this).remove();
									$("p").html(displayValue);
									location.reload();
								
								}
						});
			 });
		 });
		 
$(function(){
			 
			 $("p:contains('♥')").on("click", function() {
				 		
					$.ajax( 
							{
								url : "/festivalRest/json/deleteZzim/${user.userId}/${festival.festivalNo}",
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								
								success : function(JSONData , status) {
	
											var displayValue = "<p>♡</p>";
									
									$(this).remove();
									$("p").html(displayValue);
									
									location.reload();
								
								}
						});
			 });
		 });
	
			 
		</script>		
	
</head>
<body>

<div id="map" style="width:100%;height:350px;"></div>
	<p>
<button onclick="setCenter()">지도 중심좌표 이동시키기</button> 
<button onclick="panTo()">지도 중심좌표 부드럽게 이동시키기</button>
	</p>
	
	<br/>
	<br/>
	
		
	<br/>
	<br/>
	
	
	축제번호 : ${festival.festivalNo }
	
	<br/>
	<br/>
	
	홈페이지 :  ${festival.homepage }
	
	<br/>
	<br/>
	
	축제명 : ${festival.festivalName }
		
	<br/>
	<br/>

	
	 <img src = "${festival.festivalImage }" />
	 
	 
	 
	 <c:if test="${returnZzim == null }">
		<p>♡</p>
	</c:if>
	
	<c:if test="${returnZzim != null }">
		<p>♥</p>
	</c:if>
	
	
	
	 
	 	
	<br/>
	<br/>
	
	소개 : ${festival.festivalOverview }
	
		
	<br/>
	<br/>
	
	 
	
	개최장소 : ${festival.addr }
	
	<br/>
	<br/>
	
	축제기간 : ${festival.startDate } ~ ${festival.endDate }
	
	<br/>
	<br/>
	
	내용 : ${festival.festivalDetail }
	
	<br/>
	<br/>
	
	연락처 : ${festival.orgPhone }
	
	<br/>
	<br/>
	
	연령제한 : ${festival.ageLimit }
		
	<br/>
	<br/>
	
	
	예매처 : ${festival.bookingPlace }
		
	<br/>
	<br/>
	
	
	할인정보 : ${festival.discount }
		
	<br/>
	<br/>
	
	
	행사프로그램 : ${festival.program }
		
	<br/>
	<br/>
	
	
	공연시간 : ${festival.playTime }
		
	<br/>
	<br/>
	
	
	관람소요시간 : ${festival.spendTimeFestival }
		
	<br/>
	<br/>
	
	
	부대행사 : ${festival.subEvent }
		
	<br/>
	<br/>
	
	
	이용요금 : ${festival.useTimeFestival }
		
	<br/>
	<br/>
	
	<c:if test= "${user.role=='u' }" >
	
	티켓가격 : ${festival.ticketPrice }
		
	<br/>
	<br/>
	
	
	티켓수량 : ${festival.ticketCount }
		
	<br/>
	<br/>
	
	</c:if>
	
	
	<input type = "hidden" class="form-control" id="festivalLongitude" name="festivalLongitude" value= "${festival.festivalLongitude }">
	<input type = "hidden" class="form-control" id="festivalLatitude" name="festivalLatitude" value= "${festival.festivalLatitude }">
	<input type = "hidden" class="form-control" id="festivalNo" name="festivalNo" value= "${festival.festivalNo }">
	
	<!-- user sample  -->
	
	<input type = "hidden" class="form-control" id="userId" name="userId" value= "${user.userId }">
	<input type = "hidden" class="form-control" id="userName" name="userName" value= "${user.userName }">
	<input type = "hidden" class="form-control" id="role" name="role" value= "${user.role }">
	<input type = "hidden" class="form-control" id="nickname" name="userId" value= "${user.nickname }">
	
	
	
	
	
	<c:if test= "${user.role=='a' }" >
		
		<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
				
				<c:if test="${ticket==null }">
					<button type="button" class="btn btn-primary">등록하기</button>
				</c:if>
			
				<c:if test="${ticket!=null }">
					<button type="button" class="btn btn-primary">수정하기</button>
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