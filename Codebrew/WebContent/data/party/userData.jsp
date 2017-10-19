<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%
	
	User user = new User();
	user.setUserId("user01@naver.com");
	user.setNickname("쎄리");
	user.setPassword("1111");
	user.setRole("a");
	user.setPhone("01012345678");
	user.setGender("f");
	user.setAge(27);
	user.setLocationFlag("y");
	user.setCoconutCount(1000);
	
	/* user.setUserId("user04@naver.com");
	user.setNickname("까정"); */
	
	session.setAttribute("user", user); 
	
%>