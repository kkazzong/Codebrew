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
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
        
    <link rel="stylesheet" href="/resources/css/index/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/index/css/font-awesome.css">
    <link rel="stylesheet" href="/resources/css/index/css/animate.css">
    <link rel="stylesheet" href="/resources/css/index/css/templatemo_misc.css">
    <link rel="stylesheet" href="/resources/css/index/css/templatemo_style.css">

    <script src="/resources/css/index/js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
	
	<!-- autocomplete -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
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
			var innerHtml = "";
			if(image.indexOf('http') != -1) {
				innerHtml = '<img src='+image+' alt="축제이미지">';
			} else {
				innerHtml = '<img src="/resources/uploadFile/'+image+'" alt="축제이미지">';
			}
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


<body>

	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

	<div class="site-main" id="sTop">
           
            <div class="site-slider">
                <div class="slider">
                    <div class="flexslider">
                        <ul class="slides">
                            <li>
                                <div class="overlay"></div>
                               <!--  <img src="/resources/css/index/images/slide1.jpg" alt=""> -->
                               <div id="img1"></div>
                                <div class="slider-caption visible-md visible-lg">
                                    <!-- <h2>Digital Marketing</h2> -->
                                    <div id="name1"></div>
                                    <!-- <p>more visitors to your website</p> -->
                                    <div id="addr1"></div>
                                    <!-- <a href="#" class="slider-btn">상세보기</a> -->
                                    <div id="button1"></div>
                                </div>
                            </li>
                            <li>
                                <div class="overlay"></div>
                                <!-- <img src="/resources/css/index/images/slide2.jpg" alt=""> -->
                                <div id="img2"></div>
                                <div class="slider-caption visible-md visible-lg">
                                   <!--  <h2>Responsive HTML CSS</h2> -->
                                   <div id="name2"></div>
                                    <!-- <p>Download and use it for your site</p> -->
                                    <div id="addr2"></div>
                                    <!-- <a href="#" class="slider-btn">상세보기</a> -->
                                    <div id="button2"></div>
                                </div>
                            </li>
                            <li>
                                <div class="overlay"></div>
                                <!-- <img src="/resources/css/index/images/slide3.jpg" alt=""> -->
                                <div id="img3"></div>
                                <div class="slider-caption visible-md visible-lg">
                                   <!--  <h2>Pro Level Design</h2> -->
                                   <div id="name3"></div>
                                   <!--  <p>High standard work</p> -->
                                   <div id="addr3"></div>
                                    <!-- <a href="#" class="slider-btn">상세보기</a> -->
                                    <div id="button3"></div>
                                </div>
                            </li>
                        </ul>
                    </div> <!-- /.flexslider -->
                </div> <!-- /.slider -->
            </div> <!-- /.site-slider -->
        </div> <!-- /.site-main -->
        
        
        <div class="site-main" id="sTop">
           
            <div class="site-slider">
                <div class="slider">
                    <div class="flexslider">
                        <ul class="slides">
                            <li>
                            	<div class="col-md-12">
									<div class="col-md-offset-2 col-md-7">		
										<div class="page-header text-center">
											<div class="input-group text-center">
												<input type="hidden" id="currentPage" name="currentPage" value=""/>
												<input type="hidden" id="festivalNo" name="festivalNo" value=""/>
												<input type="search" class="form-control  input-lg" id="searchKeyword" name="searchKeyword" type="text" 
												value="${!empty search.searchKeyword ? search.searchKeyword : ''}"
												placeholder="축제를 검색해보세요.">
													<span class="input-group-btn">
														<button id="search" class="btn btn-default btn-lg btn-block" type="button">
													    	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
													    </button>
													</span>
											</div>
										</div>
									</div>
								</div>
                            </li>
                        </ul>
                    </div> <!-- /.flexslider -->
                </div> <!-- /.slider -->
            </div> <!-- /.site-slider -->
        </div> <!-- /.site-main -->


		<div class="content-section" id="services">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>Our Services</h2>
                        <p>We design mobile-first websites for you</p>
                    </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="col-md-2 col-sm-4">
                        <div class="service-item" id="service-1">
                            <div class="service-icon">
                                <i class="fa fa-cubes"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Party</h3>
                                   <p>Enjoy enjoying fun parties together, Please register yourself with the party and the last party doesn't appear on the list.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-2 col-sm-4">
                        <div class="service-item" id="service-2">
                            <div class="service-icon">
                                <i class="fa fa-paper-plane-o"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Festival</h3>
                                   <p>It's a useful place to check for information about festivals in different regions. You can pre-empt the festival you want to go.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-2 col-sm-4">
                        <div class="service-item" id="service-3">
                            <div class="service-icon">
                                <i class="fa fa-pencil"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Review</h3>
                                   <p>Don't miss the chance to share people's frank reviews. You can check the traffic information around the festival, and there is room for sharing ideas.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-2 col-sm-4">
                        <div class="service-item" id="service-4">
                            <div class="service-icon">
                                <i class="fa fa-ticket"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Ticket</h3>
                                   <p>Anyone who wants to go to parties or festivals can easily purchase tickets at our site. To purchase tickets, you can use them after logging in.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-2 col-sm-4">
                        <div class="service-item" id="service-5">
                            <div class="service-icon">
                                <i class="fa fa-wechat"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Chatting</h3>
                                   <p>In Monana, we organized a forum for communication among members.
