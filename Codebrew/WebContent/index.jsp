<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
<style type="text/css">
	body {
       padding-top : 50px;
    }
</style>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
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
<h1>jsp에서 dropdown cdn추가하고 툴바.jsp include(index.jsp참고하세염)</h1>
<br>
<br>
<!--후기등록 테스트중 -->
<a href="/review/addReview">후기등록</a>


<!-- 파티 index -->
<div><a href = "/party/addParty?userId=${user.userId}">addParty.jsp</a></div>
	<div><a href = "/party/getParty?partyNo=10000">getParty.jsp</a></div>
	<div><a href = "/party/getPartyList">getPartyList.jsp</a></div>
</body>
</html>