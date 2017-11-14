<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%-- <%@ include file="/data/purchase/festivalData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/partyData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/userData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/sessionData.jsp" %> --%>
<!-- 기본티켓, 무료티켓 수량이 0일때 (품절)-->
					<c:if test="${ticket.ticketFlag != 'nolimit' and ticket.ticketCount == 0}">
					 	품절인디용권디용
						<jsp:forward page="soldOutTicket.jsp"></jsp:forward>
					</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
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
	
	<!-- jQuery ui -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
	<!-- 아임포트 -->
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<!-- sweet alert -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.2/sweetalert2.all.min.js"></script>
	<!-- Include a polyfill for ES6 Promises (optional) for IE11 and Android browser -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
	
	<script type="text/javascript" src="/resources/javascript/commonUtil.js"></script>
	<!-- 자바스크립트 -->
	<script type="text/javascript">
		
		//// 아임포트 변수 초기화
		var IMP = window.IMP; // 생략가능
		IMP.init('imp74820381'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		
		//// 아임포트 휴대폰결제
		function fncPhonePay(selectedCount, purchasePrice, purchaseFlag) {
			wrapWindowByMask();
			
			console.log("핸드폰 결제"+selectedCount+","+purchasePrice+","+purchaseFlag);
			var ticketNo = ${ticket.ticketNo};
			var userId = "${user.userId}";
			var ticketCount = ${ticket.ticketCount};
			/* var name;
			if(${ticket.ticketName}.indexOf("'") != -1) {
				name ="${ticket.ticketName}";
			} else {
				name = '${ticket.ticketName}';
			} */
			var name = $("input:hidden[name='ticketName']").val();
			
			IMP.request_pay({
			    pg : 'danal', // version 1.1.0부터 지원.
			    pay_method : 'phone',
			    merchant_uid : 'codebrew_moana_' + new Date().getTime(),
			    name : name,
			    amount : purchasePrice,
			    /* buyer_email : 'iamport@siot.do', */
			    buyer_name : userId,
			    buyer_tel : "${user.phone}",
			  /*   buyer_addr : '',
			    buyer_postcode : '123-456', */
			    m_redirect_url : 'http://127.0.0.1:8080/purchaseRest/json/iamport/approvePurchase'
			}, function(rsp) {
			    if ( rsp.success ) {
			    	$("#wrap").css("top","250px");
			    	$.ajax({
			    		
			    		url : "/purchaseRest/json/iamport/approvePayment",
			    		method : "POST",
			    		headers : {
			    			"Accept" : "application/json",
			    			"Content-Type" : "application/json"
			    		},
			    		data : JSON.stringify({
			    			aid : rsp.imp_uid, //아이엠포트 고유번호
			    			cid : rsp.merchant_uid, //아이엠포트 가맹점 고유번호
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
			    		success : function(JSONData){
			    			
			    			console.log(JSONData);
			    			self.location = "/purchase/getPurchase?purchaseNo="+JSONData.purchaseNo;
			    		}
			    		
			    	});
			    	
			        var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			    }
			    console.log(msg);
			});
			
		}
		
		function fncReadyTransfer(selectedCount, purchasePrice, purchaseFlag) {
			
			var ticketNo = ${ticket.ticketNo};
			var userId = "${user.userId}";
			var ticketCount = ${ticket.ticketCount};
			var name = '${ticket.ticketName}';
			
			//alert($("#purchaseForm").serialize());
			var innerHtml = "<form id=transForm>";
			innerHtml += "<input type='hidden' name='purchaseCount' value='"+selectedCount+"'>";
			innerHtml += "<input type='hidden' name='purchasePrice' value='"+purchasePrice+"'>";
			innerHtml += "<input type='hidden' name='purchaseFlag' value='"+purchaseFlag+"'>";
			innerHtml += "<input type='hidden' name='ticket.ticketNo' value='"+ticketNo+"'>";
			innerHtml += "<input type='hidden' name='ticket.ticketCount' value='"+ticketCount+"'>";
			innerHtml += "<input type='hidden' name='user.userId' value='"+userId+"'>";
			innerHtml += "<input type='hidden' name='itemName' value='"+name+"'>";
			innerHtml += "</form>";
			
			$("body").append(innerHtml);
			$("#transForm").attr("method", "POST").attr("action", "/purchase/readyTransfer").submit();
			
		}
		
		/* ////계쫘이체 결제준비 호출 function
		function fncReadyTransfer(selectedCount, purchasePrice, purchaseFlag){
	
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
			
		} */
		
		//// 수량 선택시 validation check function
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
			$("#purchasePrice").html(AddComma(purchasePrice)); //결제금액
			
			$("#kakaoPay").removeAttr("disabled"); //카카오페이 버튼 활성화
			$("#danal").removeAttr("disabled"); //핸드폰 결제 활성화
			$("#bank").removeAttr("disabled"); //계좌이체 활성화
			
		}
		
		//// 카카오페이 결제준비 호출 function
		function fncPayment(selectedCount, purchasePrice, purchaseFlag, e){
	
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
					showPopup(url);
					//window.open(url,'kakaoPay','toolbar=no, directories=no, scrollbars=no, status=no, scrollbars=no,width=426,height=510,  resizable=no, direction=no, location=no, menubar=no, toolbar=no, titlebar=no');
				}
				
			});
			
		}
		
		//////////////레이어팝업 배경
		function wrapWindowByMask(){
			//화면의 높이와 너비를 구한다.
			var maskHeight = $(document).height();  
			var maskWidth = $(window).width();
	
			//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
			$('#mask').css({'width':maskWidth,'height':maskHeight});  
	    	//마스크의 투명도 처리
	         $('#mask').fadeTo("slow",0.8);    
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
			$("#kakaoPay").on("click",function(event){
				
				fncPayment(selectedCount, purchasePrice, purchaseFlag, event);
				
			});
			
			//핸드폰 결제 클릭 시
			$("#danal").on("click",function(){
				
				fncPhonePay(selectedCount, purchasePrice, purchaseFlag);
				
			});
			
			//계좌이체 클릭 시
			$("#bank").on("click",function(){
				
				fncReadyTransfer(selectedCount, purchasePrice, purchaseFlag);

			});
			
			//구매하기 클릭 시
			$("#purchase").on("click", function(){
				
				console.log("구매버튼 클릭클릭");
				
				if(confirm("구매하시겠습니까?")) {
	
					selectedCount = $("#purchaseCount").html().trim();
					$("input:hidden[name='purchaseCount']").val(selectedCount);
					$("input:hidden[name='purchasePrice']").val(AddComma(purchasePrice));
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
			
			////////////////레이어팝업 사이즈조절
			$(window).resize(function(){
				console.log($(window).width());
				$("#mask").css("width" , $(window).width());
				$("#mask").css("height",$(document).height());
				if($(window).width() < 963) {
					$("#popLayer").css("left","0%");
					$("#popLayer").css("width" , $(window).width());
				} else {
					$("#popLayer").css("width","447px");
					$("#popLayer").css("left","40%");
					
				}
				//$("#popLayer").css("heigth" , $(window).heigth());
			}) 
			
			
		});
	
			////////////////////////////////레이어팝업
			jQuery.fn.center = function () {
			    this.css("position","absolute");
			    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
			    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
			    return this;
			}
			var showPopup = function(url) {
				$("#kakaoUrl").attr("src", url);
				$("#popLayer").show();
				//$("#popLayer").css("width" , $(window).width());
				//$("#popLayer").css("height" , $(window).height());
				wrapWindowByMask();
				$("#popLayer").center();
			}
	</script>
	
	<!-- CSS 시작 -->
	<style type="text/css">
	
		/* 툴바 간격, 배경색 */
		body {
			padding-top : 70px;
			background-color: #f2f4f6;
	    }
	    
		/* 링크 클릭시 파란색 안남도록 */
	    .btn {
			text-decoration : none;
			border : 0;
			outline : 0;
		}
		
		.panel-primary>.panel-heading {
	    	background-color: #000000;
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
		
		form > img {
			width : 100%;
			height : 323px
		}
		
		.table>tbody>tr>td {
			border-top: 1px solid rgba(255,255,255,.15);
		}
		
		/*           레이어 팝 업              */
		.layer {
			display:none;
		    position: fixed;
		    width: 448px;
		    left: 50%; 
		   /*  margin-left: -40%; */ /* half of width */
		     height: 710px; 
		    top: 35%; 
		    margin-top: -150px;  /* half of height */
		    overflow: visible;
			z-index : 6;
		    /* decoration */
		    border: 1px solid #000;
		    background-color: #eee;
		    padding: 1em;
		    box-sizing: border-box;
		}
		
		/* @media (max-width: 930px) {
		    .layer {
		    	margin-top:-75%;
		        width: 90%;
		        margin-left: -10%;
				margin-right: -5%;
		    }
		}
		
		@media (max-width: 930px) {
		    #mask {
		    	margin-top:50%;
		        width: 80%;
		        margin-left: -10%;
		    }
		} */
		
		#mask { /* position:absolute; z-index:9000; background-color:#000; display:none; left:0; top:0; */
			display:none;
	        background-color:black;
    	    position:absolute;
        	left:0px;
        	top:0px;
			z-index: 3;
		 }

		/* 화면 디버그용 */
	   /*  div {
			border : 3px solid #D6CDB7;
			margin0top : 10px;
		}   */
		
	</style>
	
</head>

<body>
	
	<!-- 툴바 -->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
	<!-- 화면시작 -->
	<div class="container">
		
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info">
						<span class="glyphicon glyphicon-tag" aria-hidden="true"></span> 티켓구매
					</h3>
					<small class="text-muted">구매정보를 확인해주세요</small>
				</div>
			</div>
		</div>
		
		<!-- form -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
			
				<!-- form 시작 -->
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
					<input type="hidden" name="ticketName" value="${ticket.ticketName}">
					
					<!-- 이미지 -->
					<div class="row">
						<div class="col-md-12">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<!-- 축제 이미지 -->
									<c:if test="${!empty festival}">
										<c:if test="${festival.festivalImage.contains('http://')}">
											<img width="100%" height="323" src="${festival.festivalImage}">
										</c:if>
										<c:if test="${!festival.festivalImage.contains('http://')}">
											<img width="100%" height="323" src="/resources/uploadFile/${festival.festivalImage}">
										</c:if>
									</c:if>
									<!-- 파티 이미지 -->
									<c:if test="${!empty party}">
										<img width="100%" height="323" src="/resources/uploadFile/${party.partyImage}">
									</c:if>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 축제정보 -->
					<c:if test="${!empty festival}">
						<div class="row">
							<div class="col-md-12">
								<div class="panel panel-default">
							  		<div class="panel-body text-center">
										<div class="row">
											<!-- 축제이름 -->
											<div class="col-md-12">
												<h3>
													<strong>${festival.festivalName}</strong>
												</h3>
											</div>
											<!-- 축제주소 -->
											<div class="col-md-12">
												<h4>
													<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> ${festival.addr}
												</h4>
											</div>
											<!-- 축제기간 -->
											<div class="col-md-12">
												<h4>
													<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
													${ticket.festival.startDate} ~ ${ticket.festival.endDate}
												</h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					
					<!-- 파티정보 -->
					<c:if test="${!empty party}">
						<input type="hidden" name="party.partyName" value="${party.partyName}">
						<div class="row">
							<div class="col-md-12">
								<div class="panel panel-default">
							  		<div class="panel-body text-center">
										<div class="row">
											<!-- 파티이름 -->
											<div class="col-md-12">
												<h3>
													<strong>${party.partyName}</strong>
												</h3>
											</div>
											<!-- 파티장소 -->
											<div class="col-md-12">
												<h4>
													<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> ${party.partyPlace}
												</h4>
											</div>
											<!-- 파티날짜 -->
											<div class="col-md-12">
												<h4>
													<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> ${party.partyDate}
												</h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					
					<!-- 가격, 수량정보 -->
					<div class="row">
						<div class="col-md-12">
							<div class="panel panel-default">
								<div class="panel-body">
									<div class="row">
										<!-- 가격!!!!! -->
										<div class="col-md-6 text-center">
											<h4>
												<span class="glyphicon glyphicon-usd" aria-hidden="true"></span>
													가격 
											</h4>
										</div>
										<div class="col-md-6 text-center">
											<h4>
												<!-- 1....기본티켓 or 무제한티켓 -->
												<c:if test="${empty ticket.ticketFlag or ticket.ticketFlag == 'nolimit'}">
													${ticket.ticketPrice}원
												</c:if>
												<!-- 2....무료티켓 -->
												<c:if test="${ticket.ticketFlag == 'free'}">
													무료
												</c:if>
											</h4>
										</div>
									</div>
									<hr>
									<!-- 수량!!!! -->
									<!-- 기본티켓, 무료티켓 수량 0 아닐때 -->
									<c:if test="${ticket.ticketCount > 0}">
										<div class="row">
											<div class="col-md-6 text-center">
												<h4>수량</h4>
											</div>
											<div class="col-md-6 text-center">
												<div class="form-group form-inline">
													<select id="countSelect" class="form-control input-lg" name="ticketCount">
														<option value="" selected>선택하세요</option>
															<c:forEach begin="1" end="${ticket.ticketCount}" var="i" step="1">
																<option>${i}</option>
															</c:forEach>
													</select>
												</div>
											</div>
										</div>
									</c:if>
									<!-- 무제한티켓이면서 수량 0일때 -->	
									<c:if test="${ticket.ticketFlag == 'nolimit' and ticket.ticketCount == 0}">
										<div class="row">
											<div class="col-md-12 text-center">
												<div class="col-md-6 text-center">
													<h4>수량</h4>
												</div>
												<div class="col-md-6 text-center">
													<div class="input-group">
														<span class="input-group-addon">
															<span id="minus" class="glyphicon glyphicon-minus" aria-hidden="true"></span>
														</span>
														<input type="text" class="form-control" name="ticketCount" value="0" placeholder="0" readonly>
														<span class="input-group-addon">
															<span id="plus" class="glyphicon glyphicon-plus" aria-hidden="true"></span>
														</span>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 수량 정보 -->
					<%-- <!-- 기본티켓, 무료티켓 수량이 0일때 (품절)-->
					<c:if test="${ticket.ticketFlag != 'nolimit' and ticket.ticketCount == 0}">
					 	품절인디용권디용
						<jsp:forward page="soldOutTicket.jsp"></jsp:forward>
					</c:if> --%>
							
					<!-- 구매정보 -->
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">
								<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
								&nbsp;&nbsp; ${user.nickname}님의 구매정보
							</h3>
						</div>
						<div class="panel-body">
							<table class="table table-condensed text-center">
								<tr>
									<td class="col-md-3"><h4>아이디</h4></td>
									<td><h4>${user.userId}</h4></td>
								</tr>
								<tr>
									<td class="col-md-3"><h4>구매수량</h4></td>
									<td><h4><span id="purchaseCount">0</span>장</h4></td>
								</tr>
								<tr>
									<td class="col-md-3"><h4>결제금액</h4></td>
									<td><h4><span id="purchasePrice">0</span>원</h4></td>
								</tr>
							</table>
						</div>
					</div>
							
					<!-- 카카오페이 & 핸드폰결제 & 계좌이체 -->
					<c:if test="${empty ticket.ticketFlag or ticket.ticketFlag == 'nolimit'}">
						<div class="row">
							<div class="col-md-12">
								<span class="help-block">
									결제창이 뜨지 않을 경우, 팝업을 허용한 뒤 다시 시도 해주세요.
								</span>
							</div>
						</div>
						
						<!-- 카카오페이 버튼 -->	
						<div class="row">
							<div class="col-md-6">
								<div class="panel panel-default">
									<div class="panel-body">
										카카오페이
										<button id="kakaoPay" class="btn btn-link btn-block" disabled="disabled" type="button">
											 <img src="../../resources/image/buttonImage/kakaopay.png">
										</button>
									</div>
								</div>
							</div>
								
							<!-- 휴대폰 결제 버튼 -->
							<div class="col-md-6">
								<div class="panel panel-default">
									<div class="panel-body">
										휴대폰결제
										<button id="danal" class="thumbnail btn btn-link btn-block" disabled="disabled" type="button">
											<img width="120" height="51" src="../../resources/image/buttonImage/danal.jpg">
										</button>
									</div>
								 </div>
							</div>
							
							<!-- 뒤로가기 -->
							<div class="col-md-offset-3 col-md-6">
								<button class="btn btn-default btn-lg btn-block" type="button">뒤로가기</button>
							</div>
						</div>
					</c:if>
							
					<!-- 단순구매 -->
					<c:if test="${ticket.ticketFlag == 'free' and ticket.ticketCount > 0}">
						<div class="row">
							<div class="col-md-6">
								<button class="btn btn-default btn-lg btn-block" type="button">뒤로가기</button>
							</div>
							<div class="col-md-6">
								<button id="purchase" class="btn btn-primary btn-lg btn-block" disabled="disabled" type="button">
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
				<!-- 폼끝 -->
			</div>
		</div>
	</div>
	
	<!-- 카카오레이어팝업 -->
	<div id="mask">
	</div> 
		<div id="popLayer" class="js-layer  layer">
			<iframe id="kakaoUrl" frameborder="0" allowTransparency="true"  width="100%" height="100%" src=""></iframe>
		</div>
</body>

</html>