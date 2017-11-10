<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>


	<!-- ----------------------UI -->
	<link rel="stylesheet" href="/resources/css/main/assets/css/main.css" />
	
	<script type="text/javascript">
	
		var name;
		var image;
		var addr;
		var no;
		var detail;
		var memberCount = "";
		var hashtag;
		var date;
		
		function getFestivalList() {
			
			$.ajax({
				
				url : "/mainRest/json/getFestivalListDB/db",
				method : "POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				dataType : "json",
				success : function(JSONData) {
					
					for(var i = 0; i < JSONData.length; i++) {
						
						name = JSONData[i].festivalName;
						image = JSONData[i].festivalImage;
						addr = JSONData[i].addr;
						date = JSONData[i].startDate +"~"+ JSONData[i].endDate;
						no = JSONData[i].festivalNo;
						writeImage(i, name, image, addr, no, date);
						//alert(name+"."+image+","+addr);
						
					}
					
				}				
			});
			
		}
		
		function getPartyList() {
			
			$.ajax({
				
				url : "/mainRest/json/getPartyList/1",
				method : "GET",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				/* data : JSON.stringify({
					partyFlag : 2
				}),  */
				dataType : "json",
				success : function(JSONData) {
					
					for(var i = 0; i < JSONData.length; i++) {
						
						name = JSONData[i].partyName;
						image = JSONData[i].partyImage;
						addr = JSONData[i].partyPlace;
						no = JSONData[i].partyNo;
						detail = JSONData[i].partyDetail;
						//writeParty(i, name, image, addr, no, detail);
						//alert(name+"."+image+","+addr);
						
					}
					
				}				
			});
			
		}
		
		function getPartyMemberCount() {
			
			$.ajax({
				
				url : "/statisticsRest/json/getPartyCount",
				method : "GET",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				/* data : JSON.stringify({
					partyFlag : 2
				}),  */
				dataType : "json",
				success : function(JSONData) {
					//alert(JSON.stringify(JSONData));
					
					for(var i = 0; i < JSONData.length; i++) {
						
						memberCount = JSONData[i].totalCount;
						name = JSONData[i].name;
						addr = JSONData[i].addr;
						no = JSONData[i].referNo;
						image = JSONData[i].image;
						writeParty(i, name, image, addr, no,  detail, memberCount);
						//alert(name+"."+image+","+addr+","+memberCount);
					}
					
				}				
			});
			
		}
		
		function getReviewList() {
			
			$.ajax({
				
				url : "/reviewRest/json/getReviewList",
				method : "POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					currentPage : 1
				}),  
				dataType : "json",
				success : function(JSONData) {
					//alert(JSON.stringify(JSONData));
					
					var list = JSONData.list;
					for(var i = 0; i < 3; i++) {
						var fname = list[i].festivalName;
						name = list[i].reviewTitle;
						image = list[i].reviewImageList[0].reviewImage;
						no = list[i].reviewNo;
						hashtag = list[i].reviewHashtag;
						writeReview(i, name, fname, image, no,  hashtag);
					}
					
				}				
			});
			
		}
		
		function writeImage(index, name, image, addr, no, date) {
			
			index++;
			var innerHtml = '<img src="/resources/uploadFile/'+image+'" alt="축제이미지">';
			$("#img"+index).html(innerHtml);
			innerHtml = '<h2>'+name+'</h2>';
			$("#name"+index).html(innerHtml);
			innerHtml = '<p>'+addr+'</p>'
							+'<p>'+date+'</p>]';
			$("#addr"+index).html(innerHtml);
			innerHtml = '<a href="#" class="slider-btn">상세보기'
							+'<input type="hidden" name="festivalNo" value="'+no+'">'
							+'</a>';
			$("#button"+index).html(innerHtml).on("click", function(){
				//alert($(this).html());
				//alert($(this).find("input:hidden[name='festivalNo']").val());
				var fno = $(this).find("input:hidden[name='festivalNo']").val();
				self.location="/festival/getFestivalDB?festivalNo="+fno;
			});;
			
		}
		
		function writeParty(index, name, image, addr, no,  detail, memberCount) {
			
			//alert(memberCount);
			index++;
			var innerHtml = '<img height="380px" src="/resources/uploadFile/'+image+'" alt="축제이미지">';
			$("#pimg"+index).html(innerHtml);
			innerHtml = '<h3>'+index+'위 '+name+'</h3>';
			$("#pname"+index).html(innerHtml);
			innerHtml = '<p>'+addr+'</p>'
							 +'<p>현재 참여자수 :'+memberCount+'명</p>';
			$("#paddr"+index).html(innerHtml);
			innerHtml = '<a href="#" class="expand">'
							+'<input type="hidden" name="partyNo" value="'+no+'">'
							+'<i class="fa fa-search"></i>'
							+'</a>';
			$("#pbutton"+index).html(innerHtml).on("click", function(){
				//alert($(this).html());
				//alert($(this).find("input:hidden[name='partyNo']").val());
				var pno = $(this).find("input:hidden[name='partyNo']").val();
				self.location="/party/getParty?partyNo="+pno;
			});;
			
		}
		
		function writeReview(index, name, festivalName, image, no,  hashtag) {
			
			//alert(hashtag);
			index++;
			var innerHtml = '<img height="380px" src="/resources/uploadFile/'+image+'" alt="축제이미지">';
			$("#rimg"+index).html(innerHtml);
			innerHtml = '<h3>'+name+'</h3>';
			$("#rname"+index).html(innerHtml);
			innerHtml = '<p>'+festivalName+'</p>';
			$("#rfname"+index).html(innerHtml);
			innerHtml = '<p>'+hashtag+'</p>';
			$("#rhash"+index).html(innerHtml);
			innerHtml = '<a href="#" class="expand">'
							+'<input type="hidden" name="reviewNo" value="'+no+'">'
							+'<i class="fa fa-search"></i>'
							+'</a>';
			$("#rbutton"+index).html(innerHtml).on("click", function(){
				//alert($(this).html());
				//alert($(this).find("input:hidden[name='festivalNo']").val());
				var rno = $(this).find("input:hidden[name='reviewNo']").val();
				self.location="/review/getReview?reviewNo="+rno;
			});; 
			
		}
		
		$(function(){
			
			getFestivalList();
			
			getPartyList();
			
			getPartyMemberCount();
			
			getReviewList();
			
			//파티
			$("#service-1").on("click", function(){
				self.location = "/party/getPartyList";
			});
			
			//축제
			$("#service-2").on("click", function(){
				self.location = "/festival/getFestivalListDB?menu=db";
			});
			
			//후기
			$("#service-3").on("click", function(){
				self.location = "/review/getReviewList";
			});
			
			//티켓
			$("#service-4").on("click", function(){
				self.location = "/purchase/getPurchaseList";
			});
			
			//티켓
			$("#service-5").on("click", function(){
				self.location = "/chat/getChattingList";
			});
			
		});
		
		
		///////////////////////////////////검색///////////////////////////////////////
		$(function() {
			
				$("#searchKeyword").autocomplete({
					source: function( request, response ) {
				        $.ajax( {
				          url: "/festivalRest/json/getKeyword",
				          method : "POST",
				          headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
						  },
				          dataType: "json",
				          data: JSON.stringify({
				        	currentPage : "1",
					        searchKeyword : $("#searchKeyword").val(),
					        searchCondition : ""
				          }),
				          success: function( JSONData ) {
				            response($.map(JSONData, function(value, key){
				            	console.log(value.festivalNo);
				            	
				            	var festivalNo = value.festivalNo;
				            	
				            	$("#festivalNo").val(festivalNo);
				            	
				            		return {
				            			label :  value.festivalName,
				            			value : value.festivalName
				            		}
					        	}));
					          }
				        });
				    }
				});
			});
	   
		   $(function(){
				$("input:search[name='searchKeyword']").on('keydown',function(event){
					
					if(event.keyCode ==13){
						event.preventDefault();
						$( "#search"  ).click();
					}
				});
			
			});
	   
		   $(function(){
			   $("#search").on("click",function(){
					
				   var festivalNo = $("#festivalNo").val();
				   var searchKeyword = $("#searchKeyword").val();
				   
				   if(searchKeyword == null || searchKeyword.length <1){
						alert("축제명은 반드시 한 글자 이상 입력하셔야 합니다.");
						return;
					}
				   
				   self.location="/festival/getFestivalDB?festivalNo="+festivalNo;
			   });
		   });
	    
	</script>


	<style type="text/css">
	
		body {
	            padding-top : 65px;
	            /* padding-left : 50px; */
	            /* color: #3b3b3b; */
	            /* background-color: #E0E0F8; */
	    }
		
		.member-thumb {
			position: relative;
		  overflow: hidden;
		  border-radius: 50%;
		  -webkit-border-radius: 50%;
		  -moz-border-radius: 50%;
		}
	</style>

	<title>Moana</title>
	
