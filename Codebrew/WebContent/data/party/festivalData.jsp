<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%
	
	Festival festival = new Festival();
	festival.setFestivalNo(2510119);
	festival.setFestivalName("�̵峪�� �ҷ��� ��Ƽ 2017 : ���� ��Ƽ 2017");
	festival.setAddr("����Ư���� ������ ������� 200");
	festival.setStartDate("20171013");
	festival.setEndDate("20171029");
	
	request.setAttribute("festival", festival);
	
%>