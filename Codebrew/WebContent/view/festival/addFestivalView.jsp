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
				$('form').reset();
			});
		});
		
		$(function() {
			$("button[type='button']").on("click", function() {

				$('form').attr("method","POST").attr("enctype", "multipart/form-data").attr("action", "/festival/addFestival").submit();
			});
		});

		
		</script>		
	
</head>
<body>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

	<div id="map" style="width:100%;height:350px;"></div>
		<p>
			<button onclick="setCenter()">지도 중심좌표 이동시키기</button> 
			<button onclick="panTo()">지도 중심좌표 부드럽게 이동시키기</button>
		</p> 

	

<br/>
<br/>

<form name="detailForm" class="form-horizontal">
	
	<div class = "form-group">
	
		<label for ="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제명</label>
		
		<div class="col-sm-4">
			<%-- <input type="text" class="form-control" id="festivalName" name="festivalName" value= "${festival.festivalName }"> --%>
				<textarea rows="5" cols="30" name="festivalName">${festival.festivalName }</textarea>
		</div>
	
	</div>
	
<br/>
<br/>

	<div class = "form-group">
	
		<label for ="festivalOverview" class="col-sm-offset-1 col-sm-3 control-label">소개</label>
	
		<div class="col-sm-4">
			<%-- <input type="text" class="form-control" id="festivalOverview" name="festivalOverview"  value= "${festival.festivalOverview }"> --%>
			<textarea rows="5" cols="30" name="festivalOverview">${festival.festivalOverview }</textarea>
			
		</div>
	
	</div>
<br/>
<br/>

	<div class = "form-group">
	
		<label for ="file" class="col-sm-offset-1 col-sm-3 control-label">이미지</label>
		
		<div class="col-sm-4">
			<img src="${festival.festivalImage }" width="300" height="300"/>
			<input type = "hidden" class="form-control" id="festivalImage" name="festivalImage" value= "${festival.festivalImage }">
			
			<input type="file" id="festivalImage" name="file" class="form-control">
			
			
		</div>	
		
	</div>
		
<br/>
<br/>

	<div class = "form-group">
		
			<label for ="addr" class="col-sm-offset-1 col-sm-3 control-label">개최장소</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="addr" name="addr" value= "${festival.addr }"> --%>
				<textarea rows="5" cols="30" name="addr">${festival.addr }</textarea>
			</div>	
			
		</div>

<br/>
<br/>

		<div class = "form-group">
		
			<label for ="startDate" class="col-sm-offset-1 col-sm-3 control-label">축제시작일자</label>
			
			<div class="col-sm-4">
				<input type = "text" class="form-control" id="startDate" name="startDate" value= "${festival.startDate }">
			</div>	
			
		</div>
<br/>
<br/>

		<div class = "form-group">
		
			<label for ="endDate" class="col-sm-offset-1 col-sm-3 control-label">축제종료일자</label>
			
			<div class="col-sm-4">
				<input type = "text" class="form-control" id="endDate" name="endDate" value= "${festival.endDate }">
			</div>	
			
		</div>
<br/>
<br/>

	<div class = "form-group">
		
			<label for ="festivalDetail" class="col-sm-offset-1 col-sm-3 control-label">내용을 입력하세요</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="festivalDetail" name="festivalDetail" value= "${festival.festivalDetail }"> --%>
				<textarea rows="5" cols="30" name="festivalDetail">${festival.festivalDetail }</textarea>
			</div>	
			
		</div>
		
<br/>
<br/>

		<div class = "form-group">
		
			<label for ="orgPhone" class="col-sm-offset-1 col-sm-3 control-label">연락처</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="orgPhone" name="orgPhone" value= "${festival.orgPhone }"> --%>
				<textarea rows="5" cols="30" name="orgPhone">${festival.orgPhone }</textarea>
			</div>	
			
		</div>

<br/>
<br/>

		<div class = "form-group">
		
			<label for ="ageLimit" class="col-sm-offset-1 col-sm-3 control-label">연령제한</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="ageLimit" name="ageLimit" value= "${festival.ageLimit }"> --%>
				<textarea rows="5" cols="30" name="ageLimit">${festival.ageLimit }</textarea>
			</div>	
			
		</div>

