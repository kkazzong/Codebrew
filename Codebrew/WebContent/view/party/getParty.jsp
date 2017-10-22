<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@include file="/data/party/userData.jsp"%>  --%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	
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
					console.log("파티티켓구매 :: partyNo :: "+partyNo);
					
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
		
		//============= "참여자목록보기"  Event 처리 및  연결 =============
		/* $(function(){
			$("button:contains('참여자목록보기')").on("click", function() {
				self.location="/party/getPartyMemberList?partyNo=${party.partyNo}";
		
			});
		}); */
		
		//============= "확인"  Event 처리 및  연결 =============
		/* $(function(){
			$("button:contains('확인')").on("click", function() {
				self.location="/party/getGenderRatio?partyNo=${party.partyNo}";
		
			});
		}); */
		
		//============= "주최자"  Event 처리 및  연결 =============
		$(function(){
			$("div.host").on("click", function() {
				self.location="/user/getProfile/"+"${party.user.userId}";
		
			});
		});
		
	
		
	</script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	
	
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
			<div class="host">
				<h2 class="text-center">${ party.partyName }</h2>
				<div>
					<%-- <p><img class="rounded-circle" src="/resources/image/uploadFile/${ party.user.profileImage }" alt="Generic placeholder image" width="40" height="40"></p> --%>
					<p>파티 호스트 &nbsp;<img class="rounded-circle" src="/resources/uploadFile/${party.partyImage}" alt="Generic placeholder image" width="40" height="40">
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
						<strong>파티인원</strong>
					</div>
					<div class="col-xs-4 col-md-2">${party.partyMemberLimit} 명 중 ${currentMemberCount} 명 참여중</div>
					
					<c:set var="i" value="0"/>
					<c:forEach var="partyMember" items="${list}">
						<c:set var="i" value="${i+1}"/>
						<c:if test="${user.userId == partyMember.user.userId }">
							<!-- <button type="button" class="btn btn-primary">파티참여취소</button> -->
							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
							  파티멤버보기
							</button>
							
							<%@include file="/view/party/getPartyMemberList.jsp"%> 
							
							<%-- <!-- Modal -->
							<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">파티 멤버 목록</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <div class="modal-body">
							        <form class="form-horizontal" enctype="multipart/form-data">
										${ partyMember.party.partyNo }
										<c:set var="i" value="0"/>
										<c:forEach var="partyMember" items="${list}">
											<div class="row">
												<img class="rounded-circle" src="/resources/image/uploadFile/${ partyMember.user.profileImage }" alt="Generic placeholder image" width="40" height="40">
												${ partyMember.user.userId }
												<c:if test="${partyMember.role =='host' }">
													<strong>host</strong>
												</c:if>
											</div>
										</c:forEach>
									</form>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
							      </div>
							    </div>
							  </div>
							</div> --%>
						
						</c:if>
					</c:forEach>
					
					
				</div>
				
				<hr/>
				<c:if test="${ empty party.festival.festivalNo }">
				<div class="row" id="ticketPriceDiv">
					<div class="col-xs-4 col-md-2 ">
						<strong>파티 티켓 가격</strong>
					</div>
					<div class="col-xs-8 col-md-4">${ticket.ticketPrice}</div>
				</div>
				
				<hr />
				</c:if>
				
				<c:if test="${ ticket.ticketPrice == 0 }">
				<div class="row" id="ticketPriceDiv">
					<div class="col-xs-4 col-md-2 ">
						<strong>파티 티켓 가격</strong>
					</div>
					<div class="col-xs-8 col-md-4">0</div>&nbsp;원
				</div>
				
				<hr />
				</c:if>
				
				<div class="row">
					<div class="col-xs-4 col-md-2">
						<strong>파티설명</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyDetail}</div>
				</div>
				
				<hr/>

				<div class="jumbotron">
					<p>당신은 현재 참여중인 참여자의 성별비율을 볼 수 있습니다.....당신은 궁금합니다.....코코넛을 사용해 확인하시겠습니까?</p>
				
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal2">
					  확인하기
					</button>
					
					<%@include file="/view/party/getGenderRatio.jsp"%> 
					<!-- Modal -->
					<%-- <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">파티 성별 비율</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        <form class="form-horizontal" enctype="multipart/form-data">
								${ partyMember.partyNo }
								<c:set var="i" value="0"/>
								<c:forEach var="partyMember" items="${list}">
									<div class="row">
										<img class="rounded-circle" src="/resources/uploadFile/${ partyMember.user.profileImage }" alt="Generic placeholder image" width="40" height="40">
										${ partyMember.user.userId }
										<c:if test="${partyMember.role =='host' }">
											<strong>host</strong>
										</c:if>
									</div>
								</c:forEach>
							</form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					      </div>
					    </div>
					  </div>
					</div> --%>
				
				</div>

				<hr />

				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>파티 장소</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyPlace}</div>
				</div>

				<hr />

				<div class="row">
					<div class="col-md-12 text-center">
						<c:if test="${ ! empty party.user.userId && party.user.userId==user.userId }">
							<button type="button" class="btn btn-primary">파티수정</button>
						</c:if>
						<%-- <c:if test="${ ! empty party.user.userId && party.user.userId==sessionScope.user.userId }">
							<button type="button" class="btn btn-primary">파티삭제</button>
						</c:if> --%>
						<c:if test="${ empty party.festival.festivalNo && party.user.userId!=user.userId }">
							<button type="button" class="btn btn-primary">파티티켓구매</button>
						</c:if>
						
						<c:set var="i" value="0" />
						<c:forEach var="partyMember" items="${list}">
							<c:set var="i" value="${ i+1 }" />
							<c:if test="${ !empty party.festival.festivalNo }">
								<c:if test="${ partyMember.user.userId!=user.userId } && ${ party.user.userId!=user.userId } ">
								<button type="button" class="btn btn-primary">애프터파티 참여</button>
								<c:set var="break" value="true" />
								</c:if>
							</c:if>
							<c:if test="${ partyMember.user.userId==user.userId && party.user.userId!=user.userId }">
								<button type="button" class="btn btn-primary">파티참여취소</button>
								<c:set var="break" value="true" />
							</c:if>
						</c:forEach>
						
					</div>
				</div>

			</div>

		</div>
	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>
</html>