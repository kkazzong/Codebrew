<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	 
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 70px;
            background-color : #f2f4f6;
        }
        
        .card {
        	margin-top : 50px;
        }
	</style>
	
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	 
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- card css -->
	<link rel="stylesheet" href="/resources/css/card.css">
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	<!--  // 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScript 이용 --> 
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
	   	$("form[name='detailForm']").attr("method" , "POST").attr("action" , "/review/getCheckReviewList").submit();
	}
	
	//=====> "검색", reviewTitle link Event 연결 및 처리
	$(function(){
		
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2. $(#id) : 3.$(.className)
		//==> 1과 3 방법 조합 : $("tagName.className:filter함수") 사용함.
		$("#searchReviewList").on("click", function(){
			if($("#searchKeyword").val() == ''){
				event.preventDefault();
				alert("검색어를 입력해주세요");
				return;
			}
			event.preventDefault();
			fncGetList(1);
			//alert("검색버튼 클릭 : val = "+$("#searchKeyword").val());
		});
		
		//enter key 검색 : 뒤의 on부터
		$("#searchKeyword").on("keydown", function(event){
			if(event.keyCode == '13'){
				alert("검색버튼 클릭 : val = "+$("#searchKeyword").val());
				if($("#searchKeyword").val() == ''){
					event.preventDefault();
					alert("검색어를 입력해주세요");
					return;
				}
				event.preventDefault();
				fncGetList(1);
			}
		});
		
		
		//==> reviewTitle LINK : Click Event 연결처리
		//조회
		$(".card > a").on("click", function(){
			console.log($(this).find("input:hidden[name='reviewNo']").val());
			var reviewNo = $(this).find("input:hidden[name='reviewNo']").val();
		 	self.location = "/review/getReview?reviewNo="+reviewNo;
		});
		
		$( "button:contains('조회')" ).on("click" , function() {
			//alert("조회버튼 클릭 : val = "+$(this).val());
			self.location="/review/getReview?reviewNo="+$(this).val();
		});
		 
		$( ".btn-success" ).each(function(){}).on("click" , function() {
			//alert("통과 버튼!!!!"+$(this).val());
			self.location = "/review/passCheckCodeFromCheckReviewList?reviewNo="+$(this).val();				
		});
			 
		$( ".btn-danger" ).each(function(){}).on("click" , function() {
			//alert("반려 버튼!!!"+$(this).val());
			self.location = "/review/failCheckCodeFromCheckReviewList?reviewNo="+$(this).val();
		});
		 
		//==> UI 수정 추가부분  :  reviewTitle LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		$("h7").css("color" , "red");
		$( ".ct_list_pop td:nth-child(7)" ).css("color" , "blue");
		
		//==> 아래와 같이 정의한 이유는 ??
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
	});
	
	</script>




<title>Insert title here</title>
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!-- 화면구성 div Start -->
   	<div class="container">
   	
   		<div class="row">
   			<div class="col-md-offset-4 col-md-4">
   				<div class="page-header text-center">
   					<h3 class="text-info"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> 후기심사목록</h3>
   				</div>
   			</div>
   		</div>

   		<!-- 검색 Start -->
   		<div class="row">
   		
   			<div class="col-md-6 text-left">
   				<p class="text-primary">
   					총 : ${resultPage.totalCount} 건<br>
					현재 : ${resultPage.currentPage} 페이지 / 총 : ${resultPage.maxPage} 페이지
   				</p>
   			</div>
   			
   			<div class="col-md-6 text-right">
   			
   				<form class="form-inline" name="detailForm">
   					<div class="form-group">
   					<label class="sr-only" for="searchCondition"></label>
   						<select class="form-control" name="searchCondition">
   							<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>축제이름</option>
   							<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>축제장소</option>
   							<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>해시태그</option>
   						</select>
   					</div>
   					
   					<div class="form-group">
   						<label class="sr-only" for="searchKeyword">검색어</label>
   						<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" 
   						value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
   					</div>
   					
   					<button id = "searchReviewList" type="button" class="btn btn-default">검색</button>
   					
   					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
   					<input type="hidden" id="currentPage" name="currentPage" value=""/>
   				</form>
   				
   			</div>
   		</div>
   		<!-- 검색 End -->
   		
   		
   		<!-- table Start -->
   		<div class="row">
   			<c:forEach var="review" items="${list}">
   				<c:set var="i" value="${i+1}"/>
   				<div class="col-md-6">
   					<div class="card">
   						<a href="#">
   							<input type="hidden" name="reviewNo" value="${review.reviewNo }">
   							<c:if test="${!empty review.reviewImageList }">
   								<img width="100%" height="423" src="/resources/uploadFile/${review.reviewImageList[0].reviewImage}">
   							</c:if>
   						</a>
					
						<form name="checkForm">
						<input type="hidden" name="reviewNo" value="${review.reviewNo}"> <!-- post........ -->
							<c:if test = "${sessionScope.user.role == 'a' }">
							<button id = "fail" class="btn btn-danger pull-right" type="button" value="${review.reviewNo }">
								<span class="glyphicon glyphicon-remove-circle" aria-hidden="true" style="color:whitesmoke"></span>
							</button>
							<button id = "pass" class="btn btn-success pull-right" type="button" value="${review.reviewNo }">
								<span class="glyphicon glyphicon-ok-circle" aria-hidden="true" style="color:whitesmoke"></span>
							</button>
							</c:if>
						</form>
						
   						<div class="card-body">
   							<div class="col-md-12">
   								<strong>
   									${review.festivalName }
   								</strong>
   							</div>
   							<div class="col-md-12">
   								<small>
   									<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
   									${review.reviewTitle }
   								</small>
   							</div>
   							<div class="col-md-12">
   								<small>
   									<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
   									${review.addr }
   								</small>
   							</div>
   							<div class="col-md-12">
   								<small>
   									<span class="glyphicon glyphicon-tags" aria-hidden="true"></span>
   									${review.reviewHashtag }
   								</small>
   							</div>
   							<hr>
   						</div>
   						
   					</div>
   				</div>
   			</c:forEach>
   		</div>
   		
   	</div>
   	<!-- 화면구성 div End -->
   	
	<!-- PageNavigation Start... -->
	<jsp:include page="../../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->


</body>
</html>