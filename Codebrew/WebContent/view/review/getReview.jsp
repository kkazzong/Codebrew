<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	 
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
 		body {
            padding-top : 50px;
            background-color: #f2f4f6;
        }
        
       	#carouselActive {
        	width: 900px;
        	height: 600px;
        	display: block;
        	margin-left: auto;
        	margin-right: auto;
        }
        
        #carouselInactive {
        	width: 900px;
        	height: 600px;
        	display: block;
        	margin-left: auto;
        	margin-right: auto;
        }
        
        video {
        	width: 600px;
        	height: 600px;
        	display: block;
        	margin-left: auto;
        	margin-right: auto;
        }
        
	</style>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- Load the Google API -->
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDvESicBSzYYtr3_xNOvik6YvE4v6UxPOQ"></script>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncAddReply() {
		
		//Form 유효성 검증
		var replyDetail = $("input[name='replyDetail']").val();
		
		if(replyDetail == null || replyDetail.length < 1){
			alert("댓글내용을 입력한 후에 등록할 수 있습니다.")
			return;
		}
		$("form").attr("method", "POST").attr("action", "/reply/addReply").submit();
	}
	
	//맵 1단 : 맵을 초기화해주기 위한 함수 : test 중
	var map_x = null;
	var map_y = null;
	function initialize() {
		//초기화 함수 안에, 맵의 속성(properties)을 정의할 객체(mapProp)를 생성한다
		//center 속성 : 맵의 중심을 어디로 할지
		//LatLng객체를 생성하여 특정포인트를 정한다.
		//zoom 속성은 맵에서의 줌 레벨을 정의한다.
		//mapTypeID 속성은 화면에 표시될 맵 타입을 정의한다.
			
			// Roadmap(normal, default 2D map)
			// Satellite(photographic map)
			// Hybrid(photographic map + roads and city names)
			// Terrain(map with mountains, rivers, etc.)
		
		var mapOptions = {
							zoom:16,
							mapTypeId:google.maps.MapTypeId.ROADMAP
						};

		//id가 'googleMap'인 <div> 태그 안에 새로운 맵을 만드는 코드이다. 파라미터인 mapProp를 이용한다.
		var map = new google.maps.Map(document.getElementById("googleMap"), mapOptions);
		/* 
		var size_x = 40; //마커로 사용할 이미지의 가로 크기
		var size_y = 40; //마커로 사용할 이미지의 세로 크기
		
		//마커로 사용할 이미지 주소
		var iconImage = new google.maps.MarkerImage(
												'../../resources/image/monster.png', 
												new google.maps.Size(size_x, size_y),
                                                '',
                                                '', 
                                                new google.maps.Size(size_x, size_y)
												);
		 */										
		
		//Geocoding start*********************
		//alert($('#addrIdForGoogleMap').html());
		//alert($('#festivalNameIdForGoogleMap').html());
		
		var address = $('#addrIdForGoogleMap').html(); //tag에서 받아오는 주소
		var marker = null;
        var geocoder = new google.maps.Geocoder(); //google map의 Geocoder 객체 생성
        geocoder.geocode( { 'address': address}, function(results, status) {
        	if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                marker = new google.maps.Marker({
                                map: map,
                                icon: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png', // 마커로 사용할 이미지(변수 or URL)
                                title: address, // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
                                position: results[0].geometry.location
                            });
                
                map_x = results[0].geometry.location.lng(); //밑에서 쓰기위해서 선언해준 변수에 값을 대입
                map_y = results[0].geometry.location.lat(); //밑에서 쓰기위해서 선언해준 변수에 값을 대입
                
				var content = $('#festivalNameIdForGoogleMap').html()+"<br/><br/>"+"좋아요 : "+$('#goodCountForGoogleMap').html()+"<br/><br/>"+"축제평점 : "+$('#reviewFestivalRatingForGoogleMap').html(); // 말풍선 안에 들어갈 내용
				
            	 // 마커를 클릭했을 때의 이벤트. 말풍선 뿅~
                var infowindow = new google.maps.InfoWindow({ content: content});
                google.maps.event.addListener(marker, "click", function() {infowindow.open(map,marker);});
            } else {
                alert("Geocode was not successful for the following reason: " + status);
            }
			
        	//ODSayAPI 요청 ajax
           	//console.log(map_x);
           	//console.log(map_y);
        	
     	    //대중교통정보 불러오기 ajax
    		$(function(){
    			 
   				$.ajax(
   						{
   							url : "/reviewRest/json/getTransportListAtStation/"+map_x+"/"+map_y+"/"+"350", 
   							method : "GET", 
   							dataType : "json", 
   							headers : {
   								"Accept" : "application/json", 
   								"Content-Type" : "application/json"
   							}, 
   							success : function(JSONData, status){
   								//alert(status);
   								//console.log(JSONData.busNoList);
   								//console.log(JSONData.stationNameList);
   								//console.log(JSONData.stationIDList);
   								//console.log(JSONData.subwayList);
   								var str = "";
   								for(var i = 0; i < JSONData.busNoList.length; i ++) {
   									str += JSONData.busNoList[i]+", ";
   								}
   								for(var i = 0; i < JSONData.subwayList.length; i++) {
   									str += JSONData.subwayList[i]+", ";
   								}
   								str = str.substr(0, str.length-2);
   								$("#transportListAtStation").html(str);
   							}
   						}		
   				)
    			
    		});
           	
        	
        });
		//Geocoding end*********************

	}
	google.maps.event.addDomListener(window, 'load', initialize);
	
	
	/* 교통정보 API 이용
	function fncPointSearch() {
		
		console.log("x : "+map_x);
		console.log("y : "+map_y);
		
		var xhr = new XMLHttpRequest();
		var url = "https://api.odsay.com/api/pointSearch?x="+map_x+"&y="+map_y+"&radius=250"+"&apiKey=9Y8umSFLTjBabpZyQD9MSJZ/GpAV/XJrRHAGwBVmguw";
		console.log("requestURL : "+url);
		
		xhr.open("GET", url, true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				console.log( xhr.responseText ); // <- xhr.responseText 로 결과를 가져올 수 있음
			}
		}
	}
	 */
	
	
	//Event 걸어주기
	$(function() {
		
		 $( "#getReviewList" ).on("click" , function() { //ok
			 self.location = "/review/getReviewList"
		});
		 
		 $( "#getCheckReviewList" ).on("click" , function() {
			self.location = "/review/getCheckReviewList?role=${session.user.role}"
		});
		
		 $( "#updateReview" ).on("click" , function() {
			self.location = "/review/updateReview?reviewNo=${review.reviewNo}"
		});
		 
		$( "#passCheckCode" ).on("click" , function() {
			self.location = "/review/passCheckCode?reviewNo=${review.reviewNo }";				
		});
		 
		 $( "#failCheckCode" ).on("click" , function() {
			self.location = "/review/failCheckCode?reviewNo=${review.reviewNo }";
		});
		 
		 $("#testButtonForTransport").on("click", function(){
			 fncPointSearch();
		 });
		 
		/* 
		$( "#addGood" ).on("click", function() { //수정중
			self.location = "/review/addGood?userId=${sessionScope.user.userId}&reviewNo=${review.reviewNo}";
		}); 
		 */
		 
		/* var reviewNo = document.getElementById('reviewNo').getAttribute('value');
		console.log(reviewNo); */
		
		//addGood ajax
		$(function(){
			
			$("#addGood").on("click", function(){
				$.ajax(
						{
							url : "/reviewRest/json/addGood/${sessionScope.user.userId}/${review.reviewNo}", 
							method : "GET", 
							dataType : "json", 
							headers : {
								"Accept" : "application/json", 
								"Content-Type" : "application/json"
							}, 
							success : function(JSONData, status){
								$("#goodCountForGoogleMap").html(JSONData.goodCount);
							}
						}		
				)
			})
			
		});
	 
	});
	
