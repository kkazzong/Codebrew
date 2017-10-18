<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	
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
		
		//============= "DatePicker"  Event 처리 및  연결 =============
		$(function() {
	      $( "#datepicker" ).datepicker({
	   	   changeMonth: true, 
	          changeYear: true,
		       dateFormat: "y/mm/dd" 
	      });   
	    });

		//============= "티켓수량"  Event 처리 및  연결 =============
		$(function(){
			$("#partyMemberCount").on("keyup", function(){
				var ticketCount = $("#partyMemberCount").val();
				$("#ticketCount").val(ticketCount);
			});
		})
		
		
	</script>
</head>
<body>
	
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
		  
		  <div class="form-group">
		    <label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="festival.festivalName" name="festival.festivalName" value="${ party.festival.festivalName }" />
		      <!-- <input type="text" readonly="readonly" class="form-control" id="festival.festivalName" name="festival.festivalName" placeholder="축제를 검색해주세요."> -->
		      <input type="hidden" class="form-control" id="festival.festivalNo" name="festival.festivalNo" value="${ party.festival.festivalNo}">
		    </div>
		    <div>
		      <button type="button" class="btn btn-primary" id="search-festival"  >축제검색</button>
		    </div>
		  </div>
		  
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
		      <button type="button" class="btn btn-primary" id="search-partyPlace"  >검색</button> 	
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ticketCount" class="col-sm-offset-1 col-sm-3 control-label">티켓수량</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="ticketCount" name="ticketCount" value="${ ticket.ticketCount }">
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ticketPrice" class="col-sm-offset-1 col-sm-3 control-label">티켓가격</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="ticketPrice" name="ticketPrice" value="${ ticket.ticketPrice }"> 
			</div>
			<div class="col-sm-1">
			   무료<input type="radio" class="form-control" id="ticketPrice" name="ticketPrice" value="0">
			</div>
		  </div>
		 		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수정</button>
			  <a class="btn btn-primary btn" href="#" role="button">취소</a>
		    </div>
		  </div>
		</form>
		
		
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>
</html>