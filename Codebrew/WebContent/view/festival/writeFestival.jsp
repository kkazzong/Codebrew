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
	
	<!--map  -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a6419e542017d8fd315556f745f29fcf&libraries=services"></script>
	
		<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>

	
	<script type="text/javascript">
	
	$(function() {
		$("button[type='button']").on("click", function() {

			fncWriteFestival();
		});
	});
	
	function fncWriteFestival() {
		
		var festivalName=$("textarea[name='festivalName']").val();
		
		if(festivalName == null || festivalName.length <1){
			alert("축제명은 반드시 한 글자 이상 입력하셔야 합니다.");
			return;
		}
		
		$('form').attr("method","POST").attr("enctype", "multipart/form-data").attr("action", "/festival/writeFestival").submit();
	}
	
   function sample5_execDaumPostcode() {
       new daum.Postcode({
           oncomplete: function(data) {
               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullAddr = data.address; // 최종 주소 변수
               var extraAddr = ''; // 조합형 주소 변수

               // 기본 주소가 도로명 타입일때 조합한다.
               if(data.addressType === 'R'){
                   //법정동명이 있을 경우 추가한다.
                   if(data.bname !== ''){
                       extraAddr += data.bname;
                   }
                   // 건물명이 있을 경우 추가한다.
                   if(data.buildingName !== ''){
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                   fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
               }

               // 주소 정보를 해당 필드에 넣는다.
               document.getElementById("addr").value = fullAddr;
               // 주소로 상세 정보를 검색
               var geocoder = new daum.maps.services.Geocoder();
               geocoder.addressSearch(data.address, function(results, status) {
                   // 정상적으로 검색이 완료됐으면
                   if (status === daum.maps.services.Status.OK) {

                       var result = results[0]; //첫번째 결과의 값을 활용
                       
                       document.getElementById("festivalLatitude").value = result.x;
                       document.getElementById("festivalLongitude").value = result.y;
                       
                   }
               });
           }
       }).open();
   }
		
		
		$(function(){
			$("#back").on("click", function(){
				$('form').reset();
			});
		});
		
		$(function() {
			$('#startDate').datepicker(
					{

						dateFormat : "yymmdd",
						showMonthAfterYear : true,
						changeMonth: true,
					    changeYear: true,
					    yearRange: 'c-100:c+10',
						dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
								'8월', '9월', '10월', '11월', '12월' ]
					});
		});
		
		$(function() {
			$('#endDate').datepicker(
					{

						dateFormat : "yymmdd",
						showMonthAfterYear : true,
						changeMonth: true,
					    changeYear: true,
					    yearRange: 'c-100:c+10',
						dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
								'8월', '9월', '10월', '11월', '12월' ]
					});
		});
		
		$.datepicker.setDefaults({
	        dateFormat: 'yy-mm-dd',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        yearSuffix: '년',
	        changeMonth: true,
			changeYear : true,
			buttonImageOnly: true,
		    yearRange : "1990:2017"
    	});
		

		
		</script>		
	
</head>
<body>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	


	<form name="detailForm" class="form-horizontal">
                          
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

	
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
			<%-- <img src="${festival.festivalImage }" width="300" height="300"/> --%>
			<input type = "hidden" class="form-control" id="festivalImage" name="festivalImage" value= "${festival.festivalImage }">
			
			<input type="file" id="festivalImage" name="file" class="form-control">
			
		</div>	
		
	</div>
		
<br/>
<br/>

	<div class="form-group">
	
		<label for="addr" class="col-sm-offset-1 col-sm-3 control-label">개최장소</label>
		
		<div class="col-sm-4">
		
			<input type="text" class="form-control" id="addr" name = "addr" placeholder="주소">
			<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
			<input type="hidden" class="form-control" id="festivalLongitude" name="festivalLatitude">
			<input type="hidden" class="form-control" id="festivalLatitude" name="festivalLongitude" >
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
		
		
		<!-- 시퀀스 -->
		<!-- <input type = "hidden" class="form-control" id="festivalNo" name="festivalNo"> -->
		
		
		<input type = "hidden" class="form-control" id="contentTypeId" name="contentTypeId" value= "15">
		<!-- <input type = "hidden" class="form-control" id="readCount" name="readCount"> -->
		
		<!--주소검색시 맨앞 파싱해서 비교  -->
		<%-- <input type = "hidden" class="form-control" id="areaCode" name="areaCode" value= "${festival.areaCode }"> --%>
		
		<!--일단은 null  -->
		<input type = "hidden" class="form-control" id="sigunguCode" name="sigunguCode" value= "${festival.sigunguCode }">
		

	<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" class="btn btn-primary">등록</button>
					<input type = "button" id = "back" name = "back" value = "취소"/>
				</div>
			</div>
	
	</form>
	
</body>
</html>