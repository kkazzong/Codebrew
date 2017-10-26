<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%-- <%@ include file="/data/purchaseData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/sessionData.jsp" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>transferMoney</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

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
	

	////계쫘이체 결제준비 호출 function
	function fncReadyTransfer(){
	
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
		
	}
	
	$(function(){
		
		fncReadyTransfer();
		
		//이체
		$(".btn:contains('이체')").on("click", function(){
			
			if(confirm("계좌이체를 하시겠습니까?")) {
				$("#transferForm").attr("method", "POST").attr("action", "/purchase/transferMoney").submit();
			} else {
				return;
			}
			
		});
		
		//취소
		$(".btn:contains('취소')").on("click", function(){
			
			if(confirm("계좌이체를 취소 하시겠습니까?")) {
				history.go(-1);
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
	
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
	<input type="hidden" name="itemName" value="${purchase.itemName}">
	
	<div class="container">
	
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span> 계좌이체</h3>
				</div>
			</div>
		</div>
		
		
		<!-- 계좌이체 폼 -->
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">${purchase.itemName} 티켓</h3>
					</div>
					<div class="panel-body">
						<form class="form form-horizontal" aria-hidden="true" name="transferForm">
							<div class="form-group">
								<label class="control-label" for="accountHolder">예금주명</label>
								<input class="form-control" id="searchKeyword" name="searchKeyword" type="text" 
											placeholder="예금주명 입력">
							</div>
							<div class="form-group">
								<label for="accountHolder">출금은행</label>
								<input class="form-control" id="searchKeyword" name="searchKeyword" type="text" 
											placeholder="출금은행 선택">
							</div>
							<div class="form-group">
								<label for="accountHolder">출금계좌</label>
								<input class="form-control" id="searchKeyword" name="searchKeyword" type="text" 
											placeholder="계좌번호 입력">
							</div>
							<div class="form-group">
								<label for="accountHolder">입금은행</label>
								<input class="form-control" id="searchKeyword" name="searchKeyword" type="text" 
											placeholder="은행" readonly>
							</div>
							<div class="form-group">
								<label for="accountHolder">입금계좌</label>
								<input class="form-control" id="searchKeyword" name="searchKeyword" type="text" 
											placeholder="계쫘" readonly>
							</div>
							<div class="form-group">
								<label for="accountHolder">이체금액</label>
								<input class="form-control" id="searchKeyword" name="searchKeyword" type="text" 
											placeholder="이체 금액" readonly>
							</div>
							<div class="col-md-6 ">
								<button class="btn btn-default btn-block">취소</button>
							</div>
							<div class="col-md-6 ">
								<button class="btn btn-primary btn-block">이체</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		
		<%-- <div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">${purchase.itemName} 티켓</h3>
					</div>
					<div class="panel-body">
						<!-- 축제티켓 -->
						<c:if test="${!empty ticket.festival}">
						<img width="100%" height="300" src="${ticket.festival.festivalImage}">
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
							<img width="100%" height="300" src="/resources/uploadFile/${ticket.party.partyImage}">
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
									<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
									${ticket.party.partyTime}
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
								<div class="col-xs-4 col-md-6"><strong>결제수단</strong></div>
								<div class="col-xs-8 col-md-6">
									<c:if test="${purchase.paymentMethodType == 'CARD'}">
										카드
									</c:if>
									<c:if test="${purchase.paymentMethodType == 'MONEY'}">
										현금
									</c:if>
									<c:if test="${empty purchase.paymentMethodType}">
										무료결제
									</c:if>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-md-6"><strong>결제상태</strong></div>
								<div class="col-xs-8 col-md-6">
									<c:if test="${purchase.tranCode == 1}">
										결제완료
									</c:if>
									<c:if test="${purchase.tranCode == 2}">
										결제취소
									</c:if>
								</div>
							</div>
							<hr>
							<div class="row">
								<img class="col-md-offset-3" width="50%" height="50%" src="../../resources/image/QRCodeImage/${purchase.qrCode.qrCodeImage}">
							</div>
							<button class="btn btn-default" type="button">확인</button>
							<c:if test="${ticket.ticketFlag != 'free' }">
								<button class="btn btn-primary" type="button" value="${purchase.purchaseNo}">결제취소하기</button>
							</c:if>
							<c:if test="${ticket.ticketFlag == 'free' }">
								<form id="cancelForm">
									<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}" >
									<button class="btn btn-primary" type="button" value="${purchase.purchaseNo}">구매취소하기</button>
								</form>
							</c:if>
						</div>
					</div>
				</div>
		</div> --%>
		
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