<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <%-- <c:if test="${ ! empty user }">
 	<jsp:forward page="/festival/getFestivalListDB?menu=db"/>
 </c:if> --%>



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

	<script type="text/javascript">
	
	/* $(document).ready(function() {
				 
					$.ajax( 
							{
								url : "/festivalRest/json/getInitListDB",
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(jsonData , status) {
									
									for(var i = 0 ; i<3; i++){
										
									var festivalName =  jsonData.list[i].festivalName;	
									var festivalImage = jsonData.list[i].festivalImage
									var festivalNo = jsonData.list[i].festivalNo
									var startDate = jsonData.list[i].startDate
									var endDate = jsonData.list[i].endDate
									var addr = jsonData.list[i].addr
									
									}
									
									$("#festivalName0").text(jsonData.list[0].festivalName);
									$("#image0").attr("src",jsonData.list[0].festivalImage);
									$("#festivalNo0 > p").text(jsonData.list[0].festivalNo);
									$("#date0").text(jsonData.list[0].startDate + " ~ " + jsonData.list[0].endDate);
									$("#addr0").text(jsonData.list[0].addr);
									$("c").attr("test",jsonData.list[0].festivalImage +".contains('http://')==false");
									$(".first-slide").attr("src",jsonData.list[0].festivalImage);
									$("#tag0 > div > p").text(jsonData.list[0].festivalNo);
									$("#tag0").val(jsonData.list[0].festivalNo);
									
									
									$("#festivalName1").text(jsonData.list[1].festivalName);
									$("#image1").attr("src",jsonData.list[1].festivalImage);
									$("#festivalNo1 > p").text(jsonData.list[1].festivalNo);
									$("#date1").text(jsonData.list[1].startDate + " ~ " + jsonData.list[1].endDate);
									$("#addr1").text(jsonData.list[1].addr);
									$(".second-slide").attr("src",jsonData.list[1].festivalImage);
									$("#tag1 > div > p").text(jsonData.list[1].festivalNo);
									$("#tag1").val(jsonData.list[1].festivalNo);
									
									$("#festivalName2").text(jsonData.list[2].festivalName);
									$("#image2").attr("src",jsonData.list[2].festivalImage);
									$("#festivalNo2 > p").text(jsonData.list[2].festivalNo);
									$("#date2").text(jsonData.list[2].startDate + " ~ " + jsonData.list[2].endDate);
									$("#addr2").text(jsonData.list[2].addr);
									$(".third-slide").attr("src",jsonData.list[2].festivalImage);
									$("#tag2 > div > p").text(jsonData.list[2].festivalNo);
									$("#tag2").val(jsonData.list[2].festivalNo);
									
									fncGetWebSearch();
									
									
								}
				});
	});
 
 function fncGetWebSearch() {
		$(function() {
			
			var festivalName0 = $("#festivalName0").text();
			var festivalName1 = $("#festivalName1").text();
			var festivalName2 = $("#festivalName2").text();
		
			 $.ajax( 
					 {
						url : "/festivalRest/json/kakaoWeb?festivalName0="+festivalName0+"&festivalName1="+festivalName1+"&festivalName2="+festivalName2,
						method : "GET",
						success : function(jsonData , status) {
						
					if(jsonData.url0!=null){
						 $("#iframe").attr("src","//www.youtube.com/embed/"+jsonData.url0 + "?autoplay=1&rel=0");
						 
					}else if(jsonData.url1!=null){
						 $("#iframe").attr("src","//www.youtube.com/embed/"+jsonData.url1 + "?autoplay=1&rel=0");
						 
					}else if(jsonData.url2!=null){
						 $("#iframe").attr("src","//www.youtube.com/embed/"+jsonData.url2 + "?autoplay=1&rel=0");
					}else{
						 $("#iframe").attr("src","//www.youtube.com/embed/8Nzvfks800c?autoplay=1&rel=0");
					}
				}
			});
	});
}
	 */
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
	   
	/*    $(function(){
			$("input:search[name='searchKeyword']").on('keydown',function(event){
				
				if(event.keyCode ==13){
					event.preventDefault();
					$( "#search"  ).click();
				}
			});
		
		}); */
	   
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
	   
	    $(function(){
		   $("button:contains('상세보기')").on("click",function(){
				
			   var festivalNo = $(this).val();
			   
			   /* var festivalNo = $("#festivalNo").val(); */
			   
			   self.location="/festival/getFestivalDB?festivalNo="+festivalNo;
		   });
	   });
	    
</script>


<style type="text/css">

	body {
            padding-top : 50px;
            padding-left : 50px;
            /* color: #3b3b3b; */
            /* background-color: #E0E0F8; */
    }
	

  /* .carousel-inner > .item > img {
  
      min-width: 100%;
      min-height: 100%;
    
    } */
    
        .carousel-inner > .item > img {
      top: 0;
      left: 0;
      min-width: 100%;
      min-height: 100%;
    } 
    
    #myCarousel, .carousel-inner{
           height : 400x;
    }
    
   .form-control{
   	width: 600px;
   	height: auto;
   }
   
	.video-container { margin: 0;padding-bottom: 75%; max-width: 100%; height: 0; position: relative;overflow: hidden;} 
	.video-container iframe, 
	.video-container object, 
	.video-container embed { margin: 0;padding: 0; width: 100%; height: 45%;position: absolute; top: 0;left: 0; }
    
    
   /*  .glyphicon-search{
    	font-size: 1.5em;
    } */
    
/*      .page-header {
    	border-bottom : 1px solid #f2f4f6;
    } */
    
    img.bg {
	min-height: 100%;
	min-width: 1024px;
	width: 100%;
	height: auto;
	position: fixed;
	top: 0;
	left: 0;
}

