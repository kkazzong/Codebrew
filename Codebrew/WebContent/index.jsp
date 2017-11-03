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

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>



<style type="text/css">
	body {
		padding-top : 70px;
    }
    
    section {
    	/* background: url(/resources/image/toolbarImage/bg2.jpg) no-repeat center center; */
    	background: url(/resources/image/ui/main.gif) no-repeat center center;
		width: 100%;
	   	height: 500px;
	   background-size: 100%;
	   opacity: 0.8;
    }
    
    #box {
		padding-top: 187px;
		text-align: center;
	}
     
		
	.title {
		color: black;
		text-shadow:1px 1px 1px black;
	} 
	
	/* .main .search-main input[type=text] {
		
		width: 83%;
	    height: 41px;
	    padding-left: 10px;
	    float: left;
	    margin-top: 2px;
	    margin-left: 2px;
	}
	
	.main .search-main {
	    background-color: #556180;
	    width: 100%;
	    height: 45px;
	    margin-bottom: 76px;
	    position: relative;
	}

	.main .search-main img {
	    width: 40px;
	    margin-top: 2px;

	}
 */
</style>


	<script type="text/javascript">

	    
</script>
<title>Moana</title>
<!-- 타이틀 수정하지마세용 -->
</head>
<body>
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

	
	<!-- 배경 이미지 -->
	<section>
	
	<div class="row">
		<div class="col-md-12 text-center">
			<div class="title">
			</div>
		</div>
	</div>
	
	<div id="box" class="row">
		<div class="col-md-12 text-center">
			<div class="col-md-offset-4 col-md-4">
				<form class="form form-inline">
					<div class="form-group">
						<input class="form-control input-lg" type="text" placeholder="축제명 or 파티명 검색">
					</div>
					<div class="form-group">
						 <button class="btn btn-primary btn-block" type="button">검색</button> 
						<!-- <a id="search" class="click" type="button">
		                      <img src="/resources/image/buttonImage/btn_nav_search_white@3x.png">
		                </a>	 -->
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	
	<a href="/user/getUser?userId=${sessionScope.user.userId }">Ui테스트</a>
	
	<br>
	<br>
	<a href="/view/user/getMyPage.jsp">로그인</a>
	<br>
	<br>
	<a href="/view/user/getMyPage2.jsp">마이페이지</a>
	
	
	<!-- Title -->
	<!-- <div class="main-wrapper">
		
		<div class="main">
		<div class="main">
	        <div class="container">
	            <div class="col-md-12">
	                <div class="col-md-6 col-md-offset-3 padding-none">
	                    <div class="text-center white">
	                       
	                        <div class="title">
	                        	<h1>MOANA</h1>
	                            <h1>이번 주말에 모아나ㅋ</h1>
	                        </div>
	
	                        <div class="sub-title-container">
	
	                            <div class="search-main">
	                                
	                                <form class="form-inline" name="detailForm">
	                                	
										  
										  <div class="form-group">
										    <label class="sr-only" for="searchKeyword">검색어</label>
										    
											<input type="text" class="form-control" id="search" placeholder="ex) 할로윈">
											<input type="text" placeholder="ex) 할로윈">
										    <a id="search" class="click" type="button">
		                                        <img src="/resources/image/buttonImage/btn_nav_search_white@3x.png">
		                                    </a>		 
										  </div>
	                               	</form>
	                                
	                             
	                                </div>
	                            </div>
	                        
	
	                        <script>
	                            $("#search").click(function () {
	                                var query = $(".search-main input").val();
	                                if (!query) {
	                                    alert("검색어를 입력해주세요.");
	                                } else {
	                                    location.href = "/search/" + query;
	                                }
	                            })
	                        </script>
	
	                        
	
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div> -->
	
	
<!-- <a href="/festival/ListFestival"> 축제리스트 (api사용) </a> -->
<!-- <a href="/festival/getFestivalList?pageNo=1"> 축제리스트 (api사용) 관리자 </a>

<br/>
<br/> -->

<!-- <a href="/festival/getFestivalListDB"> 축제리스트 (서버DB) 회원 / 비회원 </a> -->

<!-- <a href="/festival/getFestivalListDB?menu=db"> 축제리스트 (서버DB) 회원 / 비회원 </a> -->

<!-- 가정이가 써보았다 -->
<%-- <br>
<br>
<c:if test="${user.role == 'a'}">
<a href="/purchase/getSaleList"> 판매목록 (관리자only) </a>
</c:if>
<br>
<br> --%>

<!-- <a href="/purchase/getPurchaseList"> my티켓 </a>

<br>
<br> -->
<!--주영이가 써보았다.  -->


<%-- <a href="/user/login">로그인</a>

<br>
<br>

<a href="/user/logout">로그아웃</a>


<br>
<br>


<a href="/user/updateUser?userId=${user.userId}">회원정보 수정</a>

<br>
<br>

<a href="/user/getUserList">회원리스트</a>

<br>
<br>

<a href="/user/withdrawUser?userId=${user.userId }">회원탈퇴</a>

<br>
<br>

<a href="/view/user/addUser.jsp">회원가입 ui 확인용</a>
<br>
<br>


<a href="/view/festival/writeFestival.jsp">직접등록</a>

<br>
<br>

<a href="/view/festival/weather.jsp">날씨</a> --%>

<!--유아이 수정용 주소  -->
<!-- <a href="/view/user/addExtraUser.jsp">추가정보 입력 ui</a>

<br>
<br>

<a href="/view/user/findUser.jsp">아이디찾기/비밀번호 찾기 ui 확인용</a>

<br>
<br>

<a href="/view/user/confirmUser.jsp">본인인증UI용</a> -->



<!-- 가정이가 또 써보았다 -->
<%-- <br>
<br>
<c:if test="${!empty user}">
 현재 로그인한 userId : ${user.userId} <br>
 어드민이니? 유저니? : ${user.role} <br>
</c:if>

<c:if test="${user.role == 'a'}">
	<a href="/statistics/getStatistics"> 판매통계보기 (관리자only) </a>
</c:if>
<h5>jsp에서 dropdown cdn추가하고 툴바.jsp include(index.jsp참고하세염)</h5>
<br>
<br> --%>
<!--후기등록 테스트중 -->
<!-- <a href="/review/addReview">후기등록</a> -->


<!-- 파티 index -->
<!-- <div>
	<div><a href = "/party/getMyPartyList">My 파티 리스트</a></div>
</div>	 -->

<!-- <a href="/festival/getFestivalListDB?menu=pop">popup</a> -->
<!-- <a href="/festival/getMyZzimList">getZzimlist</a> -->
	</section>
</body>
</html>