<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%-- <%@ include file="/data/purchase/userData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/sessionData.jsp" %> --%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<title>approvePayment</title>
	
	<!-- Bootstrap, jQuery CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<!-- 자바스크립트 -->
	<script type="text/javascript">
		$(function(){
			
			var payType = "${purchase.paymentMethodType}";
			
			$("button").bind("click", function(){
				if(payType == 'phone') {
					self.location = "/purchase/getPurchaseList?userId=${user.userId}";
				} else {
					//opener.parent.location="/purchase/getPurchaseList?userId=${user.userId}";
					//익스플로러경우 닫기할때 alert창 안뜨게 하기위해..
					//window.open("about:blank", "_self").close();
				}
			});
			
			
		});
		function layerClose(){
			 $("#popLayer").css("display","none");
			 $("body").css("overflow","auto");
			 window.parent.location = "/purchase/getPurchaseList?userId=${user.userId}";
		}
	</script>
	
	<!-- CSS -->
	<style type="text/css">
		
		 /* div {
			border : 3px solid #D6CDB7;
			margin0top : 10px;
		}  */
		
		body {
			background-color: #f2f4f6;
		}
		
		.text-info {
	    	color: #333333; 
	    }
	    
	    .page-header {
	    	border-bottom : 1px solid #f2f4f6;
	    }
	    
	    .panel-primary {
	    	border-color : #3e3e3d;
	    }
	    
	   .panel-primary > .panel-heading {
	    	background-image :linear-gradient(to bottom,#333 0,#333 100%);
	    }
	    
	</style>
	
</head>
<body>
	
	<input type="hidden" name="userId" value="${user.userId}">
	
	<div class="container">
	
		<!-- page header -->
		<!-- <div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 결제완료</h3>
					<small class="text-muted">결제정보를 확인해주세요</small>
				</div>
			</div>
		</div> -->
		
		<!-- 이미지 -->
		<%-- <div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<c:if test="${!empty purchase.ticket.festival}">
							<c:if test="${purchase.ticket.festival.festivalImage.contains('http://')}">
								<img class="col-md-12" width="100%" height="320" src="${purchase.ticket.festival.festivalImage}">
							</c:if>
							<c:if test="${!purchase.ticket.festival.festivalImage.contains('http://')}">
								<img class="col-md-12" width="100%" height="320" src="/resources/uploadFile/${purchase.ticket.festival.festivalImage}">
							</c:if>
						</c:if>
						<c:if test="${!empty purchase.ticket.party}">
							<img class="col-md-12" width="100%" height="320" src="/resources/uploadFile/${purchase.ticket.party.partyImage}">
						</c:if>
					</div>
				</div>
			</div>
		</div> --%>
		
		<!-- 결제정보 -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
					<div class="panel-body">
						<h3>
							<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
							<strong>결제정보</strong>
						</h3>
							<table class="table">
								<tr>
									<td class="col-md-3 active"><h4>아이디</h4></td>
									<td><h4>${user.userId}</h4></td>
								</tr>
								<tr>
									<td class="col-md-3 active"><h4>티켓명</h4></td>
									<td><h4>${purchase.itemName}</h4></td>
								</tr>
								<tr>
									<td class="col-md-3 active"><h4>구매수량</h4></td>
									<td><h4>${purchase.purchaseCount}장</h4></td>
								</tr>
								<tr>
									<td class="col-md-3 active"><h4>결제금액</h4></td>
									<td><h4><%-- ${purchase.purchasePrice} --%>${purchase.price}원</h4></td>
								</tr>
								<tr>
									<td class="col-md-3 active"><h4>결제수단</h4></td>
									<td>
										<c:if test="${purchase.paymentMethodType == 'MONEY'}">
											<h4>현금</h4>
										</c:if>
										<c:if test="${purchase.paymentMethodType == 'CARD'}">
											<h4>카드</h4>
										</c:if>
										<c:if test="${purchase.paymentMethodType == 'phone'}">
											<h4>핸드폰 결제</h4>
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="col-md-3 active"><h4>결제일시</h4></td>
									<td><h4>${purchase.purchaseDate}</h4></td>
								</tr>
								<!-- 큐알코드 -->
								<tr>
									<td colspan="2" class="col-md-offset-2">
										<img src="../../resources/image/QRCodeImage/${purchase.qrCode.qrCodeImage}">
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		
		<!-- 큐알코드 -->
		<%-- <div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<img class="col-md-offset-3" width="50%" height="50%" 
							onError="this.src='/resources/uploadFile/no.png'"
							src="../../resources/image/QRCodeImage/${purchase.qrCode.qrCodeImage}">
						</div>
					</div>
				</div>
			</div>
		</div> --%>
		
		
		<!-- 확인버튼 -->
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<button class="btn btn-default btn-lg btn-block" type="button" onclick="javascript:layerClose();">확인</button>
			</div>
		</div>
	
	</div>
	
</body>

</html>