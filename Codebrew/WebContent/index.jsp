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
</body>
</html>