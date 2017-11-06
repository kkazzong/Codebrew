<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
	
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
	 <!--   <a class="navbar-brand js-scroll-trigger" href="#page-top">
	   	 <span class="nav-link js-scroll-trigger"><a class="navbar-brand js-scroll-trigger" href="/index.jsp">MOANA</a></span>
	   </a> -->
      <a class="navbar-brand js-scroll-trigger" href="#page-top">
        <span class="d-block d-lg-none">MOANA</span>
        <span class="d-none d-lg-block">
          <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="/resources/uploadFile/${user.profileImage}" alt="profile image">
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
            <a class="nav-link js-scroll-trigger" href="#getMyReviewList">Festival</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#getMyZzimList">Party</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#getMyPartyList">Review</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link js-scroll-trigger dropdown-toggle" href="#getPurchaseList" data-toggle="dropdown" role="button" aria-expanded="false">
            	<span >Purchase</span>
	           <!--  <span class="caret"></span> -->
            </a>
			<ul class="dropdown-menu">
					<li><a href="#">myTicket</a></li>
					<!-- <li><a href="#">축제통계</a></li>
					<li><a href="#">평점통계</a></li>
					<li><a href="#">참여자수통계</a></li> -->
					<c:if test="${sessionScope.user.role == 'a'}">
						<li class="divider"></li>
						<li><a href="#">saleList</a></li>
						<li><a href="#">saleSatistics</a></li>
					</c:if>
				</ul>
			</li>
        </ul>
      </div>
    </nav>


		<!-- ToolBar End /////////////////////////////////////-->
   	
   	
   	<script type="text/javascript">
					$(".dropdown").hover(function() {
						$(this).toggleClass("mouse-on");
					})

					//////로그인, 로그아웃//////
					$(function() {
						$("a:contains('로그인')").on("click", function() {
							self.location = "/user/login";
						});
						$("a:contains('로그아웃')").on("click", function() {
							self.location = "/user/logout";
						});

						$("a:contains('마이페이지')")
								.on(
										"click",
										function() {

											self.location = "/myPage/getMyPage?requestId=${sessionScope.user.userId}";

										});

					});

					//////축제관리//////
					$(function() {
						$("li > a:contains('축제목록')")
								.on(
										"click",
										function() {
											self.location = "/festival/getFestivalListDB?menu=db";
										});

						$("li > a:contains('축제등록')").bind('click', function() {
							self.location = "/festival/getFestivalList";
						});

						$("li > a:contains('축제직접등록')")
								.bind(
										'click',
										function() {
											self.location = "/view/festival/writeFestival.jsp";
										});

						$("li > a:contains('my찜')").bind('click', function() {
							self.location = "/festival/getMyZzimList";
						});
					});

					//////후기관리//////
					$(function() {
						$("a:contains('Review')").on("click", function() {
							//self.location = "/review/getReviewList";
							//self.location = "/review/getReviewList";
						});
					});

					//////후기관리//////
					$(function() {
						$("a:contains('후기목록')").on("click", function() {
							self.location = "/review/getReviewList";
						});

						$("li > a:contains('후기등록')").bind('click', function() {
							self.location = "/review/addReview";
						});

						$("li > a:contains('my후기')").bind('click', function() {
							self.location = "/review/getMyReviewList";
						});

						$("li > a:contains('후기심사목록')")
								.bind(
										'click',
										function() {
											self.location = "/review/getCheckReviewList";
										});
					});

					//////구매관리//////
					$(function() {

						$("a:contains('myTicket')").bind('click', function() {
							self.location = "/purchase/getPurchaseList";
						});

						$("a:contains('축제통계')").bind('click', function() {
							self.location = "/statistics/getFestivalZzim";
						});

						$("a:contains('평점통계')").bind('click', function() {
							self.location = "/statistics/getFestivalRating";
						});

						$("a:contains('참여자수통계')").bind('click', function() {
							self.location = "/statistics/getPartyCount";
						});

						$("li > a:contains('판매목록')").bind('click', function() {
							self.location = "/purchase/getSaleList";
						});

						$("li > a:contains('판매통계')").bind('click', function() {
							self.location = "/statistics/getStatistics";
						});

					});

					//////파티관리//////
					$(function() {

						$("li > a:contains('my파티')").bind('click', function() {
							self.location = "/party/getMyPartyList";
						});

						$("li > a:contains('파티등록')").bind('click', function() {
							self.location = "/party/addParty";
						});

						$("li > a:contains('파티목록')").bind('click', function() {
							self.location = "/party/getPartyList";
						});

						$("li > a:contains('애프터파티')").bind('click', function() {

						});

						$("li > a:contains('아모르파티')").bind('click', function() {

						});

					});

					///////툴바 MANAGE////////
					$(function() {

						$("a:contains('회원목록')").on("click", function() {
							self.location = "/user/getUserList";
						});

						$("a:contains('축제등록')")
								.on(
										"click",
										function() {
											self.location = "/festival/getFestivalList?pageNo=1";
										});

						$("a:contains('후기심사목록')").on("click", function() {
							//self.location = "";
						});

					});

					///////파티관리////////
					$(function() {

						$("a:contains('파티등록')").on("click", function() {
							self.location = "/party/addParty"
						});

						$("a[href='#']:contains('파티목록')").bind('click',
								function() {
									self.location = "/party/getPartyList";
								});

					});
				</script>  

	<style>
		.navbar-brand > img {
				width : 45%;
				heigth : 45%;
				padding-bottom: 3px;
		}
		/* .bg-primary{
			background-color: #868e96 !important;
		} */
		@media (min-width: 992px)
		.navbar-expand-lg .navbar-nav .dropdown-menu {
		    position: sticky;
		}
		.dropdown-menu{
			background-color:#868e96; 
			padding-right: .5rem;
    		padding-left: .5rem;
		}
		.dropdown-menu>li>a {
			color: #d2d5cf;
			font-weight: 600;
		}
		.navbar {
			/* max-height : 60px; */
		}
	</style>