<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<!-- <script src="https://use.fontawesome.com/04438b50a5.js"></script>
 -->
<!-- <html xmlns="http://www.w3.org/1999/xhtml"> -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
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




<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/resources/css/fonts.css" rel="stylesheet" type="text/css" media="all" />

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->

</head>
<script type="text/javascript">


  $(function(){
	
	 var userId = $("#userId").val();
		 
      var requestId = $("#userId").val();
	  
      
	   $( "#getMyZzimList" ).on("click" , function() {
			
			self.location="/myPage/getMyZzimList";
		});
	   
	   
		
		$( "#getMyPartyList" ).on("click" , function() {
			var userId = $("#userId").val();
			self.location="/myPage/getMyPartyList";
		});
		
		
		
		$( "#getMyReviewList" ).on("click" , function() {
		
			self.location="/myPage/getMyReviewList";
		});
		
		
		
		$( "#getPurchaseList" ).on("click" , function() {
		
			self.location="/myPage/getPurchaseList";
		});
	
	
	
  });




</script>


<!-- <div id="page" class="container"> -->
	<div id="header">
	
		<div id="logo">
			<input type="hidden" id="sessionId" value="${sessionScope.user.userId}">
			<img src="/resources/uploadFile/default_profile_image.jpg" alt="" width="100" height="100"/>
			<h1><a href="#">Privy</a></h1>
			<span>Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a></span>
		</div>
		
		<div id="menu">
			<ul>
				<li class="current_page_item"><a href="#" accesskey="1" title="">Homepage</a></li>
				<li><a href="#" accesskey="2" id="getMyZzimList">my zzim</a></li>
				<li><a href="#" accesskey="3" aria-hidden="true" id="getMyPartyList">my Party</a></li>
				<li><a href="#" accesskey="4" aria-hidden="true" id="getMyReviewList">my review</a></li>
				<li><a href="#" accesskey="5" aria-hidden="true" id="getPurchaseList">my purchase</a></li>
			</ul>
		</div>
		
	</div>

	<%--  <div id="main">
	 
	 <jsp:include page="/view/mypage/getMyPartyList.jsp"/> --%>
		<!-- <div id="banner">
			<img src="/resources/uploadFile/1508412935368_user1.jpg" alt="" class="image-full" />
		</div>
		<div id="welcome">
			<div class="title">
				<h2>Fusce ultrices fringilla metus</h2>
				<span class="byline">Donec leo, vivamus fermentum nibh in augue praesent a lacus at urna congue</span>
			</div>
			<p>This is <strong>Privy</strong>, a free, fully standards-compliant CSS template designed by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>. The photos in this template are from <a href="http://fotogrph.com/"> Fotogrph</a>. This free template is released under the <a href="http://templated.co/license">Creative Commons Attribution</a> license, so you're pretty much free to do whatever you want with it (even use it commercially) provided you give us credit for it. Have fun :) </p>
			<ul class="actions">
				<li><a href="#" class="button">Etiam posuere</a></li>
			</ul>
		</div>
		<div id="featured">
			<div class="title">
				<h2>Maecenas lectus sapien</h2>
				<span class="byline">Integer sit amet aliquet pretium</span>
			</div>
			<ul class="style1">
				<li class="first">
					<p class="date"><a href="#">Jan<b>05</b></a></p>
					<h3>Amet sed volutpat mauris</h3>
					<p><a href="#">Consectetuer adipiscing elit. Nam pede erat, porta eu, lobortis eget, tempus et, tellus. Etiam neque. Vivamus consequat lorem at nisl. Nullam non wisi a sem semper eleifend. Etiam non felis. Donec ut ante.</a></p>
				</li>
				<li>
					<p class="date"><a href="#">Jan<b>03</b></a></p>
					<h3>Sagittis diam dolor amet</h3>
					<p><a href="#">Etiam non felis. Donec ut ante. In id eros. Suspendisse lacus turpis, cursus egestas at sem. Mauris quam enim, molestie. Donec leo, vivamus fermentum nibh in augue praesent congue rutrum.</a></p>
				</li>
				<li>
					<p class="date"><a href="#">Jan<b>01</b></a></p>
					<h3>Amet sed volutpat mauris</h3>
					<p><a href="#">Consectetuer adipiscing elit. Nam pede erat, porta eu, lobortis eget, tempus et, tellus. Etiam neque. Vivamus consequat lorem at nisl. Nullam non wisi a sem semper eleifend. Etiam non felis. Donec ut ante.</a></p>
				</li>
				<li>
					<p class="date"><a href="#">Dec<b>31</b></a></p>
					<h3>Sagittis diam dolor amet</h3>
					<p><a href="#">Etiam non felis. Donec ut ante. In id eros. Suspendisse lacus turpis, cursus egestas at sem. Mauris quam enim, molestie. Donec leo, vivamus fermentum nibh in augue praesent congue rutrum.</a></p>
				</li>
			</ul>
		</div>
		<div id="copyright">
			<span>&copy; Untitled. All rights reserved. | Photos by <a href="http://fotogrph.com/">Fotogrph</a></span>
			<span>Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</span>
		</div>
	</div> -->
<!-- </div> -->



<!--sidebar menu -->





