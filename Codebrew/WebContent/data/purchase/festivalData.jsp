<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%
	
	Festival festival = new Festival();
	festival.setFestivalNo(2510101);
	festival.setFestivalName("������ ��å�� 2017");
	festival.setAddr("����Ư���� ���α� ȿ�ڷ�13�� 45");
	festival.setStartDate("20170930");
	festival.setEndDate("20171118");
	festival.setFestivalImage("http://tong.visitkorea.or.kr/cms/resource/97/2510097_image2_1.jpg");
	festival.setTicketCount(30);
	festival.setTicketPrice(1000);
	
	request.setAttribute("festival", festival);
	
%>