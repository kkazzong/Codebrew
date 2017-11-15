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
		$("button:contains('수정')").on("click", function() {
			
			if(confirm("축제를 수정하시겠습니까?")) {
				fncUpdateFestival();
			} else {
				return;
			}
		});
	});
	
	function fncUpdateFestival() {
		
		var frm = document.detailForm ;
		var tp = frm.ticketPrice.value ;
		var tc = frm.ticketCount.value ;
		
		var festivalName=$("#festivalName").val();
		var startDate=$("#startDate").val();
		var endDate=$("#endDate").val();
		var addr=$("#addr").val();
		
		if(festivalName == null || festivalName.length <1){
			alert("축제명은 반드시 한 글자 이상 입력하셔야 합니다.");
			return;
		}
		
		if(startDate == null || startDate.length <1){
			alert("축제시작일을 입력하세요.");
			return;
		}
		
		if(endDate == null || endDate.length <1){
			alert("축제종료일을 입력하세요.");
			return;
		}
		
		if(addr == null || addr.length <1){
			alert("장소를 입력하세요.");
			return;
		}
		/* if(ticketPrice == null || ticketPrice == ''){
		var ticketPrice=$("#ticketPrice").val(0);
	} */
	
	//자바스크립트 정규식 숫자 / 길이 체크!
	if( tp == "" ){
		
		alert ( " 숫자를 입력해주세요" )
		frm.tp.value="";
		frm.tp.focus();
		return false;
		
	}else{
		
		var num_check=/^[0-9]*$/;
		if(!num_check.test(tp)) {
			
			alert ( "숫자만 입력할 수 있습니다." );
			frm.tp.value="";
			frm.tp.focus();
			return false;
			}
	 
		}
	
	//자바스크립트 정규식 숫자 / 길이 체크!
	if( tc == "" ){
		
		alert ( " 숫자를 입력해주세요" )
		frm.tc.value="";
		frm.tc.focus();
		return false;
		
	}else{
		
		var num_check=/^[0-9]*$/;
		if(!num_check.test(tc)) {
			
			alert ( "숫자만 입력할 수 있습니다." );
			frm.tc.value="";
			frm.tc.focus();
			return false;
			}
	}
		
		$('form').attr("method","POST").attr("enctype", "multipart/form-data").attr("action", "/festival/updateFestival").submit();
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
		
		
		/* $(function(){
			$("#back").on("click", function(){
				$('form').reset();
			});
		}); */
		
		$(function(){
			$("#back").on("click", function(){
				$('form').reset();
			});
		});
		
		$(function() {
			$("button:contains('재등록')").on("click", function() {
 
				$('form').attr("method","POST").attr("enctype", "multipart/form-data").attr("action", "/festival/updateFestival").submit();
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
		
		
		<style type="text/css">
			.img_wrap{
        	width:600px;
        	margin-top: 50px;
        }
        
        .img_wrap img{
        max-width: 200px;
        }
        
        .form-control{
        	resize: none; /* cannot be changed by the user */
        }
        
 		body {
            padding-top : 50px;
            background-color: #f2f4f6;
        }
        
        .imgs_wrap { 
        	/* border: 3px solid #333; */
        	/* width: 600px; */
        	/* height : 120px; */
        	margin-top: 50px;
        	aling-items: center;
        	justify-content: center;
        }
        
        .imgs_wrap img {
        	max-width: 200px;
        }
		
		</style>
	
</head>
<body>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

	<div class="row">
		<div class="col-md-12">
		
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-list" aria-hidden="true"></span>축제수정</h3>
				</div>
			</div>
		</div> 
			
				<form class="form-horizontal" method="post" name="detailForm" enctype="multipart/form-data">
					<div class = "form-group">
	
						<label for ="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제명</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="festivalName" name="festivalName" value="${festival.festivalName }">
							</div>
					</div>
					
					<hr/>
					
					<div class = "form-group">
	
						<label for ="festivalOverview" class="col-sm-offset-1 col-sm-3 control-label">소개</label>
							<div class="col-md-4">
								<textarea rows="5" cols="50" class="form-control" id="festivalOverview" name="festivalOverview">${festival.festivalOverview }</textarea>
							</div>
					</div>
					
					<hr/>
					
					<div class = "form-group">
	
						<label for ="file" class="col-sm-offset-1 col-sm-3 control-label">이미지</label>
						
				<c:if test="${festival.festivalImage.contains('http://')==true }">
				 <div class="col-md-4">
					<img id="img" src="${festival.festivalImage }" width="360" height="300"/>
					<input type = "hidden" class="form-control" name="festivalImage" value= "${festival.festivalImage }">
					<input type="file" id="festivalImage" name="file" class="form-control btn-info" value="${festival.festivalImage }">
				</div>
				</c:if>
				
				<c:if test="${festival.festivalImage.contains('http://')==false }">
				<div class="col-md-4">
					<img id="img" src="../../resources/uploadFile/${festival.festivalImage }" width="360" height="300"/>
					<input type = "hidden" class="form-control" name="festivalImage" value= "${festival.festivalImage }">
					<input type="file" id="festivalImage" name="file" class="form-control btn-info" value= "${festival.festivalImage }" >
				</div>
				</c:if>
	</div>
				
				<hr/>
				
				<div class="form-group">
					<label for="addr" class="col-sm-offset-1 col-sm-3 control-label">개최장소</label>
						<div class="col-md-4">
							<input type="text" class="form-control" id="addr" name = "addr" placeholder="주소" value="${festival.addr }">
							<input type="button" class="btn-info" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
							<input type="hidden" class="form-control" id="festivalLongitude" name="festivalLatitude" value="${festival.festivalLatitude }">
							<input type="hidden" class="form-control" id="festivalLatitude" name="festivalLongitude" value="${festival.festivalLongitude }" >
						</div>
				</div>
				
				<hr/>
				
				<div class = "form-group">
					<label for ="startDate" class="col-sm-offset-1 col-sm-3 control-label">축제시작일자</label>
						<div class="col-md-4">
							<input type = "text" class="form-control" id="startDate" name="startDate" value= "${festival.startDate }">
						</div>	
				</div>
				
				<hr/>
				
				
				<div class = "form-group">
					<label for ="endDate" class="col-sm-offset-1 col-sm-3 control-label">축제종료일자</label>
						<div class="col-md-4">
							<input type = "text" class="form-control" id="endDate" name="endDate" value= "${festival.endDate }">
						</div>	
					
				</div>
				
				<hr/>
				
				<div class = "form-group">
					<label for ="festivalDetail" class="col-sm-offset-1 col-sm-3 control-label">내용을 입력하세요</label>
						<div class="col-md-4">
							<textarea rows="10" class="form-control" cols="54" name="festivalDetail">${festival.festivalDetail }</textarea>
						</div>	
				</div>
				
				<hr/>
				
				<div class = "form-group">
					<label for ="orgPhone" class="col-sm-offset-1 col-sm-3 control-label">연락처</label>
						<div class="col-md-4">
							<textarea rows="2" cols="54" class="form-control" name="orgPhone">${festival.orgPhone }</textarea>
						</div>	
				</div>
				
				<hr/>
				
				<div class = "form-group">
					<label for ="ageLimit" class="col-sm-offset-1 col-sm-3 control-label">연령제한</label>
						<div class="col-md-4">
							<textarea rows="2" cols="54" class="form-control" name="ageLimit">${festival.ageLimit }</textarea>
						</div>	
				</div>
			
				<hr/>
				
				<div class = "form-group">
			
					<label for ="bookingPlace" class="col-sm-offset-1 col-sm-3 control-label">예매처</label>
						<div class="col-sm-4">
							<textarea rows="2" cols="54" class="form-control" name="bookingPlace">${festival.bookingPlace }</textarea>
						</div>	
				</div>
				
				<hr/>
				
								
				<div class = "form-group">
						<label for ="program" class="col-sm-offset-1 col-sm-3 control-label">행사프로그램</label>
							<div class="col-md-4">
								<textarea rows="2" cols="54" class="form-control" name="program">${festival.program }</textarea>
							</div>	
				</div>
				
				<hr/>
				
				
				<div class = "form-group">
					<label for ="playTime" class="col-sm-offset-1 col-sm-3 control-label">공연시간</label>
						<div class="col-md-4">
							<textarea rows="2" cols="54" class="form-control" name="playTime">${festival.playTime }</textarea>
						</div>	
				</div>
				
				<hr/>
				
				<div class = "form-group">
					<label for ="spendTimeFestival" class="col-sm-offset-1 col-sm-3 control-label">관람소요시간</label>
						<div class="col-md-4">
							<textarea rows="2" cols="54" class="form-control" name="spendTimeFestival">${festival.spendTimeFestival }</textarea>
						</div>	
				</div>
				
				<hr/>
				
			<div class = "form-group">
				<label for ="subEvent" class="col-sm-offset-1 col-sm-3 control-label">부대행사</label>
					<div class="col-md-4">
						<textarea rows="2" cols="54" class="form-control" name="subEvent">${festival.subEvent }</textarea>
					</div>	
			</div>
			
			<hr/>
			
			<div class = "form-group">
				<label for ="useTimeFestival" class="col-sm-offset-1 col-sm-3 control-label">이용요금</label>
					<div class="col-md-4">
						<textarea rows="2" cols="54" class="form-control" name="useTimeFestival">${festival.useTimeFestival }</textarea>
					</div>	
			</div>
			
			<hr/>
			
			<div class = "form-group">
				<label for ="ticketPrice" class="col-sm-offset-1 col-sm-3 control-label">티켓가격</label>
					<div class="col-md-4">
						<input type = "text" class="form-control" class="form-control" id="ticketPrice" name="ticketPrice" value= "${festival.ticketPrice }">
					</div>	
			</div>
			
			<hr/>
			<div class = "form-group">
				<label for ="ticketCount" class="col-sm-offset-1 col-sm-3 control-label">티켓수량</label>
					<div class="col-md-4">
						<input type = "text" class="form-control" class="form-control" id="ticketCount" name="ticketCount" value= "${festival.ticketCount }">
					</div>	
			</div>
				
				
		<%-- <input type = "hidden" class="form-control" id="festivalLongitude" name="festivalLongitude" value= "${festival.festivalLongitude }">
		<input type = "hidden" class="form-control" id="festivalLatitude" name="festivalLatitude" value= "${festival.festivalLatitude }"> --%>
		<input type = "hidden" class="form-control" id="festivalNo" name="festivalNo" value= "${festival.festivalNo }">
		<input type = "hidden" class="form-control" id="contentTypeId" name="contentTypeId" value= "${festival.contentTypeId }">
		<input type = "hidden" class="form-control" id="readCount" name="readCount" value= "${festival.readCount }">
		<input type = "hidden" class="form-control" id="areaCode" name="areaCode" value= "${festival.areaCode }">
		<input type = "hidden" class="form-control" id="sigunguCode" name="sigunguCode" value= "${festival.sigunguCode }">
		<input type = "hidden" class="form-control" id="contentTypeId" name="contentTypeId" value= "15">
		<input type = "hidden" class="form-control" id="sigunguCode" name="sigunguCode" value= "${festival.sigunguCode }">
				
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
				<c:if test="${festival.isNull==true }">
					<button type="button" class="btn btn-info">재등록</button>
				</c:if>
				
				<c:if test="${festival.isNull==false }">
					<button type="button" class="btn btn-info">수정</button>
				</c:if>
					<input type = "button" class="btn btn-info" id = "back" name = "back" value = "내용삭제"/>
				</div>
			</div>
					
				
			</form>
		</div>
	</div>
</div>
</body>
</html>