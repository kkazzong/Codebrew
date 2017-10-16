<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%@ page import="java.util.*"%>
<%
	
	User user = new User();
	user.setUserId("sk@naver.com");
	user.setUserName("김성경");
	user.setPassword("1234");
	user.setProfileImage(null);
	user.setRole("a");
	user.setPhone("01031347181");
	user.setGender("남자");
	user.setAge(27);
	user.setLocationFlag(null);
	user.setNickname("sk");
	user.setRegDate(new Date(20171106));
	user.setCoconutCount(10);
	
	
	
	request.setAttribute("user", user); 
	
%>