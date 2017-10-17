<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- <a href="/festival/ListFestival"> 축제리스트 (api사용) </a> -->
<a href="/festival/getFestivalList?pageNo=1"> 축제리스트 (api사용) 관리자 </a>

<br/>
<br/>

<a href="/festival/getFestivalListDB"> 축제리스트 (서버DB) 회원 / 비회원 </a>

<!-- 가정이가 써보았다 -->
<br>
<br>

<a href="/purchase/getSaleList"> 판매목록 (관리자only) </a>

<br>
<br>

<a href="/purchase/getPurchaseList?userId=user03@naver.com"> my티켓 </a>

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

</body>
</html>