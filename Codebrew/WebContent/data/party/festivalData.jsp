<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%
	
	Festival festival = new Festival();
	festival.setFestivalNo(2510119);
	festival.setFestivalName("미드나잇 할로윈 파티 2017 : 몬스터 시티 2017");
	festival.setAddr("서울특별시 광진구 아차산로 200");
	festival.setStartDate("20171013");
	festival.setEndDate("20171029");
	
	request.setAttribute("festival", festival);
	
%>