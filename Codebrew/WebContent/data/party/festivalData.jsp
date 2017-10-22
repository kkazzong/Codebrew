<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%
	
	Festival festival = new Festival();
	festival.setFestivalNo(2510028);
	festival.setFestivalName("생활문화주간(아티팟카니발) 2017");
	festival.setAddr("서울특별시 성동구 뚝섬로 273");
	festival.setStartDate("20171021");
	festival.setEndDate("20171104");
	
	request.setAttribute("festival", festival);
	
%>