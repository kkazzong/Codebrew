<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%-- <%@ include file="/data/purchaseData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/userData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/sessionData.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>getPurchaseList</title>

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

<script type="text/javascript">
	
	function fncGetList(currentPage) {
		console.log("페이지클릭 : "+currentPage);
		$("#currentPage").val(currentPage);
		$("#searchForm").attr("method", "POST").attr("action", "/purchase/getPurchaseList").submit();
	}

	$(function(){
		
		var userId = $("input:hidden[name='userId']").val();
		
		//page header 클릭(판매목록)
		$(".page-header").on("click", function(){
			self.location = "/purchase/getPurchaseList?userId="+userId;
		})
		
		//enter key 검색
		$("#searchKeyword").on("keydown", function(event){
			
			if(event.keyCode == '13') {
				if($("#searchKeyword").val() == '') {
					event.preventDefault();
					alert("검색어를 입력해주세요");
					return;
				}
				event.preventDefault();
				fncGetList(1);
			}

		});
		
		//검색버튼
		$(".btn:contains('검색')").on("click", function(){
			
			if($("#searchKeyword").val() == '') {
				alert("검색어를 입력해주세요");
				return;
			}
			fncGetList(1);
			
		});
		
		//축제버튼
		$("#festivalBtn").on("click", function(){
			console.log("축제버튼 클릭 : val = "+$(this).val());
			self.location = "/purchase/getPurchaseList?userId="+userId+"&purchaseFlag="+$(this).val()+"&searchCondition=1";
		});
		
		//파티버튼		
		$("#partyBtn").on("click", function(){
			console.log("파티버튼 클릭 : val = "+$(this).val());
			self.location = "/purchase/getPurchaseList?userId="+userId+"&purchaseFlag="+$(this).val()+"&searchCondition=2";
		});
		
		//조회
		$("button:contains('조회')").on("click", function(){
			console.log("조회버튼 클릭 : val = "+$(this).val());
			self.location = "/purchase/getPurchase?purchaseNo="+$(this).val();
		});
		
		/* $(".btn:contains('마이티켓')").on("click", function(){
			console.log("마이티켓 클릭");
			self.location = "/purchase/getPurchaseList?userId="+userId;
		}); */
		
		$(".pull-right").each(function(){}).on("click", function(){
			
			if(confirm("정말로 삭제하시겠습니까?")) {
				/* $.ajax({
					
					url : "/purchaseRest/json/deletePurchase/"+$(this).val(),
					mehtod : "POST",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData) {
						console.log("delete 성공(update delete flag)");
						console.log(JSON.stringify(JSONData));
						//self.location = "/purchase/deletePurchase";
					}
				}); */
				$("#deleteForm").attr("method", "post").attr("action", "/purchase/deletePurchase").submit();
			} else {
				return;
			}
			
		});

		var purchaseFlag = $("#purchaseFlag").val();
		if(purchaseFlag = '') {
			purchaseFlag = null;
		}
		var userId = "${user.userId}";
		//autocomplete
		$("#searchKeyword").autocomplete({
			source: function( request, response ) {
		        $.ajax( {
		          url: "/purchaseRest/json/getPurchaseList/${user.userId}/1",
		          method : "POST",
		          headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
				  },
		          dataType: "json",
		          data: JSON.stringify({
		        	currentPage : "1",
			        searchKeyword : $("#searchKeyword").val(),
			        searchCondition : $("#searchCondition").val(),
		          }),
		          success: function( JSONData ) {
		        		  
		        	console.log("server data =>"+JSON.stringify(JSONData));
		        	var searchCondition = $("#searchCondition").val();
		            response($.map(JSONData, function(value, key){
		            	console.log(value.itemName);
		            	console.log("key(autocomplete : value)====>"+key);
		            	//아이디 검색 시
		            	if(searchCondition == 4) {
			        		return {
			        			label : value.user.userId,
			        			value : value.user.userId //원래는 key,, 선택시를 위해
			        		}
		            	} else if(searchCondition == 5) { //티켓명 검색 시
		            		return {
		            			label :  value.itemName,
		            			value : value.itemName
		            		}
		            	}
		        	}));
		          }
		        } );
		    }
		});
		
	});
