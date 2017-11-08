<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- <html>
<head> -->
	
	
	
	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!--   <link rel="stylesheet" href="/resources/demos/style.css"> -->
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script type="text/javascript">

  /*   $(function() {
		
		//팔로우한 회원 프로필로 이동(회원프로필에서 userId입장에서 물고들어간다.)
		$(".followProfile").on("click", function() {
			var userId = $(this).text().trim();
			self.location = "/myPage/getYourPage?userId="+userId;
		});
	
	}); */
	
	
	
	
	
		 $(function() {
			 
			 var sessionId = $("#sessionId").val();
				var userId = $("#userId").val();
	
				console.log("sessionId????"+sessionId);
				console.log("userId????"+userId);
				
				
				 if( sessionId == userId ) { /* 그래서 세리일때만 나옴  */
					 /*내 화면 모달창에서 add delete 하고 싶을때  */
				$( ".btn.btn-sm" ).on("click" , function() {//맞팔이 안되어있는 버튼
					var requestId = $("#follower").val();
								
					 f4f = $(this).val();
					
					
					if( f4f == "Follow" ) {//내 팔로워 목록에 맞팔이 안되있으니깐 추가하는거고
						
						$.ajax(
								{
									url : '/myPageRest/json/addFollow/'+requestId,
									method : "GET",
									dataType : "json",
									headers : {
										 "Accept" : "application/json",
										 "Content-Type" : "application/json"
									 },
									 context : this,
									 success : function(JSONData, status) {
										
										/*  location.reload(); */ 
										this.val('Following');
										location.reload();
										  
									 }
								}		
							)
					} else  if( f4f == "Following" ) {//내팔로워 목록에  맞팔이 되어있으니깐 삭제할수 있다.
						$.ajax(
								{
									url : '/myPageRest/json/deleteFollow/'+requestId,
									method : "GET",
									dataType : "json",
									headers : {
										 "Accept" : "application/json",
										 "Content-Type" : "application/json"
									 },
									 context : this,
									 success : function(JSONData, status) {
										
										/* location.reload(); */ 
										 this.val('Follow');
										 location.reload();
									 }
								}		
							)
						}
					});
				 }
			});	
		 
	
	
	</script>
	
	
	<style>
	 body {
		padding-top : 70px;
    }	
		
	.profile-content{
		text-align:center;
		}
		
		
		
	</style>
	
	
 <%-- </head>
<body>
<jsp:include page="/toolbar/toolbar.jsp"/>

<input type="hidden" id="sessionId" value="${sessionScope.user.userId}">
 <input type="hidden" id="userId" value="${user.userId}"> 
	<div class="container">
		<div class="row profile">
			 <jsp:include page="/view/mypage/getMyPage.jsp" /> <!--프로필 정보에서 세션아디와 유저아디를 물고와야 하니깐  -->
				<div class="col-md-9">
				<div class="profile-content">
					<div class="row">
						<div>
						<c:set var="i" value="0" />
							<c:forEach var="follow" items="${list6}">
								<c:set var="i" value="${ i+1 }" />
								<div class="profile-pic"
									style="width: 180px; float: left; height: 250px;">
									<br> <br> <br> 
									<img src="/resources/uploadFile/${follow.profileImage}" class="img-responsive" alt=""> 
										<input type="hidden" class="follow" value="${follow.responseId }">
										<span class="followProfile" title="클릭 이동">${follow.nickname}</span><br>
									<c:choose>
										<c:when test="${follow.f4f == 1}">
											<input type="button" class="btn btn-info btn-sm"
												id="following" value="Following">
											<input type="hidden" class="follow"
												value="${follow.responseId }">
										</c:when>
										<c:otherwise>
											<input type="button" class="btn btn-sm" id="follow"
												value="Follow">
											<input type="hidden" id="follower" class="follow"
												value="${follow.responseId }">
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

 --%>





<%-- 
<jsp:include page="/toolbar/toolbar.jsp"/> --%>
<%-- <jsp:include page="/mypage/getMyPage.jsp"/> --%>
<!-- Modal -->
 <input type="hidden" value="${sessionScope.user.userId}" id="sessionId" name="sessionId">
 <input type="hidden" value="${user.userId}" id="userId" name="userId">
<div class="modal fade" id="follower" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="follower">팔로워</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     <form class="form-horizontal-1" enctype="multipart/form-data"> 
		
		
		
	
  
  
		<%-- <div class="container">
		<div class="row profile">
			 <jsp:include page="/view/mypage/getMyPage.jsp" /> <!--프로필 정보에서 세션아디와 유저아디를 물고와야 하니깐  -->
			<div class="col-md-5">
				<div class="profile-content">
					<div class="row">
						<div> --%>
			  <!-- <div class="profile-content">  -->
				    <div class='row'>
				   
						<c:set var="i" value="0" />
							<c:forEach var="follow" items="${list1}">
							
							
								<c:set var="i" value="${ i+1 }" />
							    
								<!--  <div class="profile-pic"
									style="width: 10px; float: left; height: 15px;">  -->
									
									<!-- style="float:margin-left; margin:20px width=500px;"> -->
									
									<div class="col-xs-6 col-md-4" ><img class="img-circle" src="/resources/uploadFile/${follow.profileImage}" width="40" height="40"></div>
									<!--  class="img-responsive" alt=""  -->
									<input type="hidden" class="follow" value="${follow.responseId }">
									 <div class="col-xs-6 col-md-4"  title="클릭 이동">${follow.nickname}</div>
									 <div class="col-xs-6 col-md-4">
									 <c:choose>
										<c:when test="${follow.f4f == 1}">
											<input type="button" class="btn btn-info btn-sm pull-right"
												id="following" value="Following">
											<input type="hidden" class="follow"
												value="${follow.responseId }">
										</c:when>
										<c:otherwise>
											<input type="button" class="btn btn-sm pull-right" id="follow"
												value="Follow">
											<input type="hidden" id="follower" class="follow"
												value="${follow.responseId }">
										</c:otherwise>
									</c:choose>
							      </div>
							    <br>
							   <br>
							   <br>
							 </c:forEach>
						
						</div>
					
				
			
		
		  
		
	
		
		
		
			
			
			
		 </form> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>