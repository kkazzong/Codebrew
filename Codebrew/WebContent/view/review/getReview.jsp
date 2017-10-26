<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	 
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
	</style>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncAddReply() {
		//Form 유효성 검증
		var replyDetail = $("input[name='replyDetail']").val();
		
		if(replyDetail == null || replyDetail.length < 1){
			alert("댓글내용을 입력한 후에 등록할 수 있습니다.")
			return;
		}
		$("form").attr("method", "POST").attr("action", "/reply/addReply").submit();
	}
	
	
	//Event 걸어주기
	$(function() {
		 $( "#getReviewList" ).on("click" , function() {
			 self.location = "/review/getReviewList"
		});
		
		 $( "#getCheckReviewList" ).on("click" , function() {
			self.location = "/review/getCheckReviewList?role='a'"
		});
		
		 $( "#updateReview" ).on("click" , function() {
			self.location = "/review/updateReview?reviewNo=${review.reviewNo}"
		});
		 
		$( "#passCheckCode" ).on("click" , function() {
			alert("review.checkCode :: "+"${review.checkCode}");
			self.location = "/review/passCheckCode?reviewNo=${review.reviewNo }";				
		});
		 
		 $( "#failCheckCode" ).on("click" , function() {
			self.location = "/review/addPurchaseView?prodNo=${product.prodNo}";
		});
		 
		$( "#addReply" ).on("click" , function() {
			fncAddReply();
		});
		 
		 /* var reviewNo = document.getElementById('reviewNo').getAttribute('value');
		 console.log(reviewNo); */
	 
	});
	
</script>

</head>

