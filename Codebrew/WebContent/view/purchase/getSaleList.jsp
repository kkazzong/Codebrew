<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	
	<link rel="stylesheet" href="/resources/css/badge.css">
	
	<!-- 자바스크립트 -->
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
			//alert($("#sortForm").serialize());
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
				} else if($(this).val() == '5') {
					$("#searchKeyword").attr("placeholder", "티켓명 입력");
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
	
	<!-- CSS -->
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
	    
	    .table {
	    	margin-top: 70px;
	    }
	    
	    .table>thead>tr>th {
	    	text-align: center;
	    }
	    
	    .table>tbody>tr>td {
	    	font-size: 17px;
	    }
	    
	    .thead-dark th{color:#fff;background-color:#212529;border-color:#32383e}
	    /* div {
			border : 3px solid #D6CDB7;
			margin0top : 10px;
		} */
	
	</style>

</head>

<body>
	
	<!-- 툴바 -->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	<!-- 모달 -->
	<jsp:include page="/view/purchase/filterModal.jsp"></jsp:include>
	
	<%-- 서치컨디션 ${search.searchCondition } <br>
	어레인지 ${search.arrange } --%>
	
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
				<h5>총 : ${resultPage.totalCount} 건 (${resultPage.currentPage} / ${resultPage.maxPage})</h5>
			</div>
		</div>
		
		<!-- 검색결과 -->
		<div class="row">
			<div class="col-md-12">
				<c:if test="${!empty search.arrange}">
				<h5 class="text-muted">
					검색결과 :
					<c:choose>
						<c:when test="${search.arrange == 1}">
							판매금액 ▲
						</c:when>
						<c:when test="${search.arrange == 2}">
							판매금액▼
						</c:when>
						<c:when test="${search.arrange == 3}">
							판매수량▲
						</c:when>
						<c:when test="${search.arrange == 4}">
							판매수량▼
						</c:when>
						<c:when test="${search.arrange == 5}">
							아이디▲
						</c:when>
						<c:when test="${search.arrange == 6}">
							아이디▼
						</c:when>
					</c:choose>
				</h5>
				</c:if>
				<c:if test="${!empty search.searchCondition}">
				<h5 class="text-muted">
					검색어 :
					<c:choose>
						<c:when test="${search.searchCondition == 5}">
							'${search.searchKeyword}'
						</c:when>
					</c:choose>
				</h5>
				</c:if>
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
						<button class="btn btn-default btn-lg" data-toggle="modal" 
									 data-target=".bs-example-modal-sm" type="button">
							<span class="glyphicon glyphicon-filter" aria-hidden="true"></span>		 
						</button>
					</div>
				</form>
			</div>
			<!-- 검색 -->
			<div class="col-md-6 text-right">
				<form class="form form-inline" id="searchForm" name="searchForm">
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					 <div class="form-group">
						<select class="form-control input-lg" id="searchCondition" name="searchCondition" class="form-group">
							<option value="" selected>선택</option>
							<option value="3" ${!empty search.searchCondition and search.searchCondition == 3 ? "selected" : "" }>구매번호</option>
							<option value="4" ${!empty search.searchCondition and search.searchCondition == 4 ? "selected" : "" }>아이디</option>
							<option value="5" ${!empty search.searchCondition and search.searchCondition == 5 ? "selected" : "" }>티켓명</option>
						</select>
					</div>
					<div class="input-group">
						<input class="form-control  input-lg" id="searchKeyword" name="searchKeyword" type="text" 
									value="${!empty search.searchKeyword ? search.searchKeyword : ''}"
									placeholder="검색조건 선택">
						<span class="input-group-btn">
							<button id="search" class="btn btn-default btn-lg btn-block" type="button">
						    	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						    </button>
						</span>
					</div>
				</form>
			</div>
		</div>
		
		<!-- table -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped text-center">
					<thead class="thead-dark">
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
								<td scope="row">${i}</td>
								<td>${purchase.purchaseNo}</td>
								<td>${purchase.user.userId}</td>
								<td>
									<c:choose>
										<c:when test="${purchase.purchaseFlag == 1}">
											<span class="badge badge-pill badge-info"># 축제</span>
										</c:when>
										<c:when test="${purchase.purchaseFlag == 2}">
											<span class="badge badge-pill badge-warning"># 파티</span>
										</c:when>
									</c:choose>
								</td>
								<td>${purchase.itemName}</td>
								<td>${purchase.purchaseDate}</td>
								<td>${purchase.purchaseCount}장</td>
								<td><%-- ${purchase.purchasePrice} --%>${purchase.price}원</td>
								<td>
								<c:if test="${purchase.tranCode == 1}">
									결제완료
								</c:if>
								<c:if test="${purchase.tranCode == 2}">
									<span class="text-danger">결제취소</span>
								</c:if>
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
	
</body>
</html>