<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%-- <%@ include file="/data/purchaseData.jsp" %> --%>
<%@ include file="/data/purchase/sessionData.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>getPurchase</title>
<!-- facebook metadata -->
<meta property="fb:app_id" content="365648920529865" />
<meta property="og:type" content="website"/>
<meta property="og:title" content="티켓공유"/>
<meta property="og:url" content="http://127.0.0.1:8080/purchase/getPurchase" />
<meta property="og:description" content="이것은 공유다 이것은 공유다" />
<meta property="og:image" content="http://www.kccosd.org/files/testing_image.jpg" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
<!-- Bootstrap Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
<!-- Bootstrap JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- KakaoLink -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- facebook share -->
<script src="http://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript">
	
	//1.facebook공유
	function share(url) {
		window.open("http://www.facebook.com/sharer/sharer.php?u="+url);
	}
	
	//2.facebook 공유 sdk
	window.fbAsyncInit = function() {
	    FB.init({appId: '365648920529865', status: true, cookie: true, xfbml: true});
	  };
	 
	 /*  (function() {
	    var e = document.createElement('script'); e.async = true;
	    e.src = document.location.protocol +
	      '//connect.facebook.net/ko_KR/all.js';
	    document.getElementById('fb-root').appendChild(e);
	  }()); */
	  
	  function share2(){
		    var share = {
		        method: 'share',
		        href: 'http://127.0.0.1:8080/purchase/getPurchase',
		    	title : "티켓공유",
		    	description : "이것은 티켓공유를 위한 것이다",
		    	image : "http://www.kccosd.org/files/testing_image.jpg"
		    };
		 
		    FB.ui(share, function(response) { 
		    	if (response && !response.error_message) {
		    	      alert("게시완료");
		    	    } else {
		    	      alert("띠로리 썸띵롱");
		    	    }	
		    }); 
		}
	
	// '가정'app 키 ip변경시 동적변경해줘야함
	Kakao.init('4c581b38ff4c308971bc220233e61b89');
	
	var ticketPrice = ${ticket.ticketPrice};
	var itemName = "${purchase.itemName}";
	var imageUrl = "${ticket.festival.festivalImage}";
	var ip = "http://192.168.0.7:8080";
	var festivalNo = ${ticket.festival.festivalNo};
	if(!imageUrl.includes('http://')) {
		imageUrl = ip+"/resources/uploadFile/${ticket.festival.festivalImage}";
	}
	
	// 카카오 링크 보내기
	function sendLink() {
	    Kakao.Link.sendDefault({
	      objectType: 'commerce',
	      content: {
	        title: itemName,
	        imageUrl: imageUrl,
	        link: {
	          mobileWebUrl: ip+"/festival/getFestival?festivalNo="+festivalNo,
	          webUrl: 'https://developers.kakao.com'
	        }
	      },
	      commerce: {
	        regularPrice: ticketPrice
	      },
	      buttons: [
	        {
	          title: '구매하기',
	          link: {
	            mobileWebUrl: ip+'/purchase/addPurchase?festivalNo='+festivalNo,
	            webUrl: 'https://developers.kakao.com'
	          }
	        }
	      ]
	    });
	  }

	// 카카오페이 결제취소
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
		
		$("#facebookShare").on("click", function(){
			//share("http://127.0.0.1:8080/purchase/getPurchase");
			share2();
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
	
	<input type="hidden" name="itemName" value="${purchase.itemName}">
	
	<div class="container">
	
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span> 마이티켓상세</h3>
				</div>
			</div>
		</div>
		
		<!-- kakao link -->
		<a id="kakao-link-btn" href="javascript:sendLink();">
			<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
		</a>
		
		<!-- facebook share -->
		<a id="facebookShare">
			<img src="../../resources/image/buttonImage/facebook.png">
		</a>
		
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