<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@include file="/data/party/userData.jsp"%>  --%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>파티 상세 조회 화면</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    

    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= "파티수정"  Event 연결 =============
		$(function(){
			$("button:contains('파티수정')").on("click", function() {
				console.log($( "td.ct_btn01:contains('파티수정')" ).html());
				
				var partyFlag = $( "input[name=partyFlag]", $(this) ).val();
				
				self.location="/party/updateParty?partyNo=${party.partyNo}&partyFlag="+partyFlag;
		
			});
		});
		
		
		//============= "파티삭제"  Event 처리 및  연결 =============
		/* $(function(){
			$("button:contains('파티삭제')").on("click", function() {
				self.location="/party/deleteParty/"+${party.partyNo};
		
			});
		}); */
		
		
		//============= "파티티켓구매"  Event 처리 및  연결 =============
		$(function(){
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
		});
		
		
		//============= "애프터파티 참여"  Event 처리 및  연결 =============
		$(function(){
			$("button:contains('애프터파티 참여')").on("click", function() {
				
				var result = confirm("애프터 파티에 참여하시겠습니까?");
				
				if(result) {
					var partyNo = $("#partyNo").val();
					console.log("애프터파티 참여 :: partyNo :: "+partyNo);
					
					self.location="/party/joinParty?partyNo=${party.partyNo}";
				} else {
					return;
				}
				
			});
		});
		
		
		//============= "파티참여취소"  Event 처리 및  연결 =============
		$(function(){
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
		});
		
		
		//============= "주최자"  Event 처리 및  연결 =============
		$(function(){
			$("p.host").on("click", function() {
				self.location="/myPage/getMyPage/"+"${party.user.userId}";
		
			});
		});
		
		
		
		
	</script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style type="text/css">
		
		body {
	     	padding-top : 70px;
	    }
	    
	</style>
	
	
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<h1 class="bg-primary text-center"> 
		${ empty party.festival.festivalNo  ? '파티 상세 보기' : '애프터 파티 상세 보기'}
		<input type="hidden" id="festival.festivalNo" name="festival.festivalNo" value="${ party.festival.festivalNo }"/>
		<input type="hidden" id="partyFlag" name="partyFlag" value="${ empty party.festival.festivalNo ? '1' : '2' }"/>
		<input type="hidden" id="partyNo" name="partyNo" value="${ party.partyNo }"/>
		</h1>
		<hr />

		<div class="container">
			<div>
				<h2 class="text-center">${ party.partyName }</h2>
				<div>
					<%-- <p><img class="rounded-circle" src="/resources/image/uploadFile/${ party.user.profileImage }" alt="Generic placeholder image" width="40" height="40"></p> --%>
					<p class="host">파티 호스트 &nbsp;<img class="rounded-circle" src="/resources/uploadFile/${party.partyImage}" alt="Generic placeholder image" width="40" height="40">
					${ party.user.nickname }</p>
					<%-- <p>파티 호스트 &nbsp;<img class="rounded-circle" src="/resources/uploadFile/${ party.user.profileImage }" alt="Generic placeholder image" width="40" height="40">
					${ party.user.nickname }</p> --%>
				</div>
			</div>
			
			<div class="text-center">
				<img src="../../resources/uploadFile/${party.partyImage}" width="800" >
			</div>
			
			<br>
			
			<div>
			
			<c:if test="${ party.festival != null }">
				<div class="row">
					<br />
					<div class="col-xs-4 col-md-2 ">
						<strong>축제명</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.festival.festivalName}</div>
				</div>

				<hr />
			</c:if>
			
				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>파티날짜</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyDate}</div>
				</div>

				<hr />
				
				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>파티시간</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyTime}</div>
				</div>

				<hr />

				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>파티인원</strong>
					</div>
					<div class="col-xs-4 col-md-2" id="currentMemberCountDiv"></div>
	
					<%@include file="/view/party/getPartyMemberList.jsp"%> 				
					
				</div>
				
				<hr/>
				<c:if test="${ empty party.festival.festivalNo}">
					<c:if test="${ !empty ticket.ticketPrice || ticket.ticketPrice == 0 }">
					<div class="row" id="ticketPriceDiv">
						<div class="col-xs-4 col-md-2 ">
							<strong>파티 티켓 가격</strong>
						</div>
						<div class="col-xs-8 col-md-4">${ticket.ticketPrice}&nbsp;원</div>
					</div>
					
					<hr />
					</c:if>
				</c:if>
				
				<%-- <c:if test="${ ticket.ticketPrice == 0 }">
				<div class="row" id="ticketPriceDiv">
					<div class="col-xs-4 col-md-2 ">
						<strong>파티 티켓 가격</strong>
					</div>
					<div class="col-xs-8 col-md-4">0</div>&nbsp;원
				</div>
				
				<hr />
				</c:if> --%>
				
				<div class="row">
					<div class="col-xs-4 col-md-2">
						<strong>파티설명</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyDetail}</div>
				</div>
				
				<hr/>

				<div class="jumbotron">
					<p>당신은 현재 참여중인 참여자의 성별비율을 볼 수 있습니다.....당신은 궁금합니다.....코코넛을 사용해 확인하시겠습니까?</p>
				
					<%@include file="/view/party/getGenderRatio.jsp"%> 
					
				</div>

				<hr />

				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>파티 장소</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyPlace}
					
					<%@include file="/view/party/map.jsp"%> 
					</div>
				</div>

				<hr />

				<div class="row">
					<div class="col-md-12 text-center">
						
						<!-- 파티 & 애프터 파티 -->
						<c:if test="${ party.user.userId==user.userId }">
					
							<button type="button" class="btn btn-primary">파티수정</button>
						</c:if>
						
						<%-- <c:if test="${ ! empty party.user.userId && party.user.userId==sessionScope.user.userId }">
							<button type="button" class="btn btn-primary">파티삭제</button>
						</c:if> --%>
						
						<!-- 파티 -->
 						<c:if test="${ empty party.festival.festivalNo }">
							<c:if test="${ party.user.userId!=user.userId }">
						
								<button type="button" class="btn btn-primary">파티티켓구매</button>
							</c:if>
						</c:if>
						
						<!-- 애프터 파티 -->
						<%-- <c:if test="${ !empty party.festival.festivalNo }">
							console.log("애프터 파티 버튼 구간 1");
							<c:set var="i" value="0" />
							<c:forEach var="partyMember" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								console.log("애프터 파티 버튼 구간 2");
									<c:if test="${ partyMember.user.userId != user.userId }">
										console.log("애프터 파티 버튼 구간 3");
										<button type="button" class="btn btn-primary">애프터파티 참여</button>
									</c:if>
								
									<c:if test="${ partyMember.user.userId==user.userId && party.user.userId!=user.userId }">
										console.log("애프터 파티 버튼 구간 4");
										<button type="button" class="btn btn-primary">파티참여취소</button>
		
									</c:if>
							</c:forEach>
						</c:if> --%>
						<span id="partyButtonDiv"></span>					
					<!-- <button type="button" class="btn btn-primary">뒤로</button> -->
						
					</div>
				</div>

			</div>

		</div>
	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>
</html>