</script>

</head>

<body>

	<jsp:include page="../../toolbar/toolbar.jsp" />
	
	<input type="hidden" name="reviewNo" value="${review.reviewNo }">
	<input type="hidden" id="location_x" value="">
	<input type="hidden" id="location_y" value="">
   	
   	<!-- 후기상세조회 화면구성 div Start -->
   	<div class="container">

		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
		   		<div class="page-header text-center">
		   			<h3 class="text-info">후기상세조회</h3>
		   			<h5 class="text-muted">후기 정보를 <strong class="text-danger">내놓으시길</strong>바랍니다.</h5>
		   			<!-- 
		   			<span class = "glyphicon glyphicon-road" id = "testButtonForTransport" role="button"></span>
		   			 -->
		   		</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
			<!-- <div class="col-md-12"> -->
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title text-center">후기제목 : ${review.reviewTitle }</h3>
					</div>
					<div class="panel-body">
						<%--  
						이렇게 하면 1번째 이미지 들어간다
						<img width="100%" height="300" src="/resources/uploadFile/${review.reviewImageList[0].reviewImage }"> 
						 --%>
						<!-- Carousel ex Start -->
						
						<c:if test="${!empty review.reviewImageList }">
						<div id="myCarousel" class="carousel slide" data-ride="carousel">
						<!-- Indicators -->
							<ol class="carousel-indicators">
							<c:set var="i" value="0"/>
								<li data-target="#myCarousel" data-slide-to="${0 }" class="active"></li>
				  			<c:forEach begin="1" var="imageListforIndex" items="${review.reviewImageList}">
								<li data-target="#myCarousel" data-slide-to="${i }"></li>
							</c:forEach>
							</ol>
							<!-- Wrapper for slides -->
							<div class="carousel-inner" role="listbox">
							<c:set var="i" value="0"/>
								<div class="item active">
									<img src="/resources/uploadFile/${review.reviewImageList[0].reviewImage }" id="carouselActive">
								</div>
							<c:forEach var="imageList" begin="1" items="${review.reviewImageList }">
								<div class="item">
									<img src="/resources/uploadFile/${imageList.reviewImage }" id="carouselInactive">
								</div>
							</c:forEach>
							</div>
							
							<!-- Left and right controls -->
							<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
						</c:if>
						<!-- 
						<c:if test="${!empty review.reviewImageList }">
							<c:forEach var="imageList" items="${review.reviewImageList }">
							<c:set var="i" value="${i+1 }"/>
							<img width="100%" height="300" src="/resources/uploadFile/${imageList.reviewImage}">					
							</c:forEach>
						</c:if>
						 -->
						<!-- Carousel End -->
						<hr>
						<div class="col-md-12">
							<strong>
								<span>축제명 : </span>
								<span id="festivalNameIdForGoogleMap">${review.festivalName }</span>
							</strong>
						</div>
						<c:if test="${sessionScope.user.userId == review.userId || sessionScope.user.role == 'a'}">
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-flag" aria-hidden="true"></span>
								후기상태 : 
								<c:if test="${review.checkCode == '1' || review.checkCode == '11' }">
									심사중									
								</c:if>
								<c:if test="${review.checkCode == '2' || review.checkCode == '22' }">
									통과
								</c:if>
								<c:if test="${review.checkCode == '4' || review.checkCode == '44' }">
									반려									
								</c:if>
							</small>
						</div>
						</c:if>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-time" aria-hidden="true">작성일시:</span>
								<span id="reviewRegDateIdForJS">${review.reviewRegDate }</span>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-user" aria-hidden="true">작성자:</span>
								<span id="writerIdForJS">${review.userId }</span>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true">축제장소:</span>
								<span id="addrIdForGoogleMap">${review.addr }</span>
							</small>
						</div>
						<!-- 지도추가된부분 -->		
						<div class="col-md-12" id="googleMap" style="width:100%;height:380px;"></div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-road" aria-hidden="true">대중교통:</span>
								<span id="transportListAtStation">교통정보 불러오는 중...</span>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-dashboard" aria-hidden="true">축제평점:</span>
								<span id="reviewFestivalRatingForGoogleMap">${review.reviewFestivalRating }</span>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-heart-empty" aria-hidden="true">좋아요:</span>
								<span id="goodCountForGoogleMap">${review.goodCount }</span>
								<c:if test="${!empty sessionScope.user }">
									<span class = "glyphicon glyphicon-thumbs-up" id = "addGood" role="button"></span>
								</c:if>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-book" aria-hidden="true">후기내용:</span>
								<span id="reviewDetailForJS">${review.reviewDetail }</span>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-tags" aria-hidden="true">해시태그:</span>
								<span id="reviewHashtagForJS">${review.reviewHashtag }</span>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-facetime-video" aria-hidden="true"></span>
									동영상
							</small>
							<c:if test="${!empty review.reviewVideoList[0].reviewVideo }">
								<c:set var="i" value="0"/>
					  			<c:forEach var="listV" items="${review.reviewVideoList}">
						   				<!-- 
						   				<video width="320" height="240" controls>
						   				 -->
						   				<video controls >
						   					<source src="/resources/uploadFile/${listV.reviewVideo}" type="video/mp4">
						   				</video>
					   			</c:forEach>
				   			</c:if>
				   			<c:if test="${empty review.reviewVideoList[0].reviewVideo }">
				   				동영상 없다~
				   			</c:if>
						</div>
						<hr>
						<div class="col-md-12">
							<small>
								<!-- button class 구분 ==>> 회원 : primary, Admin : default -->
								<!-- admin이 아니면서(일반회원 혹은 비회원이면서) 해당 후기 작성자와 조회한 사람이 동일인일 때, -->
						   		<c:if test="${sessionScoepe.user.role != 'a' && sessionScope.user.userId == review.userId}">
						   			<center>
						   				<button id = "updateReview" type="button" class="btn btn-primary">수정하기</button>
						   				<button id = "getReviewList" type="button" class="btn btn-primary">목록보기</button>
						   			</center>
								</c:if>
								<!-- admin이 아니면서(일반회원 혹은 비회원이면서) 해당 후기 작성자와 조회한 사람이 동일하지 않을 때 ==>> 가장 많은 경우 -->
						   		<c:if test="${sessionScope.user.role != 'a' && sessionScope.user.userId != review.userId}">
						   			<center>
							   			<button id = "getReviewList" type="button" class="btn btn-primary">목록보기</button>
						   			</center>
						   		</c:if>
						   		
						   		<!-- admin인 경우 & checkCode에 따라서 분류 -->
						   		<!-- admin이면서  해당 후기가 등록요청중인 후기 일 때 -->
						   		<c:if test="${sessionScope.user.role == 'a' && (review.checkCode == '1' || review.checkCode == '11')}">
						   			<center>
							   			<button id="passCheckCode" type="button" class="btn btn-success">
							   				통과(등록)
							   			</button>
							   			<button id="failCheckCode" type="button" class="btn btn-warning">
							   				반려(미등록)
							   			</button>
							   		</center>
						   		</c:if>
						   		<!-- admin이면서  해당 후기가 반려된 후기 혹은 통과된 후기(나머지 심사상태인 후기인 경우) 일 때-->
						   		<c:if test="${sessionScope.user.role =='a' }">
						   			<center>
						   				<button id = "updateReview" type="button" class="btn btn-info">수정하기</button>
							   			<button id = "getCheckReviewList" type="button" class="btn btn-info">심사목록보기</button>
							   			<button id = "getReviewList" type="button" class="btn btn-info">목록보기</button>
						   			</center>
						   		</c:if>
							</small>
							<br>
						</div>
						<div class="col-md-12">
							<small>
								<!-- ToolBar Start /////////////////////////////////////-->
								<jsp:include page="getReplyList.jsp" >
									<jsp:param name="reviewNo" value="${review.reviewNo }"/>
								</jsp:include>
							   	<!-- ToolBar End /////////////////////////////////////-->
							</small>
						</div>
					</div>
				</div>
			</div>
		</div>
   		
   	</div>
   	<!-- 화면구성 div End -->

</body>
</html>