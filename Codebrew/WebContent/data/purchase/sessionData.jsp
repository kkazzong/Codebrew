<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%
	
	User user = new User();
	
	//user.setUserId("user04@naver.com");
	//user.setNickname("까정");
	
	user.setUserId("user03@naver.com");
	user.setNickname("썽경");
	
	session.setAttribute("user", user);

%>