<br/>
<br/>

	<div class = "form-group">
		
			<label for ="bookingPlace" class="col-sm-offset-1 col-sm-3 control-label">예매처</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="bookingPlace" name="bookingPlace" value= "${festival.bookingPlace }"> --%>
				<textarea rows="5" cols="30" name="bookingPlace">${festival.bookingPlace }</textarea>
			</div>	
			
		</div>

<br/>
<br/>

	<div class = "form-group">
		
			<label for ="discount" class="col-sm-offset-1 col-sm-3 control-label">할인정보</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="discount" name="discount" value= "${festival.discount }"> --%>
				<textarea rows="5" cols="30" name="discount">${festival.discount }</textarea>
			</div>	
			
		</div>

<br/>
<br/>
	
	<div class = "form-group">
		
			<label for ="program" class="col-sm-offset-1 col-sm-3 control-label">행사프로그램</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="program" name="program" value= "${festival.program }"> --%>
				<textarea rows="5" cols="30" name="program">${festival.program }</textarea>
			</div>	
			
		</div>

<br/>
<br/>

		<div class = "form-group">
		
			<label for ="playTime" class="col-sm-offset-1 col-sm-3 control-label">공연시간</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="playTime" name="playTime" value= "${festival.playTime }"> --%>
				<textarea rows="5" cols="30" name="playTime">${festival.playTime }</textarea>
			</div>	
			
		</div>


<br/>
<br/>

		<div class = "form-group">
		
			<label for ="spendTimeFestival" class="col-sm-offset-1 col-sm-3 control-label">관람소요시간</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="spendTimeFestival" name="spendTimeFestival" value= "${festival.spendTimeFestival }"> --%>
				<textarea rows="5" cols="30" name="spendTimeFestival">${festival.spendTimeFestival }</textarea>
			</div>	
			
		</div>

<br/>
<br/>

	<div class = "form-group">
		
			<label for ="subEvent" class="col-sm-offset-1 col-sm-3 control-label">부대행사</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="subEvent" name="subEvent" value= "${festival.subEvent }"> --%>
				<textarea rows="5" cols="30" name="subEvent">${festival.subEvent }</textarea>
			</div>	
			
		</div>

<br/>
<br/>

		<div class = "form-group">
		
			<label for ="useTimeFestival" class="col-sm-offset-1 col-sm-3 control-label">이용요금</label>
			
			<div class="col-sm-4">
				<%-- <input type = "text" class="form-control" id="useTimeFestival" name="useTimeFestival" value= "${festival.useTimeFestival }"> --%>
				<textarea rows="5" cols="30" name="useTimeFestival">${festival.useTimeFestival }</textarea>
			</div>	
			
		</div>
	

<br/>
<br/>

	<div class = "form-group">
		
			<label for ="ticketPrice" class="col-sm-offset-1 col-sm-3 control-label">티켓가격</label>
			
			<div class="col-sm-4">
				<input type = "text" class="form-control" id="ticketPrice" name="ticketPrice" value= "${festival.ticketPrice }">
			</div>	
			
		</div>


<br/>
<br/>

		<div class = "form-group">
		
			<label for ="ticketCount" class="col-sm-offset-1 col-sm-3 control-label">티켓수량</label>
			
			<div class="col-sm-4">
				<input type = "text" class="form-control" id="ticketCount" name="ticketCount" value= "${festival.ticketCount }">
			</div>	
			
		</div>
		
		<input type = "hidden" class="form-control" id="festivalLongitude" name="festivalLongitude" value= "${festival.festivalLongitude }">
		<input type = "hidden" class="form-control" id="festivalLatitude" name="festivalLatitude" value= "${festival.festivalLatitude }">
		<input type = "hidden" class="form-control" id="festivalNo" name="festivalNo" value= "${festival.festivalNo }">
		<input type = "hidden" class="form-control" id="contentTypeId" name="contentTypeId" value= "${festival.contentTypeId }">
		<input type = "hidden" class="form-control" id="readCount" name="readCount" value= "${festival.readCount }">
		<input type = "hidden" class="form-control" id="areaCode" name="areaCode" value= "${festival.areaCode }">
		<input type = "hidden" class="form-control" id="sigunguCode" name="sigunguCode" value= "${festival.sigunguCode }">
		

	<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" class="btn btn-primary">등록</button>
					<input type = "button" id = "back" name = "back" value = "내용삭제"/>
				</div>
			</div>
	
	</form>
	
</body>
</html>