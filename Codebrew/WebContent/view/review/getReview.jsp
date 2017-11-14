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
	
	<!-- 별점매기기 소스 start -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">
	<link href="../../resources/javascript/kartik-v-bootstrap-star-rating/css/star-rating.min.css" media="all" rel="stylesheet" type="text/css" />
	<script src="../../resources/javascript/kartik-v-bootstrap-star-rating/js/star-rating.min.js" type="text/javascript"></script>
	<!-- 이건 위에 있어서 혹시몰라 남겨둠...
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	별점매기기 소스 end -->
	 
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
		@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
 
		/* * {
			font-family: 'Nanum Pen Script', cursive;
			font-size: 22px;
		}
		
		html {
			font-family: 'Nanum Pen Script', cursive;
			font-size: 22px;
		} */
	
 		body {
            padding-top : 70px;
            background-color: #f2f4f6;
        }
        
        #getReviewMainImage {
        	
        }
        
       	#carouselActive {
       		width: -webkit-fill-available;
        	height: 600px;
        	display: block;
        	margin-left: auto;
        	margin-right: auto;
        }
        
        #carouselInactive {
       		width: -webkit-fill-available;
        	height: 600px;
        	display: block;
        	margin-left: auto;
        	margin-right: auto;
        }
        
        video {
        	width: 100%;
        	height: 500px;
        	display: block;
        	margin-left: auto;
        	margin-right: auto;
        	margin-top: -50px;
        }
        
        /* .btn-reply {
        	height: 25px;
        } */
        
        
	</style>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- Load the Google API -->
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDvESicBSzYYtr3_xNOvik6YvE4v6UxPOQ"></script>
    
    <!-- sweet alert -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.2/sweetalert2.all.min.js"></script>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script>
	
	
	//////////댓글include 없애면서 추가한 부분 start //////////
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
	   	$("form[name='searchForm']").attr("method" , "POST").attr("action" , "/review/getReview").submit(); //그냥...화면 흔들자
		//$("form[name='searchForm']").attr("method" , "POST").attr("action" , "/reply/getReplyList").submit(); //rest 로 하려다가...
	}
	
	function fncAddReply() {
		
		//Form 유효성 검증
		var replyDetail = $("input[name='replyDetailLogIn']").val();
		$("form[name='detailForm']").attr("method", "POST").attr("action", "/reply/addReply").submit();
	}
	
	/* function calculateDate(date){ //수정중 08112017
		//Date dateNow = Date.now();
		var timeOfReplyRegDate = $('.glyphicon-time').html(); //2017-11-04 12:
	} */
	
	
	$(function(){
		
		$('.clear-rating').css("display", 'none'); //참조용 : 이거 css 어거지로 집어 넣은거임...따라하지 마셈 : this css will be applied primarily 
		
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2. $(#id) : 3.$(.className)
		//==> 1과 3 방법 조합 : $("tagName.className:filter함수") 사용함.
		$("#searchReply").on("click", function(){
			fncGetList(1);
		});
		
		/* 이거 엔터가....nullString check가 안된다. ㅅㅂ
		$("#replyDetail").on("keydown", function(event){
			if(event.keyCode == '13'){
				fncAddReply();
			}
		});
		 */
		
		$("#addReply").on("click", function(){
			
			//alert("댓글등록 클릭");
			//alert($('#replyDetail').val());
			
			if($('#replyDetail').val() == null || $('#replyDetail').val() == ''){
				//alert('댓글 내용을 입력한 후에 댓글을 등록할 수 있습니다');
				swal({
					title: "오류", 
					text : "댓글 내용을 입력한 후에 댓글을 등록할 수 있습니다", 
					type : "error", 
				});
			} else {
				fncAddReply();
			}
		});
		
		/*
		$("#addReply").on("click", function(){

			if($("#replyDetail").val() == null || $("#replyDetail").val() == ''){
				
				alert("1. 댓글내용을 입력한 후에 댓글을 등록할 수 있습니다.");
				return;
				
			}else{
				
				$.ajax(
						{
							url : "/replyRest/json/addReply", 
							method : "POST", 
							headers : {
								"Accept" : "application/json", 
								"Content-Type" : "application/json"
							}, 
							data : JSON.stringify({
								userId : $("#userId").val(), 
								reviewNo : $("#reviewNo").val(), 
								replyDetail : $("#replyDetail").val()
							}), 
							datayType : "json", 
							success : function(JSONData, status){
								
								alert("1. 댓글 등록 ajax완료!!!!");
								console.log("JSONData.userId :: "+JSONData.userId+
											"\nJSONData.replyNo :: "+JSONData.replyNo+
											"\nJSONData.reviewNo :: "+JSONData.reviewNo+
											"\nJSONData.replyDetail :: "+JSONData.replyDetail+
											"\nJSONData.replyRegDate :: "+JSONData.replyRegDate);
								
								fncGetList(1);
								
								
								$.ajax(
										{
											url : "/replyRest/json/getReplyList", 
											method : "POST", 
											headers : {
												"Accept" : "application/json", 
												"Content-Type" : "application/json"
											}, 
											data : JSON.stringify({
												reviewNo : $("#reviewNo").val(), 
												search : null
											}), 
											dataType : "json", 
											success : function(JSONData, status){
												
												alert("2. 댓글 list를 불러오는 ajax 완료");
												console.log("JSONData :: "+JSONData);
												
											}
										}
										
								)
								
							}
						}
				)
				
			}
			
			
		})
		*/
		
		$(".btn-warning:contains('삭제')").on("click", function(){
			//alert("댓글삭제버튼클릭 :: replyNo :: "+$(this).val());
			self.location="/reply/deleteReply?replyNo="+$(this).val();
		});
		
		
		var tempReplyNo;
		var tempReviewNo;
		$(".btn-info:contains('수정')").on("click", function(){
			
			//alert("1 :: 댓글수정하기버튼클릭"); //debugging
			//alert("#updateReply${replyList.replyNo }");
			tempReplyNo = $(this).val();
			tempReviewNo = $("#reviewNo").val();
			
			//alert("임시reviewNo"+tempReviewNo);
			//alert("임시댓글번호"+tempReplyNo);
			
			$("#updateReply"+tempReplyNo).attr('style', 'display:none');
			$("#updateCompReply"+tempReplyNo).attr('style', 'display:inline');
			
			$("#replyDetail"+tempReplyNo).removeAttr("readonly")
			.focus()
			
			//alert("2 :: focusing 부분"); //debugging
			
		});
		
		//please...do not handle more than one event in one button.........fuxx
		$(".btn-info:contains('완료')").on("click", function(){
			
			//alert("3 :: 수정완료클릭 :: ajax 시작");
			
			$.ajax(
					{
						url : "/replyRest/json/updateReply", 
						method : "POST", 
						headers : {
							"Accept" : "application/json", 
							"Content-Type" : "application/json"
						}, 
						data : JSON.stringify({
							replyNo : tempReplyNo, 
							replyDetail : $("#replyDetail"+tempReplyNo).val()
						}),
						dataType : "json", 
						success : function(JSONData, status){
							//alert("4 :: ajax 완료"); //debugging
							$("#replyDetail"+tempReplyNo).val(JSONData.replyDetail);
							$("#replyDetail"+tempReplyNo).attr("readonly", true);
							
							//원상복귀....(보이는 건 다시 안보이게 & 안보이는건 다시 보이게)
							$("#updateCompReply"+tempReplyNo).attr('style', 'display:none');
							$("#updateReply"+tempReplyNo).attr('style', 'display:inline');
						}
					}
			)
			
		});
		
		
	});
	
	//////////댓글include 없애면서 추가한 부분 end //////////
	
	
	
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
   				
    			var defaultRadius = 350; //반경
    			
   				$.ajax(
   						{
   							url : "/reviewRest/json/getTransportListAtStation/"+map_x+"/"+map_y+"/"+defaultRadius, 
   							method : "GET", 
   							dataType : "json", 
   							headers : {
   								"Accept" : "application/json", 
   								"Content-Type" : "application/json"
   							}, 
   							success : function(JSONData, status){
   								
   								if(JSONData.busNoList.length != 0){
   									var busStr = "";
   									for(var i = 0; i < JSONData.busNoList.length; i++) {
   										busStr += JSONData.busNoList[i]+", ";
   									}
   									busStr = busStr.substr(0, busStr.length-2);
   								}
   								if(JSONData.subwayList.length != 0){
   									var subwayStr = "";
   									for(var i = 0; i < JSONData.subwayList.length; i++) {
   										subwayStr += JSONData.subwayList[i]+", ";
   									}
   									subwayStr = subwayStr.substr(0, subwayStr.length-2);
   								}
   								
   								if(JSONData.busNoList.length != 0 && JSONData.subwayList.length == 0) {
	   								$("#transportListAtStation").html("<br><img src=../../resources/images/transport/BlackBus.PNG width=24 height=24>"+"버스 : "+busStr);   									
   								}
   								if(JSONData.subwayList.length != 0 && JSONData.busNoList.length == 0) {
	   								$("#transportListAtStation").html("<br><img src=../../resources/images/transport/BlackSubway.PNG width=24 height=24>"+"지하철 : "+subwayStr);   									
   								}
   								if(JSONData.subwayList.length != 0 && JSONData.busNoList.length != 0) {
	   								$("#transportListAtStation").html("<br><img src=../../resources/images/transport/BlackBus.PNG width=24 height=24>"+"버스 : "+busStr+"<br>"+"<img src=../../resources/images/transport/BlackSubway.PNG width=24 height=24>"+"지하철 : "+subwayStr);   									
   								}
   								
   								if(JSONData.busNoList.length == 0 && JSONData.subwayList.length == 0){
   									$("#transportListAtStation").html("반경 "+defaultRadius+"m내에 관련 대중교통 정보가 없습니다.");
   								}
   								
   							}
   						}		
   				)
    			
    		});
           	
        	
        });
		//Geocoding end*********************

	}
	google.maps.event.addDomListener(window, 'load', initialize);
	
	
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
		
		$("#floatMarkerToCenter").on("click", function(){
			
			//alert("축제위치로 클릭");
			
			//맵 1단 : 맵을 초기화해주기 위한 함수 : test 중
			var map_x = null;
			var map_y = null;
				
			var mapOptions = {
								zoom:16,
								mapTypeId:google.maps.MapTypeId.ROADMAP
							};
			
			//alert("여기까지");

			//id가 'googleMap'인 <div> 태그 안에 새로운 맵을 만드는 코드이다. 파라미터인 mapProp를 이용한다.
			var map = new google.maps.Map(document.getElementById("googleMap"), mapOptions);
			
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
	        	
	        });
			//Geocoding end*********************

			google.maps.event.addDomListener(window, 'load', initialize);
			
		});
		
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
								
								if(JSONData.goodCount > $("#goodCountForGoogleMap").html()){
									swal({
										text: "'좋아요'가 추가되었습니다.", 
										type: "success", 
									});
									$("#forGetGoodLocation").html("<small>이미'좋아요'했는데~~~</small>");
									$("#goodCountForGoogleMap").html(JSONData.goodCount);
								}else{
									swal({
										text: "'좋아요'가 취소되었습니다.", 
										type: "error", 
									});
									$("#forGetGoodLocation").html("");
									$("#goodCountForGoogleMap").html(JSONData.goodCount);
								}
							}
						}		
				)
			})
			
		});
		
		$(function(){
			
			$("#searchAgainWithNewRadius").on("click", function(){
				
				var radiusForTransportSearchAgain = $("#radiusForTransportSearchAgain").val();
				//alert("변경된 반경 "+radiusForTransportSearchAgain+"으로 재검색 합니다.");
				swal({
					title: "재검색", 
					text: "변경된 반경 "+radiusForTransportSearchAgain+"으로 재검색 합니다.", 
					type: "info", 
				});
				
				$("#transportListAtStation").html("반경 "+radiusForTransportSearchAgain+"m로 재검색 중입니다.");
				
				$.ajax(
   						{
   							url : "/reviewRest/json/getTransportListAtStation/"+map_x+"/"+map_y+"/"+radiusForTransportSearchAgain, 
   							method : "GET", 
   							dataType : "json", 
   							headers : {
   								"Accept" : "application/json", 
   								"Content-Type" : "application/json"
   							}, 
   							success : function(JSONData, status){
   								
   								
   								if(JSONData.busNoList.length != 0){
   									var busStr = "";
   									for(var i = 0; i < JSONData.busNoList.length; i++) {
   										busStr += JSONData.busNoList[i]+", ";
   									}
   									busStr = busStr.substr(0, busStr.length-2);
   								}
   								if(JSONData.subwayList.length != 0){
   									var subwayStr = "";
   									for(var i = 0; i < JSONData.subwayList.length; i++) {
   										subwayStr += JSONData.subwayList[i]+", ";
   									}
   									subwayStr = subwayStr.substr(0, subwayStr.length-2);
   								}
   								
   								if(JSONData.busNoList.length != 0 && JSONData.subwayList.length == 0) {
	   								$("#transportListAtStation").html("<br><img src=../../resources/images/transport/BlackBus.PNG width=24 height=24>"+"버스 : "+busStr);   									
   								}
   								if(JSONData.subwayList.length != 0 && JSONData.busNoList.length == 0) {
	   								$("#transportListAtStation").html("<br><img src=../../resources/images/transport/BlackSubway.PNG width=24 height=24>"+"지하철 : "+subwayStr);   									
   								}
   								if(JSONData.subwayList.length != 0 && JSONData.busNoList.length != 0) {
	   								$("#transportListAtStation").html("<br><img src=../../resources/images/transport/BlackBus.PNG width=24 height=24>"+"버스 : "+busStr+"<br>"+"<img src=../../resources/images/transport/BlackSubway.PNG width=24 height=24>"+"지하철 : "+subwayStr);   									
   								}
   								
   								if(JSONData.busNoList.length == 0 && JSONData.subwayList.length == 0){
   									$("#transportListAtStation").html("반경 "+radiusForTransportSearchAgain+"m내에 관련 대중교통 정보가 없습니다.");
   								}
   								
   								
   							}
   						}		
   				)
			})
			
		});
	 
	});
	
	
	//내가 좋아요를 이미 눌렀는지 안눌렀는지...확인
	$(document).ready(function(){
		
		var tempUserIdForReadyFunc = "${sessionScope.user.userId}";
		
		if((tempUserIdForReadyFunc != "") && (tempUserIdForReadyFunc != null)){
			
			$.ajax(
					{
						url : "/reviewRest/json/getGood/${sessionScope.user.userId}/${review.reviewNo}", 
						method : "GET", 
						dataType : "json", 
						headers : {
							"Accept" : "application/json", 
							"Content-Type" : "application/json"
						}, 
						success : function(JSONData, status){
							
							if(tempUserIdForReadyFunc == JSONData.userId){
								$("#forGetGoodLocation").html("<small>이미'좋아요'했는데~~~</small>");
							}
						}
					}
				)
		}
	 
	});
	
