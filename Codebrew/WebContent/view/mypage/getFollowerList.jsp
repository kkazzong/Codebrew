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
				//$("#tag" ).on("click" , function() {//맞팔이 안되어있는 follow를 클릭했을때
				$(".btn:contains('Follow')" ).each(function(){}).on("click" , function() {
					var requestId = $(this).val();//each(function(){})반복문마다 요소를 선택해서
					//alert(requestId);			
					 //f4f = $(this).val();
					var flag = $(this).attr('class').trim();
					
					//alert(flag);
					
					//if( f4f == "Follow" ) {//내 팔로워 목록에 맞팔이 안되있으니깐 추가하는거고
					 // if(${follow.f4f == 1})
						$.ajax({
									type:'POST',
									url : '/myPageRest/json/addFollow',
									data : {requestId:requestId},
									dataType : "json",
								/* 	headers : {
										 "Accept" : "application/json",
										 "Content-Type" : "application/json"
									 }, */
									 context : this, 
									 success : function(JSONData, status) {
										
										 //alert(JSON.stringify(JSONData));
										/*  location.reload(); */ 
									   //$("#followButton").text("Following").css('background-color', '#3897f0').css('color', '#fff');
										//location.reload();
										//alert("context는 머다??"+this);//[object HTMLButtonElement]
									  // $(this).removeClass('.btn.btn-sm').addClass('.btn.btn-info'); 
										
									  
									  //$('#followButton').onClick
										//moveFollow();
										//$(this).reload();
										//$("#tag").removeClass(".btn btn-sm").addClass(".btn btn-info btn-sm");
										
										$(this).removeClass("btn btn-sm pull-right").addClass("btn btn-info btn-sm pull-right").text("Following");
									 }
								})
					}); 
					
					
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
										 //alert("context는 뭘까??"+this);//[object HTMLButtonElement]
										 //$(this).removeClass("btn btn-info btn-sm pull-right").addClass("btn btn-sm pull-right");
										//$(this).removeClass('.btn.btn-info').addClass('.btn.btn-sm');
										 
										 	//$(this).reload();
										/* location.reload(); */ 
										// this.val('Follow');
										//$("#followingButton").val("Follow").css('background-color', 'buttonface').css('color', '#fff');
										 //location.reload();
										 
									  $(this).removeClass("btn btn-info btn-sm pull-right").addClass("btn btn-sm pull-right").text("Follow");
											//location.reload(); 
									
											//moveFollowing();
									 }
								})
						})
				 }
			});	
		 
	
	/* function moveFollow(){
	
	var follow=$("#followButton").val();	
		
	 $("#followingButton").val(follow)	
	 	
	};
	
	function moveFollowing(){
		
	var following=$("#followingButton").val();
	
	$("#followButton").val(following)
		
	};
	 */
	
	
	
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
			  <!-- <div class="profile-content"> -->
				    <div class='row'>
				   
						<c:set var="i" value="0" />
							<c:forEach var="follow" items="${list2}">
							
							
								<c:set var="i" value="${ i+1 }" />
				
									
									<div class="col-xs-6 col-md-4" ><img class="img-circle" src="/resources/uploadFile/${follow.profileImage}" width="40" height="40"></div>
								
									<input type="hidden" class="follow" value="${follow.responseId }">
									 <div class="col-xs-6 col-md-4"  title="클릭 이동">${follow.nickname}</div>
									 <div class="col-xs-6 col-md-4">
									 <c:choose>
										<c:when test="${follow.f4f == 1}">
											<%-- <input type="button" class="btn btn-info btn-sm pull-right" id="tag"
												value="Following" aria-hidden="true">
											<input type="hidden"
												value="${follow.responseId }"> --%>
												
										<button name="following" type="button" class="btn btn-info btn-sm pull-right" value="${follow.responseId}">Following</button>
										</c:when>
										
										
										<c:otherwise>
											<%-- <input type="button" class="btn btn-sm pull-right follow" id="tag"
												value="Follow" aria-hidden="true">
											<input type="hidden" name="follower" id="follower" 
												value="${follow.responseId }"> --%>
											<button name="follow" type="button" class="btn btn-sm pull-right" value="${follow.responseId}">Follow</button>
										</c:otherwise>
										
										
									</c:choose>
							      </div>
							    <br>
							   <br>
							   <br>
							 </c:forEach>
						
						</div>
				<!-- 	</div> -->
				
			
		
		  
		
	
		
		
		
			
			
			
		 </form> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="window.location.reload()">닫기</button>
      </div>
    </div>
  </div>
</div>