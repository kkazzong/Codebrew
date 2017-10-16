<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%-- <%@ include file="/data/purchaseData.jsp" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>getPurchase</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
<!-- Bootstrap Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
<!-- Bootstrap JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

	function fncCancelPayment(purchaseNo) {
		
		$.ajax({
			url : "/purchaseRest/json/cancelPayment/"+purchaseNo,
			method : "POST",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : "json",
			success : function(data) {
				console.log(data);
			}
		});
		
	}
	
	$(function(){
		
		$("button:contains('확인')").on("click", function(){
			history.go(-1);
		});
		
		$("button:contains('결제취소하기')").on("click", function(){
			
			var result = confirm("정말로 결제를 취소하시겠습니까?");
			
			if(result) {
				var purchaseNo = $(this).val();
				
				console.log("결제취소하기 버튼 val = "+purchaseNo);
				fncCancelPayment(purchaseNo);
			} else {
				return;
			}
		});
		
	});

</script>
<style type="text/css">
	body {
		padding-top : 70px;
    }
    /* div {
		border : 3px solid #D6CDB7;
		margin0top : 10px;
	} */
</style>
</head>
<body>

	<div class="container">
	
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span> 마이티켓상세</h3>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">${purchase.itemName} 티켓</h3>
					</div>
					<div class="panel-body">
						<!-- 축제티켓 -->
						<c:if test="${!empty ticket.festival}">
						<img width="100%" height="100" src="${ticket.festival.festivalImage}">
						<hr>
						<div class="col-md-12">
							<strong>
								${ticket.festival.festivalName}
							</strong>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
									${ticket.festival.startDate} ~ ${ticket.festival.endDate}
							</small>
							</div>
							<div class="col-md-12">
								<small>
									<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									${ticket.festival.addr}
								</small>
							</div>
							</c:if>
							<!-- 파티티켓 -->
							<c:if test="${!empty ticket.party}">
							<img width="100%" height="100" src="${ticket.party.partyImage}">
							<hr>
							<div class="col-md-12">
								<strong>
									${ticket.party.partyName}
								</strong>
							</div>
							<div class="col-md-12">
								<small>
									<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
									${ticket.party.partyDate}
								</small>
							</div>
							<div class="col-md-12">
								<small>
									<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									${ticket.party.partyPlace}
								</small>
							</div>
							</c:if>
							<br>
							<div class="row">
								<div class="col-xs-4 col-md-6"><strong>결제번호</strong></div>
								<div class="col-xs-8 col-md-6">${purchase.paymentNo}</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-md-6"><strong>결제일시</strong></div>
								<div class="col-xs-8 col-md-6">${purchase.purchaseDate}</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-md-6"><strong>구매수량</strong></div>
								<div class="col-xs-8 col-md-6">${purchase.purchaseCount} 장</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-md-6"><strong>결제금액</strong></div>
								<div class="col-xs-8 col-md-6">${purchase.purchasePrice} 원</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-md-6"><strong>결제상태</strong></div>
								<div class="col-xs-8 col-md-6">
									<c:if test="${empty purchase.tranCode}">
										결제완료
									</c:if>
									<c:if test="${purchase.tranCode == 2}">
										결제취소
									</c:if>
								</div>
							</div>
							<hr>
							<div class="row">
								<img class="col-md-offset-3" width="50%" height="50%" src="../../resources/image/QRCodeImage/qrcode.png">
							</div>
							<button class="btn btn-default" type="button">확인</button>
							<button class="btn btn-primary" type="button" value="${purchase.purchaseNo}">결제취소하기</button>
						</div>
					</div>
				</div>
		</div>
		
	</div>
	
	<%-- <c:if test="${!empty ticket.festival}">
		<img width="100" height="100" src="${ticket.festival.festivalImage}">
		<hr>
		${ticket.festival.festivalName}
		<hr>
		${ticket.festival.startDate} ~ ${ticket.festival.endDate}
		<hr>
		${ticket.festival.addr}
		<hr>
		<button type="button" value="${ticket.festival.festivalNo}">축제 정보 더보기</button>
	</c:if>
	<c:if test="${!empty ticket.party}">
		${ticket.party.partyName}
		<hr>
		${ticket.party.partyDate}
		<hr>
		${ticket.party.partyPlace}
		<hr>
		<button type="button" value="${ticket.party.partyNo}">파티 정보 더보기</button>
	</c:if>
	<hr>
	<hr>
	결제번호 : ${purchase.paymentNo}
	<hr>
	결제일시 : ${purchase.purchaseDate}
	<hr>
	결제수단 : 
	<c:if test="${purchase.purchaseMethodType == CARD}">카드</c:if>
	<c:if test="${purchase.purchaseMethodType == MONEY}">현금</c:if>
	<hr>
	구매수량 : ${purchase.purchaseCount}
	<hr>
	결제금액 : ${purchase.purchasePrice}
	<hr>
	결제상태 : 
	<c:if test="${empty purchase.tranCode}">
		결제완료
	</c:if>
	<hr>
	<img alt="큐알코드" src="../../resources/image/QRCodeImage/${purchase.qrCode.qrCodeImage}">
	<hr>
	<button type="button">확인</button>
	<button type="button" value="${purchase.purchaseNo}">결제취소하기</button> --%>
</body>
</html>