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

<script type="text/javascript">
	
	//수량 선택시 validation check function
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
		
	}
	
	//카카오페이 결제준비 호출 function
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
				window.open(url,'kakaoPay','toolbar=no,location=center,menubar=no,width=426,height=510');
				
			}
			
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
</style>
</head>

<body>
	
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
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
							
							<!-- 카카오페이 -->
							<c:if test="${empty ticket.ticketFlag or ticket.ticketFlag == 'nolimit'}">
							<div class="row">
									<span class="help-block">
										카카오페이 결제창이 뜨지 않을 경우, 팝업을 허용한 뒤 다시 시도 해주세요.
									</span>
								<div class="col-md-offset-4 col-md-4">
									<button id="kakaoPay" class="btn btn-link btn-block" disabled="disabled" type="button">
										<img src="../../resources/image/buttonImage/kakaopay.png">
									</button>
								</div>
							</div>
							</c:if>
							
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