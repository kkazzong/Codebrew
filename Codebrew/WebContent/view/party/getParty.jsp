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
   	
	<!-- page header -->
	<div class="row">
		<div class="col-md-offset-4 col-md-4">
			<div class="page-header text-center">
				<h3 class="text-info"><span class="glyphicon glyphicon-flag" aria-hidden="true"></span> ${ empty party.festival.festivalNo  ? '파티' : '애프터 파티'}</h3>
				<input type="hidden" id="festival.festivalNo" name="festival.festivalNo" value="${ party.festival.festivalNo }"/>
				<input type="hidden" id="partyFlag" name="partyFlag" value="${ empty party.festival.festivalNo ? '1' : '2' }"/>
				<input type="hidden" id="partyNo" name="partyNo" value="${ party.partyNo }"/>
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-md-offset-3 col-md-6">
			<div class="panel panel-primary">
				<%-- <div class="panel-heading">
					<h3 class="panel-title">${party.partyName}</h3>
				</div> --%>
				<div class="panel-body">
					
					<div class="col-md-12">
						<h3>
						<strong>
							${party.partyName}
						</strong>
						</h3>
					</div>
					<hr><br>
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
								<div>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${ party.festival.festivalName }
								</div>
							</c:if>
						
					</div>
					<br>
					<div class="col-md-12">
						
							<c:if test="${ !empty party.festival.festivalNo}">
								<h4><strong>#애프터 파티</strong></h4>
							</c:if>
							<c:if test="${ empty party.festival.festivalNo}">
								<h4><strong>#파티</strong></h4>
							</c:if>
						
					</div>
					<div class="col-md-12">
						<br>
						<span>
							<img src="../../resources/uploadFile/${party.partyImage}" width="100%" >
						</span>
						
					</div>
					<hr>
					<div class="col-md-12">
						<small><span class="glyphicon glyphicon-star"></span> 파티 호스트</small>
						<br/>
						<%-- <p><img class="rounded-circle" src="/resources/image/uploadFile/${ party.user.profileImage }" alt="Generic placeholder image" width="40" height="40"></p> --%>
						<div>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<img class="img-circle" src="/resources/uploadFile/${party.user.profileImage}" width="50" height="50">
							${ party.user.nickname }
						</div>
					</div>
					
					<div class="col-md-12">
						<hr>
						<small><span class="glyphicon glyphicon-star"></span> 참여인원</small>
						<br>
						<div id="currentMemberCountDiv"></div>
		                <%@include file="/view/party/getPartyMemberList.jsp"%>
						
					</div>
					<div class="col-md-12">
						<div class="jumbotron">
							<div class="text-center">당신은 현재 참여중인 참여자의 성별비율을 볼 수 있습니다.....당신은 궁금합니다.....코코넛을 사용해 확인하시겠습니까?</div>
							<br>
							<%@include file="/view/party/getGenderRatio.jsp"%> 
						</div>
					</div>	
					<hr><br>
					<div class="col-md-12">
						<small><span class="glyphicon glyphicon-star"></span> &nbsp; 파티 설명</small>
						<br>
						&nbsp;&nbsp;&nbsp;&nbsp;${party.partyDetail}
					</div>
					<c:if test="${ empty party.festival.festivalNo}">
						<div class="col-md-12">
							<br>
							<small><span class="glyphicon glyphicon-tags"></span> &nbsp; 티켓 가격</small>
							<br>
							&nbsp;&nbsp;&nbsp;&nbsp;￦ ${ticket.ticketPrice}원
						</div>
					</c:if>
					<div class="col-md-12">
						<br><br><hr>
						<div>${party.partyPlace}
							<%@include file="/view/party/map.jsp"%>
						</div>	
					</div>
					<div class="col-md-12">
						<br><br><hr>
						<div class="col-md-offset-4 col-md-4 text-center">
						
						<!-- 파티 & 애프터 파티 -->
						<c:if test="${ party.user.userId==user.userId }">
					
							<button type="button" class="btn btn-primary btn-block">파티수정</button>
						</c:if>
						
						<%-- <c:if test="${ ! empty party.user.userId && party.user.userId==sessionScope.user.userId }">
							<button type="button" class="btn btn-primary">파티삭제</button>
						</c:if> --%>
						
						<!-- 파티 -->
 						<%-- <c:if test="${ empty party.festival.festivalNo }">
							<c:if test="${ party.user.userId!=user.userId }">
						
								<button type="button" class="btn btn-primary">파티티켓구매</button>
							</c:if>
						</c:if> --%>
						
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
</div>
	


</body>
</html>