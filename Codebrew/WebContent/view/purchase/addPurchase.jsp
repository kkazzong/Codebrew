<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%-- <%@ include file="/data/purchase/festivalData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/partyData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/userData.jsp" %> --%>
<%@ include file="/data/purchase/sessionData.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>addPurchase</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
<!-- Bootstrap Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
<!-- Bootstrap JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

	function fncPayment(selectedCount, purchasePrice, purchaseFlag){

		var ticketNo = $("input:hidden[name='ticketNo']").val();
		var userId = $("input:hidden[name='userId']").val();
		
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
		var ticketPrice; //티켓가격
		var purchasePrice; //결제금액
		var purchaseFlag = $("input:hidden[name='purchaseFlag']").val(); //1-축제,2-파티
		console.log("축제입니까 파티입니까 : "+purchaseFlag);
		
		//구매수량 선택 시
		$("select").on("change",function(){
			
			selectedCount = $("select option:selected").val();
			ticketPrice = $("input:hidden[name='ticketPrice']").val();
			purchasePrice = selectedCount * ticketPrice;
			
			console.log("수량선택 : "+selectedCount+"개 선택");
			console.log("결제금액 : "+purchasePrice+"원");
			
			if(purchasePrice >= 100000) {
				alert("결제금액은 100,000만원 이하여야 합니다");
				return;
			}
			
			$("#purchaseCount").html(selectedCount); //구매수량
			$("#purchasePrice").html(purchasePrice); //결제금액
			
			$("#kakaoPay").removeAttr("disabled"); //카카오페이 버튼 활성화
		});
		
		//카카오페이 클릭 시
		$("#kakaoPay").on("click",function(){
			fncPayment(selectedCount, purchasePrice, purchaseFlag);
		});
		
		$(".btn:contains('뒤로가기')").on("click", function() {
			history.go(-1);
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
     /* div {
		border : 3px solid #D6CDB7;
		margin0top : 10px;
	}  */
</style>
</head>

<body>

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
				<form class="form-horizontal" id="purchaseForm" name="purchaseForm">
					<!-- hidden -->
					<input type="hidden" name="ticketNo" value="${ticket.ticketNo}">
					<input type="hidden" name="ticketPrice" value="${ticket.ticketPrice}">
					<input type="hidden" name="purchaseFlag" value="${purchaseFlag}">
					<input type="hidden" name="userId" value="${user.userId}">
					<!-- 축제정보 -->
					<c:if test="${!empty festival}">
						<input type="hidden" name="festival.festivalName" value="${festival.festivalName}">
						<img class="col-md-5" height="90" src="${festival.festivalImage}">
						<div class="row">
							<div class="col-md-6">
								<strong>${festival.festivalName}</strong>
							</div>
							<div class="col-md-6 text-muted">
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> <small>${festival.addr}</small>
							</div>
							<div class="col-md-6">
								${ticket.ticketPrice}원	
							</div>
						</div>
					</c:if>
					
					<!-- 파티정보 -->
					<c:if test="${!empty party}">
						<input type="hidden" name="party.partyName" value="${party.partyName}">
						<img class="col-md-6" height="90" src="../../resources/image/uploadFile/${party.partyImage}">
						<div class="row">
							<div class="col-md-6">
								<strong>${party.partyName}</strong>
							</div>
							<div class="col-md-6 text-muted">
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> <small>${party.partyPlace}</small>
							</div>
							<div class="col-md-6">
								${ticket.ticketPrice}원	
							</div>
						</div>
					</c:if>
					
					<!-- 수량이 0일때 -->
					<c:if test="${ticket.ticketCount == 0}">
						<jsp:include page="soldOutTicket.jsp"></jsp:include>
						<button class="btn btn-default" type="button">뒤로가기</button>										
					</c:if>
					
					<!-- 수량 0 아닐때 -->
					<c:if test="${ticket.ticketCount > 0 }">
						<div class="row">
							<div class="col-md-offset-2 col-xs-4 col-md-8">
									<div class="form-group form-inline">
										<label class="control-label" for="ticketCount">수량선택</label>
										<select class="col-md-offset-5 form-control input-sm" name="ticketCount">
											<option>선택하세요</option>
												<c:forEach begin="1" end="${ticket.ticketCount}" var="i" step="1">
													<option>${i}</option>
												</c:forEach>
										</select>
									</div>
							</div>
						</div>
					
						<!-- 구매정보 -->
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">${user.nickname}님의 구매정보</h3>
							</div>
							<div class="panel-body">
								<div class="row">
							  		<div class="col-md-offset-2 col-xs-4 col-md-4"><strong>아이디</strong></div>
									<div class="col-xs-8 col-md-4">${user.userId}</div>
								</div>
								<div class="row">
							  		<div class="col-md-offset-2 col-xs-4 col-md-4"><strong>구매수량</strong></div>
									<div class="col-xs-8 col-md-4"><span id="purchaseCount">0</span>장</div>
								</div>
								<div class="row">
							  		<div class="col-md-offset-2 col-xs-4 col-md-4"><strong>결제금액</strong></div>
									<div class="col-xs-8 col-md-4"><span id="purchasePrice">0</span>원</div>
								</div>
							</div>
						</div>
						
						<!-- 카카오페이 -->
						<div class="row">
							<div class="col-md-offset-4 col-md-4">
								<button id="kakaoPay" class="btn btn-link btn-block" disabled="disabled" type="button"><img src="../../resources/image/buttonImage/kakaopay.png"></button>
							</div>
						</div>
					</c:if>
					
				</form>
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