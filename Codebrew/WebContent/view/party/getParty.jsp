<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@include file="/data/party/userData.jsp"%>  --%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>파티 상세 조회 화면</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Jquery DatePicker -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= "파티수정"  Event 연결 =============
	$(function() {
		$("button:contains('파티수정')")
				.on(
						"click",
						function() {
							console.log($("td.ct_btn01:contains('파티수정')")
									.html());

							var partyFlag = $("input[name=partyFlag]", $(this))
									.val();

							self.location = "/party/updateParty?partyNo=${party.partyNo}&partyFlag="
									+ partyFlag;

						});
	});

	//============= "파티삭제"  Event 처리 및  연결 =============
	/* $(function(){
		$("button:contains('파티삭제')").on("click", function() {
			self.location="/party/deleteParty/"+${party.partyNo};
	
		});
	}); */

	//============= "파티티켓구매"  Event 처리 및  연결 =============
	/* $(function(){
		$("button:contains('파티티켓구매')").on("click", function() {
	
				var result = confirm("파티 티켓을 구매하시겠습니까?");
				
				if(result) {
					var partyNo = $("#partyNo").val();
					console.log("파티티켓구매 :: partyNo :: "+partyNo);
					
					self.location="/purchase/addPurchase?partyNo=${party.partyNo}";
				} else {
					return;
				}
			
		});
	}); */

	//============= "애프터파티 참여"  Event 처리 및  연결 =============
	/* $(function(){
		$("#afterPartyBtn").on("click", function() {
			alert("참여");
			var result = confirm("애프터 파티에 참여하시겠습니까?");
			
			if(result) {
				var partyNo = $("#partyNo").val();
				console.log("애프터파티 참여 :: partyNo :: "+partyNo);
				
				self.location="/party/joinParty?partyNo=${party.partyNo}";
			} else {
				return;
			}
			
		});
	}); */

	//============= "파티참여취소"  Event 처리 및  연결 =============
	/* $(function(){
		$("button:contains('파티참여취소')").on("click", function() {
			
			var result = confirm("파티참여를 취소하시겠습니까?");
			
			if(result) {
				
				var partyNo = $("#partyNo").val();
				console.log("파티참여취소 :: partyNo :: "+partyNo);
			
				var festivalNo = $("#festival.festivalNo").val();
				console.log("파티참여취소 :: festivalNo :: "+festivalNo);
				
				if(festivalNo != null){
					
					self.location="/party/cancelParty?partyNo=${party.partyNo}";
				}else{
					
					self.location="/party/cancelParty?partyNo=${party.partyNo}";
				}
			} else {
				return;
			}
			
	
		});
	}); */

	//============= "주최자"  Event 처리 및  연결 =============
	$(function() {
		$("#host").on(
				"click",
				function() {
					/* self.location="/myPage/getMyPage/"+"${party.user.userId}"; */
					/* var self = "${user.userId}";
					var other = "${party.user.userId}"; */
					window.open('http://127.0.0.1:3000/chat', '채팅팝업',
							'width=440, height=520, scrollbars=yes');

				});
	});

	//============= "티켓환불"  Event 처리 및  연결 =============
	/* function fncGetPurchaseNo(sessionId, partyNo) {
		
		console.log("purchaseNo얻기"+sessionId+","+partyNo);
		$.ajax({
			
			url : "/purchaseRest/json/getPurchaseNo/"+sessionId+"/"+partyNo,
			method : "GET",
			dataType : "json",
			success : function(JSONData, status) {
				
				console.log("purchaseNo--->"+JSON.stringify(JSONData));
				purchaseNo = JSONData.purchaseNo;
				
			}
			
		});
		
	}
	
	$(function(){
		
		var sessionId = "${user.userId}";
		var partyNo = $("#partyNo").val();
		//var partyNo = 10087; //일단 테스트를 위해
		
		/// ajax 호출 함수
		fncGetPurchaseNo(sessionId, partyNo);
		
		/// 파티참여취소 버튼 클릭 시 바로 getPurchase로 이동
		$("#partyButtonDiv").on("click", function(){
			self.location = "/purchase/getPurchase?purchaseNo="+purchaseNo;
		});
	}); */

	//============= "채팅"  Event 처리 및  연결 =============
	function popup(frm) {
		var url = "http://127.0.0.1:3000/chat";
		var title = "chatPop";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=440, height=520, top=0,left=20";
		window.open("", title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
		//인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
		//가능합니다.
		frm.target = title; //form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
		frm.action = url; //form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
		frm.method = "post";
		frm.submit();
	}
</script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style type="text/css">
body {
	padding-top: 70px;
	background-color: #f2f4f6;
}

.text-info {
	color: #333333;
}

.page-header {
	border-bottom: 1px solid #f2f4f6;
}

.panel-primary>.panel-heading {
	background-image: linear-gradient(to bottom, #333 0, #333 100%);
}

.panel-primary {
	border-color: #3e3e3d;
}

.col-md-12 > h4 {
	color: #b5121b;
}

#userDiv {
	height: 80px;
}
/* Zoom In */
.hover01 figure img {
	-webkit-transform: scale(1);
	transform: scale(1);
	-webkit-transition: .3s ease-in-out;
	transition: .3s ease-in-out;
}
.hover01 figure:hover img {
	-webkit-transform: scale(1.3);
	transform: scale(1.3);
}

/* Blur */
/* .hover07 figure img {
	-webkit-filter: blur(3px);
	filter: blur(3px);
	-webkit-transition: .3s ease-in-out;
	transition: .3s ease-in-out;
}
.hover07 figure:hover img {
	-webkit-filter: blur(0);
	filter: blur(0);
} */

</style>


</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	<!-- ToolBar End ///////////////////////////////////////-->

	<div class="container">
		<header>
			<!-- page header -->
			<div class="row">
				<div class="col-md-offset-4 col-md-4">
					<div class="page-header text-center">
						<h3 class="text-info">
							<span class="glyphicon glyphicon-flag" aria-hidden="true"></span> ${ empty party.festival.festivalNo  ? '파티' : '애프터 파티'}
							<input type="hidden" id="festival.festivalNo" name="festival.festivalNo" value="${ party.festival.festivalNo }"/>
							<input type="hidden" id="partyFlag" name="partyFlag" value="${ empty party.festival.festivalNo ? '1' : '2' }"/>
							<input type="hidden" id="partyNo" name="partyNo" value="${ party.partyNo }"/>
						</h3>
					</div>
				</div>
			</div>
		</header>
		<section>

			<!-- 이미지 -->
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<span> <img src="../../resources/uploadFile/${party.partyImage}" width="100%">
							</span>
						</div>
					</div>
				</div>
			</div>

			<!-- 파티 간략 정보 -->
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<div class="panel panel-default">
						<div class="panel-body">

							<!-- 파티 -->
							<div class="col-md-12">
								<h3>
									<strong> ${party.partyName} </strong>
								</h3>
							</div>
							<div class="col-md-12">

								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
								${party.partyDate}

							</div>
							<div class="col-md-12">

								<span class="glyphicon glyphicon-time" aria-hidden="true"></span>
								${party.partyTime}

							</div>
							<div class="col-md-12">

								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
								${party.partyPlace}

							</div>
							<div class="col-md-12">

								<c:if test="${ !empty party.festival.festivalName}">
									<span class="glyphicon glyphicon-flag" aria-hidden="true"></span>&nbsp;축제
									<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${ party.festival.festivalName }</div>
								</c:if>

							</div>
							<br>
							<div class="col-md-12">

								<c:if test="${ !empty party.festival.festivalNo}">
									<h4>
										<strong>#애프터 파티</strong>
									</h4>
								</c:if>
								<c:if test="${ empty party.festival.festivalNo}">
									<h4>
										<strong>#파티</strong>
									</h4>
								</c:if>

							</div>

						</div>
					</div>
				</div>
			</div>

			<!-- 파티 상세 정보 -->
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="col-md-12">
								<small><span class="glyphicon glyphicon-star"></span>&nbsp; 파티 설명</small>
								<br><br>
								&nbsp;&nbsp;&nbsp;&nbsp;${party.partyDetail}
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 파티 부가적 정보 -->
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<div class="panel panel-default">
						<div class="panel-body">
							<div id="host" class="col-md-12">
								<small><span class="glyphicon glyphicon-star"></span> 파티호스트</small> <br>
								<%-- <p><img class="rounded-circle" src="/resources/image/uploadFile/${ party.user.profileImage }" alt="Generic placeholder image" width="40" height="40"></p> --%>
								<%-- <div>
									<br>
									&nbsp;&nbsp;&nbsp;&nbsp; <img class="img-circle" src="/resources/uploadFile/${party.user.profileImage}" width="50" height="50">
									<span id="host">${ party.user.nickname }</span>
									<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button type='button' class='btn btn-default'>채팅하기</button> -->

									<!-- chatting form -->
									<form name="form">
										<input type="hidden" name="recipient" value="${party.user.userId}">
										<input type="hidden" name="sender" value="${user.userId}">
										<button type='button' class='btn-sm btn-default pull-right' onclick="javascript:popup(this.form);">채팅하기</button>
										<br>
										
									</form>
								</div> --%>
								
								<div>
									<p class="pull-left">
										<br>
										&nbsp;&nbsp;&nbsp;&nbsp; <img class="img-circle" src="/resources/uploadFile/${party.user.profileImage}" width="50" height="50">
										<span id="userDiv">${ party.user.nickname }</span>
										<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type='button' class='btn btn-default'>채팅하기</button> -->
									</p>
									
	        						<!-- chatting form -->
									<form name="form">
										<input type="hidden" name="recipient" value="${party.user.userId}">
										<input type="hidden" name="sender" value="${user.userId}">
										<button type='button' class='btn-sm btn-default pull-right' onclick="javascript:popup(this.form);">채팅하기</button>
										<br>
										
									</form>
								</div>
							</div>

							<div class="col-md-12">
								<%@include file="/view/party/getPartyMemberList.jsp"%>
								<hr>
								<small><span class="glyphicon glyphicon-star"></span> 파티에 참여한 사람들</small>
								<div id="currentMemberCountDiv"></div>
								<br>
								<br>
								
								<div class="col-md-6 text-center">
									<div class="ratio-info">
										<div class="hover01 column">
											<div>
												<figure id="ratioLock">
													<img
														src="../../resources/image/buttonImage/ratio_lock_icon.png"
														width="45%" height="45%" data-toggle="modal"
														data-target="#exampleModal2">
												</figure>
											</div>
										</div>
										<%@include file="/view/party/getGenderRatio.jsp"%>
										<br>
									</div>
									<div>
										<div class="text-center">
											<h4>
												<strong>파티에 참여한 사람들의 비율을 확인하세요</strong>
											</h4>
										</div>
										<div class="text-center">
											<h5>파티에 참여하기 전에 '코코넛'을 이용하면 참여자 비율을 미리 알 수 있어요!</h5>
										</div>
										<!-- <div class="text-center"><h5>참여자 비율을 미리 알 수 있어요!</h5></div> -->
									</div>
								</div>
								<br>
								<br>
								<div class="col-md-6 text-center">
									<div class="member-info">
										<div id="partyMemberListButtonDiv">
											<div class='hover01 column'>
												<div>
													<figure id="memberLock">
														<img
															src='../../resources/image/buttonImage/member_lock_icon.png'
															width='35%' height='35%'>
													</figure>
												</div>
											</div>
										</div>
										<br><br>
										<div>
											<div class="text-center">
												<h4>
													<strong>파티에 참여한 사람들의 리스트를 확인하세요</strong>
												</h4>
											</div>
											<div class="text-center">
												<h5>${ !empty user.nickname ? user.nickname : '회원' }님 말고도
													다른 사람들이 참여중이에요!</h5>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 파티 티켓 정보 -->
			<c:if test="${ empty party.festival.festivalNo}">
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="col-md-12">
								<small><span class="glyphicon glyphicon-tags"></span>&nbsp; 티켓 가격</small> 
								<br> 
								&nbsp;&nbsp;&nbsp;&nbsp;￦ ${ticket.ticketPrice}원
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:if>

			<!-- 파티 map 정보 -->
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="col-md-12">
								<div>
									<span class="glyphicon glyphicon-flag"></span>&nbsp;${party.partyPlace}
									<br><br>
									<%@include file="/view/party/map.jsp"%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 버튼 -->
			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<div class="col-md-6">
						<button class="btn btn-default btn btn-block" type="button">파티리스트 보기</button>
					</div>
					<div class="col-md-6">
						<c:if test="${ party.user.userId==user.userId }">
							<button type="button" class="btn btn-primary btn-block">파티수정</button>
						</c:if>
						
						<!-- 파티버튼 -->
						<span id="partyButtonDiv"></span>	
					</div>
				</div>
			</div>

		</section>
	</div>



</body>
</html>