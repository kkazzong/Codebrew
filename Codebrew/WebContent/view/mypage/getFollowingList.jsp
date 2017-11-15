<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- <html> -->
<!-- <head> -->
	

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script type="text/javascript">
	
/* 	
	$(function() {
		
		//팔로우한 회원 프로필로 이동(회원프로필에서 userId입장에서 물고들어간다.)
		$(".followProfile").on("click", function() {
			var userId = $(this).text().trim();
			self.location = "/myPage/getYourPage?userId="+userId;
		});
	
	}); */
	
	
	
		 $(function() {
		
			
			var sessionId = $("#sessionId").val();
			var userId = $("#userId").val();
			
			console.log("sessionId는?????"+sessionId);
			console.log("userId는????"+userId);
		
			 if( sessionId == userId ) {
				 
				 
				 $(".btn:contains('Following')" ).each(function(){}).on("click" , function() {	
						var requestId = $(this).val();
						//alert(requestId);
						/* else  if( f4f == "Following" ) { *///내팔로워 목록에  맞팔이 되어있으니깐 삭제할수 있다.
							
						var flag = $(this).attr('class').trim();
						
						//alert(flag);
						
							$.ajax({
										type:'POST',
										url : '/myPageRest/json/deleteFollow',
										data : {requestId:requestId},
										dataType : "json",
										/* headers : {
											 "Accept" : "application/json",
											 "Content-Type" : "application/json"
										 }, */
									     context : this, 
										 success : function(JSONData, status) {
										
											 //$("#tag").removeClass(".btn.btn-info.btn-sm").addClass(".btn.btn-sm");
											 
											 //$(this).removeClass("btn btn-info btn-sm pull-right").addClass("btn btn-sm pull-right");
											//$('.btn.btn-info').removeClass('.btn.btn-info').addClass('.btn.btn-sm');
											 
											 	//$(this).reload();
											/* location.reload(); */ 
											// this.val('Follow');
											//$("#followingButton").val("Follow").css('background-color', 'buttonface').css('color', '#fff');
											 //location.reload();
											 
										  // $('#followingButton').removeClass("btn btn-info btn-sm pull-right").addClass("btn btn-sm pull-right");
												//location.reload(); 
										
												//moveFollowing();
												
												
											//alert("context는 뭘까??"+this);//[object HTMLButtonElement]
											
										   $(this).removeClass("btn btn-info btn-sm pull-right").addClass("btn btn-sm pull-right").text("Follow");
										 
										 
										 }
									})
							})
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
 <input type="hidden" value="${sessionScope.user.userId}" id="sessionId" name="sessionId">
  <input type="hidden" value="${user.userId}" id="userId" name="userId"> 
<jsp:include page="/toolbar/toolbar.jsp"/>
<div class="container">
    <div class="row profile">
    
<jsp:include page="/view/mypage/getMyPage.jsp"/>

			<div class="col-md-9">
	          	<div class="profile-content">
					<div class="row">
						<div>
							<c:set var="i" value="0" />
							<c:forEach var="follow" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<div class="profile-pic"
									style="width: 180px; float: left; height: 250px;">
									<br>
									<br>
									<br> 
									<img src="/resources/uploadFile/${follow.profileImage}" class="img-responsive" alt="" >
									<input type="hidden" class="follow" name="follow" value="${follow.requestId }">
										<span class="followProfile" title="클릭 이동">${follow.nickname}</span><br> 
									<c:choose>
										<c:when test="${ empty follow.nickname } ">
											<input type="button" class="btn btn-sm" id="follow"
												value="Follow">
											<input type="hidden" class="follow"
												value="${follow.requestId }">
										</c:when>
										<c:otherwise>
											<input type="button" class="btn btn-info btn-sm"
												id="following" value="Following">
											<input type="hidden" class="follow"
												value="${follow.requestId }">
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
</html> --%>







<!-- Modal -->
<%-- <jsp:include page="/toolbar/toolbar.jsp"/> --%>
<%-- <jsp:include page="/view/mypage/getMyPage.jsp"/> --%>
<div class="modal fade" id="following" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="following">팔로잉</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form class="form-horizontal-1" enctype="multipart/form-data">
		
	
	
  <input type="hidden" value="${sessionScope.user.userId}" id="sessionId" name="sessionId">
 <input type="hidden" value="${user.userId}" id="userId" name="userId">  

<!-- <div class="container">
    <div class="row profile">
       <div class="col-md-9">
	          	<div class="profile-content"> -->
	         
			
					<!-- 	<div> -->
						<c:set var="i" value="0" />
							<c:forEach var="follow" items="${list1}">
							
								<c:set var="i" value="${ i+1 }" />
								
							    <div class="row" id="userDiv">
								
								 <div class="col-xs-2" id="userImage">
									<img class="img-circle" src="/resources/uploadFile/${follow.profileImage}" width="30" height="30"></div>
									<input type="hidden" class="follow" name="follow" value="${follow.requestId }">
										<div class="col-xs-6" id="userNick" title="클릭 이동">${follow.nickname}</div>
									<div class="col-xs-4">
									<c:choose>
										<c:when test="${ empty follow.nickname } ">
											<%-- <input type="button" class="btn btn-sm pull-right" id="followButton"
												value="Follow">
											<input type="hidden" class="follow"
												value="${follow.requestId }"> --%>
								<button name="follow" type="button" class="btn btn-sm pull-right" value="${follow.requestId}">Follow</button>	
												
										</c:when>
										<c:otherwise>
											<%-- <input type="button" class="btn btn-info btn-sm pull-right"
												id="followingButton" value="Following">
											<input type="hidden" class="follow"
												value="${follow.requestId }"> --%>
												
								<button name="following" type="button" class="btn btn-info btn-sm pull-right" value="${follow.requestId}">Following</button>
										</c:otherwise>
									</c:choose>
								</div>
								
							
								
								<hr>
							</div>
							</c:forEach>
			              </form>
			               </div>
			          
	
	
		
			
			
				
			
	

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="window.location.reload()">닫기</button>
      </div>
    </div>
  </div>
</div>
