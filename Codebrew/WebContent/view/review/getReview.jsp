<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!-- CDN 사용으로 필요없을듯한데...
	<link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
	</style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//Event 걸어주기
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
		 $( "button.btn.btn-primary:contains('목록보기')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('확인')" ).html() );
			 self.location = "/review/getReviewList?menu=manage"
		});
		
		 $( "button.btn.btn-primary:contains('심사목록보기')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('심사목록보기')" ).html() );
				self.location = "/review/getCheckReviewList?reviewNo=${review.reviewNo}"
		});
		
		 $( "button.btn.btn-primary:contains('수정')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
			self.location = "/review/updateReview?reviewNo=${review.reviewNo}"
		});
		 
		 $( "button.btn.btn-primary:contains('통과(등록)')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('통과(등록)')" ).html() );
				self.location = "/review/addPurchaseView?prodNo=${product.prodNo}";
		});
		 
		 $( "button.btn.btn-primary:contains('반려(미등록)')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('반려(미등록)')" ).html() );
				self.location = "/review/addPurchaseView?prodNo=${product.prodNo}";
		});
		 
		 $( "button.btn.btn-primary:contains('이전')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('이전')" ).html() );
			history.go(-1);
		});
		 
	});
	
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../../toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!-- 후기상세조회 화면구성 div Start -->
   	<div class="container">
   	
   		<div class="page-header">
   			<h3 class="text-info">단일후기 상세조회</h3>
   			<h5 class="text-muted">후기 정보를 <strong class="text-danger">항상 최신정보로 관리</strong>바랍니다.</h5>
   		</div>
   		
   		<c:if test="${user.role == 'a' }"> <!-- only!! admin이거나 본인이 작성한 후기 상세조회인경우만 보인다 -->
	   		<div class="row">
	   			<div class="col-xs-4 col-md-2"><strong>후기상태</strong></div>
	   			<c:if test="${review.checkCode == '1' || review.checkCode == '11'}">
		   			<div class="col-xs-8 col-md-4">심사중</div>	   			
	   			</c:if>
	   			<c:if test="${review.checkCode == '2' || review.checkCode == '22' }">
	   				<div class="col-xs-8 col-md-4">통과</div>	 
	   			</c:if>
	   			<c:if test="${review.checkCode == '4' || review.checkCode == '44' }">
	   				<div class="col-xs-8 col-md-4">반려</div>	 
	   			</c:if>
	   		</div>   		
   		</c:if>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>작성일시</strong></div>
   			<div class="col-xs-8 col-md-4">${review.reviewRegDate }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>후기제목</strong></div>
   			<div class="col-xs-8 col-md-4">${review.reviewTitle }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>작성자</strong></div>
   			<div class="col-xs-8 col-md-4">${review.user.userId }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>축제명</strong></div>
   			<div class="col-xs-8 col-md-4">${review.festival.festivalName }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>축제위치</strong></div>
   			<div class="col-xs-8 col-md-4">${review.festival.Addr }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>축제평점</strong></div>
   			<div class="col-xs-8 col-md-4">${review.reviewFestivalRating }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>좋아요</strong></div>
   			<div class="col-xs-8 col-md-4">${review.goodCount }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2" style="height:300px;text-align:left;line-height:300px;"><strong>사진</strong></div>
   			<div class="col-xs-8 col-md-4"><img src="/images/uploadFiles/${review.reviewImage }" width="300"></div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>후기내용</strong></div>
   			<div class="col-xs-8 col-md-4">${review.reviewDetail }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>동영상</strong></div>
   			<div class="col-xs-8 col-md-4">${review.reviewVideo }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row">
   			<div class="col-xs-4 col-md-2"><strong>해시태그</strong></div>
   			<div class="col-xs-8 col-md-4">${review.hashtag }</div>
   		</div>
   		
   		<hr/>
   		
   		<div class="row"> <!-- 관리자, 해당유저, 일반유저(비회원 포함) : 3가지 경우 -->
	   		<c:if test="${sessionScope.user.userId == review.user.userId}">
	   			<center>
	   				<button type="button" class="btn btn-primary">수정하기</button>
	   				<button type="button" class="btn pull-center btn-primary">이전</button>
	   			</center>
	   		</c:if>
	   		<c:if test="${sessionScope.user.role == 'a'}">
	   			<center>
	   				<button type="button" class="btn btn-primary">수정하기</button>
		   			<button type="button" class="btn pull-center btn-primary">통과(등록)</button>
		   			<button type="button" class="btn pull-center btn-primary">반려(미등록)</button>
	   				<button type="button" class="btn pull-center btn-primary">이전</button>
	   				<button type="button" class="btn pull-center btn-primary">심사목록보기</button>
		   		</center>
	   		</c:if>
	   		<c:if test="${sessionScope.user.userId != review.user.userId}">
	   			<center>
		   			<button type="button" class="btn pull-center btn-primary">이전</button>
	   			</center>
			</c:if>
			<c:if test="${sessionScope.user.role != review.user.role}">
	   			<center>
		   			<button type="button" class="btn pull-center btn-primary">이전</button>
	   			</center>
			</c:if>
   	   	</div>
   	   	
   	</div>
   	<!-- 화면구성 div End -->

</body>
</html>