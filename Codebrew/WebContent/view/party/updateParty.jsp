<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>파티 수정 화면</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		function fncUpdateParty() {
	
			var partyName=$("input[name='partyName']").val();
			var partyDate=$("input[name='partyDate']").val();
			var partyDetail=$("textarea[name='partyDetail']").val();
			var partyPlace=$("input[name='partyPlace']").val();
			//var partyMemberLimit=$("input[name='partyMemberLimit']").val();
			var ticketCount=$("input[name='ticketCount']").val();
			var ticketPrice=$("input[name='ticketPrice']").val();
			var festivalNo=$("input[name='festival.festivalNo']").val();
			
			var checkNum = /\d/g;
			
			if(partyName == null || partyName.length <1){
				alert("파티이름은 반드시 입력하셔야 합니다.");
				return;
			}
			if(partyName.length >60){
				alert("파티이름은 60자 이내로 입력해주세요.");
				return;
			}
			if(partyDate == null || partyDate.length <1){
				alert("파티날짜는  반드시 입력하셔야 합니다.");
				return;
			}
			if(partyDetail == null || partyDetail.length <1){
				alert("파티설명은  반드시 입력하셔야 합니다.");
				return;
			}
			if(partyDetail.length >500){
				alert("파티설명은 500자 이내로 입력해주세요.");
				return;
			}
			if(partyPlace == null || partyPlace.length <1){
				alert("파티장소는 반드시 입력하셔야 합니다.");
				return;
			}
			if(festivalNo == 0){
				if(ticketCount != 0 && checkNum.test(ticketCount) == false){
					alert("티켓 수량은 반드시 숫자로 입력하셔야 합니다.");
					return;
				}
				if(ticketPrice != 0 && checkNum.test(ticketPrice) == false){
					alert("티켓 가격은 반드시 숫자로 입력하셔야 합니다.");
					return;
				}
				if(ticketCount == 0 && ticketPrice == 0){
					
						alert("티켓 수량이 무제한인 경우 티켓 가격을 반드시 입력하셔야 합니다.");
						return;
				}
			}	
			
			
			$("form").attr("method", "POST").attr("action", "/party/updateParty").submit();
		}
	
		
		//============= "수정"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button:contains('수정')" ).on("click" , function() {
				fncUpdateParty();
			});
		});	
		
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#']").on("click" , function() {
				history.go(-1);
			});
		});
		
		
		//============= "축제검색"  Event 연결 =============
		 function openChild(){
             
 			 // window.name = "부모창 이름"; 
             window.name = "parentForm";
             // window.open("open할 window", "자식창 이름", "팝업창 옵션");
             openWin = window.open("/view/festival/popupListDB.jsp",
                     "childForm", "width=570, height=350, resizable = no, scrollbars = yes");    
         }
		
		
		//============= "DatePicker"  Event 처리 및  연결 =============
		$(function() {
	      $( "#datepicker" ).datepicker({
	   	  	changeMonth: true, 
	        changeYear: true,
		    dateFormat: "y/mm/dd" 
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
	           buttonText: "Select date",
	           showOn: "button",
	           buttonImage: "/resources/image/ui/small_cal.jpg",
	           yearRange : "1990:2017"
	       });
		

		//============= "티켓"  Event 처리 및  연결 =============
		$(function() {
			//무료 티켓 선택시
			$("#freeTicket").click(function() {
				//alert("무료");
				$("#freeTicket").attr("disabled","disabled");
				$("#noFreeTicket").removeAttr("disabled");
				
				$("#ticketPrice").val(0);
				$("#ticketCount").val('');
				$("#ticketPrice").attr("readonly","readonly");
				
				$("#noLimitDiv").css("display", "none");
				
			});
			
			//유료 티켓 선택시
			$("#noFreeTicket").click(function() {
				//alert("유료");
				$("#noFreeTicket").attr("disabled","disabled");
				$("#freeTicket").removeAttr("disabled");
				
			    $("#ticketPrice").removeAttr("readonly");
			    
			    $("#noLimitDiv").css("display", "block");
				
			});
			
			//무제한 티켓 선택시
			$("#noLimit").click(function(){
				$("#ticketCount").val(0);
				
			});
		});
		
		
		//============= "파티 플래그"  Event 처리 및  연결 =============
		$(function(){
			if( "${party.festival.festivalNo}" == ""){
				
				$("#partyFlag").val("1");
				var partyFlag = $("#partyFlag").val();
				console.log(partyFlag);
				
				$("#festivalNameDiv").css("display", "none");
				$("#ticketDiv").css("display", "block");
				
				$("#festivalNo").val(0);
				$("#festivalName").val("");
				var festivalNo = $("#festivalNo").val();
				var festivalName = $("#festivalName").val();
				
				/* $("#ticketCountDiv").css("display", "block");
				$("#ticketPriceDiv").css("display", "block"); */
				
				if( "${ticket.ticketPrice}" != null ){
					$("#ticketPrice").val("${ticket.ticketPrice}");
				}
				if( "${ticket.ticketCount}" != null ){
					$("#ticketCount").val("${ticket.ticketCount}");
				}
				
				
				console.log("#party ==> "+festivalNo+" :: "+festivalName);
			
			}else{
			
				$("#partyFlag").val("2");
				var partyFlag = $("#partyFlag").val();
				console.log(partyFlag);
				
				$("#festivalNameDiv").css("display", "block");
				$("#ticketDiv").css("display", "none");
				
				$("#ticketCount").val(-1);
				$("#ticketPrice").val(-1);
				/* $("#festivalNo").val("${party.festival.festivalNo}");
				$("#festivalName").val("${party.festival.festivalName}");
				$("#partyPlace").val("${party.partyPlace}"); */
				var festivalNo = $("#festivalNo").val();
				var festivalName = $("#festivalName").val();
				var partyPlace = $("#addr").val();
				
				//console.log("#afterParty ==> "+festivalNo+" :: "+festivalName);
				console.log("#afterParty ==> "+festivalNo+" :: "+festivalName+" :: "+partyPlace);
			
			}
		});
		
		
		//============= "사진 미리보기"  Event 처리 및  연결 =============
		function getUploadFilePrivew(html, $target) {
		    if (html.files && html.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $target.css('display', '');
		            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
		            $target.html('<img src="' + e.target.result + '"width="50%" border="0" alt="" />');
		        }
		        reader.readAsDataURL(html.files[0]);
		    }
		}
		
	</script>
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style type="text/css">
		
		body {
	     	padding-top : 70px;
	    }
	    
	    #festivalNameDiv {
			display: none;
		}
		#ticketCountDiv {
			display: block;
		}
		#ticketPriceDiv {
			display: block;
		}
		.filebox label {
		    display: inline-block;
		    padding: .5em .75em;
		    color: #999;
		    font-size: inherit;
		    line-height: normal;
		    vertical-align: middle;
		    background-color: #e0f4ff;
		    cursor: pointer;
		    border: 1px solid #ebebeb;
		    border-bottom-color: #e2e2e2;
		    border-radius: .25em;
		    width:50%;
		    max-width:100%;
		}
		.filebox input[type="file"] {  /* 파일 필드 숨기기 */
		    position: absolute;
		    width: 1px;
		    height: 1px;
		    padding: 0;
		    margin: -1px;
		    overflow: hidden;
		    clip:rect(0,0,0,0);
		    border: 0;
		}
	</style>
	
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span>${ empty party.festival.festivalNo  ? '파티 수정' : '애프터 파티 수정'}</h3>
					<small>파티 내용을 수정해주세요.</small>
				</div>
			</div>
		</div>
		
		<br>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
			<div class="form-group">
				<%-- <label for="host" class="col-sm-offset-1 col-sm-2 control-label">파티
					호스트</label>
				<div class="col-sm-6">
					<img class="img-circle"
						src="/resources/uploadFile/${party.user.profileImage}" width="50"
						height="50"> ${ party.user.nickname } <input type="hidden"
						class="form-control" id="user.userId" name="user.userId"
						value="${ party.user.userId }" />
				</div> --%>

				<div class="form-group text-center" id="previewImage">
					<img src="../../resources/uploadFile/${party.partyImage}"
						width="50%"> <br>
				</div>

				<div class="form-group">
					<div class="filebox">
						<label for="uploadFile">파티 이미지 업로드 (클릭하여 선택)</label>
						<div class="col-sm-3">
							<input type="file" name="uploadFile" id="uploadFile"
								onchange="getUploadFilePrivew(this,$('#previewImage'))" /> <br />
							<br />
						</div>

					</div>
				</div>
				<hr>
			</div>

			<%-- <c:if test="${ party.festival != null }"> --%>
			<div class="form-group" id="festivalNameDiv">
				<label for="festivalName"
					class="col-sm-offset-1 col-sm-2 control-label">축제명</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="festivalName"
						name="festival.festivalName"
						value="${ party.festival.festivalName }" />
					
					<input type="hidden" class="form-control" id="festivalNo"
						name="festival.festivalNo"
						value=${ !empty party.festival.festivalNo ? party.festival.festivalNo : 0 }>
				</div>
				<div class="col-sm-2 text-center">
					<button type="button" class="btn btn-primary btn-block"
						name="searchFestival" onclick="openChild()">축제검색</button>
				</div>
			</div>
			<%-- </c:if> --%>

			<div class="form-group">
				<label for="partyName"
					class="col-sm-offset-1 col-sm-2 control-label">파티이름</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="partyName"
						name="partyName" value="${ party.partyName }"> 
					<input type="hidden" class="form-control" id="partyNo" name="partyNo" value="${ party.partyNo }">
				</div>
			</div>

			<div class="form-group">
				<label for="partyDate" class="col-sm-offset-1 col-sm-2 control-label">파티날짜</label>
				<div class="col-sm-6">
					<input type="text" readonly="readonly" class="form-control" id="datepicker" name="partyDate" value="${ party.partyDate }">
				</div>
			</div>

			<div class="form-group">
				<label for="partyName" class="col-sm-offset-1 col-sm-2 control-label">파티시간</label> 
					
					<span class="col-sm-1"> 
						<select name="hour">
						<option value="00" selected>00</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
				</select>
				</span>
				<span class="col-sm-1">시</span> 
						<span class="col-sm-1"> 
						<select name="minutes">
						<option value="00" selected>00</option>
						<option value="10">10</option>
						<option value="20">20</option>
						<option value="30">30</option>
						<option value="40">40</option>
						<option value="50">50</option>
				</select> <!-- <input type="text" class="form-control" id="minutes" name="minutes"/> -->
				</span><span class="col-sm-1">분</span>
			</div>

			<div class="form-group">
				<label for="partyDetail"
					class="col-sm-offset-1 col-sm-2 control-label">파티설명</label>
				<div class="col-sm-6">
					<textarea class="form-control" name="partyDetail" rows="10"
						cols="50">${ party.partyDetail }</textarea>
				</div>
			</div>

			<div class="form-group">
				<label for="partyPlace"
					class="col-sm-offset-1 col-sm-2 control-label">파티장소</label>
				<div class="col-sm-6">
					<input type="text" readonly="readonly" class="form-control"
						id="addr" name="partyPlace" value="${ party.partyPlace }">
				</div>
				
				<!-- <button type="button" class="btn btn-primary" id="search-partyPlace"  >검색</button> -->
				<%@include file="/view/party/searchAddr.jsp"%>
				
			</div>

			<div id=ticketDiv>
				<div class="form-group">
					<label for="partyFlag"
						class="col-sm-offset-1 col-sm-2 control-label">티켓</label>

					<div class="col-sm-2">
						<button type="button" class="btn btn-primary btn-block"
							name="ticketPriceFlag" id="freeTicket" disabled>무료티켓</button>
					</div>
					<div class="col-sm-2">
						<button type="button" class="btn btn-primary btn-block"
							name="ticketPriceFlag" id="noFreeTicket">유료티켓</button>
					</div>
				</div>

				<div class="form-group">
					<label for="ticketCount"
						class="col-sm-offset-1 col-sm-2 control-label">티켓수량</label>
					<div class="col-sm-2">
						<input type="text" class="form-control" id="ticketCount"
							name="ticketCount">
					</div>
					<div class="col-sm-2" id="noLimitDiv">
						<button type="button" class="btn btn-primary btn-block"
							name="noLimit" id="noLimit">무제한</button>
					</div>
				</div>

				<div class="form-group">
					<label for="ticketPrice"
						class="col-sm-offset-1 col-sm-2 control-label">티켓가격</label>
					<div class="col-sm-2">
						<input type="text" readonly="readonly" class="form-control"
							id="ticketPrice" name="ticketPrice" value="0">
					</div>
				</div>
			</div>

			<div class="form-group">
				<br><br>
				<div class="col-sm-offset-3 col-sm-6">
					<span>
						<button type="button" class="btn btn-info btn-block">수정</button>
						<a class="btn btn-default btn btn-block" href="#" role="button">취소</a>
					</span>
				</div>
			</div>
		</form>


		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>
</html>