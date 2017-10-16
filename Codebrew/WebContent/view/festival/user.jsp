<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codebrew.moana.service.domain.*" %>
<%@ page import="java.util.*"%>
<%
	
User user = new User();
user.setUserId("taehoon@naver.com");
user.setUserName("임정은");
user.setPassword("1111");
user.setProfileImage(null);
user.setRole("u");
user.setPhone("01011112222");
user.setGender("여자");
user.setAge(27);
user.setLocationFlag(null);
user.setNickname("gj");
user.setRegDate(new Date(20150505));
user.setCoconutCount(30);



request.setAttribute("user", user);
%>