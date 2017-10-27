<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%-- <%@ include file="/data/purchaseData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/sessionData.jsp" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>getPurchase</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!-- Facebook image must be at least 600x315px -->
<meta property="og:title" content="Title Here" />
<meta property="og:type" content="website" />
<meta property="og:url" content="http://www.codebrew.com:8080/" />
<meta property="og:image" content="http://example.com/image.jpg" />
<meta property="og:description" content="Description Here" />
<meta property="og:site_name" content="Site Name" />
<meta property="article:published_time" content="2013-09-17T05:59:00+01:00" />
<meta property="article:modified_time" content="2013-09-16T19:08:47+01:00" />
<meta property="article:section" content="Article Section" />
<meta property="article:tag" content="Article Tag" />
<meta property="fb:admins" content="365648920529865" />

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

<!-- KakaoLink -->
<!-- <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> -->

<!-- facebook share -->
<script src="http://connect.facebook.net/ko_KR/all.js"></script>

<script type="text/javascript">
	
	//1.facebook공유
	function share(url) {
		window.open("http://www.facebook.com/sharer/sharer.php?u="+url);
	}
	
	//2.facebook 공유 sdk
	window.fbAsyncInit = function() {
	    FB.init({
	    	appId: '365648920529865',
	    	status: true,
	    	version: 'v2.10',
	    	cookie: true,
	    	xfbml: true});
	  };
	  
	  (function(d, s, id){
		     var js, fjs = d.getElementsByTagName(s)[0];
		     if (d.getElementById(id)) {return;}
		     js = d.createElement(s); js.id = id;
		     js.src = "//connect.facebook.net/en_US/sdk.js";
		     fjs.parentNode.insertBefore(js, fjs);
	 }(document, 'script', 'facebook-jssdk'));
	 
	 /*  (function() {
	    var e = document.createElement('script'); e.async = true;
	    e.src = document.location.protocol +
	      '//connect.facebook.net/ko_KR/all.js';
	    document.getElementById('fb-root').appendChild(e);
	  }()); */
	  
	  function share2(){
		    var share = {
		        method: 'share_open_graph',
		        action_type: 'og.likes',
		        action_properties : JSON.stringify({
		        	object :  'http://codebrew.com:8080/view/purchase/getPurchase.jsp',
			        picture: 'http://ww2.sjkoreancatholic.org/files/testing_image.jpg',
			        name: 'Facebook Dialogs',
			        caption: 'Reference Documentation',
			        description: 'Using Dialogs to interact with people.'
		        }),
		        href: 'http://codebrew.com:8080/view/purchase/getPurchase.jsp',
		        name: 'codebrew moana',
		        description: 'festival party'
		    };
		 
		   FB.ui(share, function(response) { 
		    	if (response && !response.error_message) {
		    	      alert("게시완료");
		    	    } else {
		    	      alert("띠로리 썸띵롱");
		    	    }	
		    }); 
		    /* FB.ui(
		    		 {
		    		  method: 'share',
		    		  href: 'http://127.0.0.1/view/purchase/getPurchase.jsp'
		    		}, function(response){}); */
		}
	
	// '가정'app 키 ip변경시 동적변경해줘야함
	/* Kakao.init('4c581b38ff4c308971bc220233e61b89');
	
	var ticketPrice = ${ticket.ticketPrice};
	var itemName = "${purchase.itemName}";
	var imageUrl = "${ticket.festival.festivalImage}";
	var ip = "http://192.168.0.7:8080";
	var referNo; */
	
	/* if(${ticket.festival} != "") {
		referNo = ${ticket.festival.festivalNo};
	} else if(${ticket.party} != "") {
		referNo = ${ticket.party.partyNo};
	} */
	
	/* if(!imageUrl.includes('http://')) {
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
	  } */

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
				self.location = "/purchase/cancelPurchase";
			}
		});
		
		
	}
	
	$(function(){
		
		//확인 버튼
		$("button:contains('확인')").on("click", function(){
			self.location = "/purchase/getPurchaseList";
		});
		
		//카카오페이 결제 취소
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
		
		//구매취소(무료티켓 구매한 내역)
		$(".btn:contains('구매취소하기')").on("click", function(){
			
			if(confirm("정말로 구매를 취소하시겠습니까?")) {
				alert($("#cancelForm").serialize());
				$("#cancelForm").attr("method", "POST").attr("action", "/purchase/cancelPurchase").submit();
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
	
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
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
		<!-- <a id="kakao-link-btn" href="javascript:sendLink();">
			<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
		</a> -->
		
		<!-- facebook share -->
		<a id="facebookShare">
			<img src="../../resources/image/buttonImage/facebook.png">
		</a>
		
		<!-- facebook -->
		<!-- <div
		  	class="fb-like"
		  data-share="true"
		  data-width="450"
		  data-show-faces="true">
		</div> -->
		
		<div class="row">
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
								<img class="col-md-offset-3" width="50%" height="50%" 
										onError="this.src='/resources/uploadFile/no.png'"
										src="../../resources/image/QRCodeImage/${purchase.qrCode.qrCodeImage}">
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