/* input{
	
}

.text-stroke {
  -moz-text-stroke: 1px #000;
  -webkit-text-stroke: 1px #000;
}

     */
    
    
    

</style>



<title>Moana</title>
</head>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

<!-- <body onload="fncGetWebSearch();"> -->
<!-- <body background="./resources/image/ui/2.gif"> -->
<body>

<!-- 	<img class="bg" src="./resources/image/ui/9.jpg" />
	 -->
	
	
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
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
<!-- </div> -->
	
	
		
	<!-- <div class="container"> -->
	
<%-- 	<div class="col-md-16">
		<div class="col-md-offset-2 col-md-8">		
			<div class="page-header text-center">
				<div class="input-group text-center">
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					<input type="hidden" id="festivalNo" name="festivalNo" value=""/>
					<input class="form-control  input-lg" id="searchKeyword" name="searchKeyword" type="text" 
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
</div> --%>
		
		
		
<!-- 		<header>
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
				
				<h3 class="text-info"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span>&nbsp;&nbsp;축제정보</h3>
		
		
				</div>
			</div>
		</div>row
	</header> -->
		
				
<!-- 				carousel 
		
	<div class="container">
	
	<div class="row">
		<div class="col-md-offset-2 col-md-8">
			<div class="panel panel-default  text-center">
					<div class="panel-heading">
						<div class="col-md-12  text-center">
					  	<h3>
							<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
							<strong>인기축제</strong>
						</h3>
	
		
	      <div id="myCarousel" class="carousel slide" data-ride="carousel">
	        <ol class="carousel-indicators">
	          <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	          <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	          <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	        </ol>
	        
	        <div class="carousel-inner" role="listbox">
	           
	          <div class="item active">
	          
	      		<label for="item">
	      		</label>  
	            <img class="first-slide" src="" alt="First slide"  style="width : 600px; height : 400px;"  title="Click Images">
	            <div class="carousel-caption" >
	            
	            data 삽입태그
	            <h1 class="glyphicon glyphicon-eye-open" id="festivalName0" aria-hidden="true"></h1><br/>
	            <h4 class="glyphicon glyphicon-map-marker" id="addr0" aria-hidden="true"></h4><br/>
	            <h4 class="glyphicon glyphicon-calendar" id="date0"></h4><br/>
	            <button type="button" id="tag0" data-loading-text="Loading..." class="btn btn-primary" value="">상세보기</button>
	            <div style=diplay:none>
	            <p></p>
	            </div>
	            
            
	        <div class="container">
	          		</div>
	          		</div>
	          		</div>
	          <div class="item">
	          <label for="item">
	      		</label>  
	            <img class="second-slide" src="" alt="Second slide"  style="width : 600px; height : 400px;" title="Click Images" >
	            <div class="container">
	            <div class="carousel-caption">
	            
	            data 삽입태그
	            <h1 class="glyphicon glyphicon-eye-open" id="festivalName1" aria-hidden="true"></h1><br/>
	            <h4 class="glyphicon glyphicon-map-marker" id="addr1" aria-hidden="true"></h4><br/>
	            <h4 class="glyphicon glyphicon-calendar" id="date1"></h4><br/>
	            <div>
	            <button type="button" id="tag1" data-loading-text="Loading..." class="btn btn-primary" value="">상세보기</button>
	            <p></p>
	            </div>
	          		</div>
	          		</div>
	          		</div>
	          <div class="item">
	          <label for="item">
	      		</label>  
	            <img class="third-slide" src="" alt="Third slide" style="width : 600px; height : 400px;" title="Click Images" >
	            <div class="container">
	            <div class="carousel-caption">
	            
	            data 삽입태그
	            <h1 class="glyphicon glyphicon-eye-open" id="festivalName2" aria-hidden="true"></h1><br/>
	            <h4 class="glyphicon glyphicon-map-marker" id="addr2" aria-hidden="true"></h4><br/>
	            <h4 class="glyphicon glyphicon-calendar" id="date2"></h4><br/>
	            <div>
	            <button type="button" id="tag2" data-loading-text="Loading..." class="btn btn-primary" value="">상세보기</button>
	            <p></p>
	            </div>
	          		</div>
	          		</div>
	          		</div>
	          		</div>
	        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	          <span class="sr-only">Previous</span>
	        </a>
	        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	          <span class="sr-only">Next</span>
	        </a>
	      </div>
	      
	      </div>
	      </div>
	      </div>
	      </div>
	      </div> -->
      
 <!--    
      <div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
				  <div class="panel-body text-center">
				  	<div class="col-md-12">
					  	<h3>
							<span class="glyphicon glyphicon-play" aria-hidden="true"></span>
							<strong>축제소개영상</strong>
						</h3>
						<br/>
				  
      fncGetWebSearch....
				       <div class="video-container">
					  		 <iframe id = "iframe" width="100%" height="350" src="" frameborder="0" allowfullscreen ></iframe>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
 -->			
	
	
	
	
	
	<!-- </div> -->
      
      
      
      
      
    <!-- carousel 끝 -->
<a href = "/view/user/oldGetMyPage.jsp">예전 마이페이지</a>
<br>
<br>
<a href = "/view/user/loginNew.jsp">로그인</a>
<br>
<br>
<a href = "/view/user/getMyPageNew2.jsp">마이페이지2</a>
<br>
<br>
<a href="/view/user/getMyPageNew3.jsp">마이페이지3</a>
<br>
<br>
<a href = "http://127.0.0.1:8080/view/user/toolbar2.jsp">툴바테스트</a>
<br>
<br>
<a href="/view/user/getProfile.jsp">다른프로젝트조</a>
<br>
<br>
<a href="/view/user/twitter.jsp">트위터 형식</a>
<br>
<br>
<br>
<br>

  
</body>

</html>