</head>

	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

<body>

	
	<!-- Wrapper -->
			<div id="wrapper">


				<!-- Menu -->
					<section id="menu">

						<!-- Links -->
							<section>
								<ul class="links">
									<li>
										<a href="#">
											<h3>Lorem ipsum</h3>
											<p>Feugiat tempus veroeros dolor</p>
										</a>
									</li>
									<li>
										<a href="#">
											<h3>Dolor sit amet</h3>
											<p>Sed vitae justo condimentum</p>
										</a>
									</li>
									<li>
										<a href="#">
											<h3>Feugiat veroeros</h3>
											<p>Phasellus sed ultricies mi congue</p>
										</a>
									</li>
									<li>
										<a href="#">
											<h3>Etiam sed consequat</h3>
											<p>Porta lectus amet ultricies</p>
										</a>
									</li>
								</ul>
							</section>

						<!-- Actions -->
							<section>
								<ul class="actions vertical">
									<li><a href="#" class="button big fit">Log In</a></li>
								</ul>
							</section>

					</section>

				<!-- Main -->
					<div id="main">

						<!-- Post -->
							<article class="post">
								<!-- <header>
									<div class="title">
										<h2><a href="#">파티이름</a></h2>
										<p>파티주소</p>
									</div>
									<div class="meta">
										<time class="published" datetime="2017-10-11">파티날짜</time>
										<a href="#" class="author"><span class="name">주최자</span><img src="/resources/css/main/images/avatar.jpg" alt="" /></a>
									</div>
								</header> -->
								<a href="#" class="image featured"><img src="/resources/css/main/images/pic01.jpg" alt="" /></a>
								<p>Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at. Phasellus sed ultricies mi non congue ullam corper. Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
								<footer>
									<ul class="actions">
										<li><a href="#" class="button big">Continue Reading</a></li>
									</ul>
									<ul class="stats">
										<li><a href="#">General</a></li>
										<li><a href="#" class="icon fa-heart">28</a></li>
										<li><a href="#" class="icon fa-comment">128</a></li>
									</ul>
								</footer>
							</article>

						<!-- Post -->
							<!-- <article class="post">
								<header>
									<div class="title">
										<h2><a href="#">Ultricies sed magna euismod enim vitae gravida</a></h2>
										<p>Lorem ipsum dolor amet nullam consequat etiam feugiat</p>
									</div>
									<div class="meta">
										<time class="published" datetime="2015-10-25">October 25, 2015</time>
										<a href="#" class="author"><span class="name">Jane Doe</span><img src="images/avatar.jpg" alt="" /></a>
									</div>
								</header>
								<a href="#" class="image featured"><img src="images/pic02.jpg" alt="" /></a>
								<p>Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at. Phasellus sed ultricies mi non congue ullam corper.</p>
								<footer>
									<ul class="actions">
										<li><a href="#" class="button big">Continue Reading</a></li>
									</ul>
									<ul class="stats">
										<li><a href="#">General</a></li>
										<li><a href="#" class="icon fa-heart">28</a></li>
										<li><a href="#" class="icon fa-comment">128</a></li>
									</ul>
								</footer>
							</article> -->

						<!-- Post -->
							<!-- <article class="post">
								<header>
									<div class="title">
										<h2><a href="#">Euismod et accumsan</a></h2>
										<p>Lorem ipsum dolor amet nullam consequat etiam feugiat</p>
									</div>
									<div class="meta">
										<time class="published" datetime="2015-10-22">October 22, 2015</time>
										<a href="#" class="author"><span class="name">Jane Doe</span><img src="images/avatar.jpg" alt="" /></a>
									</div>
								</header>
								<a href="#" class="image featured"><img src="images/pic03.jpg" alt="" /></a>
								<p>Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at. Phasellus sed ultricies mi non congue ullam corper. Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla. Cras vehicula tellus eu ligula viverra, ac fringilla turpis suscipit. Quisque vestibulum rhoncus ligula.</p>
								<footer>
									<ul class="actions">
										<li><a href="#" class="button big">Continue Reading</a></li>
									</ul>
									<ul class="stats">
										<li><a href="#">General</a></li>
										<li><a href="#" class="icon fa-heart">28</a></li>
										<li><a href="#" class="icon fa-comment">128</a></li>
									</ul>
								</footer>
							</article> -->

						<!-- Post -->
						<!--
							<article class="post">
								<header>
									<div class="title">
										<h2><a href="#">Elements</a></h2>
										<p>Lorem ipsum dolor amet nullam consequat etiam feugiat</p>
									</div>
									<div class="meta">
										<time class="published" datetime="2015-10-18">October 18, 2015</time>
										<a href="#" class="author"><span class="name">Jane Doe</span><img src="images/avatar.jpg" alt="" /></a>
									</div>
								</header>

								<section>
									<h3>Text</h3>
									<p>This is <b>bold</b> and this is <strong>strong</strong>. This is <i>italic</i> and this is <em>emphasized</em>.
									This is <sup>superscript</sup> text and this is <sub>subscript</sub> text.
									This is <u>underlined</u> and this is code: <code>for (;;) { ... }</code>. Finally, <a href="#">this is a link</a>.</p>
									<hr />
									<p>Nunc lacinia ante nunc ac lobortis. Interdum adipiscing gravida odio porttitor sem non mi integer non faucibus ornare mi ut ante amet placerat aliquet. Volutpat eu sed ante lacinia sapien lorem accumsan varius montes viverra nibh in adipiscing blandit tempus accumsan.</p>
									<hr />
									<h2>Heading Level 2</h2>
									<h3>Heading Level 3</h3>
									<h4>Heading Level 4</h4>
									<hr />
									<h4>Blockquote</h4>
									<blockquote>Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan faucibus. Vestibulum ante ipsum primis in faucibus lorem ipsum dolor sit amet nullam adipiscing eu felis.</blockquote>
									<h4>Preformatted</h4>
									<pre><code>i = 0;

