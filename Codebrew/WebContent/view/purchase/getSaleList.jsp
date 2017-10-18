<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>

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

<script type="text/javascript">

	function fncGetList(currentPage) {
		console.log("페이지클릭 : "+currentPage);
		$("#currentPage").val(currentPage);
		$("#searchForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
	}
	
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
	
	<div class="container">
	
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> 판매목록</h3>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-offset-1 col-md-2 ">
				<!-- 정렬 -->
				<form class="form form-inline" id="orderForm" name="orderForm">
					<select class="form-group">
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
			</div>
			<div class="col-md-offset-4 col-md-5 ">
				<!-- 검색 -->
				<form class="form form-inline" id="searchForm" name="searchForm">
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					<select class="form-group">
						<option value="1" selected="selected">구매번호</option>
						<option value="2">아이디</option>
					</select>
					<input class="form-group" name="searchKeyword" type="text">
					<button class="btn btn-default" type="button">검색</button>
				</form>
			</div>
		</div>
		
		<!-- 데이터 수 -->
		<div class="row">
			<div class="col-md-offset-1 col-md-10">
				<h5>총 : ${resultPage.totalCount} 건</h5>
				<h5>현재 : ${resultPage.currentPage} 페이지</h5>
			</div>
		</div>
		<!-- table -->
		<div class="row">
			<div class="col-md-offset-1 col-md-10">
				<table class="table table-striped">
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