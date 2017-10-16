<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%-- <%@ include file="/data/purchaseData.jsp" %> --%>
<%@ include file="/data/purchase/userData.jsp" %>
<!DOCTYPE html>
<html>
<head>

<title>getPurchaseList</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
<!-- Bootstrap Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
<!-- Bootstrap JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		var userId = $("input:hidden[name='userId']").val();
		
		$("#festivalBtn").on("click", function(){
			console.log("축제버튼 클릭 : val = "+$(this).val());
			self.location = "/purchase/getPurchaseList?userId="+userId+"&purchaseFlag="+$(this).val();
		});
		
		$("#partyBtn").on("click", function(){
			console.log("파티버튼 클릭 : val = "+$(this).val());
			self.location = "/purchase/getPurchaseList?userId="+userId+"&purchaseFlag="+$(this).val();
		});
		
		$("button:contains('조회')").on("click", function(){
			console.log("조회버튼 클릭 : val = "+$(this).val());
			self.location = "/purchase/getPurchase?purchaseNo="+$(this).val();
		});
		
	});
</script>
<style type="text/css">
	body {
		padding-top : 70px;
    }
    .panel {
		margin-top : 50px;
    }
    /* div {
		border : 3px solid #D6CDB7;
		margin0top : 10px;
	} */
</style>
</head>
<body>
	
	<input type="hidden" name="userId" value="${user.userId}">
	
	<div class="container">
	
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<button class="btn btn-primary">마이티켓</button>
			</div>
		</div>
		
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span> 마이티켓</h3>
				</div>
			</div>
		</div>
		
		<!-- 축제 / 파티 버튼 -->
		<div class="row">
			<div class="col-md-6">
				<button class="btn btn-default btn-block" id="festivalBtn" type="button" value="1">축제티켓</button>
			</div>
			<div class="col-md-6">
				<button class="btn btn-default btn-block" id="partyBtn" type="button" value="2">파티티켓</button>
			</div>
		</div>
		
		<div class="row">
			<c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${i+1}"></c:set>
				<div class="col-md-6">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">${i} 티켓</h3>
							</div>
							<div class="panel-body">
								<!-- 축제티켓 -->
								<c:if test="${!empty purchase.ticket.festival}">
									<img width="100%" height="100" src="${purchase.ticket.festival.festivalImage}">
									<hr>
									<div class="col-md-12">
										<strong>
											${purchase.ticket.festival.festivalName}
										</strong>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											 ${purchase.ticket.festival.startDate} ~ ${purchase.ticket.festival.endDate}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
										 	${purchase.ticket.festival.addr}
										 </small>
									</div>
								</c:if>
								<!-- 파티티켓 -->
								<c:if test="${!empty purchase.ticket.party}">
									<img width="100%" height="100" src="${purchase.ticket.party.partyImage}">
									<hr>
									<div class="col-md-12">
										<strong>
											${purchase.ticket.party.partyName}
										</strong>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											${purchase.ticket.party.partyDate}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											${purchase.ticket.party.partyTime}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
											${purchase.ticket.party.partyPlace}
										</small>
									</div>
								</c:if>
								<br>
								<div class="row">
									<div class="col-xs-4 col-md-6"><strong>결제번호</strong></div>
									<div class="col-xs-8 col-md-6">${purchase.paymentNo}</div>
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
										<c:if test="${purchase.tranCode == 1}">
											결제완료
										</c:if>
										<c:if test="${purchase.tranCode == 2}">
											결제취소
										</c:if>
									</div>
								</div>
								<hr>
								<button class="btn btn-primary" type="button" value="${purchase.purchaseNo}">조회</button>
								<button class="btn btn-default" type="button" value="${purchase.purchaseNo}">삭제</button>
							</div>
						</div>
				</div>
			</c:forEach>
		</div>
		
	</div>

	<%-- 게라겟겟마이티켓리스투
	<hr>
	<button id="festivalBtn" type="button" value="1">축제티켓</button>
	<button id="partyBtn" type="button" value="2">파티티켓</button>
	<hr>
	나으아이디 : ${user.userId} <br>
	나으닉네임 : ${user.nickname}
	<hr>
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${i+1}"></c:set>
		<h2>${i}</h2>
		<hr>
		${purchase.paymentNo}
		<hr>
		${purchase.itemName} 
		<hr>
		<c:if test="${!empty purchase.ticket.festival}">
			<img height="100" width="100" src="${purchase.ticket.festival.festivalImage}">
			<hr>
			${purchase.ticket.festival.startDate} ~ ${purchase.ticket.festival.endDate} 
			<hr>
			${purchase.ticket.festival.addr}
		</c:if>
		<c:if test="${!empty purchase.ticket.party}">
			<img height="100" width="100" src="${purchase.ticket.party.partyImage}">
			<hr>
			${purchase.ticket.party.partyDate}
			<hr>	
			${purchase.ticket.party.partyPlace}	
		</c:if>
		<hr>
		구매수량 : ${purchase.purchaseCount}장
		<hr>
		결제상태 : 
		<c:if test="${empty purchase.tranCode}">
			결제완료
		</c:if>
		<c:if test="${purchase.tranCode == 2}">
			결제취소
		</c:if>
		<hr>
		<button type="button" value="${purchase.purchaseNo}">조회</button>
		<button type="button" value="${purchase.purchaseNo}">삭제</button>
		<hr>
	</c:forEach>
	<hr> --%>
</body>
</html>