<body>

	<jsp:include page="../../toolbar/toolbar.jsp" />
	
	<input type="hidden" name="reviewNo" value="${review.reviewNo }">
   	
   	<!-- 후기상세조회 화면구성 div Start -->
   	<div class="container">

		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
		   		<div class="page-header text-center">
		   			<h3 class="text-info">후기상세조회</h3>
		   			<h5 class="text-muted">후기 정보를 <strong class="text-danger">내놓으시길</strong>바랍니다.</h5>
		   		</div>
			</div>
		</div>
		
		<div class="row">
			<!-- <div class="col-md-offset-3 col-md-6"> -->
			<div class="col-md-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">${review.reviewTitle } 후기제목</h3>
					</div>
					<div class="panel-body">
						<%-- 
						이렇게 하면 1번째 이미지 들어간다
						<img width="100%" height="300" src="/resources/uploadFile/${review.reviewImageList[0].reviewImage }"> 
						 --%>
						<!-- Carousel ex Start -->
						
						<c:if test="${!empty review.reviewImageList }">
						<div id="myCarousel" class="carousel slide" data-ride="carousel">
						<!-- Indicators -->
							<ol class="carousel-indicators">
							<c:set var="i" value="0"/>
								<li data-target="#myCarousel" data-slide-to="${0 }" class="active"></li>
				  			<c:forEach begin="1" var="imageListforIndex" items="${review.reviewImageList}">
								<li data-target="#myCarousel" data-slide-to="${i }"></li>
							</c:forEach>
							</ol>
							<!-- Wrapper for slides -->
							<div class="carousel-inner" role="listbox">
							<c:set var="i" value="0"/>
								<div class="item active">
									<img src="/resources/uploadFile/${review.reviewImageList[0].reviewImage }">
								</div>
							<c:forEach var="imageList" begin="1" items="${review.reviewImageList }">
								<div class="item">
									<img src="/resources/uploadFile/${imageList.reviewImage }">
								</div>
							</c:forEach>
							</div>
							
							<!-- Left and right controls -->
							<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
						</c:if>
						<!-- 
						<c:if test="${!empty review.reviewImageList }">
							<c:forEach var="imageList" items="${review.reviewImageList }">
							<c:set var="i" value="${i+1 }"/>
							<img width="100%" height="300" src="/resources/uploadFile/${imageList.reviewImage}">					
							</c:forEach>
						</c:if>
						 -->
						<!-- Carousel End -->
						<hr>
						<div class="col-md-12">
							<strong>
								축제명 : ${review.festivalName }
							</strong>
						</div>
						<c:if test="${sessionScope.user.userId == review.userId || sessionScope.user.role == 'a'}">
						<div class="col-md-12">
							<small>
								후기상태 : 
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
								<c:if test="${review.checkCode == '1' || review.checkCode == '11' }">
									심사중									
								</c:if>
								<c:if test="${review.checkCode == '2' || review.checkCode == '22' }">
									통과
								</c:if>
								<c:if test="${review.checkCode == '4' || review.checkCode == '44' }">
									반려									
								</c:if>
							</small>
						</div>
						</c:if>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									작성일시 : ${review.reviewRegDate }
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									작성자 : ${review.userId }
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									축제위치 : ${review.addr }
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									축제평점 : ${review.reviewFestivalRating }
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									좋아요 : ${review.goodCount }
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									후기내용 : ${review.reviewDetail }
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									해시태그 : ${review.reviewHashtag }
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
									동영상
							</small>
							<c:if test="${!empty review.reviewVideoList[0].reviewVideo }">
								<c:set var="i" value="0"/>
					  			<c:forEach var="listV" items="${review.reviewVideoList}">
						   				<!-- 
						   				<video width="320" height="240" controls>
						   				 -->
						   				<video controls >
						   					<source src="/resources/uploadFile/${listV.reviewVideo}" type="video/mp4"></video>
					   			</c:forEach>
				   			</c:if>
				   			<c:if test="${empty review.reviewVideoList[0].reviewVideo }">
				   				동영상 없다~
				   			</c:if>
						</div>
						<hr>
						<div class="col-md-12">
							<small>
								<!-- button class 구분 ==>> 회원 : primary, Admin : default -->
								<!-- admin이 아니면서(일반회원 혹은 비회원이면서) 해당 후기 작성자와 조회한 사람이 동일인일 때, -->
						   		<c:if test="${sessionScoepe.user.role != 'a' && sessionScope.user.userId == review.userId}">
						   			<center>
						   				<button id = "updateReview" type="button" class="btn btn-primary">수정하기</button>
						   				<button id = "getReviewList" type="button" class="btn pull-center btn-primary">목록보기</button>
						   			</center>
								</c:if>
								<!-- admin이 아니면서(일반회원 혹은 비회원이면서) 해당 후기 작성자와 조회한 사람이 동일하지 않을 때 ==>> 가장 많은 경우 -->
						   		<c:if test="${sessionScope.user.role != 'a' && sessionScope.user.userId != review.userId}">
						   			<center>
							   			<button id = "getReviewList" type="button" class="btn pull-center btn-primary">목록보기</button>
						   			</center>
						   		</c:if>
						   		
						   		<!-- admin인 경우 & checkCode에 따라서 분류 -->
						   		<!-- admin이면서  해당 후기가 등록요청중인 후기 일 때 -->
						   		<c:if test="${sessionScope.user.role == 'a' && (review.checkCode == '1' || review.checkCode == '11')}">
						   			<center>
							   			<button id="passCheckCode" type="button" class="btn pull-center btn-default">
							   				통과(등록)
							   			</button>
							   			<button id="failCheckCode" type="button" class="btn pull-center btn-default">
							   				반려(미등록)
							   			</button>
							   		</center>
						   		</c:if>
						   		<!-- admin이면서  해당 후기가 반려된 후기 혹은 통과된 후기(나머지 심사상태인 후기인 경우) 일 때-->
						   		<c:if test="${sessionScope.user.role =='a' }">
						   			<center>
						   				<button id = "updateReview" type="button" class="btn btn-default">수정하기</button>
							   			<button id = "getCheckReviewList" type="button" class="btn pull-center btn-fault">심사목록보기</button>
							   			<button id = "getReviewList" type="button" class="btn pull-center btn-fault">목록보기</button>
						   			</center>
						   		</c:if>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<!-- ToolBar Start /////////////////////////////////////-->
								<jsp:include page="getReplyList.jsp" >
									<jsp:param name="reviewNo" value="${review.reviewNo }"/>
								</jsp:include>
							   	<!-- ToolBar End /////////////////////////////////////-->
							</small>
						</div>
					</div>
				</div>
			</div>
		</div>
   		
   	</div>
   	<!-- 화면구성 div End -->

</body>
</html>