</script>

</head>

<body>

	<jsp:include page="../../toolbar/toolbar.jsp" />
	
	<input type="hidden" name="reviewNo" value="${review.reviewNo }">
	<input type="hidden" id="location_x" value="">
	<input type="hidden" id="location_y" value="">
   	
   	<!-- 후기상세조회 화면구성 div Start -->
   	<!-- 
   	<div class="container">
	 -->
		<!-- page header start-->
		<header>
			<div class="row">
				<div class="col-md-offset-4 col-md-4">
			   		<div class="page-header text-center">
			   			<h2 class="text-info">
			   				<span class="glyphicon glyphicon-edit" aria-hidden="true">
			   					후기상세조회
			   				</span>
			   			</h2>
			   			<h4 class="text-muted">후기 정보를 <strong class="text-danger">내놓으시길</strong>바랍니다.</h4>
			   		</div>
				</div>
				<!-- row end -->
			</div>
		</header>
		<!-- page header end -->
		
		
		<div class="row" id="getReviewMainImage">
			<!-- <div class="col-md-12" id="getReviewMainImage"> -->
			<!-- <div class="col-md-12"> -->
				<%-- <div class="panel panel-default">
					<div class="panel-heading">
						<h1 class="panel-title text-center">후기제목 : ${review.reviewTitle }</h1> --%>
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
				<!-- 	</div>
				</div>
			</div> -->
		</div>
		
	<div class="container">
		
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
					<div class="panel-body text-center">
						<div class="col-md-12">
							<strong>
								<span>축제명 : </span>
								<span id="festivalNameIdForGoogleMap">${review.festivalName }</span>
							</strong>
						</div>
						
						<div class="com-md=12">
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
						</div>
						
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-calendar" aria-hidden="true">작성일시:</span>
								<span id="reviewRegDateIdForJS">${review.reviewRegDate }</span>
							</small>
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-user" aria-hidden="true">작성자:</span>
								<span id="writerIdForJS">${review.userId }</span>
							</small>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 지도 : 구글맵 -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
					<div class="panel-body text-center">
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-map-marker" aria-hidden="true">축제장소:</span>
								<span id="addrIdForGoogleMap">${review.addr }</span>
							</small>
							<small>
								<button class="btn btn-default btn-xs" id="floatMarkerToCenter">다시 축제위치로</button>
							</small>
						</div>
						<div class="col-md-12" id="googleMap" style="width:100%;height:380px;">
						</div>
						<div class="col-md-12">
							<small>
								<span class="glyphicon glyphicon-road" aria-hidden="true"> 대중교통정보</span>
								<span id="transportListAtStation">교통정보 불러오는 중...</span>
								<br>
								<input type="number" id="radiusForTransportSearchAgain" min="100" max="3000" value="350"/>
								<button type="button" class="btn btn-default btn-xs" id="searchAgainWithNewRadius">
									재검색
								</button>
								(default:350 min:100 max:3000)
							</small>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 축제에 대한 작성자가 제공하는 정보 -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
					<div class="panel-body text-center">
						<div class="col-md-12">
							<h3>
								<strong>축제후기</strong>
							</h3>
							<hr>
						</div>
						<div class="col-md-12 text-center">
							<span class="glyphicon glyphicon-dashboard" aria-hidden="true"> 축제평점</span>
						</div>
						<hr>
						<div class="col-md-12 text-middle">
							<input type="number" id="reviewFestivalRating" class="rating" name="reviewFestivalRating" value="${review.reviewFestivalRating }" data-min="0" data-max="5" data-step="1" data-size="xs" data-rtl="true" readonly>
							<hr>
						</div>
						<hr>
						<div class="col-md-12">
							<span id="forGetGoodLocation"></span>
							<br>
							<span class="glyphicon glyphicon-heart-empty" aria-hidden="true"> 좋아요 : </span>
							<span id="goodCountForGoogleMap">${review.goodCount }</span>
							<c:if test="${!empty sessionScope.user }">
								<h3>
									<span class = "glyphicon glyphicon-thumbs-up" id = "addGood" role="button"></span>
								</h3>
							</c:if>
							<hr>
						</div>
						<div class="col-md-12">
							<span class="glyphicon glyphicon-book" aria-hidden="true"> 후기내용</span>
							<br>
							<br>
							<span id="reviewDetailForJS">${review.reviewDetail }</span>
							<hr>
						</div>
						<div class="col-md-12">
							<span class="glyphicon glyphicon-tags" aria-hidden="true"> 해시태그 : </span>
							<span id="reviewHashtagForJS">${review.reviewHashtag }</span>
							<hr>
						</div>
						<div class="col-md-12">
							<c:if test="${!empty review.reviewVideoList[0].reviewVideo }">
								<span class="glyphicon glyphicon-facetime-video" aria-hidden="true"> 동영상</span>
								<c:set var="i" value="0"/>
					  			<c:forEach var="listV" items="${review.reviewVideoList}">
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
					</div>
				</div>
			</div>
		</div>
			
						
		<!-- 댓글 부분 Start -->
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="col-md-12">
							<%-- 
							<small>
								<!-- ToolBar Start /////////////////////////////////////-->
								<jsp:include page="getReplyList.jsp" >
									<jsp:param name="reviewNo" value="${review.reviewNo }"/>
								</jsp:include>
							   	<!-- ToolBar End /////////////////////////////////////-->
							</small>
							 --%>
							<!-- 여기서부터 수정해보자 삭제 가능 include 대신 구현-->
							<h5 class="page-heading replyHeader">댓글</h5>
							
							<!-- 화면구성 div Start -->
						   	<div class="container">
								<!-- 'search' is only for 'Admin' menu -->
								<div class="col-md-offset-4 col-md-4">
									<form class="form-inline" name="searchForm">
										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
										<input type="hidden" id="currentPage" name="currentPage" value=""/>
										<input type="hidden" name="reviewNo" value="${review.reviewNo }"/>
									<c:if test="sessionScope.user.role == 'a'">
										<%-- 
										<input name="menu" value="${param.menu }" type="hidden"/>
										 --%>
										<div class="form-group">
											<select class="form-control" name="searchCondition">
												<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>축제이름</option>
												<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>축제장소</option>
												<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>해시태그</option>
											</select>
										</div>
										
										<div class="form-group">
											<label class="sr-only" for="searchKeyword">검색어</label>
											<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" 
													value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
										</div>
										
										<button type="button" id = "searchReply" class="btn btn-default">검색</button>
									</c:if>
									</form>
								</div>
							</div>
							<!-- 화면구성 div End -->
							<!--  table 위쪽 검색 End -->
							
							
							<!-- 댓글입력 폼 -->
							<!-- 댓글입력 form Start : 로그인한 사람만 댓글등록가능-->
							<form class="form-horizontal" method="post" name="detailForm">
								<div class="col-md-12">
									<div class="form-group pull-right">
										<input type="hidden" id="reviewNo" name="reviewNo" value="${review.reviewNo }"/>
										<input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId }"/>
										<!-- 
										<label for="replyDetail" class="col-sm-offset-1 col-sm-3 control-label">댓글내용</label>
										 -->
										<c:if test="${user.userId != null }">
										<div class="col-md-10 pull-left">
											<textarea class="form-control" id="replyDetail" name="replyDetail" placeholder='댓글을 등록해 주세요' style="margin: 0px -10px 0px 0px; width: 450px; height: 80px;"></textarea>
										</div>
										</c:if>
										<c:if test="${user.userId == null }">
										<div class="col-md-10 pull-left">
											<textarea class="form-control" id="cannotUse" name="cannotUse" placeholder='로그인 후 댓글기능을 이용하세요'></textarea>
										</div>
										</c:if>
										<div class="col-md-2">
											<button type="button" class="btn btn-primary pull pull-left" <c:if test="${user.userId ==null}">disabled="disabled"</c:if> id="addReply">댓글등록</button>
										</div>
									</div>
								</div>
							</form>
							<!-- 댓글입력 form End-->
							<%-- 
							<div class="reply-wrapper col-md-12">
								<div id="reply-form" class="detailForm">
									<c:if test="${user.userId != null }">
										<textarea class="form-control" id="replyDetail" name="replyDetail" placeholder='댓글을 등록해 주세요'></textarea>
									</c:if>
									<c:if test="${user.userId == null }">
										<textarea class="form-control" placeholder='로그인 후 이용해 주세요' readonly="readonly"></textarea>
									</c:if>
									<button type='button' id="addReply" class="btn btn-primary pull pull-left" <c:if test="${user.userId ==null}">disabled="disabled"</c:if> id="addCommentButton">댓글등록</button>
								</div>
								
							</div>
							 --%>
							
						</div>
			
						<c:if test="${!empty review.replyList }">
							<c:set var="i" value="0"/>
							<c:forEach var="replyList" items="${review.replyList }">
								<c:set var="i" value="${i+1 }"/>
									<div class="col-md-12">
										<span class="glyphicon glyphicon-user" aria-hidden="true">	
											${replyList.userId }
										</span>
									</div> 
									<div class="col-md-12">
										<input type="text" class="form-control col-md-12" id="replyDetail${replyList.replyNo }" aria-label="replyDetail" value="${replyList.replyDetail }" readonly>
												<input type="hidden" name="reviewNo" value=${review.reviewNo }>
										<span style="display: none" class="hidden_link">/review/getReview?reviewNo=${review.reviewNo }</span>
									</div>
									<div class="input-group col-md-12">
										<div class="col-md-12">
											<div class="col-md-9">
												<small>
													<span class="glyphicon glyphicon-time" aria-hidden="true" id="replyRegDate${replyList.replyNo }">
														${replyList.replyRegDate }
													</span>
												</small>
											</div>
											<div class="col-md-3">
												<small>
												<c:if test="${!empty sessionScope.user }">
													<c:if test="${!(sessionScope.user.role == 'a' || sessionScope.user.nickname == replyList.userId) }">
														<div class="col-offset-10 col-md-2">
															<div class="input-group-btn">
																<button type="button" name="replyNoForReport" id="willBeReported" class="btn btn-secondary btn-sm btn-danger btn-reply">
													   				신고
													   			</button>
															</div>
														</div>
													</c:if>
												</c:if>
												<c:if test="${!empty sessionScope.user}" >
													<c:if test="${sessionScope.user.role == 'a' || sessionScope.user.nickname == replyList.userId }">
														<div class="col-md-12">
															<div class="input-group-btn">
													   			<button type="button" name="buttonForUpdate" id="updateReply${replyList.replyNo }" class="btn btn-secondary btn-sm btn-info btn-reply" value="${replyList.replyNo }" style="display:inline">
													   				수정
													   			</button>
													   			<button type="button" name="buttonForCompUpdate" id="updateCompReply${replyList.replyNo }" class="btn btn-secondary btn-sm btn-info btn-reply" value="${replyList.replyNo }" style="display:none">
													   				완료
													   			</button>
												   				<button type="button" name="buttonForDelete" id="deleteReply${replyList.replyNo }" class="btn btn-secondary btn-sm btn-warning btn-reply" value="${replyList.replyNo }">
												   					삭제
												   				</button>
															</div>
														</div>
											   		</c:if>
											   	</c:if>
												</small>
											</div>
										</div>
									</div>
									<br>
							</c:forEach>
						</c:if>
			
		<!-- 댓글 부분 End -->
		<!-- 여기까지 삭제 가능 include 대신 구현-->
					</div>
					
				<div class="text-center">
					<!-- PageNavigation Start -->
					<jsp:include page="../../common/pageNavigator_new.jsp"/>
					<!-- PageNavigation End -->
		   		</div>
			   		
				</div>
			</div>
		</div>
	</div>
   	<!-- 화면구성 div container End -->
			

</body>
</html>