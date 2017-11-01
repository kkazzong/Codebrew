<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%-- <%@ include file="/data/purchase/festivalData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/partyData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/userData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/sessionData.jsp" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>addPurchase</title>

<!-- Bootstrap, jQuery CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>

<!-- jQuery ui -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>

<!-- popup -->
<!-- Magnific Popup core CSS file -->
<link rel="stylesheet" href="/resources/css/magnific-popup.css">

<!-- Magnific Popup core JS file -->
<script src="/resources/javascript/jquery.magnific-popup.min.js"></script>

<!-- smartpopup -->
<script type="text/javascript" src="/resources/javascript/jquery.smartPop.js"></script>
<link href="/resources/css/jquery.smartPop.css" rel="stylesheet"/>

<!-- 아임포트 -->
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">

	//// 아임포트 변수 초기화
	var IMP = window.IMP; // 생략가능
	IMP.init('imp74820381'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	
	//// 아임포트 휴대폰결제
	function fncPhonePay(selectedCount, purchasePrice, purchaseFlag) {
		
		alert("핸드폰 결제"+selectedCount+","+purchasePrice+","+purchaseFlag);
		var ticketNo = ${ticket.ticketNo};
		var userId = "${user.userId}";
		var ticketCount = ${ticket.ticketCount};
		var name = '${ticket.ticketName}';
		
		IMP.request_pay({
		    pg : 'danal', // version 1.1.0부터 지원.
		    pay_method : 'phone',
		    merchant_uid : 'codebrew_moana_' + new Date().getTime(),
		    name : name,
		    amount : purchasePrice,
		    /* buyer_email : 'iamport@siot.do', */
		    buyer_name : userId,
		    buyer_tel : "${user.phone}",
		  /*   buyer_addr : '',
		    buyer_postcode : '123-456', */
		    m_redirect_url : 'http://127.0.0.1:8080/purchase/approvePurchase'
		}, function(rsp) {
		    if ( rsp.success ) {
		    	
		    	$.ajax({
		    		
		    		url : "/purchaseRest/json/iamport/approvePayment",
		    		method : "POST",
		    		headers : {
		    			"Accept" : "application/json",
		    			"Content-Type" : "application/json"
		    		},
		    		data : JSON.stringify({
		    			aid : rsp.imp_uid, //아이엠포트 고유번호
		    			cid : rsp.merchant_uid, //아이엠포트 가맹점 고유번호
		    			purchaseCount : selectedCount,
						purchasePrice : purchasePrice,
						purchaseFlag : purchaseFlag,
						user : {
							userId : userId
						},
						ticket : {
							ticketNo : ticketNo,
							ticketCount : ticketCount
						}
		    		}),
		    		dataType : "json",
		    		success : function(JSONData){
		    			
		    			console.log(JSONData);
		    			self.location = "/purchase/getPurchase?purchaseNo="+JSONData.purchaseNo;
		    		}
		    		
		    	});
		    	
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    console.log(msg);
		});
		
	}
	
	function fncReadyTransfer(selectedCount, purchasePrice, purchaseFlag) {
		
		var ticketNo = ${ticket.ticketNo};
		var userId = "${user.userId}";
		var ticketCount = ${ticket.ticketCount};
		var name = '${ticket.ticketName}';
		
		//alert($("#purchaseForm").serialize());
		var innerHtml = "<form id=transForm>";
		innerHtml += "<input type='hidden' name='purchaseCount' value='"+selectedCount+"'>";
		innerHtml += "<input type='hidden' name='purchasePrice' value='"+purchasePrice+"'>";
		innerHtml += "<input type='hidden' name='purchaseFlag' value='"+purchaseFlag+"'>";
		innerHtml += "<input type='hidden' name='ticket.ticketNo' value='"+ticketNo+"'>";
		innerHtml += "<input type='hidden' name='ticket.ticketCount' value='"+ticketCount+"'>";
		innerHtml += "<input type='hidden' name='user.userId' value='"+userId+"'>";
		innerHtml += "<input type='hidden' name='itemName' value='"+name+"'>";
		innerHtml += "</form>";
		
		$("body").append(innerHtml);
		$("#transForm").attr("method", "POST").attr("action", "/purchase/readyTransfer").submit();
		
	}
	
	/* ////계쫘이체 결제준비 호출 function
	function fncReadyTransfer(selectedCount, purchasePrice, purchaseFlag){

		var ticketNo = ${ticket.ticketNo};
		var userId = "${user.userId}";
		var ticketCount = ${ticket.ticketCount};
		var name = "${ticket.ticketName}";
		alert("게자이체");
		
		console.log("수량선택한거 : "+selectedCount);
		if(selectedCount == null || selectedCount == 0) {
			alert("수량을 선택하세요");
			return;
		}
		
		$.ajax({
			
			url : "/purchaseRest/json/transfer/readyTransfer",
			method : "POST",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				purchaseCount : selectedCount,
				purchasePrice : purchasePrice,
				purchaseFlag : purchaseFlag,
				user : {
					userId : userId
				},
				ticket : {
					ticketNo : ticketNo,
					ticketCount : ticketCount
				}
			}), 
			dataType : "json",
			success : function(data){
				
				console.log(JSON.stringify(data));
				self.location = "/purchase/readyTransfer?token="+data.bank.token;
				
			}
			
		});
		
	} */
	
	//// 수량 선택시 validation check function
	function fncCheckPurchase(ticketPrice, selectedCount, purchasePrice) {
		
		console.log("수량선택 : "+selectedCount+"개 선택");
		console.log("결제금액 : "+purchasePrice+"원");
		
		if(purchasePrice >= 100000) {
			$("select").each(function(){
				$(this).find("option:first").prop("selected","true"); // prop :  돔 속성, attr : html태그 속성
			}); 
			$("#purchaseCount").html("0");
			$("#purchasePrice").html("0");
			$("#kakaoPay").attr("disabled", "disabled");
			alert("결제금액은 100,000만원 이하여야 합니다");
			return;
		}
		
		$("#purchaseCount").html(selectedCount); //구매수량
		$("#purchasePrice").html(purchasePrice); //결제금액
		
		$("#kakaoPay").removeAttr("disabled"); //카카오페이 버튼 활성화
		$("#danal").removeAttr("disabled"); //핸드폰 결제 활성화
		$("#bank").removeAttr("disabled"); //계좌이체 활성화
		
	}
	
	//// 카카오페이 결제준비 호출 function
	function fncPayment(selectedCount, purchasePrice, purchaseFlag){

		var ticketNo = $("input:hidden[name='ticketNo']").val();
		var userId = $("input:hidden[name='userId']").val();
		var ticketCount = ${ticket.ticketCount};
		
		console.log("수량선택한거 : "+selectedCount);
		if(selectedCount == null || selectedCount == 0) {
			alert("수량을 선택하세요");
			return;
		}
		
		$.ajax({
			
			url : "/purchaseRest/json/readyPayment/"+ticketNo,
			method : "POST",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				purchaseCount : selectedCount,
				purchasePrice : purchasePrice,
				purchaseFlag : purchaseFlag,
				user : {
					userId : userId
				},
				ticket : {
					ticketCount : ticketCount
				}
			}), 
			dataType : "json",
			success : function(data){
				
				console.log(JSON.stringify(data));
				var url = data.nextRedirectPcUrl;
				//var popupX = (window.screen.width / 2) - (200 / 2);
				// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

				//var popupY= (window.screen.height /2) - (300 / 2);
				// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
				
				var wX = screen.availWidth;
				 var wY = screen.availHeight;
				 wY = (wY-38);

				 $.smartPop.open({title: '스마트팝', width: 500, height: 500, url: url });
				//window.open(url,'kakaoPay','toolbar=no, directories=no, width='+ wX + ', height='+ wY + ', scrollbars=no, status=yes, scrollbars=no,  resizable=yes, direction=yes, location=no, menubar=no, toolbar=no, titlebar=yes');
				//$("#kakaoUrl").attr('href', url);
				//openLayer('kakaoPopup', {top:700});

				
			}
			
		});
		
	}
	
	function openLayer(targetID, options){
		var $layer = $('#'+targetID);
		var $close = $layer.find('.close');
		var width = $layer.outerWidth();
		var ypos = options.top;
		var xpos = options.left;
		var marginLeft = 0;
		
		if(xpos==undefined){
			xpos = '50%';
			marginLeft = -(width/2);
		}

		if(!$layer.is(':visible')){
			$layer.css({'top':ypos+'px','left':xpos,'margin-left':marginLeft})
				.show();
		}

		$close.bind('click',function(){
			if($layer.is(':visible')){
				$layer.hide();
			}
			return false;
		});
	}
	
	$(function(){
		
		var selectedCount; //구매수량
		var ticketPrice = $("input:hidden[name='ticketPrice']").val(); //티켓가격
		var purchasePrice; //결제금액
		var ticketFlag = "${ticket.ticketFlag}";
		var purchaseFlag = $("input:hidden[name='purchaseFlag']").val(); //1-축제,2-파티
		console.log("축제입니까 파티입니까 : "+purchaseFlag);
		
		//구매수량 선택 시
		$("select").on("change",function(){
			
			//무료티켓
			if(ticketFlag != null || ticketFlag != '') {
				$("#purchase").removeAttr("disabled");
			}
			
			selectedCount = $("select option:selected").val();
			purchasePrice = selectedCount * ticketPrice;
			fncCheckPurchase(ticketPrice, selectedCount, purchasePrice);
			
		});
		
		//카카오페이 클릭 시
		$("#kakaoPay").on("click",function(){
			
			fncPayment(selectedCount, purchasePrice, purchaseFlag);
			
		});
		
		//핸드폰 결제 클릭 시
		$("#danal").on("click",function(){
			
			fncPhonePay(selectedCount, purchasePrice, purchaseFlag);
			
		});
		
		//계좌이체 클릭 시
		$("#bank").on("click",function(){
			
			fncReadyTransfer(selectedCount, purchasePrice, purchaseFlag);
			//fncReadyTransfer();
		});
		
		//구매하기 클릭 시
		$("#purchase").on("click", function(){
			
			console.log("구매버튼 클릭클릭");
			
			if(confirm("구매하시겠습니까?")) {

				selectedCount = $("#purchaseCount").html().trim();
				$("input:hidden[name='purchaseCount']").val(selectedCount);
				$("input:hidden[name='purchasePrice']").val(purchasePrice);
				console.log(selectedCount+"개, "+purchasePrice+"원");
				$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
				
			} else {
				return;
			}
			
		});
		
		//뒤로가기 클릭 시
		$(".btn:contains('뒤로가기')").on("click", function() {
			
			if(confirm("구매를 취소하겠습니까?")) {
				history.go(-1);
			} else {
				return;
			}
			
		});
		
		//수량 + 선택
		$("#plus").on("click", function(){
			
			var originVal = $("input:text[name='ticketCount']").val();
			console.log("원래 수량 : "+originVal);
			
			selectedCount = ++originVal;
			console.log("변경 수량 : "+selectedCount);
			$("input:text[name='ticketCount']").val(selectedCount);
			
			purchasePrice = ticketPrice * selectedCount;
			fncCheckPurchase(ticketPrice, selectedCount, purchasePrice);
			
		});
		
		//수량 - 선택
		$("#minus").on("click", function(){
			
			var originVal = $("input:text[name='ticketCount']").val();
			console.log("원래 수량 : "+originVal);
			
			if(originVal == 0) {
				alert("0이하는 구매 할 수 없습니다");
				return;
			}
			
			var selectedCount = --originVal;
			console.log("변경 수량 : "+selectedCount);
			$("input:text[name='ticketCount']").val(selectedCount);
			
			purchasePrice = ticketPrice * selectedCount;
			fncCheckPurchase(ticketPrice, selectedCount, purchasePrice);
			
		});
		
	});

