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
	
 	
	/* $(function() {
		
		//팔로우한 회원 프로필로 이동(회원프로필에서 requestId입장에서 물고들어간다.)
		 $(".userNick").each(function(){}).on("click", function() {
			
			var requestId=$(this).text.trim();
			var requestId = $(this).val();
			alert(requestId);
			self.location = "/myPage/getMyPage?requestId="+requestId;
		});
		
		});  */
	
 $(function() {
			 
			 var sessionId = $("#sessionId").val();
			 var userId = $("#userId").val();
	          
	         
				console.log("sessionId????"+sessionId);
				console.log("userId????"+userId);
				
				
				if( sessionId == userId ) { //내 마이페이지에서만 팔로우 목록을 추가 삭제할 수 있다.
					 /*내 화면 모달창에서 add delete 하고 싶을때  */
					//$("#tag" ).on("click" , function() {//맞팔이 안되어있는 follow를 클릭했을때
					$(".following" ).each(function(){}).on("click" , function() {
						
						var grasp=$(this).attr('class').trim();
						
						console.log("지금 잡고 있는거"+grasp)
						
		                var flag=$(this).text().trim();
		                
						console.log("flag-->"+flag)
		                
		                var jsonFollow;
		                
		                var requestId=$(this).val();
		                
		                console.log("requestId-->"+requestId);
		                
		                
		                if(flag == "Follow"){
		                   jsonFollow="addFollow";
		                	
		                  }else{
		                	jsonFollow="deleteFollow";  
		                  
		                  }
		               
		                $.ajax({
		                	type : 'POST',
		                	url : '/myPageRest/json/'+jsonFollow,
		                	data : {requestId:requestId},
		                	dataType : 'json',
		                	context : this,
		                	success : function(JSONData, status){
		                	
		                		console.log("context는 뭘까??"+this);
		                		console.log(status);
		                		console.log(JSONData);
		                		
		                		if(flag == "Follow"){
		                			
		                			$(this).removeClass("btn btn-sm pull-right following").addClass("btn btn-info btn-sm pull-right following").text("Following");
		                		  
		                		}else{
		                			  
		                			$(this).removeClass("btn btn-info btn-sm pull-right following").addClass("btn btn-sm pull-right following").text("Follow");
		  		                	
		                		  }
		                		}//success
		                		
		                		
		                	})//ajax
		                	})//on click
		                	
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
        <h5 class="modal-title" id="following">팔로잉(내가 팔로잉한 회원목록)</h5>
         <h7 class="modal-title" id="following">닉네임 클릭이동하여 친구를 추가할 수 있습니다.</h7>
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
								
								 <div class="col-xs-2 userImage" id="userImage">
									<img class="img-circle" src="/resources/uploadFile/${follow.profileImage}" width="30" height="30"></div>
									<input type="hidden" class="follow" name="follow" value="${follow.requestId }">
										<div class="col-xs-6 userNick"   title="클릭 이동" >
										<%-- ${follow.nickname} --%>
		                                <a href="/myPage/getMyPage?requestId=${follow.requestId}">${follow.nickname}</a>
										</div>
									<div class="col-xs-4">
									<c:choose>
										<c:when test="${ empty follow.nickname } ">
											<%-- <input type="button" class="btn btn-sm pull-right" id="followButton"
												value="Follow">
											<input type="hidden" class="follow"
												value="${follow.requestId }"> --%>
							<%-- 	<c:if test="${follow.requestId == sessionScope.user.userId }">							
								<button name="follow" id="addFollow" type="button"  disabled="disabled" class="btn btn-sm pull-right" value="${follow.requestId}">Follow</button>	
								</c:if> --%>
								
								<%-- <c:if test="${follow.requestId != sessionScope.user.userId }"> --%>
								<button name="follow" id="followButton" type="button" class="btn btn-sm pull-right following" value="${follow.requestId}">Follow</button>	
							<%-- 	</c:if> --%>
												
										</c:when>
										<c:otherwise>
											<%-- <input type="button" class="btn btn-info btn-sm pull-right"
												id="followingButton" value="Following">
											<input type="hidden" class="follow"
												value="${follow.requestId }"> --%>
								<%-- <c:if test="${follow.requestId == sessionScope.user.userId}">				
								<button name="following" id="deleteFollowing" type="button" disabled="disabled" class="btn btn-info btn-sm pull-right" value="${follow.requestId}">Following</button>
								</c:if>	 --%>	
								
								<%-- <c:if test="${follow.requestId != sessionScope.user.userId }"> --%>
								<button name="following" id="followButton" type="button" class="btn btn-info btn-sm pull-right following" value="${follow.requestId}">Following</button>
							     <%-- </c:if>  --%>
								
										
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
