<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@include file="/data/party/userData.jsp"%>  --%>
<%-- <%@include file="/data/party/festivalData.jsp"%>  --%>
   
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
 
    
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    

    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		function fncAddParty() {
			
			var partyName=$("input[name='partyName']").val();
			var partyDate=$("input[name='partyDate']").val();
			var partyDetail=$("textarea[name='partyDetail']").val();
			var partyMemberLimit=$("input[name='partyMemberLimit']").val();
			var ticketCount=$("input[name='ticketCount']").val();
			var ticketPrice=$("input[name='ticketPrice']").val();
			var festivalNo=$("input[name='festival.festivalNo']").val();
			
			console.log("festivalNo ==> "+festivalNo);
			
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
				
			
			
			$("form").attr("method", "POST").attr("action", "/party/addParty").submit();
		}
	
	
		//============= "파티등록"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button:contains('파티등록')" ).on("click" , function() {
				//$("form").attr("method", "POST").attr("action", "/party/addParty").submit();
				fncAddParty();
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
	
			
		//============= "축제검색"  Event 연결 =============
		 /* $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button:contains('축제검색')" ).on("click" , function() {
				//$("form").attr("method", "POST").attr("action", "/party/addParty").submit();
				
				var pop = window.open("/view/festival/popupListDB.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
				
			});
			
			// 애프터 파티의 경우 축제 장소 자동 입력
			if( "${party.partyPlace}" != null ){
				
				var addr = "${festival.addr}";
				$("#partyPlace").val(addr);
			
			}
				
		}); */
		
		 function openChild(){
             
 			 // window.name = "부모창 이름"; 
             window.name = "parentForm";
             // window.open("open할 window", "자식창 이름", "팝업창 옵션");
             openWin = window.open("/view/festival/popupListDB.jsp",
                     "childForm", "width=570, height=350, resizable = no, scrollbars = yes");    
         }
		
		
		//============= "DatePicker"  Event 처리 및  연결 =============
		$( function() {
	       $( "#datepicker" ).datepicker({
	    	   changeMonth: true, 
	           changeYear: true,
		       dateFormat: "y/mm/dd" 
	       });   
	    } );
		
		
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
	         /* buttonImageOnly: true,
	          buttonText: "Select date",
	          showOn: "button",
	          buttonImage: "/resources/image/ui/small_cal.jpg", */
	          yearRange : "1900:2017"
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
		});
		
		//============= "파티 플래그"  Event 처리 및  연결 =============
		$(function(){
			$("#party").on("click", function(){
				
				//$("form").reset();
				
			
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
				
				//$("form").reset();
			
				$("#partyFlag").val("2");
				var partyFlag = $("#partyFlag").val();
				console.log(partyFlag);
				
				$("#festivalNameDiv").css("display", "block");
				$("#ticketCountDiv").css("display", "none");
				$("#ticketPriceDiv").css("display", "none");
				
				
				$("#festivalNo").val("${festival.festivalNo}");
				$("#festivalName").val("${festival.festivalName}");
				$("#partyPlace").val("${festival.addr}");
				var festivalNo = $("#festivalNo").val();
				var festivalName = $("#festivalName").val();
				var festivalAddr = $("#partyPlace").val();
				
				//console.log("#afterParty 버튼 클릭 ==> "+festivalNo+" :: "+festivalName);
				console.log("#afterParty 버튼 클릭 ==> "+festivalNo+" :: "+festivalName+" :: "+festivalAddr);
			});
		});
		
		
		//============= "사진 미리보기"  Event 처리 및  연결 =============
		function getUploadFilePrivew(html, $target) {
		    if (html.files && html.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $target.css('display', '');
		            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
		            $target.html('<img src="' + e.target.result + '"width="80%" border="0" alt="" />');
		        }
		        reader.readAsDataURL(html.files[0]);
		    }
		}
		
		//=============    파티 참여 취소  Event  처리 		=============
		/* $(function(){
			$("button:contains('파티 참여 취소')").on("click", function() {
				
				var partyNo = $(this).val();
				console.log("파티 참여 취소 :: partyNo :: "+partyNo);
				self.location="/party/cancelParty?partyNo="+partyNo;
		
			});
		}); */
		
		
		//=============    티켓 구매 취소  Event  처리 		=============
		/* $(function(){
			$("button:contains('티켓 구매 취소')").on("click", function() {
				var partyNo = $( "input[name=partyNo]", $(this) ).val();
				self.location="/purchase/cancelPurchase";
		
			});
		}); */
		
		
		//=============    현재 시간  Event  처리 		=============
		/* function time(){
		
		    var today = new Date();
		    var y = today.getFullYear();
		    console.log("y = "+y);
		    var m = today.getMonth()+1;
		    console.log("m = "+m);
		    var d = today.getDate();
		    console.log("d = "+d);
		    m = checkTime(m);
		    d = checkTime(d);
		    
		    var t = setTimeout(time, 5000);
		    console.log(y + "/" + m + "/" + d);
		    return y + "/" + m + "/" + d;
		}
		
		function checkTime(i){
		
		    if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
		    console.log("i = "+i);
		    return i;
		} 

		
		$(function compareTime(){
			
			var partyDate = $("input[name='partyDate']").val();
			var now = time();
			console.log("partyDate = "+partyDate);
			console.log("now = "+now);
			//var parPartyDate = Date.parse(partyDate);
			
			
			
		    
		    
			
			var result = now - partyDate;
			console.log("now - partyDate = "+result)
			/* var result = time().compareTo(partyDate); 
			var deleteButton = "<button type='button' class='btn btn-default' >삭제</button>";
			var cancelButton = "<button type='button' class='btn btn-default' >참여취소</button>";

			if(result < 0){
				alert("파티 등록 불가능");
				return result;
			}
		});  */
		
	</script>


	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style type="text/css">
		
		/* body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        } */
        
		body {
			padding-top: 70px;
			background-color: #f2f4f6;
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


<body bgcolor="#ffffff" text="#000000">

	
   	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span>파티 등록</h3>
					<small>파티 내용을 적어주세요.</small>
				</div>
			</div>
		</div>
		
		<br>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
			
		  <div class="form-group">
		    <label for="host" class="col-sm-offset-1 col-sm-2 control-label">파티 호스트</label>
		    <div class="col-sm-6">
		      <img class="img-circle" src="/resources/uploadFile/${user.profileImage}" width="50" height="50">
			  ${ user.nickname }
			  <input type="hidden" class="form-control" id="user.userId" name="user.userId" value="${ user.userId }" />
		    </div>
		   	
		  </div>
	   </form>
	   <!-- form End /////////////////////////////////////-->
		 
	   <!-- form Start /////////////////////////////////////-->
	    <form class="form-horizontal" enctype="multipart/form-data">
			<div class="form-group">
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
				
			</div>
		  
		  <div class="form-group">
		    <label for="partyFlag" class="col-sm-offset-1 col-sm-2 control-label">파티구분</label>
		    
		    <div class="col-sm-2">
		    	<button type="button" class="btn btn-primary btn-block" name="party" id="afterParty">애프터파티</button>
		    	
		    	<input type="hidden" class="form-control" id="partyFlag" name="partyFlag"/>
		    </div>
		 
		    
		  </div>
		  		
		  <div class="form-group" id="festivalNameDiv">
		    <label for="festivalName" class="col-sm-offset-1 col-sm-2 control-label">축제명</label>
		    <div class="col-sm-6">
		      <!-- <input type="text" class="form-control" id="festivalName" name="festival.festivalName" value="" /> -->
		      <!-- <input type="text" readonly="readonly" class="form-control" id="festivalName" name="festival.festivalName">
		      <input type="hidden" class="form-control" id="festivalNo" name="festival.festivalNo" value=0 /> -->	<!-- 띄어쓰기 조심 -->
		   	  <input type="text" readonly="readonly" class="form-control" id="festivalName" name="festival.festivalName" value="${festival.festivalName}">
		      <input type="hidden" class="form-control" id="festivalNo" name="festival.festivalNo" value="${festival.festivalNo}" >
		    </div>
		    <div class="col-sm-2 text-center">
				<button type="button" class="btn btn-primary btn-block"
					name="searchFestival" onclick="openChild()">축제검색</button>
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyName" class="col-sm-offset-1 col-sm-2 control-label">파티명</label>
		    <div class="col-sm-6">
		      <input type="text" class="form-control" id="partyName" name="partyName"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDate" class="col-sm-offset-1 col-sm-2 control-label">파티날짜</label>
		    <div class="col-sm-6">
		      <input type="text" readonly="readonly" class="form-control" id="datepicker" name="partyDate" placeholder="파티날짜를 선택해주세요.">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="hour" class="col-sm-offset-1 col-sm-2 control-label">파티시간</label>
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
		    </span><span class="col-sm-1">시</span>
		    <span class="col-sm-1">
		      <select name="minutes">
		        <option value="00" selected>00</option>
		        <option value="10">10</option>
		        <option value="20">20</option>
		        <option value="30">30</option>
		        <option value="40">40</option>
		        <option value="50">50</option>
		      </select>
		      <!-- <input type="text" class="form-control" id="minutes" name="minutes"/> -->
		    </span><span class="col-sm-1">분</span> 
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDetail" class="col-sm-offset-1 col-sm-2 control-label">파티설명</label>
		    <div class="col-sm-6">
		      <textarea name = "partyDetail" class="form-control" rows="10" cols="50"></textarea>
			</div>
		  </div>
		 		 	  
		  <div class="form-group">
		    <label for="partyPlace" class="col-sm-offset-1 col-sm-2 control-label">파티장소</label>
		    <div class="col-sm-6">
		      <%-- <input type="text" readonly="readonly" class="form-control" id="partyPlace" name="partyPlace" value="${ party.partyPlace }"> --%>
		      <input type="text" readonly="readonly" class="form-control" id="addr" name="partyPlace" value="${ festival.addr }">
		    </div>
		    <div>
		      <!-- <button type="button" class="btn btn-primary" id="search-partyPlace"  >검색</button> -->
		      <%@include file="/view/party/searchAddr.jsp"%> 	
		    </div>
		  </div>
		
		  <div class="form-group">
		  	<div class="col-sm-offset-3  col-sm-6 text-center">
		  	<br><br>
		      <button type="button" class="btn btn-info btn-block" name="addParty" >파티등록</button>
			  <a class="btn btn-default btn btn-block" href="#" role="button">취소</a>
		    </div>
		  </div>
		</form>
		
		
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
</body>


</html>