</script>
<style type="text/css">
	body {
		padding-top : 70px;
    }
    .btn {
		/*링크 클릭시 파란색 안남도록 */
		text-decoration : none;
		border : 0;
		outline : 0;
	}
   /*  div {
		border : 3px solid #D6CDB7;
		margin0top : 10px;
	}   */
	.glyphicon {
		font-size: 20px;
	}
	form > img {
		width : 100%;
		height : 300px
	}
	/* #kakaoPayModal {  
		  position:absolute;  
		  left:0;
		  top:0;
		  z-index:9000;  
		  background-color:#000;  
		  display:block;  
	} */
	.white-popup {
	  position: relative;
	  background: #FFF;
	  padding: 20px;
	  width: auto;
	  max-width: 500px;
	  margin: 20px auto;
	}
	.layer-popup {
		display: none;
		position: absolute;
		left: 50%;
		top: 175px;
		z-index: 10;
		 padding: 30px 30px 35px;
		 margin-left: -235px;
		 background-color: #fff;
		 border: 1px solid #000;
	}
</style>
</head>

<body>
	
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
	<div id="kakaoPopup" class="layer-popup">
		<a id="kakaoUrl" href="#"></a>
	</div>
		
	<div class="container">
		
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-tag" aria-hidden="true"></span> 티켓구매</h3>
					<small class="text-muted">구매정보를 확인해주세요</small>
				</div>
			</div>
		</div>
		
		<!-- form -->
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<form class="form-inline" id="purchaseForm" name="purchaseForm">
					<!-- hidden -->
					<input type="hidden" name="ticketNo" value="${ticket.ticketNo}">
					<input type="hidden" name="ticket.ticketNo" value="${ticket.ticketNo}">
					<input type="hidden" name="ticket.ticketFlag" value="${ticket.ticketFlag}">
					<input type="hidden" name="ticket.ticketCount" value="${ticket.ticketCount}">
					<input type="hidden" name="ticketPrice" value="${ticket.ticketPrice}">
					<input type="hidden" name="purchaseFlag" value="${purchaseFlag}">
					<input type="hidden" name="userId" value="${user.userId}">
					<input type="hidden" name="user.userId" value="${user.userId}">
					<input type="hidden" name="purchaseCount" value="">
					<input type="hidden" name="purchasePrice" value="">
					<input type="hidden" name="ticketName" value="${ticket.ticketName}">
					<!-- 축제정보 -->
					<c:if test="${!empty festival}">
						<input type="hidden" name="festival.festivalName" value="${festival.festivalName}">
						<c:if test="${festival.festivalImage.contains('http://')}">
							<img class="col-md-12" src="${festival.festivalImage}">
						</c:if>
						<c:if test="${!festival.festivalImage.contains('http://')}">
							<img class="col-md-12" src="/resources/uploadFile/${festival.festivalImage}">
						</c:if>
						<hr>
						<div class="row">
							<div class="col-md-12 text-center">
								<strong>${festival.festivalName}</strong>
							</div>
							<div class="col-md-12 text-center">
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> ${festival.addr}
							</div>
							<div class="col-md-12 text-center">
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
								${ticket.festival.startDate} ~ ${ticket.festival.endDate}
							</div>
							<%-- <div class="col-md-6">
								${ticket.ticketPrice}원	
							</div> --%>
						</div>
					</c:if>
					
					<!-- 파티정보 -->
					<c:if test="${!empty party}">
						<input type="hidden" name="party.partyName" value="${party.partyName}">
						<img class="col-md-12" src="/resources/uploadFile/${party.partyImage}">
						<hr>
						<div class="row">
							<div class="col-md-12 text-center">
								<strong>${party.partyName}</strong>
							</div>
							<div class="col-md-12 text-center">
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> ${party.partyPlace}
							</div>
							<div class="col-md-12 text-center">
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> ${party.partyDate}
							</div>
							<%-- <div class="col-md-6">
								${ticket.ticketPrice}원	
							</div> --%>
						</div>
					</c:if>
					
					
					
					<!-- 기본티켓 or 무제한티켓 -->
					<c:if test="${empty ticket.ticketFlag or ticket.ticketFlag == 'nolimit'}">
						<div class="row">
							<div class="col-md-12 text-center">
								<label class="control-label" for="ticketCount">티켓가격 : </label>
								<label class="control-label" for="ticketCount">${ticket.ticketPrice}원</label>
							</div>
						</div>
					</c:if>
					<!-- 무료티켓 -->
					<c:if test="${ticket.ticketFlag == 'free'}">
						<div class="row">
							<div class="col-md-12 text-center">
								<label class="control-label" for="ticketCount">티켓가격 : </label>
								무료
							</div>
						</div>
					</c:if>
						<!-- 기본티켓 수량이 0일때 (품절)-->
						<c:if test="${ticket.ticketFlag != 'nolimit' and ticket.ticketCount == 0}">
							<jsp:include page="soldOutTicket.jsp"></jsp:include>
						</c:if>
						<hr>
						<c:if test="${ticket.ticketFlag == 'nolimit' and ticket.ticketCount == 0}">
							<div class="row">
								<div class="col-md-12 text-center">
									<div class="form-group form-inline">
										<label class="control-label" for="ticketCount">수량선택</label>
										<span id="minus" class="glyphicon glyphicon-minus" aria-hidden="true"></span>
										<input class="form-control input-sm" type="text" name="ticketCount" value="0" placeholder="0" readonly>
										<span id="plus" class="glyphicon glyphicon-plus" aria-hidden="true"></span>
									</div>
								</div>
							</div>
						</c:if>
						<!-- 기본티켓, 무료티켓 수량 0 아닐때 -->
						<c:if test="${ticket.ticketCount > 0}">
							<div class="row">
								<div class="col-md-12 text-center">
									<div class="form-group form-inline">
										<label class="control-label" for="ticketCount">수량선택</label>
										<select id="countSelect" class="form-control input-sm" name="ticketCount">
											<option value="" selected>선택하세요</option>
											<c:forEach begin="1" end="${ticket.ticketCount}" var="i" step="1">
												<option>${i}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							</c:if>
							<!-- 구매정보 -->
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">${user.nickname}님의구매정보</h3>
								</div>
								<div class="panel-body">
									<div class="row">
										<div class="col-md-offset-2 col-xs-4 col-md-4">
											<strong>아이디</strong>
										</div>
										<div class="col-xs-8 col-md-4">${user.userId}</div>
									</div>
									<div class="row">
										<div class="col-md-offset-2 col-xs-4 col-md-4">
											<strong>구매수량</strong>
										</div>
										<div class="col-xs-8 col-md-4">
											<span id="purchaseCount">0</span>장
										</div>
									</div>
									<div class="row">
										<div class="col-md-offset-2 col-xs-4 col-md-4">
											<strong>결제금액</strong>
										</div>
										<div class="col-xs-8 col-md-4">
											<span id="purchasePrice">0</span>원
										</div>
									</div>
								</div>
							</div>
							
							<!-- 카카오페이 & 핸드폰결제 & 계좌이체 -->
							<c:if test="${empty ticket.ticketFlag or ticket.ticketFlag == 'nolimit'}">
							<div class="row">
									<span class="help-block">
										결제창이 뜨지 않을 경우, 팝업을 허용한 뒤 다시 시도 해주세요.
									</span>
								<div class="col-md-4">
									<ul class="list-group">
									  <li class="list-group-item">
									카카오페이
									<button id="kakaoPay" class="btn btn-link btn-block" disabled="disabled" type="button">
										 <img width="120" height="60" src="../../resources/image/buttonImage/kakaopay.png">
									</button>
										</li>
									</ul>
								</div>
							<!-- </div> -->
							<!-- <div class="row"> -->
								<div class="col-md-4">
									<ul class="list-group">
									  <li class="list-group-item">
										휴대폰결제
										<button id="danal" class="thumbnail btn btn-link btn-block" disabled="disabled" type="button">
											 <img width="120" height="50" src="../../resources/image/buttonImage/danal.jpg">
										</button>
									  </li>
									</ul>
								</div>
							<!-- </div>
							<div class="row"> -->
								<div class="col-md-4">
									<ul class="list-group">
									  <li class="list-group-item">
										계좌이체
										<button id="bank" class="btn btn-link btn-block" disabled="disabled" type="button">
											 <img width="120" height="60" src="../../resources/image/buttonImage/bank.png">
										</button>
										</li>
									</ul>
								</div>
							</div>
							</c:if>
							
							<!-- 단순구매 -->
							<c:if test="${ticket.ticketFlag == 'free' and ticket.ticketCount > 0}">
							<div class="row">
								<div class="col-md-offset-4 col-md-4">
									<button id="purchase" class="btn btn-default btn-block" disabled="disabled" type="button">
										구매하기
									</button>
								</div>
							</div>
							</c:if>
					
					<!-- 딜릿티켓일때(예외상황) -->
					<c:if test="${ticket.ticketFlag == 'del'}">
						<h1>딜릿티켓 (이 페이지로 넘어오면 안댐)</h1>
					</c:if>
					
					
				</form>
				<hr>
				<div class="row">
					<div class="col-md-12">
						<button class="btn btn-primary btn-lg btn-block" type="button">뒤로가기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<%-- <form id="purchaseForm" name="purchaseForm">
	<label for="ticketNo">
		<c:if test="${!empty festival}">
			<input type="hidden" name="referNo" value="${festival.festivalNo}">
			<input type="hidden" name="ticketPrice" value="${festival.ticketPrice}">
		</c:if>
		<c:if test="${!empty party}">
			<input type="hidden" name="referNo" value="${party.partyNo}">
			<input type="hidden" name="ticketPrice" value="${party.ticketPrice}">
		</c:if>
		<input type="hidden" name="ticketNo" value="${ticket.ticketNo}">
		<input type="hidden" name="ticketPrice" value="${ticket.ticketPrice}">
	</label>
	<c:if test="${!empty festival}">
	축제정보
		<input type="hidden" name="purchaseFlag" value="${purchaseFlag}">
		<label for="festivalName">
			<input type="hidden" name="festival.festivalName" value="${festival.festivalName}">
		</label>
		<img width="200" height="200" src="${festival.festivalImage}">
		<hr>
		${festival.festivalName}
		<hr>
		${festival.addr}
		<hr>
		${festival.ticketPrice}원	
		<hr>
	</c:if>
	
	<c:if test="${!empty party}">
	파티정보
		<input type="hidden" name="purchaseFlag" value="${purchaseFlag}">
		<label for="partyName">
			<input type="hidden" name="party.partyName" value="${party.partyName}">
		</label>
		<img width="200" height="200" src="${party.partyImage}">
		<hr>
		${party.partyName}
		<hr>
		${party.partyPlace}
		<hr>
		${party.ticketPrice}원	
		<hr>
	</c:if>
		수량선택 
		<select name="ticketCount">
			<c:if test="${!empty party}">
				<c:forEach begin="1" end="${party.ticketCount}" var="i" step="1">
					<option>${i}</option>
				</c:forEach>
			</c:if>
			<c:if test="${!empty festival}">
				<c:forEach begin="1" end="${festival.ticketCount}" var="i" step="1">
					<option>${i}</option>
				</c:forEach>
			</c:if>
		</select>
		<select name="ticketCount">
				<option>선택하세요</option>
				<c:forEach begin="1" end="${ticket.ticketCount}" var="i" step="1">
					<option>${i}</option>
				</c:forEach>
		</select>
		<hr>
		id : ${user.userId} <br>
		${user.nickname}님의 구매정보
		<br>		
		구매수량 : <span></span>개
		<br>
		결제금액 : <span></span>원
		<hr>
		<button type="button"><img src="../../resources/image/buttonImage/kakaopay.png"></button>
	</form> --%>
</body>
</html>