You can chat or chat with each other. After attending the party, you can chat with the group.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#services -->

        <div class="content-section" id="portfolio">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>파티 인기순</h2>
                        <p>Amazing party for our clients</p>
                    </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                    <!-- <div class="portfolio-item col-md-3 col-sm-6"> -->
                    <div class="portfolio-item col-md-12">
                        <div class="portfolio-thumb">
                            <!-- <img src="/resources/css/index/images/gallery/p1.jpg" alt=""> -->
                            <div id="pimg1"></div>
                            <div class="portfolio-overlay">
                                <!-- <h3>New Walk</h3> -->
                                <div id="pname1"></div>
                                <!-- <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p> -->
                                <div id="paddr1"></div>
                                <!-- <a href="images/gallery/p1.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a> -->
                                <div id="pbutton1"></div>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <!-- <div class="portfolio-item col-md-3 col-sm-6"> -->
                    <div class="portfolio-item col-md-12">
                        <div class="portfolio-thumb">
                            <!-- <img src="images/gallery/p2.jpg" alt=""> -->
                            <div id="pimg2"></div>
                            <div class="portfolio-overlay">
                                <!-- <h3>Boat</h3> -->
                                <div id="pname2"></div>
                               <!--  <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p> -->
                               <div id="paddr2"></div>
                                <!-- <a href="images/gallery/p2.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a> -->
                                <div id="pbutton2"></div>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <!-- <div class="portfolio-item col-md-3 col-sm-6"> -->
                    <div class="portfolio-item col-md-12">
                        <div class="portfolio-thumb">
                            <!-- <img src="images/gallery/p7.jpg" alt=""> -->
                            <div id="pimg3"></div>
                            <div class="portfolio-overlay">
                                <!-- <h3>Urban</h3> -->
                                <div id="pname3"></div>
                                <!-- <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p> -->
                                <div id="paddr3"></div>
                                <!-- <a href="images/gallery/p7.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a> -->
                                <div id="pbutton3"></div>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#portfolio -->

	
		<div class="content-section" id="portfolio">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>최근 등록된 후기</h2>
                        <p>Recent HOT review for our clients</p>
                    </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                    <!-- <div class="portfolio-item col-md-3 col-sm-6"> -->
                    <div class="portfolio-item col-md-12">
                        <div class="portfolio-thumb">
                            <!-- <img src="/resources/css/index/images/gallery/p1.jpg" alt=""> -->
                            <div id="rimg1"></div>
                            <div class="portfolio-overlay">
                                <!-- <h3>New Walk</h3> -->
                                <div id="rname1"></div>
                                <!-- <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p> -->
                                <div id="rfname1"></div>
                                <div id="rhash1"></div>
                                <!-- <a href="images/gallery/p1.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a> -->
                                <div id="rbutton1"></div>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <!-- <div class="portfolio-item col-md-3 col-sm-6"> -->
                    <div class="portfolio-item col-md-12">
                        <div class="portfolio-thumb">
                            <!-- <img src="images/gallery/p2.jpg" alt=""> -->
                            <div id="rimg2"></div>
                            <div class="portfolio-overlay">
                                <!-- <h3>Boat</h3> -->
                                <div id="rname2"></div>
                                <div id="rfname2"></div>
                                <div id="rhash2"></div>
                               <!--  <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p> -->
                                <!-- <a href="images/gallery/p2.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a> -->
                                <div id="rbutton2"></div>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <!-- <div class="portfolio-item col-md-3 col-sm-6"> -->
                    <div class="portfolio-item col-md-12">
                        <div class="portfolio-thumb">
                            <!-- <img src="images/gallery/p7.jpg" alt=""> -->
                            <div id="rimg3"></div>
                            <div class="portfolio-overlay">
                                <!-- <h3>Urban</h3> -->
                                <div id="rname3"></div>
                                <div id="rfname3"></div>
                                <div id="rhash3"></div>
                                <!-- <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p> -->
                                <!-- <a href="images/gallery/p7.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a> -->
                                <div id="rbutton3"></div>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#portfolio -->
        

        <!-- <div class="content-section" id="our-team">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>후기 평점 높은 축제</h2>
                        <p>Our reviews are very united for your choice</p>
                    </div> /.heading-section
                </div> /.row
                <div class="row">
                    <div class="team-member col-md-3 col-sm-6">
                        <div class="member-thumb">
                            <img src="/resources/css/index/images/member1.jpg" alt="">
                            <div  id="rimg1"></div>
                            <div class="team-overlay">
                                <h3>Tracy</h3>
                                <div  id="rname1"></div>
                                <span>Designer</span>
                               <div id="rcount1"></div>
                                <ul class="social">
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                </ul>
                            </div> /.team-overlay
                        </div> /.member-thumb
                    </div> /.team-member
                    <div class="team-member col-md-3 col-sm-6">
                        <div class="member-thumb">
                            <img src="images/member2.jpg" alt="">
                            <div  id="rimg2"></div>
                            <div class="team-overlay">
                                <h3>Cindy</h3>
                                 <div  id="rname2"></div>
                                <span>Developer</span>
                                <div id="rcount2"></div>
                                <ul class="social">
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                </ul>
                            </div> /.team-overlay
                        </div> /.member-thumb
                    </div> /.team-member
                    <div class="team-member col-md-3 col-sm-6">
                        <div class="member-thumb">
                            <img src="images/member3.jpg" alt="">
                            <div  id="rimg3"></div>
                            <div class="team-overlay">
                                <h3>Mary</h3>
                                <div  id="rname3"></div>
                                <span>Director</span>
                                <div id="rcount3"></div>
                                <ul class="social">
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                </ul>
                            </div> /.team-overlay
                        </div> /.member-thumb
                    </div> /.team-member
                    <div class="team-member col-md-3 col-sm-6">
                        <div class="member-thumb">
                            <img src="images/member4.jpg" alt="">
                            <div class="team-overlay">
                                <h3>Linda</h3>
                                <span>Chief Executive</span>
                                <ul class="social">
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                </ul>
                            </div> /.team-overlay
                        </div> /.member-thumb
                    </div> /.team-member
                </div> /.row
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="skills-heading">
                            <h3 class="skills-title">Design Skills</h3>
                            <p class="small-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                        </div>
                    </div> /.col-md-12
                </div> /.row
                <div class="row">
                    <div class="col-md-8 col-sm-6">
                        <p>Aliquam faucibus in dolor sed vestibulum. Sed adipiscing malesuada luctus. Morbi tincidunt, tellus scelerisque scelerisque scelerisque, sapien dui pretium augue, at consectetur sapien tellus vitae nunc. Ut vitae metus quis nulla cursus adipiscing pretium vel dolor. Fusce lacinia accumsan arcu, quis porttitor nisi tincidunt ut. Nunc malesuada nunc eget nunc sollicitudin posuere. Maecenas vitae tortor quis odio hendrerit sagittis.<br><br>
						Etiam tincidunt, magna eu elementum tristique, sapien nisl venenatis lacus, nec sagittis lectus dui eget lorem. Donec in tempus mi. Aenean egestas interdum dolor, et mollis lectus consequat. Mauris ullamcorper, felis sit amet gravida malesuada, nisi sem rhoncus massa, non tempor est erat sit amet diam.spacing for mobile viewing<br><br>
						</p>
                    </div> /.col-md-8
                    <div class="col-md-4 col-sm-6">
                        <ul class="progess-bars">
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width: 90%;">Photoshop 90%</div>
                                </div>
                            </li>
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%;">HTML CSS 80%</div>
                                </div>
                            </li>
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">Development 70%</div>
                                </div>
                            </li>
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%;">Marketing 80%</div>
                                </div>
                            </li>
                        </ul>
                    </div> /.col-md-4
                </div> /.row
            </div> /.container
        </div> /#our-team -->

        <!-- <div class="content-section" id="contact">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>Contact</h2>
                        <p>Send a message to us</p>
                    </div> /.heading-section
                </div> /.row
                <div class="row">
                    <div class="col-md-12">
                       <div class="googlemap-wrapper">
                            <div id="map_canvas" class="map-canvas"></div>
                        </div> /.googlemap-wrapper
                    </div> /.col-md-12
                </div> /.row
                <div class="row">
                    <div class="col-md-7 col-sm-6">
                        <p>Flex is a Bootstrap v3.1.1 HTML CSS web template by <span class="blue">template</span><span class="green">mo</span>. Slider images and portfolio images are from <a rel="nofollow" href="http://unsplash.com" target="_parent">Unsplash</a> website. Thank you for visiting. Please tell your friends about templatemo.<br><br>
                        Hic, suscipit, praesentium earum quod ea distinctio impedit ullam deserunt minus dolore quibusdam quis saepe aliquam doloribus voluptatibus eum excepturi. Aenean semper erat neque. Nunc et scelerisque nunc, in adipiscing magna.<br><br>
				    Duis ullamcorper tortor tellus. Ut diam libero, ultricies non augue a, mollis congue risus. Fusce a quam eget nisi luctus imperdiet. Consectetur quod at aperiam corporis totam. Nesciunt minima laborum sapiente totam facere unde est cum quia. 
                    	</p>
                        <ul class="contact-info">
                            <li>Phone: 033-033-0660</li>
                            <li>Email: <a href="mailto:info@company.com">info@company.com</a></li>
                            <li>Address: 880 De Best Studio, Fork Street, San Francisco</li>
                        </ul>
                        spacing for mobile viewing<br><br>
                    </div> /.col-md-7
                    <div class="col-md-5 col-sm-6">
                        <div class="contact-form">
                            <form method="post" name="contactform" id="contactform">
                                <p>
                                    <input name="name" type="text" id="name" placeholder="Your Name">
                                </p>
                                <p>
                                    <input name="email" type="text" id="email" placeholder="Your Email"> 
                                </p>
                                <p>
                                    <input name="subject" type="text" id="subject" placeholder="Subject"> 
                                </p>
                                <p>
                                    <textarea name="comments" id="comments" placeholder="Message"></textarea>    
                                </p>
                                <input type="submit" class="mainBtn" id="submit" value="Send Message">
                            </form>
                        </div> /.contact-form
                    </div> /.col-md-5
                </div> /.row
            </div> /.container
        </div> /#contact -->
            
        <div id="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-xs-12 text-left">
                        <span>Copyright &copy; 2014 Codebrew Moana</span>
                  </div> <!-- /.text-center -->
                    <div class="col-md-4 hidden-xs text-right">
                        <a href="#top" id="go-top">Back to top</a>
                    </div> <!-- /.text-center -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#footer -->
        
        <script src="/resources/css/index/js/vendor/jquery-1.11.0.min.js"></script>
        <script>window.jQuery || document.write('<script src="/resources/css/index/js/vendor/jquery-1.11.0.min.js"><\/script>')</script>
        <script src="/resources/css/index/js/bootstrap.js"></script>
        <script src="/resources/css/index/js/plugins.js"></script>
        <script src="/resources/css/index/js/main.js"></script>

        <!-- Google Map -->
        <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
        <script src="/resources/css/index/js/vendor/jquery.gmap3.min.js"></script>
        
        <!-- Google Map Init-->
        <script type="text/javascript">
            jQuery(function($){
                $('#map_canvas').gmap3({
                    marker:{
                        address: '37.769725, -122.462154' 
                    },
                        map:{
                        options:{
                        zoom: 15,
                        scrollwheel: false,
                        streetViewControl : true
                        }
                    }
                });

                /* Simulate hover on iPad
                 * http://stackoverflow.com/questions/2851663/how-do-i-simulate-a-hover-with-a-touch-in-touch-enabled-browsers
                 --------------------------------------------------------------------------------------------------------------*/ 
                $('body').bind('touchstart', function() {});
            });
        </script>
        <!-- templatemo 406 flex -->
	
</body>

</html>