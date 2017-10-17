<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>


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
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddProduct();
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
		       dateFormat: "yy/mm/dd" 
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
		<h1 class="bg-primary text-center">파티 수정</h1>
		<br>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
		
		  <div class="form-group">
		    <label for="partyFlag" class="col-sm-offset-1 col-sm-3 control-label">파티구분</label>
		    <div class="col-sm-4">
		      <input type="radio" name="partyFlag" value="party" checked />파티
		      <input type="radio" name="partyFlag" value="afterParty" />애프터파티		  		      
		    </div>
		  </div>
	
		  <div class="form-group">
		    <label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제명</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="festivalName" name="festivalName" placeholder="축제를 검색해주세요.">
		      <input type="hidden" class="form-control" id="festivalNo" name="festivalNo">
		    </div>
		    <div>
		      <button type="button" class="btn btn-primary" id="search-festival"  >축제검색</button>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="host" class="col-sm-offset-1 col-sm-3 control-label">주최자</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="host" name="nickName" >
		    </div>
		   	
		  </div>
		  
		  <div class="form-group">
		    <label for="partyName" class="col-sm-offset-1 col-sm-3 control-label">파티이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyName" name="partyName" >
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDate" class="col-sm-offset-1 col-sm-3 control-label">파티날짜</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="datepicker" name="partyDate" placeholder="파티날짜를 선택해주세요.">
		    </div> 	
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDetail" class="col-sm-offset-1 col-sm-3 control-label">파티설명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyDetail" name="partyDetail" >
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDetail" class="col-sm-offset-1 col-sm-3 control-label">파티인원</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyMemberCount" name="partyMemberCount" >
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyPlace" class="col-sm-offset-1 col-sm-3 control-label">파티장소(선택입력)</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="partyPlace" name="partyPlave" placeholder="파티장소를 검색해주세요.">
		    </div>
		    <div>
		      <button type="button" class="btn btn-primary" id="search-partyPlace"  >검색</button> 	
		    </div>
		  </div>
		  		  	  
		  <div class="form-group">
		    <label for="partyImage" class="col-sm-offset-1 col-sm-3 control-label">파티사진(선택입력)</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="partyImage" name="partyImage" placeholder="파티사진을 올려주세요.">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ticketCount" class="col-sm-offset-1 col-sm-3 control-label">티켓수량</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="ticketCount" name="ticketCount" >
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ticketPrice" class="col-sm-offset-1 col-sm-3 control-label">티켓가격</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="ticketPrice" name="ticketPrice" > 
			</div>
			<div class="col-sm-1">
			   무료<input type="radio" class="form-control" id="ticketPrice" name="ticketPrice" value="0">
			</div>
		  </div>
		 		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >등&nbsp;록</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		
		
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>
</html>