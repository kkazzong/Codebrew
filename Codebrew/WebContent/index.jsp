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
    	background: url(/resources/image/toolbarImage/bg2.jpg) no-repeat center center;
		width: 100%;
	   	height: 100%;
	   background-size: 100%;
	   opacity: 0.7;
    }
    
</style>


	<script type="text/javascript">

	    
</script>
<title>Insert title here</title>

</head>
<body>
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
	<!-- 배경 이미지 -->
	<section>
<!-- <a href="/festival/ListFestival"> 축제리스트 (api사용) </a> -->
<a href="/festival/getFestivalList?pageNo=1"> 축제리스트 (api사용) 관리자 </a>

<br/>
<br/>

<!-- <a href="/festival/getFestivalListDB"> 축제리스트 (서버DB) 회원 / 비회원 </a> -->

<a href="/festival/getFestivalListDB?menu=db"> 축제리스트 (서버DB) 회원 / 비회원 </a>

<!-- 가정이가 써보았다 -->
<br>
<br>
<c:if test="${user.role == 'a'}">
<a href="/purchase/getSaleList"> 판매목록 (관리자only) </a>
</c:if>
<br>
<br>

<a href="/purchase/getPurchaseList"> my티켓 </a>

<br>
<br>
<!--주영이가 써보았다.  -->
<a href="/user/login">로그인</a>

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
<!--유아이 수정용 주소  -->
<a href="/view/user/addExtraUser.jsp">추가정보 입력 ui</a>

<br>
<br>

<a href="/view/user/findUser.jsp">아이디찾기/비밀번호 찾기 ui 확인용</a>

<br>
<br>

<a href="/view/user/confirmUser.jsp">본인인증UI용</a>



<!-- 가정이가 또 써보았다 -->
<br>
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
<br>
<!--후기등록 테스트중 -->
<a href="/review/addReview">후기등록</a>


<!-- 파티 index -->
<div><a href = "/party/addParty?userId=${user.userId}">addParty.jsp</a></div>
	<div><a href = "/party/getMyPartyList">getMyPartyList.jsp</a></div>
	<div><a href = "/party/getPartyList">getPartyList.jsp</a></div>
	</section>
</body>
</html>