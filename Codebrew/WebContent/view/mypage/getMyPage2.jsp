<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<script src="https://use.fontawesome.com/04438b50a5.js"></script>
	
	 <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	  
	
	
	<script type="text/javascript">
	
	  $(function() {
		 
			$("#profileFollow").on("click" , function() {
				var requestId = $("#userId").val();
			
			 console.log("requestId는????"+requestId);
			 
				
				$.ajax({
					    type:'POST',
						url : '/myPageRest/json/addFollow',
						data: {requestId:requestId},
						dataType : "json",
					 /* headers : {
							 "Accept" : "application/json",
							 "Content-Type" : "application/json"
						 }, */
						 /* async:false; */
						 /* context : this, */
						 success : function(JSONData, status) {
							/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); */
							/* location.reload(); */
							//console.log(this);
							//console.log(JSON.stringify(JSONData));
							//$(this).val('following');
							//alert(status);
							//alert(JSON.stringify(JSONData));
							 //location.reload();
							/* 팔로잉 됐다고 버튼이  바뀜 follow(팔로잉 안한거)--> following(팔로잉된거) */
							//$("#profileFollow").text("Following").css('background-color', '#3897f0').css('color', '#fff');
							
							$("#profileFollow").removeClass("btn btn-sm").addClass("btn btn-info btn-sm").text("Following");
							
							//$(this).val("Following");
							
							
							
							location.reload();
						     //window.location.reload(true);
						     //$('#reload').load("/myPage/getMyPage?requestId=${sessionScope.user.userId}");
							// window.location.reload(true);
							//$('#content').html(JSON.stringify(JSONData));
						 } 
					})
			  });
			
	 });	
	 
	 
	 
	 $(function() {
		 
			$("#profileFollowing").on("click" , function() {
				var requestId = $("#userId").val();
			
			 console.log("requestId는????"+requestId);
			 
				
				$.ajax({
						/* url : '/myPageRest/json/deleteFollow/'+requestId,
						method : "GET",
						dataType : "json",
						headers : {
							 "Accept" : "application/json;charset=UTF-8",
							 "Content-Type" : "application/json"
						 },
						 context : this, */
						 type:'POST',
						 url : '/myPageRest/json/deleteFollow',
						 data: {requestId:requestId},
						 dataType : "json",
						 
						 success : function(JSONData, status) {
							/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); */
							/* location.reload(); */
							//$(this).val('follow');
							alert(JSON.stringify(JSONData));
							
							//$("#profileFollowing").text("Follow").css('background-color', '#3897f0').css('color', '#fff');
							$("#profileFollowing").removeClass("btn btn-info btn-sm").addClass("btn btn-sm").text("Follow");
							 
							 //$(this).val("Follow");
							 location.reload();
						  }
					})
			  });
	
	 });	 
	  
	/*  $(function() {
		 
		 var requestId = $("#userId").val();
	
			 
	
		 
			$( "#profileFollow" ).on("click" , function() {
				
				self.location="/myPage/addFollow?requestId="+requestId;
			});   		
			
 
			$( "#profileFollowing" ).on("click" , function() {
				
				self.location="/myPage/deleteFollow?requestId="+requestId;
			});  	 */
		/* 	
			$( "#getFollowerList" ).on("click" , function() {
				self.location="/myPage/getFollowerList?requestId="+requestId;
			});
		 */
		 
			/* $( "#follower" ).on("click" , function() {
				self.location="/myPage/getFollowerList?requestId="+requestId;
			});*/
			
	//	});   
	

	 
	</script>
	<style>
	
	 body {
		padding-top : 70px;
    }
	
	
		/* 	html, body {
			width: 100%;
			height:100%;
		} */

		
		.profile {
		  margin: 20px 0;
		}
		
		
		
		.profile-sidebar {
		  padding: 20px 0 10px 0;
		  background: #F1F3FA;
		  border-radius : 4px;
		 
		}
		
		.profile-usertitle {
		  text-align: center;
		  margin-top: 50px;
		}
		.profile-usertitle-name {
		  color: #5a7391;
		  font-size: 20px;
		  font-weight: 600;
		  margin-bottom: 50px;
		}
		.profile-usertitle-job {
		  text-transform: uppercase;
		  color: #5b9bd1;
		  font-size: 20px;
		  font-weight: 600;
		  margin-bottom: 20px;
		}
		.profile-userbuttons {
		  text-align: center;
		  margin-top: 10px;
		}
		.profile-userbuttons .btn {
		  text-transform: uppercase;
		  font-size: 11px;
		  font-weight: 600;
		  padding: 6px 15px;
		  margin-right: 5px;
		}
		.profile-userbuttons .btn:last-child {
		  margin-right: 0px;
		}
		.profile-usermenu {
		  margin-top: 30px;
		}
		.profile-usermenu ul li {
		  border-bottom: 1px solid #f0f4f7;
		}
		.profile-usermenu ul li:last-child {
		  border-bottom: none;
		}
		.profile-usermenu ul li a {
		  color: #93a3b5;
		  font-size: 14px;
		  font-weight: 400;
		}
		.profile-usermenu ul li a i {
		  margin-right: 8px;
		  font-size: 14px;
		}
		.profile-usermenu ul li a:hover {
		  background-color: #fafcfd;
		  color: #5b9bd1;
		}
		.profile-usermenu ul li.active {
		  border-bottom: none;
		}
		.profile-usermenu ul li.active a {
		  color: #5b9bd1;
		  background-color: #f6f9fb;
		  border-left: 2px solid #5b9bd1;
		  margin-left: -2px;
		}
		
		button {
			color : white;
		}
	
	</style>

	
	</head>
	<body>
	 <jsp:include page="/toolbar/toolbar.jsp"/> 


	



    <div class="container-fluid" id="content">
    <!--   <div class="row profile"> -->
    
  <%--   <jsp:include page="/view/mypage/getFollowingList.jsp"/>
	<jsp:include page="/view/mypage/getFollowerList.jsp"/> --%>
		
		<input type="hidden" id="sessionId" value="${sessionScope.user.userId}">
         
			<%--  <div class="col-xs-6 col-md-4 col-md-offset-4">
              <img class="img-circle" src="/resources/uploadFile/${user.profileImage}" width="100" height="100">
              </div>
			  <div class="clearfix visible-xs-block"></div> --%>
        
        
        
        
          
		
			  
			  
			  
        
        
	
			
			 <%--<div class="col-md-4 col-md-offset-4">
             <img class="img-circle" src="/resources/uploadFile/${user.profileImage}" width="100" height="100"></div>
			<br> --%>
		            
					<!-- SIDEBAR USER TITLE -->
				<!-- 	<div class="row"> -->
					<div class="col-xs-6 col-md-4 col-md-offset-4">
					<div class="profile-usertitle" >
						
						 <div class= "row profile">
						 <img class="img-circle" src="/resources/uploadFile/${user.profileImage}" width="100" height="100">
						</div>
						
						 <div class="profile-usertitle-name"> 
						<!-- <div class="col-md-4 col-md-offset-4"> -->
							${user.nickname}
						</div>
						
						<div class="profile-usertitle-job"> 
						<!-- <div class="col-md-4 col-md-offset-4"> -->
						    ${user.gender == 'm' ? '남자':'여자'}
						</div>
						
						<div class="profile-usertitle-job">
						<!-- <div class="col-md-4 col-md-offset-4"> -->
						   ${user.age }
						</div>
						
					   <div class="profile-usertitle-job"> 
						<!-- <div class="col-md-4 col-md-offset-4"> -->
							${user.userId}
						</div>
			
			
					
			<div class="col-xs-6 col-md-4 col-md-offset-4">                                                                                                                                                                                                                                                                                                   
				<div class="profile-userbuttons">
					<c:if test="${! empty sessionScope.user.userId }">
						<c:if test="${sessionScope.user.userId != user.userId }">  <!--내가 딴 사람 마이페이지에 들어갔을때만 follow 버튼이 뜨는  조건  -->
							 <c:choose>
							 <c:when test="${empty follow.requestId }">
								
								 <!--나(sessionId) 이사람 requestId면 (팔로잉 목록에 없다면)-->
									<button type="button" class="btn btn-sm" id="profileFollow" >Follow</button>			
								</c:when>
							     <c:otherwise>
							      <!--나(sessionId) 이사람 requestId면 (팔로잉 목록에 있다면)-->
								     <button type="button" class="btn btn-info btn-sm" id="profileFollowing">Following</button>
							     </c:otherwise>
						</c:choose>
					</c:if> 
				</c:if>
			  </div>
			</div>
					
					
					
					
					
						
						
						
			</div>
			</div>
	<!-- 	</div> -->
	    
			      
			
			
			
			
			
			
			
			
			  <div class="col-xs-6 col-md-4 col-md-offset-4">
				<div class="profile-usermenu" id="reload">
					<ul class="nav">
						<li id="getFollowerList" class="test">
							<input type="hidden" id="userId" name="userId" value="${user.userId}">
							<a href="#">
							<%-- <i class="fa fa-user-circle" aria-hidden="true" 
							data-toggle="modal" data-target="#following" > </i>
							팔로잉</a> ${totalCount1} --%>
							
							<button type="button" class="btn btn-secondary" aria-hidden="true" 
							data-toggle="modal" data-target="#following">팔로잉${totalCount1}</button></a>	
							
							<jsp:include page="/view/mypage/getFollowingList.jsp"/>
							
						</li>
				
						<li id="getFollowingList" class="test">
							<a href="#">
							<input type="hidden" id="userId" name="userId" value="${user.userId}">
							<%-- <i class="fa fa-user-circle-o" aria-hidden="true"
							data-toggle="modal" data-target="#follower" ></i>
							팔로워</a>${totalCount2} --%>
							
							<button type="button" class="btn btn-secondary" aria-hidden="true" 
							data-toggle="modal" data-target="#follower">팔로워${totalCount2}</button></a>	
							
							<jsp:include page="/view/mypage/getFollowerList.jsp"/>
							
						</li>
					
					</ul>
				</div>
			</div>
				
				
				
			
			
			
			
</div>			
</div>
	
</body>
</html>