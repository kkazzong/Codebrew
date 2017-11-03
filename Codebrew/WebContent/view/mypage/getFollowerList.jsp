<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	
	
	
	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script type="text/javascript">

  
		 $(function() {
			 
			 var sessionId = $("#sessionId").val();
				var userId = $("#userId").val();
	
				console.log("sessionId????"+sessionId);
				console.log("userId????"+userId);
				
				
				 if( sessionId == userId ) { 
				$( ".btn.btn-sm" ).on("click" , function() {
					var requestId = $(this).next().val();
								
					f4f = $(this).val();
					
					
					if( f4f == "Follow" ) {
						
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
										
										 location.reload(); 
										  
									 }
								}		
							)
					} else  if( f4f == "Following" ) {
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
										
										location.reload(); 
										
									 }
								}		
							)
						}
					});
				 }
			});	
		 
	
	
	</script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	 body {
		padding-top : 70px;
    }
	
	
	
		.profile-pic img {
		  float: none;
		  margin: 0 auto;
		  width:110px;
		  height:120px;
		  -webkit-border-radius: 50% !important;
		  -moz-border-radius: 50% !important;
		  border-radius: 50% !important;
		}
		.profile-content{
			text-align:center;
		}
	</style>
	
	
 </head>
<body>
<jsp:include page="/toolbar/toolbar.jsp"/>

<input type="hidden" id="sessionId" value="${sessionScope.user.userId}">
 <input type="hidden" id="userId" value="${user.userId}"> 
	<div class="container">
		<div class="row profile">
			<%-- <jsp:include page="/view/mypage/getMyPage.jsp" /> --%>
				<div class="col-md-9">
				<div class="profile-content">
					<div class="row">
						<div>
						<c:set var="i" value="0" />
							<c:forEach var="follow" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<div class="profile-pic"
									style="width: 180px; float: left; height: 250px;">
									<br> <br> <br> 
									<img src="/resources/uploadFile/${follow.profileImage}" class="img-responsive" alt=""> 
										<input type="hidden" class="follow" value="${follow.responseId }">
										<span>${follow.nickname } </span><br> 
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
											<input type="hidden" class="follow"
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