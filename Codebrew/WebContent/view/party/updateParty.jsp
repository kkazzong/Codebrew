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
    <link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= "수정"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button:contains('수정')" ).on("click" , function() {
				$("form").attr("method" , "POST").attr("action" , "/party/updateParty").attr("enctype","multipart/form-data").submit();
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
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button:contains('축제검색')" ).on("click" , function() {
				//$("form").attr("method", "POST").attr("action", "/party/addParty").submit();
				
				var pop = window.open("/view/festival/getFestivalListDB.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
				
			});
			
			// 애프터 파티의 경우 축제 장소 자동 입력
			/* if( "${party.partyPlace}" != null ){
				
				var addr = "${festival.addr}";
				$("#partyPlace").val(addr);
			
			} */
				
		});
		
		
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
	          buttonImage: "/resources/image/ui/cal.png",
	          yearRange : "1990:2017"
	       });
		

		//============= "티켓가격 무료"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#ticketPriceFree").on("click" , function() {
				$("#ticketPrice").val(0);
			});
		});
		
		//============= "티켓수량"  Event 처리 및  연결 =============
		$(function(){
			$("#partyMemberLimit").on("keyup", function(){
				var ticketCount = $("#partyMemberLimit").val();
				$("#ticketCount").val(ticketCount);
			});
		})
		
		
		//============= "파티 플래그"  Event 처리 및  연결 =============
		$(function(){
			if( "${party.festival.festivalNo}" == ""){
			
				$("#partyFlag").val("1");
				var partyFlag = $("#partyFlag").val();
				console.log(partyFlag);
				
				$("#festivalNameDiv").css("display", "none");
				$("#ticketCountDiv").css("display", "block");
				$("#ticketPriceDiv").css("display", "block");
				
				$("#festivalNo").val(0);
				$("#festivalName").val("");
				var festivalNo = $("#festivalNo").val();
				var festivalName = $("#festivalName").val();
				
				console.log("#party ==> "+festivalNo+" :: "+festivalName);
			
			}else{
			
				$("#partyFlag").val("2");
				var partyFlag = $("#partyFlag").val();
				console.log(partyFlag);
				
				$("#festivalNameDiv").css("display", "block");
				$("#ticketCountDiv").css("display", "none");
				$("#ticketPriceDiv").css("display", "none");
				
				
				$("#festivalNo").val("${party.festival.festivalNo}");
				$("#festivalName").val("${party.festival.festivalName}");
				$("#partyPlace").val("${party.partyPlace}");
				var festivalNo = $("#festivalNo").val();
				var festivalName = $("#festivalName").val();
				var partyPlace = $("#partyPlace").val();
				
				//console.log("#afterParty ==> "+festivalNo+" :: "+festivalName);
				console.log("#afterParty ==> "+festivalNo+" :: "+festivalName+" :: "+partyPlace);
			
			}
		});
		
		
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
	</style>
	
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<hr/>
		<h1 class="bg-primary text-center">${ empty party.festival.festivalNo  ? '파티 수정' : '애프터 파티 수정'}</h1>
		<br>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="host" class="col-sm-offset-1 col-sm-3 control-label">파티 호스트</label>
		    <div class="col-sm-4">
		      <img class="rounded-circle" src="/resources/uploadFile/${party.partyImage}" alt="Generic placeholder image" width="40" height="40">
			  ${ party.user.nickname }
			  <input type="hidden" class="form-control" id="user.userId" name="user.userId" value="${ party.user.userId }" />
		    </div>
		   	
		  </div>
		  
		  <div class="text-center">
				<img src="../../resources/uploadFile/${party.partyImage}" width="800" >
		  </div>
		  
		  <div class="form-group">
		    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">파티사진(선택입력)</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
		    </div>
		  </div>
		  
		  <%-- <c:if test="${ party.festival != null }"> --%>
		  <div class="form-group" id="festivalNameDiv">
		    <label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="festival.festivalName" name="festival.festivalName" value="${ party.festival.festivalName }" />
		      <!-- <input type="text" readonly="readonly" class="form-control" id="festival.festivalName" name="festival.festivalName" placeholder="축제를 검색해주세요."> -->
		      <input type="hidden" class="form-control" id="festival.festivalNo" name="festival.festivalNo" value=${ !empty party.festival.festivalNo ? party.festival.festivalNo : 0 }>
		    </div>
		    <div>
		      <button type="button" class="btn btn-primary btn-block" id="search-festival"  >축제검색</button>
		    </div>
		  </div>
		 <%-- </c:if> --%>
		  
		  <div class="form-group">
		    <label for="partyName" class="col-sm-offset-1 col-sm-3 control-label">파티이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyName" name="partyName" value="${ party.partyName }">
		      <input type="hidden" class="form-control" id="partyNo" name="partyNo" value="${ party.partyNo }">
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDate" class="col-sm-offset-1 col-sm-3 control-label">파티날짜</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="datepicker" name="partyDate" value="${ party.partyDate }">
		    </div> 	
		  </div>
		  
		  <div class="form-group">
		    <label for="partyName" class="col-sm-offset-1 col-sm-3 control-label">파티시간</label>
		    <div class="col-sm-2">
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
		      </select>시
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="minutes" name="minutes"/>분
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDetail" class="col-sm-offset-1 col-sm-3 control-label">파티설명</label>
		    <div class="col-sm-4">
		      <textarea name = "partyDetail" rows="10" cols="50">${ party.partyDetail }</textarea>
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDetail" class="col-sm-offset-1 col-sm-3 control-label">파티인원</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyMemberLimit" name="partyMemberLimit" value="${ party.partyMemberLimit }">
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyPlace" class="col-sm-offset-1 col-sm-3 control-label">파티장소(선택입력)</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="partyPlace" name="partyPlace" value="${ party.partyPlace }">
		    </div>
		    <div>
		      <!-- <button type="button" class="btn btn-primary" id="search-partyPlace"  >검색</button> -->
		      <%@include file="/view/party/searchAddr.jsp"%> 	
		    </div>
		  </div>
		  
		  <div class="form-group" id="ticketCountDiv">
		    <label for="ticketCount" class="col-sm-offset-1 col-sm-3 control-label">티켓수량</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="ticketCount" name="ticketCount" value="${ empty party.festival.festivalNo ? ticket.ticketCount : 0 }">
			</div>
		  </div>
		  
		  <div class="form-group" id="ticketPriceDiv">
		    <label for="ticketPrice" class="col-sm-offset-1 col-sm-3 control-label">티켓가격</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="ticketPrice" name="ticketPrice" value="${ empty party.festival.festivalNo ? ticket.ticketPrice : 0 }"> 
			</div>
			<div class="col-sm-1">
			   무료<input type="radio" class="form-control" id="ticketPriceFree" name="ticketPrice" value="0">
			</div>
		  </div>
		 		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary btn-block"  >수정</button>
			  <a class="btn btn-primary btn btn-block" href="#" role="button">취소</a>
		    </div>
		  </div>
		</form>
		
		
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>
</html>