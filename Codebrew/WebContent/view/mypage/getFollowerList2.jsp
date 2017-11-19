<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- <html>
<head> -->
	
	
	
	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	
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
				
					
					
				
					
				$(".follower" ).each(function(){}).on("click" , function() {
					var requestId = $(this).next().val();//each(function(){})반복문마다 요소를 선택해서
					console.log(requestId);			
					 var f4f = $(this).val();
					 console.log("맞팔"+f4f)
					var flag = $(this).attr('class').trim();
					/* if(sessionId == requestId){
					    alert("니 아디야.")	
					    event.preventDefault();
					  
					}else{ */
					console.log(flag);
					
					if( f4f == "Follow" ) {//내 팔로워 목록에 맞팔이 안되있으니깐 추가하는거고
					
						 
						 
						 
					 
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
										
										 console.log(status);
										 //alert(JSON.stringify(JSONData));
										/*  location.reload(); */ 
									   //$("#followButton").text("Following").css('background-color', '#3897f0').css('color', '#fff');
										//location.reload();
										//alert("context는 머다??"+this);//[object HTMLButtonElement]
									  // $(this).removeClass('.btn.btn-sm').addClass('.btn.btn-info'); 
										//alert(status);
									  
									  //$('#followButton').onClick
										//moveFollow();
										//$(this).reload();
										//$("#tag").removeClass(".btn btn-sm").addClass(".btn btn-info btn-sm");
										
										
										console.log(this);
										$(this).removeClass("btn btn-sm pull-right follower").addClass("btn btn-info btn-sm pull-right follower").text("Following");
									
									 }
									 
								})//ajax
					}
						})
					}
								
					    //}//if	
					    
					/* });  */
					
					
			/* 	$(".deleteFollower" ).each(function(){}).on("click" , function() {	
					var requestId = $(this).val();
					console.log(requestId);
					/* else  if( f4f == "Following" ) { *///내팔로워 목록에  맞팔이 되어있으니깐 삭제할수 있다.
						
					//var flag = $(this).attr('class').trim();
					
					//console.log(flag); */
				/* 	if(sessionId == requestId){
					   alert("니 아디야.")	
					   event.preventDefault();
					
					}else{ */
					else{
						
						
						$(".follower" ).each(function(){}).on("click" , function() {
							var requestId = $(this).next().val();//each(function(){})반복문마다 요소를 선택해서
							console.log(requestId);			
							 var f4f = $(this).val();
							 console.log("맞팔"+f4f)
							var flag = $(this).attr('class').trim();
							/* if(sessionId == requestId){
							    alert("니 아디야.")	
							    event.preventDefault();
							  
							}else{ */
							console.log(flag);
						
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
										 
									  $(this).removeClass("btn btn-info btn-sm pull-right follower").addClass("btn btn-sm pull-right follower").text("Follow");
										
									
											//moveFollowing();
									 }//success
								})//ajax
							});
					//}//if
						//})
				}
			
					
					
					
		 
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

<div class="modal fade" id="follower" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="follower">팔로워(나를 팔로잉한 회원목록)</h5>
         <h7 class="modal-title" id="following">닉네임 클릭이동하여 친구를 추가할 수 있습니다.</h7>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     <form class="form-horizontal-1" enctype="multipart/form-data"> 
		
		
		
	
   <input type="hidden" value="${sessionScope.user.userId}" id="sessionId" name="sessionId">
  <input type="hidden" value="${user.userId}" id="userId" name="userId">
  
		<%-- <div class="container">
		<div class="row profile">
			 <jsp:include page="/view/mypage/getMyPage.jsp" /> <!--프로필 정보에서 세션아디와 유저아디를 물고와야 하니깐  -->
			<div class="col-md-5">
				<div class="profile-content">
					<div class="row">
						<div> --%>
			  <!-- <div class="profile-content"> -->
				    <!-- <div class='row' id="userDiv"> -->
				   
						<c:set var="i" value="0" />
							<c:forEach var="follow" items="${list2}">
								<c:set var="i" value="${ i+1 }" />
								
				              <div class="row" id="userDiv"><!--반복문안에 div row를 넣어야 그리드대로 정렬됨 -->
								
									<div class="col-xs-2" id="userImage" >
									<img class="img-circle" src="/resources/uploadFile/${follow.profileImage}" width="30" height="30"></div>
								
									<input type="hidden" class="follow" value="${follow.responseId }">
									 <div class="col-xs-6" id="userNick" title="클릭 이동">
									 <a href="/myPage/getMyPage?requestId=${follow.responseId}">${follow.nickname}</a>
									</div>
									 <div class="col-xs-4 f4f">
									 <%-- <c:choose>
										<c:when test="${follow.f4f == 1}"> --%>
										
										<c:if test="${follow.f4f == 1 }">
										
										
											<%-- <input type="button" class="btn btn-info btn-sm pull-right" id="tag"
												value="Following" aria-hidden="true">
f											<input type="hidden"
												value="${follow.responseId }"> --%>
									<c:if test="${follow.responseId == sessionScope.user.userId }">	
										<button name="following" id="f4f" type="button" disabled="disabled" class="btn btn-info btn-sm pull-right" value="${follow.responseId}">Following</button>
										</c:if> 
									<c:if test="${follow.responseId != sessionScope.user.userId }"> 
										<button name="following" id="f4f" type="button" class="btn btn-info btn-sm pull-right follower" value="Following">Following</button>
										<input type="hidden"  class="tag" value="${follow.responseId}">
									</c:if> 
										
										</c:if>
									<%-- 	</c:when> --%>
										
										
										<%-- <c:otherwise> --%>
										
										  <c:if test="${follow.f4f == 0 }">
										   
											<%-- <input type="button" class="btn btn-sm pull-right follow" id="tag"
												value="Follow" aria-hidden="true">
											<input type="hidden" name="follower" id="follower" 
												value="${follow.responseId }"> --%>
										 	<c:if test="${follow.responseId == sessionScope.user.userId }">	<!--내 아이디가 이사람 responseId로 있으면 -->
											<button name="follow" id="f4f" type="button" disabled="disabled" class="btn btn-sm pull-right" value="${follow.responseId}">Follow</button>
										    </c:if> 
										 
										 <c:if test="${follow.responseId != sessionScope.user.userId }">
										<button name="follow" id="f4f" type="button" class="btn btn-sm pull-right follower" value="Follow">Follow</button>
										<input type="hidden"  class="tag" value="${follow.responseId}">
										</c:if> 
										
										</c:if>
										
									<%-- 	</c:otherwise>
									</c:choose> --%>
									
							      </div>
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