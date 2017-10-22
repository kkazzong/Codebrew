<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>getSaleList</title>

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
		var arrange = $("input:hidden[name='arrange']").val();
		//alert(arrange);
		if(arrange != '' && arrange != null) {
			//alert("정렬");
			$("#currentPageSort").val(currentPage);
			$("#sortForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
		} else {
			//alert("검색");
			$("#currentPage").val(currentPage);
			$("#searchForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
		}
	}
	
	function fncSearchList() {
		$("#currentPage").val("1");
		$("#searchForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
	}
	
	function fncSortList(arrange) {
		//alert(arrange);
		$("#currentPageSort").val("1");
		$("input:hidden[name='arrange']").val(arrange);
		alert($("#sortForm").serialize());
		$("#sortForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
	}
	
	$(function(){
		
		//page header 클릭(판매목록)
		$(".page-header").on("click", function(){
			self.location = "/purchase/getSaleList";
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
		
		//정렬 모달창에서 클릭한 모든 버튼
		$(".modal-content .btn").each(function(){}).on("click", function(){
			fncSortList($(this).val());
		});
		
		//검색조건 바꿀때
		$("#searchCondition").on("change", function(){
			
			if($(this).val() == '3') {
				$("#searchKeyword").attr("placeholder", "구매번호 입력");
			} else if($(this).val() == '4') {
				$("#searchKeyword").attr("placeholder", "회원아이디 입력");
			} else if($(this).val() == ''){
				$("#searchKeyword").attr("placeholder", "검색조건 선택");
			}
			
		});
		
		//autocomplete
		$("#searchKeyword").autocomplete({
			source: function( request, response ) {
		        $.ajax( {
		          url: "/purchaseRest/json/getSaleList",
		          method : "POST",
		          headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
				  },
		          dataType: "json",
		          data: JSON.stringify({
		        	currentPage : "1",
		            searchKeyword : $("#searchKeyword").val(),
		            searchCondition : $("#searchCondition").val()
		          }),
		          success: function( JSONData ) {
		        		  
		        	console.log("server data =>"+JSON.stringify(JSONData));
		        	var searchCondition = $("#searchCondition").val();
		            response($.map(JSONData, function(value, key){
		            	console.log(value.user.userId);
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
    /* div {
		border : 3px solid #D6CDB7;
		margin0top : 10px;
	} */
</style>
</head>
<body>
	
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	<!-- 모달 -->
	<jsp:include page="/view/purchase/filterModal.jsp"></jsp:include>
	
	서치컨디션 ${search.searchCondition } <br>
	어레인지 ${search.arrange }
	
	<div class="container">
	
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> 판매목록</h3>
				</div>
			</div>
		</div>
		
		<!-- 데이터 수 -->
		<div class="row">
			<div class="col-md-12">
				<h5>총 : ${resultPage.totalCount} 건</h5>
				<h5>현재 : ${resultPage.currentPage} 페이지 / 총 ${resultPage.maxPage} 페이지</h5>
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
					<div class="form-group">
						<select class="form-control" id="searchCondition" name="searchCondition" class="form-group">
							<option value="" selected>선택</option>
							<option value="3" ${!empty search.searchCondition and search.searchCondition == 3 ? "selected" : "" }>구매번호</option>
							<option value="4" ${!empty search.searchCondition and search.searchCondition == 4 ? "selected" : "" }>아이디</option>
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
		
		<!-- table -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>NO</th>
							<th>구매번호</th>
							<th>아이디</th>
							<th>분류</th>
							<th>티켓명</th>
							<th>구매날짜</th>
							<th>수량</th>
							<th>결제금액</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="purchase" items="${list}">
							<c:set var="i" value="${i+1}"></c:set>
							<tr>
								<td>${i}</td>
								<td>${purchase.purchaseNo}</td>
								<td>${purchase.user.userId}</td>
								<td>
									<c:choose>
										<c:when test="${empty purchase.ticket.ticketFlag}">
											기본
										</c:when>
										<c:when test="${purchase.ticket.ticketFlag == 'free'}">
											무료
										</c:when>
										<c:when test="${purchase.ticket.ticketFlag == 'nolimit'}">
											무제한
										</c:when>
									</c:choose>
								</td>
								<td>${purchase.itemName}</td>
								<td>${purchase.purchaseDate}</td>
								<td>${purchase.purchaseCount}</td>
								<td>${purchase.purchasePrice}</td>
								<td>
								<c:if test="${purchase.tranCode == 1}">결제완료</c:if>
								<c:if test="${purchase.tranCode == 2}">결제취소</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 내가 만든 페이지네비게이터 -->
		<jsp:include page="../../common/pageNavigator_new.jsp"/>
		<%-- <jsp:include page="../../common/pageNavigator.jsp"/> --%>
		
	</div>
	
	<%-- <form name="orderForm">
		<select>
			<option value="" selected="selected">필터</option>
			<optgroup label="가격">
				<option value="1">가격▲</option>
				<option value="2">가격▼</option>
			</optgroup>
			<optgroup label="아이디">
				<option value="3">아이디▲</option>
				<option value="4">아이디▼</option>
			</optgroup>
			<optgroup label="구매날짜">
				<option value="5">구매날짜▲</option>
				<option value="6">구매날짜▼</option>
			</optgroup>
		</select>
	</form>
	
	<form name="searchForm">
		<select>
			<option value="1" selected="selected">구매번호</option>
			<option value="2">아이디</option>
		</select>
		<input name="searchKeyword" type="text">
		<button type="button">검색</button>
	</form>
	
	<table>
		<thead>
			<tr>
				<th>NO</th>
				<th>구매번호</th>
				<th>아이디</th>
				<th>티켓명</th>
				<th>구매날짜</th>
				<th>수량</th>
				<th>결제금액</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${i+1}"></c:set>
				<tr>
					<td>${i}</td>
					<td>${purchase.purchaseNo}</td>
					<td>${purchase.user.userId}</td>
					<td>${purchase.itemName}</td>
					<td>${purchase.purchaseDate}</td>
					<td>${purchase.purchaseCount}</td>
					<td>${purchase.purchasePrice}</td>
					<td>
					<c:if test="${empty purchase.tranCode}">결제완료</c:if>
					<c:if test="${purchase.tranCode == 2}">결제취소</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table> --%>
	
</body>
</html>