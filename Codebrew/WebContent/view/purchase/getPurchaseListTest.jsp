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

<!-- Include Required Prerequisites -->
<script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<!-- Include Date Range Picker -->
<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />

<!-- sweet alert -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.2/sweetalert2.all.min.js"></script>
<!-- Include a polyfill for ES6 Promises (optional) for IE11 and Android browser -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>

<script type="text/javascript">
	
	function fncGetList(currentPage) {
		console.log("페이지클릭 : "+currentPage);
		var startDate = $("#startDate").val();
		if(startDate != null && startDate != '') {
			//alert("데이트서치");
			$("#currentPageDate").val(currentPage);
			$("#dateSearchForm").attr("method", "POST").attr("action", "/purchase/getPurchaseList").submit();
		} else {
			$("#currentPage").val(currentPage);
			//alert("서치키워드 + "+$("#searchKeyword").val());
			if($("#searchKeyword").val() != null && $("#searchKeyword").val() != '') {
				$("input:hidden[name='searchCondition']").val(5);
			}
			//alert($("#searchForm").serialize());
			$("#searchForm").attr("method", "POST").attr("action", "/purchase/getPurchaseList").submit();
		}
	}
	
	function fncSearchDate() {
		$("#currentPageDate").val("1");
		$("#dateSearchForm").attr("method", "POST").attr("action", "/purchase/getPurchaseList").submit();
	}
	
	function fncSortList(arrange) {
		////alert(arrange);
		//$("#currentPageSort").val("1");
		//$("input:hidden[name='arrange']").val(arrange);
		////alert($("#sortForm").serialize());
		//$("#sortForm").attr("method", "POST").attr("action", "/purchase/getPurchaseList").submit();
		$("#searchKeyword").val('');
		if(arrange == 1 || arrange == 2) {
			//alert("축제파티티켓 정렬");
			$("input:hidden[name='searchCondition']").val(arrange);
			//alert($("#searchCondition").val());
			fncGetList(1);
		}
	}
	
	
	$(function(){
		
		var userId = $("input:hidden[name='userId']").val();
		
		//page header 클릭(판매목록)
		$(".page-header").on("click", function(){
			self.location = "/purchase/getPurchaseList?userId="+userId;
		})
		
		
		
		//enter key 검색
		$("#searchKeyword").on("click", function(){
			$("#startDate").val('');
			$("#endDate").val('');
		}).on("keydown", function(event){
			
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
		/* $(".btn:contains('검색')").on("click", function(){
			
			if($("#searchKeyword").val() == '') {
				//alert("검색어를 입력해주세요");
				return;
			}
			fncGetList(1);
			
		}); */
		
		//검색버튼
		$("#search").on("click", function(){
			
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
		
		
		//조회(판넬 클릭시)
		$(".panel-heading").on("click", function(){
			console.log($(this).find("input:hidden[name='purchaseNo']").val());
			var purchaseNo = $(this).find("input:hidden[name='purchaseNo']").val()
			self.location = "/purchase/getPurchase?purchaseNo="+purchaseNo;
		})
		
		/* $(".btn:contains('마이티켓')").on("click", function(){
			console.log("마이티켓 클릭");
			self.location = "/purchase/getPurchaseList?userId="+userId;
		}); */
		
		$("#deleteForm>.pull-right").each(function(){}).on("click", function(event){
			
			console.log($(this).val());
			var purchaseNo = $(this).val();
			
			
			swal({
				  
				title: '삭제하시겠습니까?',
				  text: "You won't be able to revert this!",
				  type: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '확인',
				  cancelButtonText: '취소',
				  confirmButtonClass: 'btn btn-success',
				  cancelButtonClass: 'btn btn-danger',
				  buttonsStyling: false,
				  preConfirm : function(){
					  return new Promise(function(resolve, reject) {
						  
						  $.ajax({
								
								url : "/purchaseRest/json/deletePurchase/"+purchaseNo,
								mehtod : "POST",
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								dataType : "json",
								
						}).done(function(JSONData){
							if(JSONData.message != null) {
								resolve();
							} else {
								reject('Error!');
							}
						})
						  
					 });
					  
				  }
			
			}).then(function () {
				 
				 swal({
					    type: 'success',
					    title: '구매내역이 삭제되었습니다',
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
			
			event.preventDefault();
			
			//if(confirm("정말로 삭제하시겠습니까?")) {
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
				//$(this).parents("#deleteForm").attr("method", "post").attr("action", "/purchase/deletePurchase").submit();
			//} else {
				//return;
			//}
			
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
		          url: "/purchaseRest/json/getPurchaseList/${user.userId}/''",
		          method : "POST",
		          headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
				  },
		          dataType: "json",
		          data: JSON.stringify({
		        	currentPage : "1",
			        searchKeyword : $("#searchKeyword").val(),
			        searchCondition : "5",
		          }),
		          success: function( JSONData ) {
		        		  
		        	console.log("server data =>"+JSON.stringify(JSONData));
		        	var searchCondition = $("#searchCondition2").val();
		            response($.map(JSONData, function(value, key){
		            	console.log(value.itemName);
		            	console.log("key(autocomplete : value)====>"+key);
		            	
		            		return {
		            			label :  value.itemName,
		            			value : value.itemName
		            		}
		        	}));
		          }
		        } );
		    }
		});
		
		//판넬 높이 조절
		var maxHeight = -1;

		$('.panel').each(function() {
			maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
		});

		$('.panel').each(function() {
			 $(this).height(maxHeight);
		});		
		
		//날짜 검색 버튼 
		$("#dateRange").on("click", function() {
			//alert($("#dailySelect").val());
			if($("#startDate").val() == '' || $("#startDate").val() == null) {
				alert("조회 기간을 선택해주세요");
				return;
			}
			fncSearchDate();
		})
		
		//datepicker 설정
		$.datepicker.setDefaults({
	        dateFormat: 'yy-mm-dd',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        yearSuffix: '년',
	        changeMonth: true,
			changeYear : true,
			buttonImageOnly: true,
		    yearRange : "1990:2017"
    	});
		
		//datepicker로 선택시, searchkeyword는 지워지고 ~~
		$("#startDate, #endDate").each(function(){}).datepicker().on('change', function(){
			$(this).val($(this).datepicker().val());
		}).on("click", function(){
			$("#searchKeyword").val('');
		});
		
		//modal에서 클릭한 버튼
		$(".modal-content .btn").each(function(){}).on("click", function(){
			if($("#startDate").val() != '' && $("#endDate").val() == '') {
				alert('조회날짜를 선택해주세요');
				return;
			}
			fncSortList($(this).val());
		});
		
		
		/// sweet alert
		// ES6 Modules or TypeScript
		//import swal from 'sweetalert2';
		
		// CommonJS
		//const swal = require('sweetalert2');
		
		$("#partyButtonDiv").on("click", function(){
			swal({
				  title: 'Error!',
				  text: 'Do you want to continue',
				  type: 'error',
				  confirmButtonText: 'Cool'
				})
		});	
		
		$("input:hidden[name='tranCode']").each(function(){
			if($(this).val() == 2) {
				console.log("결제취소된거")
				//console.log($(this).find("div>.purchaseInfo").html());
				//$("div>.purchaseInfo").css("text-decoration","line-through");
			}
		});
		
	});
</script>
<style type="text/css">
	body {
		padding-top : 70px;
		background-color: #f2f4f6;
    }
    .panel {
		margin-top : 50px;
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
    .panel {
    	box-shadow : 9px 7px 10px rgba(154, 143, 143, 0.98);
    }
    .section {
    	margin-top : 400px;
    }
    /* div {
		border : 3px solid #D6CDB7;
		margin0top : 10px;
	} */
	/* .panel-heading h3 {
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    line-height: normal;
	    width: 75%;
	    padding-top: 8px;
	} */
</style>
</head>
<body>
	
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	<!-- 모달 -->
	<jsp:include page="/view/purchase/filterModalUser.jsp"></jsp:include>
	<%-- 서치컨디션 ${search.searchCondition } --%>
	<div class="container">
	
		<!-- <div class="row">
			<div class="col-md-offset-4 col-md-4">
				<button class="btn btn-primary">마이티켓</button>
			</div>
		</div> -->
		
		<!-- page header -->
		<div class="row">
			<div class="col-md-12">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-list" aria-hidden="true"></span>&nbsp;&nbsp;my티켓</h3>
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
				<c:if test="${!empty search.searchCondition}">
				<h5 class="text-muted">
					검색결과 :
					<c:if test="${search.searchCondition == 1}">
						축제티켓
					</c:if>
					<c:if test="${search.searchCondition == 2}">
						파티티켓
					</c:if>
					<c:if test="${search.searchCondition == 6}">
						${search.startDate} ~ ${search.endDate }
					</c:if>
				</c:if>
				</h5>
			</div>
		</div>
		
		
		<!-- 정렬 -->
		<div class="search">
		<div class="row">
			<div class="col-md-2">
				<form class="form form-inline" id="sortForm" name="sortForm">
					<input type="hidden" id="currentPageSort" name="currentPage" value=""/>
					<input type="hidden" name="arrange" 
								value="${!empty search.arrange ? search.arrange : ''}">
					<div class="form-group">
						<button id="filter" class="btn btn-default btn-lg" data-toggle="modal" 
									 data-target=".bs-example-modal-sm" type="button">
						<span class="glyphicon glyphicon-filter" aria-hidden="true"></span>
						</button>
					</div>
				</form>
			</div>
			<!-- 기간 -->
			<%-- <div class="col-md-6">
				<form class="form form-inline" id="dateSearchForm" name="dateSearchForm">
					<div class="form-group">
						<input type="hidden" id="currentPageDate" name="currentPage" value=""/>
						<input type="hidden" id="searchCondition" name="searchCondition" value="6">
						<input class="col-md-3 form-control form-inline input-lg" type="text" id="startDate" name="startDate" value="${!empty search.startDate ? search.startDate : ''}" placeholder="조회 기간 선택">
						<input class="col-md-3 form-control form-inline input-lg" type="text" id="endDate" name="endDate" value="${!empty search.endDate ? search.endDate : ''}" placeholder="조회 기간 선택">
						<span class="input-group-btn">	
							<button id="dateRange" class="btn btn-default btn-lg btn-block" type="button">
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
							</button>
						</span>
					</div>
				</form>
			</div> --%>
			<!-- 검색 -->
			<div class="col-md-10 text-right">
				<form class="form form-inline" id="searchForm" name="searchForm">
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					<input type="hidden" id="purchaseFlag" name="purchaseFlag" value="${purchaseFlag}"/>
					<input type="hidden" name="userId" value="${user.userId}">
					<input type="hidden" id="searchCondition2" name="searchCondition" value="${!empty search.searchCondition ? search.searchCondition : ''}">
					<div class="input-group">
						<input class="form-control input-lg" id="searchKeyword" name="searchKeyword" type="text" 
									value="${!empty search.searchKeyword ? search.searchKeyword : ''}"
									placeholder="축제 or 파티 이름으로 검색">
						<span class="input-group-btn">
					    	<button id="search" class="btn btn-default btn-lg btn-block" type="button">
					    		<span class="glyphicon glyphicon-search" aria-hidden="true"> 
					    	</button>
					    </span>
					</div>
				</form>
			</div>
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
		<section>
		<div class="row">
		<c:if test="${empty list}">
			<jsp:include page="/view/purchase/noResult.jsp"></jsp:include>
		</c:if>
			<c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${i+1}"></c:set>
				<div class="col-md-6">
						<div class="panel panel-primary">
							<div class="panel-heading">
							<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}">
							 <c:if test="${!empty purchase.ticket.festival}">
								 	<c:if test="${purchase.ticket.festival.festivalImage.contains('http://')}">
										<img width="100%" height="523" src="${purchase.ticket.festival.festivalImage}">
									</c:if>
									<c:if test="${!purchase.ticket.festival.festivalImage.contains('http://')}">
										<img width="100%" height="523" src="/resources/uploadFile/${purchase.ticket.festival.festivalImage}">
									</c:if>
							</c:if>
							<c:if test="${!empty purchase.ticket.party}">
								<img width="100%" height="523" src="/resources/uploadFile/${purchase.ticket.party.partyImage}">
							</c:if>
							</div>
							<div class="panel-body">
								<!-- 삭제버튼 -->
								<form id="deleteForm">
										<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}">
										<button class="btn btn-default pull-right" id="deleteBtn" type="button" value="${purchase.purchaseNo}">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
										</button>
								</form>
								<!-- 축제티켓 -->
								 <c:if test="${!empty purchase.ticket.festival}">
								 	<%-- <div class="col-md-12">
								 	<c:if test="${purchase.ticket.festival.festivalImage.contains('http://')}">
										<img width="100%" height="523" src="${purchase.ticket.festival.festivalImage}">
									</c:if>
									<c:if test="${!purchase.ticket.festival.festivalImage.contains('http://')}">
										<img width="100%" height="523" src="/resources/uploadFile/${purchase.ticket.festival.festivalImage}">
									</c:if>
									</div> --%>
									<div class="col-md-12">
											<h3><strong>${purchase.ticket.festival.festivalName}</strong></h3>
									</div>
									<%-- <div class="col-md-12">
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											 ${purchase.ticket.festival.startDate} ~ ${purchase.ticket.festival.endDate}
									</div> --%>
									<div class="col-md-12">
										<h4>
											<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
										 	${purchase.ticket.festival.addr}<br>
										 </h4>
									</div>
								</c:if>
								<!-- 파티티켓 -->
								<c:if test="${!empty purchase.ticket.party}">
									<div class="col-md-12">
										<%-- <img width="100%" height="523" src="/resources/uploadFile/${purchase.ticket.party.partyImage}"> --%>
									</div>
									<div class="col-md-12">
											<h3><strong>${purchase.ticket.party.partyName}</strong></h3>
									</div>
									<%-- <div class="col-md-12">
											<h4>
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											${purchase.ticket.party.partyDate}
											</h4>
									</div>
									<div class="col-md-12">
											<h4>
											<span class="glyphicon glyphicon-time" aria-hidden="true"></span>
											${purchase.ticket.party.partyTime}
											</h4>
									</div> --%>
									<div class="col-md-12">
											<h4>
											<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
											${purchase.ticket.party.partyPlace}
											</h4>
									</div>
								</c:if>
								<!-- 결제정보 -->
								<input type="hidden" name="tranCode" value="${purchase.tranCode}">
								<div class="purchaseInfo">
									<div class="col-md-12">
										<h4>
											결제번호 : 
											${purchase.paymentNo}
										</h4>
									</div>
									<div class="col-md-12">
										<h4>
											결제일시 : 
											${purchase.purchaseDate}
										</h4>
									</div>
									<div class="col-md-12">
										<h4>
											구매수량 : 
											${purchase.purchaseCount} 장
										</h4>
									</div>
									<div class="col-md-12">
										<h4>
											결제금액 : 
											${purchase.purchasePrice} 원
										</h4>
									</div>
									<div class="col-md-12">
										<h4>
											결제상태 : 
										<c:if test="${purchase.tranCode == 1}">
											결제완료
										</c:if>
										<c:if test="${purchase.tranCode == 2}">
											결제취소
										</c:if>
										</h4>
									</div>
										<c:if test="${purchase.tranCode == 1}">
											<%-- <button class="col-md-12 btn btn-default btn-block" type="button" value="${purchase.purchaseNo}">조회</button> --%>
										</c:if>
										<%-- <form id="deleteForm">
											<input type="hidden" name="purchaseNo" value="${purchase.purchaseNo}">
											<button class="btn btn-default" type="button" value="${purchase.purchaseNo}">삭제</button>
										</form> --%>
									<div class="col-md-12">	
										<c:if test="${purchase.purchaseFlag == 1 }">
											# 축제
										</c:if>
										<c:if test="${purchase.purchaseFlag == 2 }">
											# 파티
										</c:if>
									</div>
								</div>
								</div>
								
								
								
								
							</div>
						</div>
						
			</c:forEach>
		</div>
		</section>
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