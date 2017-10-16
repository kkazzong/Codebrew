<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%
	
	Party party = new Party();
	party.setPartyNo(10000);
	party.setPartyName("할로윈 파티");
	party.setPartyImage("1507724033981_party1.jpg");
	party.setPartyPlace("서울특별시 서초구 강남대로53길 8 비트아카데미빌딩");
	party.setPartyTime("20시00분");
	party.setTicketCount(50);
	party.setTicketPrice(500);
	
	request.setAttribute("party", party);
	
%>