<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

  <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>마이페이지</title>

    <!-- Bootstrap core CSS -->
    
    
    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


     <!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>

<!-- Jquery DatePicker -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:100,200,300,400,500,600,700,800,900" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/vendor/devicons/css/devicons.min.css" rel="stylesheet">
    <link href="/resources/vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/css/resume.min.css" rel="stylesheet">

  </head>
  
  
  
  	<script type="text/javascript">
  	
  	 $(function() {
		 
			$("#profileFollow").on("click" , function() {
				var requestId = $("#userId").val();
			
			 console.log("requestId는????"+requestId);
				
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
							/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); */
							/* location.reload(); */
							$(this).val('following');
							 
						 }
					}		
				)
			});
		});	
  	
  	
  	
  	
  	
  	////////////////////////////////////////////////////////////////////////////////////////////////////////
  	
  	  /*  $(function() {
		 
		 var userId = $("#userId").val();
		 
		 var requestId = $("#userId").val();
		
		 
			$( "#getMyPage" ).on("click" , function() {
				self.location="/myPage/getMyPage?requestId="+requestId;
			});
		 
			
		 	$( "#getFollowingList" ).on("click" , function() {
				
				self.location="/myPage/getFollowingList?requestId="+requestId;
			});
			
			
			$( "#getFollowerList" ).on("click" , function() {
				
				self.location="/myPage/getFollowerList?requestId="+requestId;
			});
			
			 $( "#getMyZzimList" ).on("click" , function() {
				
				self.location="/festival/getMyZzimList";
			});
			
			$( "#getMyPartyList" ).on("click" , function() {
				var userId = $("#userId").val();
				self.location="/party/getMyPartyList";
			});
			
			$( "#getMyReviewList" ).on("click" , function() {
			
				self.location="/review/getMyReviewList";
			});
			
			
			
			$( "#getPurchaseList" ).on("click" , function() {
			
				self.location="/purchase/getPurchaseList";
			});
			
			
		});
	
   */
  
//펑션 불필요 그냥 다 mypage.jsp로 보내줌
  
  </script>
  
   <style>

 .bg-primary{
  background-color:#868e96 !important;
 }
   
	
	
</style>
  
  
  
    
  <body id="page-top">
<%--   <jsp:include page="/toolbar/toolbar.jsp"/> --%>
	<input type="hidden" id="sessionId" value="${sessionScope.user.userId}">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">

      <a class="navbar-brand js-scroll-trigger" href="#page-top">
        <span class="d-block d-lg-none">MOANA</span>
        <span class="d-none d-lg-block">
          <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="/resources/uploadFile/default_profile_image.jpg" alt="">
        </span>
      </a>
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#getMyPage">about</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#getMyReviewList">myReview</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#getMyZzimList">myZzim</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#getMyPartyList">myParty</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#getPurchaseList">myPurchase</a>
          </li>
        </ul>
      </div>
    </nav>

    <div class="container-fluid p-0">
     <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="getMyPage">
        <div class="my-auto">
         <!--  <h2 class="mb-5">about</h2> -->
             <jsp:include page="/view/mypage/getMyPage.jsp"/>
             
         </div>
      </section>
    </div>

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="getMyReviewList">
        <div class="my-auto">
         <!--  <h2 class="mb-5">my review</h2> -->
             <jsp:include page="/view/mypage/getMyReviewList.jsp"/>
             <!--key를 바꿨기때문에 바꾼 화면으로 네비 (list를 list3으로 바꿔서) -->
         </div>
      </section>


      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="getMyZzimList">
        <div class="my-auto">
          <!-- <h2 class="mb-5">my zzim</h2> -->
           <jsp:include page="/view/mypage/getMyZzimList.jsp"/>
        </div>
      </section>




       <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="getMyPartyList">
        <div class="my-auto">
         <!--  <h2 class="mb-5">my party</h2> -->
         <jsp:include page="/view/mypage/getMyPartyList.jsp"/>  
        </div>
      </section>
       
      
       <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="getPurchaseList">
        <div class="my-auto">
          <!-- <h2 class="mb-5">my purchase</h2> -->
           <jsp:include page="/view/mypage/getPurchaseList.jsp"/>  
        </div>
      </section>
   
      

     

      

   
 
    <!-- Bootstrap core JavaScript -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="/resources/javascript/resume.min.js"></script>

  </body>

</html>
