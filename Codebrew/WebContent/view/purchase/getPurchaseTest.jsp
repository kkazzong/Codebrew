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

<!-- sweet alert -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.2/sweetalert2.all.min.js"></script>
<!-- Include a polyfill for ES6 Promises (optional) for IE11 and Android browser -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>

<script type="text/javascript">
	
	// '가정'app 키 ip변경시 동적변경해줘야함
	/*  Kakao.init('4c581b38ff4c308971bc220233e61b89');
	
	var ticketPrice = ${ticket.ticketPrice};
	var itemName = '${purchase.itemName}';
	var ip = "http://192.168.1.237:8080";
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
	 */
	
	//console.log(imageUrl+","+url+","+purl);
	
	// 카카오 링크 보내기
	/* function sendLink() {
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
	  }  */

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
		//alert(referNo2);
		
		//확인 버튼
		$("button:contains('목록으로')").on("click", function(){
			self.location = "/purchase/getPurchaseList";
		});
		
		//카카오페이 결제 취소
		$("button:contains('결제취소하기')").on("click", function(){
			
			var payMethod = "${purchase.paymentMethodType}";
			var purchaseNo = $(this).val();
			/* var result = confirm("정말로 결제를 취소하시겠습니까?");
			
			if(result) {
				var purchaseNo = $(this).val();
				
				console.log("결제취소하기 버튼 val = "+purchaseNo);
				if(payMethod != 'phone') {
					console.log('카톡취소');
					fncCancelPayment(purchaseNo);
				} else {
					console.log('폰취소');
					$("#cancelPay").attr("method", "POST").attr("action", "/purchase/cancelPurchase").submit();
				}
			} else { 
				return;
			} */
			
			swal({
				  
				  title: '결제를 취소하겠습니까?',
				  text: "You won't be able to revert this!",
				  type: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33', 
				  confirmButtonText: '확인',
				  cancelButtonText: '취소',
				  confirmButtonClass: 'btn btn-primary',
				  cancelButtonClass: 'btn btn-danger',
				  buttonsStyling: true,
				  
			
			}).then(function () {
				 
				 swal({
					    type: 'success',
					    title: '결제 취소가 완료되었습니다',
					    preConfirm : function(){
					    	return new Promise(function(resolve) {
					    		if(payMethod != 'phone') {
									console.log('카톡취소');
									fncCancelPayment(purchaseNo);
									resolve();
								} else {
									console.log('폰취소');
									$("#cancelPay").attr("method", "POST").attr("action", "/purchase/cancelPurchase").submit();
									resolve();
								}
					    	})
					    }
				}), function (dismiss) {
					  // dismiss can be 'cancel', 'overlay',
					  // 'close', and 'timer'
					  if (dismiss === 'cancel') {
					    swal(
					      'Cancelled',
					      'Your imaginary file is safe :)',
					      'error'
					    )
					  }
				 }
				
			})  
			
			
		});
		
		//구매취소(무료티켓 구매한 내역)
		$(".btn:contains('구매취소하기')").on("click", function(){
			
			var purchaseNo = ${purchase.purchaseNo};
			/* if(confirm("정말로 구매를 취소하시겠습니까?")) {
				//alert($("#cancelForm").serialize());
				$("#cancelForm").attr("method", "POST").attr("action", "/purchase/cancelPurchase").submit();
			} else {
				return;
			} */
			
			 swal({
				  
				  title: '구매를 취소하겠습니까?',
				  text: "You won't be able to revert this!",
				  type: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33', 
				  confirmButtonText: '확인',
				  cancelButtonText: '취소',
				  confirmButtonClass: 'btn btn-primary',
				  cancelButtonClass: 'btn btn-danger',
				  buttonsStyling: true,
				  preConfirm : function(){
					  return new Promise(function(resolve, reject) {
						  
						  $.ajax({
								
								url : "/purchaseRest/json/cancelPurchase",
								method : "POST",
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								}, 
								data : JSON.stringify({
									"purchaseNo" : purchaseNo
								}), 
								success : function(JSONData){
									if(JSONData.message != null) {
										resolve();
									} else {
										reject('Error!');
									}
								},
								error:function(request,status,error){
							        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
							     }

								
						})
						  
					 });
					  
				  }
			
			}).then(function () {
				 
				 swal({
					    type: 'success',
					    title: '구매 취소가 완료되었습니다',
					    preConfirm : function(){
					    	return new Promise(function(resolve) {
					    		self.location = "/purchase/getPurchaseList";
					    	})
					    }
				}), function (dismiss) {
					  // dismiss can be 'cancel', 'overlay',
					  // 'close', and 'timer'
					  if (dismiss === 'cancel') {
					    swal(
					      'Cancelled',
					      'Your imaginary file is safe :)',
					      'error'
					    )
					  }
				 }
				
			})  
			
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
		background-color: #f2f4f6;
    }
     .text-info {
    	color: #333333; 
    }
    .page-header {
    	border-bottom : 1px solid #f2f4f6;
    }
     .panel-primary > .panel-heading {
    	background-image :linear-gradient(to bottom,#333 0,#333 100%);
    }
     .panel-primary {
    	border-color : #3e3e3d;
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
					<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span>&nbsp;&nbsp;구매내역</h3>
				</div>
			</div>
		</div>
	</header>
		<!-- kakao link -->
		<!-- <a id="kakao-link-btn" href="javascript:sendLink();">
			<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
		</a> -->
		
		<!-- facebook share -->
		<!-- <a id="facebookShare" onclick="share2()">
			<img src="../../resources/image/buttonImage/facebook.png">
		</a> -->
		<!-- <div class="fb-share-button" data-href="http://127.0.0.1:8080/" data-layout="button_count" data-size="large" data-mobile-iframe="true">
		<a class="fb-xfbml-parse-ignore" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Flocalhost%3A8080%2F&amp;src=sdkpreparse">공유하기</a></div> -->
		
		<!-- facebook -->
		<!-- <div
		  	class="fb-like"
		  data-share="true"
		  data-width="450"
		  data-show-faces="true">
		</div> -->
		
	<section>	
		<input type="hidden" name="purchaseFlag" value="${purchase.purchaseFlag}">
		
		<!-- 카톡공유버튼 -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<a id="kakao-link-btn" href="javascript:sendLink();">
					<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
				</a>
			</div>
		</div>
		
		<!-- 이미지 -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-primary">
					<div class="panel-heading">
						 <c:if test="${!empty ticket.festival}">
								 	<c:if test="${ticket.festival.festivalImage.contains('http://')}">
										<img width="100%" height="323" src="${ticket.festival.festivalImage}">
									</c:if>
									<c:if test="${!ticket.festival.festivalImage.contains('http://')}">
										<img width="100%" height="323" src="/resources/uploadFile/${ticket.festival.festivalImage}">
									</c:if>
							</c:if>
							<c:if test="${!empty ticket.party}">
								<img width="100%" height="323" src="/resources/uploadFile/${ticket.party.partyImage}">
							</c:if>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 티켓정보 -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
				  <div class="panel-body">
						<!-- 축제티켓 -->
						<c:if test="${!empty ticket.festival}">
						<div class="col-md-12">
							<h3><strong>
								${ticket.festival.festivalName}
							</strong>
							</h3>
						</div>
						<div class="col-md-12">
							<h4>
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
									${ticket.festival.startDate} ~ ${ticket.festival.endDate}
							</h4>
						</div>
							<div class="col-md-12">
								<h4>
									<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									${ticket.festival.addr}
								</h4>
							</div>
							</c:if>
							<!-- 파티티켓 -->
							<c:if test="${!empty ticket.party}">
							<div class="col-md-12">
								<h3>
								<strong>
									${ticket.party.partyName}
								</strong>
								</h3>
							</div>
							<div class="col-md-12">
								<h4>
									<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
									${ticket.party.partyDate}
								</h4>
							</div>
							<div class="col-md-12">
								<h4>
									<span class="glyphicon glyphicon-time" aria-hidden="true"></span>
									${ticket.party.partyTime}
								</h4>
							</div>
							<div class="col-md-12">
								<h4>
									<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									${ticket.party.partyPlace}
								</h4>
							</div>
							</c:if>
				  	</div>
				</div>
			</div>
		</div>
		
		<!-- 결제정보 -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="col-md-12">
							<h3><strong>결제정보</strong></h3>
							<table class="table">
								<tr>
									<td class="col-md-3"><h4>결제번호</h4></td>
									<td><h4>${purchase.paymentNo}</h4></td>
								</tr>
								<tr>
									<td class="col-md-3"><h4>결제일시</h4></td>
									<td><h4>${purchase.purchaseDate}</h4></td>
								</tr>
								<tr>
									<td class="col-md-3"><h4>구매수량</h4></td>
									<td><h4>${purchase.purchaseCount} 장</h4></td>
								</tr>
								<tr>
									<td class="col-md-3"><h4>결제금액</h4></td>
									<td><h4>${purchase.purchasePrice} 원</h4></td>
								</tr>
								<tr>
									<td class="col-md-3"><h4>결제수단</h4></td>
									<td>
										<h4>
											<c:if test="${purchase.paymentMethodType == 'CARD'}">
											카드
											</c:if>
											<c:if test="${purchase.paymentMethodType == 'MONEY'}">
												현금
											</c:if>
											<c:if test="${purchase.paymentMethodType == 'phone'}">
												핸드폰 결제
											</c:if>
											<c:if test="${empty purchase.paymentMethodType}">
												무료결제
											</c:if>
										</h4>
									</td>
								</tr>
								<tr>
									<td class="col-md-3"><h4>결제상태</h4></td>
									<td>
										<h4>
											<c:if test="${purchase.tranCode == 1}">
												결제완료
											</c:if>
											<c:if test="${purchase.tranCode == 2}">
												결제취소
											</c:if>
										</h4>
									</td>
								</tr>
							</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		
			<!-- 큐알코드 -->
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<div class="panel panel-default">
						<div class="panel-body">
							<img width="50%" height="20%" src="../../resources/image/QRCodeImage/${purchase.qrCode.qrCodeImage}">
						</div>
					</div>
				</div>
			</div>
		
			<!-- 버튼 -->
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
							<div class="col-md-6">
									<button class="btn btn-default btn-lg btn-block" type="button">목록으로</button>
							</div>
							<div class="col-md-6">
								<c:if test="${purchase.tranCode == 1 }">
									<c:if test="${ticket.ticketFlag != 'free' }">
									<form id="cancelPay">
											<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}" >
										<button class="btn btn-primary btn-lg btn-block" type="button" value="${purchase.purchaseNo}">결제취소하기</button>
									</form>
									</c:if>
									<c:if test="${ticket.ticketFlag == 'free' }">
										<form id="cancelForm">
											<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}" >
											<button class="btn btn-primary bth-lg btn-block" type="button" value="${purchase.purchaseNo}">구매취소하기</button>
										</form>
									</c:if>
								</c:if>
							</div>
						</div>
			</div>
		
		</section>
		</div>
		
							<%-- <div class="row">
								<div class="col-xs-4 col-md-6 pull-rigth">
									<h4>
									결제번호
									</h4>
								</div>
								<div class="col-xs-8 col-md-6">
									<h4>
									${purchase.paymentNo}
									</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-md-6">
									<h4>결제일시</h4>
								</div>
								<div class="col-xs-8 col-md-6">
									<h4>${purchase.purchaseDate}</h4>
								</div>
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
									<c:if test="${purchase.paymentMethodType == 'phone'}">
										핸드폰 결제
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
							<hr> --%>
							<%-- <div class="col-md-offset-4">
								<img width="50%" height="50%" src="../../resources/image/QRCodeImage/${purchase.qrCode.qrCodeImage}">
							</div> --%>
								<%-- <div class="col-md-6">
									<button class="btn btn-default btn-lg btn-block" type="button">확인</button>
								</div>
								<div class="col-md-6">
									<c:if test="${ticket.ticketFlag != 'free' }">
										<button class="btn btn-primary btn-lg btn-block" type="button" value="${purchase.purchaseNo}">결제취소하기</button>
									</c:if>
									<c:if test="${ticket.ticketFlag == 'free' }">
										<form id="cancelForm">
											<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}" >
											<button class="btn btn-primary bth-lg btn-block" type="button" value="${purchase.purchaseNo}">구매취소하기</button>
										</form>
									</c:if>
								</div> --%>
						<!-- </div>
					</div>
				</div>
		</div>
		</section>
	</div> -->
	
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