</script>
<style type="text/css">
	body {
		padding-top : 70px;
    }
    .panel {
		margin-top : 50px;
    }
    /* div {
		border : 3px solid #D6CDB7;
		margin0top : 10px;
	} */
	.panel-heading h3 {
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    line-height: normal;
	    width: 75%;
	    padding-top: 8px;
	}
</style>
</head>
<body>
	
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	<!-- 모달 -->
	<jsp:include page="/view/purchase/filterModalUser.jsp"></jsp:include>
	
	<div class="container">
	
		<!-- <div class="row">
			<div class="col-md-offset-4 col-md-4">
				<button class="btn btn-primary">마이티켓</button>
			</div>
		</div> -->
		
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span> 마이티켓</h3>
				</div>
			</div>
		</div>
		
		<!-- 데이터 수 -->
		<div class="row">
			<div class="col-md-12">
				<h5>총 : ${resultPage.totalCount} 건</h5>
				<h5>현재 : ${resultPage.currentPage} 페이지 / 총 : ${resultPage.maxPage} 페이지</h5>
			</div>
		</div>
		
		<!-- 정렬 -->
		<div class="row">
			<div class="col-md-6 ">
				<form class="form form-inline" id="sortForm" name="sortForm">
					<input type="hidden" id="currentPageSort" name="currentPage" value=""/>
					<input type="hidden" name="arrange" 
								value="${!empty search.arrange ? search.arrange : ''}">
					<div class="form-group">
						<button class="btn btn-default" data-toggle="modal" 
									 data-target=".bs-example-modal-sm" type="button">필터</button>
					</div>
				</form>
			</div>
			<!-- 검색 -->
			<div class="col-md-6 text-right">
				<form class="form form-inline" id="searchForm" name="searchForm">
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					<input type="hidden" id="purchaseFlag" name="purchaseFlag" value="${purchaseFlag}"/>
					<input type="hidden" name="userId" value="${user.userId}">
					<div class="form-group">
						<select class="form-control" id="searchCondition" name="searchCondition" class="form-group">
							<option value="" selected>선택</option>
							<option value="5" ${!empty search.searchCondition and search.searchCondition == 5 ? "selected" : "" }>티켓명</option>
						</select>
					</div>
					<div class="form-group">
						<input class="form-control" id="searchKeyword" name="searchKeyword" type="text" 
									value="${!empty search.searchKeyword ? search.searchKeyword : ''}"
									placeholder="검색조건 선택">
					</div>
					<div class="form-group">
						<button class="btn btn-primary" type="button">검색</button>
					</div>
				</form>
			</div>
		</div>
		
		<!-- 축제 / 파티 버튼 -->
		<%-- <div class="row">
			<form id="searchForm">
				<input type="hidden" name="userId" value="${user.userId}">
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input type="hidden" id="searchCondition" name="searchCondition" value="${search.searchCondition}"/>
				<input type="hidden" id="purchaseFlag" name="purchaseFlag" value="${purchaseFlag}"/>
				<div class="col-md-12">
					<button class="btn btn-default btn-block" id="festivalBtn" type="button" value="1">축제티켓</button>
				</div>
				<div class="col-md-12">
					<button class="btn btn-default btn-block" id="partyBtn" type="button" value="2">파티티켓</button>
				</div>
			</form>
		</div> --%>
		
		<!-- 구매한 티켓 리스트 -->
		<div class="row">
		<c:if test="${empty list}">
			<jsp:include page="/view/purchase/noResult.jsp"></jsp:include>
		</c:if>
			<c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${i+1}"></c:set>
				<div class="col-md-6">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title pull-left">${i} 티켓</h3>
								<form id="deleteForm">
										<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}">
										<button class="btn btn-default pull-right" type="button" value="${purchase.purchaseNo}">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
										</button>
								</form>
        						<div class="clearfix"></div>
							</div>
							<div class="panel-body">
								<!-- 축제티켓 -->
								<c:if test="${!empty purchase.ticket.festival}">
									<img width="100%" height="300" src="${purchase.ticket.festival.festivalImage}">
									<hr>
									<div class="col-md-12">
										<strong>
											${purchase.ticket.festival.festivalName}
										</strong>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											 ${purchase.ticket.festival.startDate} ~ ${purchase.ticket.festival.endDate}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
										 	${purchase.ticket.festival.addr}
										 </small>
									</div>
								</c:if>
								<!-- 파티티켓 -->
								<c:if test="${!empty purchase.ticket.party}">
									<img width="100%" height="300" src="/resources/uploadFile/${purchase.ticket.party.partyImage}">
									<hr>
									<div class="col-md-12">
										<strong>
											${purchase.ticket.party.partyName}
										</strong>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											${purchase.ticket.party.partyDate}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											${purchase.ticket.party.partyTime}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
											${purchase.ticket.party.partyPlace}
										</small>
									</div>
								</c:if>
								<br>
								<div class="row">
									<div class="col-xs-4 col-md-6"><strong>결제번호</strong></div>
									<div class="col-xs-8 col-md-6">${purchase.paymentNo}</div>
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
									<c:if test="${purchase.tranCode == 1}">
										<button class="col-md-12 btn btn-default btn-block" type="button" value="${purchase.purchaseNo}">조회</button>
									</c:if>
									<%-- <form id="deleteForm">
										<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}">
										<button class="btn btn-default" type="button" value="${purchase.purchaseNo}">삭제</button>
									</form> --%>
								</div>
							</div>
						</div>
				</div>
			</c:forEach>
		</div>
		
		<!-- 내가 만든 페이지네비게이터 -->
		<jsp:include page="../../common/pageNavigator_new.jsp"/>
		<%-- <jsp:include page="../../common/pageNavigator.jsp"/> --%>
		
	</div>

	<%-- 게라겟겟마이티켓리스투
	<hr>
	<button id="festivalBtn" type="button" value="1">축제티켓</button>
	<button id="partyBtn" type="button" value="2">파티티켓</button>
	<hr>
	나으아이디 : ${user.userId} <br>
	나으닉네임 : ${user.nickname}
	<hr>
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${i+1}"></c:set>
		<h2>${i}</h2>
		<hr>
		${purchase.paymentNo}
		<hr>
		${purchase.itemName} 
		<hr>
		<c:if test="${!empty purchase.ticket.festival}">
			<img height="100" width="100" src="${purchase.ticket.festival.festivalImage}">
			<hr>
			${purchase.ticket.festival.startDate} ~ ${purchase.ticket.festival.endDate} 
			<hr>
			${purchase.ticket.festival.addr}
		</c:if>
		<c:if test="${!empty purchase.ticket.party}">
			<img height="100" width="100" src="${purchase.ticket.party.partyImage}">
			<hr>
			${purchase.ticket.party.partyDate}
			<hr>	
			${purchase.ticket.party.partyPlace}	
		</c:if>
		<hr>
		구매수량 : ${purchase.purchaseCount}장
		<hr>
		결제상태 : 
		<c:if test="${empty purchase.tranCode}">
			결제완료
		</c:if>
		<c:if test="${purchase.tranCode == 2}">
			결제취소
		</c:if>
		<hr>
		<button type="button" value="${purchase.purchaseNo}">조회</button>
		<button type="button" value="${purchase.purchaseNo}">삭제</button>
		<hr>
	</c:forEach>
	<hr> --%>
</body>
</html>