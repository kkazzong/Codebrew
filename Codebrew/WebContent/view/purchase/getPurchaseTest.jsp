<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%-- <%@ include file="/data/purchaseData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/sessionData.jsp" %> --%>
<!DOCTYPE html>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml"
      xmlns:og="http://ogp.me/ns#"
      xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<title>getPurchase</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!-- Facebook image must be at least 600x315px -->
<meta property="fb:app_id" content="160276001234207">
<meta property="og:title" content="페이스북 공유를 해보자" />
<meta property="og:url" content="'http://127.0.0.1:8080/view/purchase/getPurchaseTest.jsp'" />
<meta property="og:image" content="http://192.168.0.4:8080/resources/uploadFile/default_party_image.jpg" />
<meta property="og:description" content="Description Here" />

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
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!-- facebook share -->
<script src="http://connect.facebook.net/ko_KR/all.js"></script>

<script type="text/javascript">
	
	//1.facebook공유
	/* function share(url) {
		window.open("http://www.facebook.com/sharer/sharer.php?u="+url);
	} */
	
	//2.facebook 공유 sdk
	window.fbAsyncInit = function() {
	    FB.init({
	    	appId: '160276001234207',
	    	status: true,
	    	version: 'v2.10',
	    	cookie: true,
	    	xfbml: true});
	  }; 
	/* window.fbAsyncInit = function() {
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
	 }(document, 'script', 'facebook-jssdk')); */
	 
	 /*  (function() {
	    var e = document.createElement('script'); e.async = true;
	    e.src = document.location.protocol +
	      '//connect.facebook.net/ko_KR/all.js';
	    document.getElementById('fb-root').appendChild(e);
	  }()); */
	  
	  /* $(document).ready(function() {
		  $.ajaxSetup({ cache: true });
		  $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
		    FB.init({
		      app_id: '{160276001234207}',
		      version: 'v2.10' // or v2.1, v2.2, v2.3, ...
		    });     
		    $('#loginbutton,#feedbutton').removeAttr('disabled');
		    FB.getLoginStatus(updateStatusCallback);
		  });
		}); */
	  
	 function share2(){
		  /* FB.ui({
			    method: 'share',
			    display: 'popup',
			    href: 'https://developers.facebook.com/docs/',
			  }, function(response){}); */
		    var share = {
		    	app_id : '160276001234207',
		        /* method: 'share_open_graph',
		        action_type: 'og.likes',
		        action_properties : JSON.stringify({
		        	object : 'http://127.0.0.1:8080/view/purchase/getPurchaseTest.jsp',
			        picture: 'http://127.0.0.1:8080/resources/uploadFile/default_party_image.jpg',
			        name: 'Facebook Dialogs',
			        caption: 'Reference Documentation',
			        description: 'Using Dialogs to interact with people.'
		        }),
		        href: 'http://127.0.0.1:8080/view/purchase/getPurchaseTest.jsp',
		        name: 'codebrew moana',
		        description: 'festival party' */
		        display : 'popup',
		        href :  'http://127.0.0.1:8080/view/purchase/getPurchaseTest.jsp'
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
	 Kakao.init('4c581b38ff4c308971bc220233e61b89');
	
	var ticketPrice = ${ticket.ticketPrice};
	var itemName = "${purchase.itemName}";
	var ip = "http://192.168.0.4:8080";
	var referNo = "${purchase.purchaseFlag}";
	var imageUrl = "";
	var url = "";
	var purl = "";
	
	if(referNo == "1") {
		if("${ticket.festival.festivalImage}".indexOf("http://") != -1) {
			imageUrl = "${ticket.festival.festivalImage}";
		} else {
			imageUrl = ip+"/resources/uploadFile/${ticket.festival.festivalImage}";
		}
		url = ip+"/festival/getFestivalDB?festivalNo=${ticket.festival.festivalNo}";
		purl = ip+"/purchase/addPurchase?festivalNo=${ticket.festival.festivalNo}";
	} else {
		imageUrl = ip+"/resources/uploadFile/${ticket.party.partyImage}";
		url = ip+"/party/getParty?partyNo=${ticket.party.partyNo}";
		purl = ip+"/purchase/addPurchase?partyNo=${ticket.party.partyNo}";
	}
	
	
	console.log(imageUrl+","+url+","+purl);
	
	// 카카오 링크 보내기
	function sendLink() {
	    Kakao.Link.sendDefault({
	      objectType: 'commerce',
	      content: {
	        title: itemName,
	        imageUrl: imageUrl,
	        link: {
	          mobileWebUrl: url,
	          webUrl: url
	        }
	      },
	      commerce: {
	        regularPrice: ticketPrice
	      },
	      buttons: [
	        {
	          title: '구매하기',
	          link: {
	            mobileWebUrl: purl,
	            webUrl:  purl
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
				self.location = "/purchase/cancelPurchase";
			}
		});
		
		
	}
	
	$(function(){
		
		var referNo2 = $("input:hidden[name='purchaseFlag']").val();
		alert(referNo2);
		
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
	<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.10&appId=1991630514383595';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
	<input type="hidden" name="itemName" value="${purchase.itemName}">
	
	<div class="container">
	<header>
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span> 마이티켓상세</h3>
				</div>
			</div>
		</div>
	</header>
		<!-- kakao link -->
		<a id="kakao-link-btn" href="javascript:sendLink();">
			<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
		</a>
		
		<!-- facebook share -->
		<!-- <a id="facebookShare" onclick="share2()">
			<img src="../../resources/image/buttonImage/facebook.png">
		</a> -->
		<div class="fb-share-button" data-href="http://127.0.0.1:8080/" data-layout="button_count" data-size="large" data-mobile-iframe="true">
		<a class="fb-xfbml-parse-ignore" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Flocalhost%3A8080%2F&amp;src=sdkpreparse">공유하기</a></div>
		
		<!-- facebook -->
		<!-- <div
		  	class="fb-like"
		  data-share="true"
		  data-width="450"
		  data-show-faces="true">
		</div> -->
		
	<section>	
		<input type="hidden" name="purchaseFlag" value="${purchase.purchaseFlag}">
		
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">${purchase.itemName} 티켓</h3>
					</div>
					<div class="panel-body">
						<!-- 축제티켓 -->
						<c:if test="${!empty ticket.festival}">
						<c:if test="${ticket.festival.festivalImage.contains('http://')}">
										<img width="100%" height="300" src="${ticket.festival.festivalImage}">
									</c:if>
									<c:if test="${!ticket.festival.festivalImage.contains('http://')}">
										<img width="100%" height="300" src="/resources/uploadFile/${ticket.festival.festivalImage}">
									</c:if>
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
							<div class="col-md-offset-4">
								<img width="50%" height="50%" src="../../resources/image/QRCodeImage/${purchase.qrCode.qrCodeImage}">
							</div>
								<div class="col-md-6">
									<button class="btn btn-default btn-block" type="button">확인</button>
								</div>
								<div class="col-md-6">
									<c:if test="${ticket.ticketFlag != 'free' }">
										<button class="btn btn-primary btn-block" type="button" value="${purchase.purchaseNo}">결제취소하기</button>
									</c:if>
									<c:if test="${ticket.ticketFlag == 'free' }">
										<form id="cancelForm">
											<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}" >
											<button class="btn btn-primary btn-block" type="button" value="${purchase.purchaseNo}">구매취소하기</button>
										</form>
									</c:if>
								</div>
						</div>
					</div>
				</div>
		</div>
		</section>
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