while (!deck.isInOrder()) {
  print 'Iteration ' + i;
  deck.shuffle();
  i++;
}

print 'It took ' + i + ' iterations to sort the deck.';</code></pre>
								</section>

								<section>
									<h3>Lists</h3>
									<div class="row">
										<div class="6u 12u$(medium)">
											<h4>Unordered</h4>
											<ul>
												<li>Dolor pulvinar etiam.</li>
												<li>Sagittis adipiscing.</li>
												<li>Felis enim feugiat.</li>
											</ul>
											<h4>Alternate</h4>
											<ul class="alt">
												<li>Dolor pulvinar etiam.</li>
												<li>Sagittis adipiscing.</li>
												<li>Felis enim feugiat.</li>
											</ul>
										</div>
										<div class="6u$ 12u$(medium)">
											<h4>Ordered</h4>
											<ol>
												<li>Dolor pulvinar etiam.</li>
												<li>Etiam vel felis viverra.</li>
												<li>Felis enim feugiat.</li>
												<li>Dolor pulvinar etiam.</li>
												<li>Etiam vel felis lorem.</li>
												<li>Felis enim et feugiat.</li>
											</ol>
											<h4>Icons</h4>
											<ul class="icons">
												<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
												<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
												<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
												<li><a href="#" class="icon fa-github"><span class="label">Github</span></a></li>
											</ul>
										</div>
									</div>
									<h3>Actions</h3>
									<div class="row">
										<div class="6u 12u$(medium)">
											<ul class="actions">
												<li><a href="#" class="button">Default</a></li>
												<li><a href="#" class="button">Default</a></li>
												<li><a href="#" class="button">Default</a></li>
											</ul>
											<ul class="actions small">
												<li><a href="#" class="button small">Small</a></li>
												<li><a href="#" class="button small">Small</a></li>
												<li><a href="#" class="button small">Small</a></li>
											</ul>
											<ul class="actions vertical">
												<li><a href="#" class="button">Default</a></li>
												<li><a href="#" class="button">Default</a></li>
												<li><a href="#" class="button">Default</a></li>
											</ul>
											<ul class="actions vertical small">
												<li><a href="#" class="button small">Small</a></li>
												<li><a href="#" class="button small">Small</a></li>
												<li><a href="#" class="button small">Small</a></li>
											</ul>
										</div>
										<div class="6u 12u$(medium)">
											<ul class="actions vertical">
												<li><a href="#" class="button fit">Default</a></li>
												<li><a href="#" class="button fit">Default</a></li>
											</ul>
											<ul class="actions vertical small">
												<li><a href="#" class="button small fit">Small</a></li>
												<li><a href="#" class="button small fit">Small</a></li>
											</ul>
										</div>
									</div>
								</section>

								<section>
									<h3>Table</h3>
									<h4>Default</h4>
									<div class="table-wrapper">
										<table>
											<thead>
												<tr>
													<th>Name</th>
													<th>Description</th>
													<th>Price</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Item One</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Two</td>
													<td>Vis ac commodo adipiscing arcu aliquet.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Three</td>
													<td> Morbi faucibus arcu accumsan lorem.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Four</td>
													<td>Vitae integer tempus condimentum.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Five</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="2"></td>
													<td>100.00</td>
												</tr>
											</tfoot>
										</table>
									</div>

									<h4>Alternate</h4>
									<div class="table-wrapper">
										<table class="alt">
											<thead>
												<tr>
													<th>Name</th>
													<th>Description</th>
													<th>Price</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Item One</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Two</td>
													<td>Vis ac commodo adipiscing arcu aliquet.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Three</td>
													<td> Morbi faucibus arcu accumsan lorem.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Four</td>
													<td>Vitae integer tempus condimentum.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Five</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="2"></td>
													<td>100.00</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</section>

								<section>
									<h3>Buttons</h3>
									<ul class="actions">
										<li><a href="#" class="button big">Big</a></li>
										<li><a href="#" class="button">Default</a></li>
										<li><a href="#" class="button small">Small</a></li>
									</ul>
									<ul class="actions fit">
										<li><a href="#" class="button fit">Fit</a></li>
										<li><a href="#" class="button fit">Fit</a></li>
										<li><a href="#" class="button fit">Fit</a></li>
									</ul>
									<ul class="actions fit small">
										<li><a href="#" class="button fit small">Fit + Small</a></li>
										<li><a href="#" class="button fit small">Fit + Small</a></li>
										<li><a href="#" class="button fit small">Fit + Small</a></li>
									</ul>
									<ul class="actions">
										<li><a href="#" class="button icon fa-download">Icon</a></li>
										<li><a href="#" class="button icon fa-upload">Icon</a></li>
										<li><a href="#" class="button icon fa-save">Icon</a></li>
									</ul>
									<ul class="actions">
										<li><span class="button disabled">Disabled</span></li>
										<li><span class="button disabled icon fa-download">Disabled</span></li>
									</ul>
								</section>

								<section>
									<h3>Form</h3>
									<form method="post" action="#">
										<div class="row uniform">
											<div class="6u 12u$(xsmall)">
												<input type="text" name="demo-name" id="demo-name" value="" placeholder="Name" />
											</div>
											<div class="6u$ 12u$(xsmall)">
												<input type="email" name="demo-email" id="demo-email" value="" placeholder="Email" />
											</div>
											<div class="12u$">
												<div class="select-wrapper">
													<select name="demo-category" id="demo-category">
														<option value="">- Category -</option>
														<option value="1">Manufacturing</option>
														<option value="1">Shipping</option>
														<option value="1">Administration</option>
														<option value="1">Human Resources</option>
													</select>
												</div>
											</div>
											<div class="4u 12u$(small)">
												<input type="radio" id="demo-priority-low" name="demo-priority" checked>
												<label for="demo-priority-low">Low</label>
											</div>
											<div class="4u 12u$(small)">
												<input type="radio" id="demo-priority-normal" name="demo-priority">
												<label for="demo-priority-normal">Normal</label>
											</div>
											<div class="4u$ 12u$(small)">
												<input type="radio" id="demo-priority-high" name="demo-priority">
												<label for="demo-priority-high">High</label>
											</div>
											<div class="6u 12u$(small)">
												<input type="checkbox" id="demo-copy" name="demo-copy">
												<label for="demo-copy">Email me a copy</label>
											</div>
											<div class="6u$ 12u$(small)">
												<input type="checkbox" id="demo-human" name="demo-human" checked>
												<label for="demo-human">Not a robot</label>
											</div>
											<div class="12u$">
												<textarea name="demo-message" id="demo-message" placeholder="Enter your message" rows="6"></textarea>
											</div>
											<div class="12u$">
												<ul class="actions">
													<li><input type="submit" value="Send Message" /></li>
													<li><input type="reset" value="Reset" /></li>
												</ul>
											</div>
										</div>
									</form>
								</section>

								<section>
									<h3>Image</h3>
									<h4>Fit</h4>
									<div class="box alt">
										<div class="row uniform">
											<div class="12u$"><span class="image fit"><img src="images/pic02.jpg" alt="" /></span></div>
											<div class="4u"><span class="image fit"><img src="images/pic04.jpg" alt="" /></span></div>
											<div class="4u"><span class="image fit"><img src="images/pic05.jpg" alt="" /></span></div>
											<div class="4u$"><span class="image fit"><img src="images/pic06.jpg" alt="" /></span></div>
											<div class="4u"><span class="image fit"><img src="images/pic06.jpg" alt="" /></span></div>
											<div class="4u"><span class="image fit"><img src="images/pic04.jpg" alt="" /></span></div>
											<div class="4u$"><span class="image fit"><img src="images/pic05.jpg" alt="" /></span></div>
											<div class="4u"><span class="image fit"><img src="images/pic05.jpg" alt="" /></span></div>
											<div class="4u"><span class="image fit"><img src="images/pic06.jpg" alt="" /></span></div>
											<div class="4u$"><span class="image fit"><img src="images/pic04.jpg" alt="" /></span></div>
										</div>
									</div>
									<h4>Left &amp; Right</h4>
									<p><span class="image left"><img src="images/pic07.jpg" alt="" /></span>Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent.</p>
									<p><span class="image right"><img src="images/pic04.jpg" alt="" /></span>Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent.</p>
								</section>

							</article>
						-->

						<!-- Pagination -->
							<!-- <ul class="actions pagination">
								<li><a href="" class="disabled button big previous">Previous Page</a></li>
								<li><a href="#" class="button big next">Next Page</a></li>
							</ul>
 -->
					</div>

				<!-- Sidebar -->
					<section id="sidebar">

						<!-- Intro -->
							<section id="intro">
								<a href="#" class="logo"><img src="/resources/css/main/images/logo.jpg" alt="" /></a>
								<header>
									<h2>MOANA</h2>
									<p>주말에 뭐하고 놀까, 다른 사람들은 모아나?</a></p>
								</header>
							</section>

						<!-- Mini Posts -->
							<section>
								<div class="mini-posts">

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><a href="#">Vitae sed condimentum</a></h3>
												<time class="published" datetime="2015-10-20">October 20, 2015</time>
												<a href="#" class="author"><img src="/resources/css/main/images/avatar.jpg" alt="" /></a>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic04.jpg" alt="" /></a>
										</article>

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><a href="#">Rutrum neque accumsan</a></h3>
												<time class="published" datetime="2015-10-19">October 19, 2015</time>
												<a href="#" class="author"><img src="/resources/css/main/images/avatar.jpg" alt="" /></a>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic05.jpg" alt="" /></a>
										</article>

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><a href="#">Odio congue mattis</a></h3>
												<time class="published" datetime="2015-10-18">October 18, 2015</time>
												<a href="#" class="author"><img src="/resources/css/main/images/avatar.jpg" alt="" /></a>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic06.jpg" alt="" /></a>
										</article>

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><a href="#">Enim nisl veroeros</a></h3>
												<time class="published" datetime="2015-10-17">October 17, 2015</time>
												<a href="#" class="author"><img src="/resources/css/main/images/avatar.jpg" alt="" /></a>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic07.jpg" alt="" /></a>
										</article>

								</div>
							</section>

						<!-- Posts List -->
							<section>
								<ul class="posts">
									<li>
										<article>
											<header>
												<h3><a href="#">Lorem ipsum fermentum ut nisl vitae</a></h3>
												<time class="published" datetime="2015-10-20">October 20, 2015</time>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic08.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="#">Convallis maximus nisl mattis nunc id lorem</a></h3>
												<time class="published" datetime="2015-10-15">October 15, 2015</time>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic09.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="#">Euismod amet placerat vivamus porttitor</a></h3>
												<time class="published" datetime="2015-10-10">October 10, 2015</time>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic10.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="#">Magna enim accumsan tortor cursus ultricies</a></h3>
												<time class="published" datetime="2015-10-08">October 8, 2015</time>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic11.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="#">Congue ullam corper lorem ipsum dolor</a></h3>
												<time class="published" datetime="2015-10-06">October 7, 2015</time>
											</header>
											<a href="#" class="image"><img src="/resources/css/main/images/pic12.jpg" alt="" /></a>
										</article>
									</li>
								</ul>
							</section>

						<!-- About -->
							<section class="blurb">
								<h2>About</h2>
								<p>Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod amet placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at phasellus sed ultricies.</p>
								<ul class="actions">
									<li><a href="#" class="button">Learn More</a></li>
								</ul>
							</section>

						<!-- Footer -->
							<section id="footer">
								<ul class="icons">
									<li><a href="#" class="fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="fa-facebook"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="fa-rss"><span class="label">RSS</span></a></li>
									<li><a href="#" class="fa-envelope"><span class="label">Email</span></a></li>
								</ul>
								<p class="copyright">&copy; Untitled. Crafted: <a href="http://designscrazed.org/">HTML5</a>.</p>
							</section>
	
	
</body>

</html>