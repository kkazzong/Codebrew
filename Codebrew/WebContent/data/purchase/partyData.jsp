<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%
	
	Party party = new Party();
	party.setPartyNo(10000);
	party.setPartyName("�ҷ��� ��Ƽ");
	party.setPartyImage("1507724033981_party1.jpg");
	party.setPartyPlace("����Ư���� ���ʱ� �������53�� 8 ��Ʈ��ī���̺���");
	party.setPartyTime("20��00��");
	party.setTicketCount(50);
	party.setTicketPrice(500);
	
	request.setAttribute("party", party);
	
%>