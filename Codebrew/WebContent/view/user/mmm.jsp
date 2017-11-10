<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<head>
		<title>Visualize by TEMPLATED</title>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="/resources/assets/css/main.css" />
			 <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
		<!-- Scripts -->
			<script src="/resources/assets/js/jquery.min.js"></script>
			<script src="/resources/assets/js/jquery.poptrox.min.js"></script>
			<script src="/resources/assets/js/skel.min.js"></script>
			<script src="/resources/assets/js/main.js"></script>
	
	
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
	 
</script>
	 
	</head>
	<body>
<jsp:include page="/view/mypage/getFollowingList.jsp"/>
<jsp:include page="/view/mypage/getFollowerList.jsp"/>
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<!-- <header id="header"> -->
						<span class="avatar"><img src="/resources/uploadFile/default_profile_image.jpg" alt="" /></span>
						
						
						<ul class="icons">
						
						                                                                                                                                                                                                                                                                                                     
				<li class="profile-userbuttons">
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
				</li>
			
							<li><a href="#" class="icon style2 fa-twitter" data-toggle="modal" data-target="#following">
							<span class="label">Following</span><input type="hidden" id="userId" name="userId" value="${user.userId}"></a></li>
							
							
							<li><a href="#" class="icon style2 fa-facebook" data-toggle="modal" data-target="#follower">
							<span class="label">Follower</span><input type="hidden" id="userId" name="userId" value="${user.userId}"></a></li>
							
							
							<li><a href="#" class="icon style2 fa-instagram" id="updateUser"><span class="label">회원정보수정</span></a></li>
							<li><a href="#" class="icon style2 fa-500px" id="withdrawUser"><span class="label">회원탈퇴</span></a></li>
							
							
							<li><a href="#" class="icon style2 fa-envelope-o"><span class="label">Email</span></a></li>
						</ul>
					</header>

				<!-- Main -->
			 <jsp:include page="/view/mypage/getMyPartyList.jsp"/> 
				
					<!-- <section id="main">

						Thumbnails
							<section class="thumbnails">
								<div>
									<a href="/images/fulls/01.jpg">
										<img src="images/thumbs/01.jpg" alt="" />
										<h3>Lorem ipsum dolor sit amet</h3>
									</a>
									<a href="images/fulls/02.jpg">
										<img src="images/thumbs/02.jpg" alt="" />
										<h3>Lorem ipsum dolor sit amet</h3>
									</a>
								</div>
								<div>
									<a href="images/fulls/03.jpg">
										<img src="images/thumbs/03.jpg" alt="" />
										<h3>Lorem ipsum dolor sit amet</h3>
									</a>
									<a href="images/fulls/04.jpg">
										<img src="images/thumbs/04.jpg" alt="" />
										<h3>Lorem ipsum dolor sit amet</h3>
									</a>
									<a href="images/fulls/05.jpg">
										<img src="images/thumbs/05.jpg" alt="" />
										<h3>Lorem ipsum dolor sit amet</h3>
									</a>
								</div>
								<div>
									<a href="images/fulls/06.jpg">
										<img src="images/thumbs/06.jpg" alt="" />
										<h3>Lorem ipsum dolor sit amet</h3>
									</a>
									<a href="images/fulls/07.jpg">
										<img src="images/thumbs/07.jpg" alt="" />
										<h3>Lorem ipsum dolor sit amet</h3>
									</a>
								</div>
							</section>

					</section> -->



			</div>

	

	</body>
</html>