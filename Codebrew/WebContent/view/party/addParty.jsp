<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@include file="/data/party/userData.jsp"%>  --%>
<%@include file="/data/party/festivalData.jsp"%> 
   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파티등록</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
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
    

	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
				
		//============= "파티등록"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button:contains('파티등록')" ).on("click" , function() {
				$("form").attr("method", "POST").attr("action", "/party/addParty").submit();
			});
		});	
		
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			/* $("a[href='#']").on("click" , function() { */
			$("a:contains('취소')").on("click" , function() {	
				history.go(-1);
			});
		});
	
		//============= "DatePicker"  Event 처리 및  연결 =============
		$( function() {
	       $( "#datepicker" ).datepicker({
	    	   changeMonth: true, 
	           changeYear: true,
		       dateFormat: "y/mm/dd" 
	       });   
	    } );
		
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
		});
		
		//============= "파티 플래그"  Event 처리 및  연결 =============
		$(function(){
			$("#party").on("click", function(){
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
				
				console.log("#party 버튼 클릭 ==> "+festivalNo+" :: "+festivalName);
			});
			
			$("#afterParty").on("click", function(){
				$("#partyFlag").val("2");
				var partyFlag = $("#partyFlag").val();
				console.log(partyFlag);
				
				$("#festivalNameDiv").css("display", "block");
				$("#ticketCountDiv").css("display", "none");
				$("#ticketPriceDiv").css("display", "none");
				
				
				$("#festivalNo").val("${festival.festivalNo}");
				$("#festivalName").val("${festival.festivalName}");
				var festivalNo = $("#festivalNo").val();
				var festivalName = $("#festivalName").val();
				
				console.log("#afterParty 버튼 클릭 ==> "+festivalNo+" :: "+festivalName);
			});
		});
		
		
		
	</script>

	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style type="text/css">
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


<body bgcolor="#ffffff" text="#000000">

	
   	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<hr/><hr/>
		<h1 class="bg-primary text-center">파티 등록</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">주최자</label>
		    <div class="col-sm-4">
		      ${user.nickname} 
		      <input type="hidden" class="form-control" id="user.userId" name="user.userId" value="${user.userId}" />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyFlag" class="col-sm-offset-1 col-sm-3 control-label">파티구분</label>
		    <div class="col-sm-2">
		    	<button type="button" class="btn btn-primary" name="party" id="party">파티</button>
		    	<button type="button" class="btn btn-primary" name="party" id="afterParty">애프터파티</button>
		    	
		    	<input type="hidden" class="form-control" id="partyFlag" name="partyFlag"/>
		    </div>
		 
		    
		  </div>
		  		
		  <div class="form-group" id="festivalNameDiv">
		    <label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제명</label>
		    <div class="col-sm-4">
		      <!-- <input type="text" class="form-control" id="festivalName" name="festival.festivalName" value="" /> -->
		      <input type="text" readonly="readonly" class="form-control" id="festivalName" name="festival.festivalName" value="${ festival.festivalName }">
		      <input type="hidden" class="form-control" id="festivalNo" name="festival.festivalNo" value=0 />
		      
		      <button type="button" class="btn btn-primary" name="searchFestival" >축제검색</button>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyName" class="col-sm-offset-1 col-sm-3 control-label">파티명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyName" name="partyName"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDate" class="col-sm-offset-1 col-sm-3 control-label">파티날짜</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="datepicker" name="partyDate" placeholder="파티날짜를 선택해주세요.">
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
		      <textarea name = "partyDetail" rows="10" cols="50"></textarea>
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyMemberlimit" class="col-sm-offset-1 col-sm-3 control-label">파티인원</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyMemberLimit" name="partyMemberLimit">
			</div>
		  </div>
		 		 	  
		  <div class="form-group">
		    <label for="partyPlace" class="col-sm-offset-1 col-sm-3 control-label">파티장소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyPlace" name="partyPlace" placeholder="파티장소를 검색해주세요.">
		      <button type="button" class="btn btn-primary" name="searchPartyPlace" >장소검색</button>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">파티이미지</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
		    </div>
		  </div>
		  
		  <div class="form-group" id="ticketCountDiv">
		    <label for="ticketCount" class="col-sm-offset-1 col-sm-3 control-label">티켓수량</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="ticketCount" name="ticketCount" >
		    </div>
		  </div>
		  
		  <div class="form-group" id="ticketPriceDiv">
		    <label for="ticketPrice" class="col-sm-offset-1 col-sm-3 control-label">티켓가격</label>
		    <div class="col-sm-2">
		    	<input type="text" class="form-control" id="ticketPrice" name="ticketPrice" value="0">
		    </div>
		    <div class="col-sm-2">
		    	<input type="radio" class="form-control" id="ticketPriceFree" name="ticketPrice" >무료
		    </div>
		  </div>
		  
		  
		  	  	
		 		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" name="addParty" >파티등록</button>
			  <a class="btn btn-primary btn" href="#" role="button">취소</a>
		    </div>
		  </div>
		</form>
		
		
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
</body>


</html>