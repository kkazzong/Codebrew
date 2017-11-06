<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


     <!-- Bootstrap Dropdown Hover CSS -->
	<!-- <link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet"> -->
	
	<!-- Bootstrap Dropdown Hover JS -->
	<!-- <script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script> -->

    <!-- Custom fonts for this template -->
    <!-- <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:100,200,300,400,500,600,700,800,900" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/vendor/devicons/css/devicons.min.css" rel="stylesheet">
    <link href="/resources/vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet"> -->

    <!-- Custom styles for this template -->
    <link href="/resources/css/toolbar/main.css" rel="stylesheet">
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    
    <!-- Custom js -->
    <script src="/resources/css/toolbar/js/jquery.min.js"></script>
	<script src="/resources/css/toolbar/js/jquery.scrolly.min.js"></script>
	<script src="/resources/css/toolbar/js/jquery.scrollzer.min.js"></script>
	<script src="/resources/css/toolbar/js/skel.min.js"></script>
	<script src="/resources/css/toolbar/js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="/resources/css/toolbar/js/main.js"></script>
    
<!-- <div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew"> -->
	<div id="header">
				<div class="top">

					<!-- Logo -->
						<div id="logo">
							<c:if test="${empty user}">
				                <ul>
									<li><a href="/user/login" id="top-link"><span >Login</span></a></li>
								</ul>
			             	</c:if>
							<c:if test="${!empty user}">
							<span class="image avatar48"><img src="/resources/uploadFile/${user.profileImage}" alt="profile image"/></span>
							<h1 id="title">${user.nickname }</h1>
							<p>${user.userId}</p>
							<ul>
								<li><a href="/user/logout" id="top-link"><span class="label">Logout</span></a></li>
							</ul>
							</c:if>
							<!-- <p>Logout</p> -->
						</div>

					<!-- Nav -->
						<nav id="nav">
							<!--

								Prologue's nav expects links in one of two formats:

								1. Hash link (scrolls to a different section within the page)

								   <li><a href="#foobar" id="foobar-link" class="icon fa-whatever-icon-you-want skel-layers-ignoreHref"><span class="label">Foobar</span></a></li>

								2. Standard link (sends the user to another page/site)

								   <li><a href="http://foobar.tld" id="foobar-link" class="icon fa-whatever-icon-you-want"><span class="label">Foobar</span></a></li>

							-->
							<ul>
								<!-- <li><a href="#top" id="top-link" class="skel-layers-ignoreHref"><span class="icon fa-home">Main</span></a></li> -->
								<li><a href="/index.jsp" id="top-link" class="icon fa-home"><span class="label"></span></a></li>
								<!-- <li><a href="/user/login" id="top-link" class="icon fa-sign-out"><span class="label"></span></a></li> -->
								<li><a href="#portfolio" id="portfolio-link" class="skel-layers-ignoreHref"><span class="icon fa-fire">Festival</span></a></li>
								<li>
									<a href="#about" id="about-link" class="skel-layers-ignoreHref">
										<span class="icon fa-star">Party</span>
									</a>
								</li>
								<li class="dropdown">
									<a href="#about" id="about-link" class="skel-layers-ignoreHref dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
										<span class="icon fa-pencil-square-o">Review</span>
									</a>
									<ul class="dropdown-menu">
					                    <li><a href="#">후기등록</a></li>
					                    <li class="divider"></li>
					                    <li><a href="#">후기목록</a></li>
					                    <li class="divider"></li>
					                    <li><a href="#">my후기</a></li>
					                    <!-- <li><a href="#">티켓판매목록</a></li>
					                    <li><a href="#">판매통계</a></li> -->
					                 </ul>
								</li>
								<li class="dropdown">
									<a href="#contact" id="contact-link" class="skel-layers-ignoreHref dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
										<span class="icon fa-ticket">Ticket</span>
									</a>
									<c:if test="${user.role == 'a'}">
									<ul class="dropdown-menu">
					                    <li><a href="#">판매목록</a></li>
					                    <li class="divider"></li>
					                    <li><a href="#">판매통계</a></li>
					                    <li class="divider"></li>
					                 </ul>
									</c:if>
								</li>
								<li><a href="#contact" id="contact-link" class="skel-layers-ignoreHref"><span class="icon fa-user">Mypage</span></a></li>
								<!-- <li><a href="#contact" id="contact-link" class="skel-layers-ignoreHref"><span class="icon fa-user">Logout</span></a></li> -->
							</ul>
						</nav>

				</div>

				<div class="bottom">
					<!-- Social Icons -->
						<ul class="icons">
							<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
							<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
							<li><a href="#" class="icon fa-github"><span class="label">Github</span></a></li>
							<li><a href="#" class="icon fa-dribbble"><span class="label">Dribbble</span></a></li>
							<li><a href="#" class="icon fa-envelope"><span class="label">Email</span></a></li>
						</ul>

				</div>

			</div>
			
			
			<!-- </div> -->
			
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
						$("li > a > span:contains('Festival')").on("click",function() {
									self.location = "/festival/getFestivalListDB?menu=db";
						});
						
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
						
						$("li > a > span:contains('Ticket')").bind('click', function() {
							self.location = "/purchase/getPurchaseList";
						});
						
						$("li > a:contains('myTicket')").bind('click', function() {
							self.location = "/purchase/getPurchaseList";
						});

						$("li > a:contains('축제통계')").bind('click', function() {
							self.location = "/statistics/getFestivalZzim";
						});

						$("li > a:contains('평점통계')").bind('click', function() {
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
					.dropdown-menu {
						position: absolute;
					    top: 100%;
					    left: 0;
					    z-index: 1000;
					    display: none;
					    float: left;
					    min-width: 275px;
					    padding: 5px 0;
					    margin: 2px 0 0;
					    font-size: 14px;
					    text-align: left;
					    list-style: none;
					    background-color: #222628;
					    -webkit-background-clip: padding-box;
					    background-clip: padding-box;
					    border: 1px solid #ccc;
					    border: 1px solid rgba(0,0,0,.15);
					    border-radius: 4px;
					    -webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
					    box-shadow: 0 6px 12px rgba(0,0,0,.175);
					}
					.dropdown-menu > li:hover {
						 background-color: #222628;
					}
				/* .image .avatar48 img {
				width: 100px;
    height: 100px;
	 max-width: 10rem;
        max-height: 10rem;
        border: 0.5rem solid rgba(255, 255, 255, 0.2);
} */
</style>  