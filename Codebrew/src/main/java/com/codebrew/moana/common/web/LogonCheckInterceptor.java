package com.codebrew.moana.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.codebrew.moana.service.domain.User;


/*
 * FileName : LogonCheckInterceptor.java
 */
public class LogonCheckInterceptor extends HandlerInterceptorAdapter {

	///Field
	
	///Constructor
	public LogonCheckInterceptor(){
		System.out.println("\nCommon :: "+this.getClass()+"\n");		
	}
	
	///Method
	public boolean preHandle(	HttpServletRequest request,
														HttpServletResponse response, 
														Object handler) throws Exception {
		
		System.out.println("\n[ LogonCheckInterceptor start........]");
		
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		
		if(   user != null   )  { //로그인한 회원
			
			String uri = request.getRequestURI();
			
			//로그인상태에서 갈필요 필요 없는 uri
			if(		uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 		  || 
					uri.indexOf("findPwd") != -1 || uri.indexOf("confirmUser") != -1  || 
					uri.indexOf("findUser") != -1 || uri.indexOf("json/confirmUser") != -1 ||
					uri.indexOf("json/checkUserId") != -1 || uri.indexOf("json/findUserId") != -1 ||
					uri.indexOf("kakaoLogin") != -1){
				request.getRequestDispatcher("/index.jsp").forward(request, response);
				System.out.println("[ 로그인 상태임 불필요한 요구.... ]");
				System.out.println("[ LogonCheckInterceptor end........]\n");
				return false;
			}
			
			System.out.println("[ 로그인 상태 ... ]");
			System.out.println("[ LogonCheckInterceptor end........]\n");
			return true;
		}else{ //미로그인한 회원
			
			String uri = request.getRequestURI();
			
			if(		uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 		  || 
					uri.indexOf("findPwd") != -1 || uri.indexOf("confirmUser") != -1  || 
					uri.indexOf("findUser") != -1||uri.indexOf("json/confirmUser") != -1 ||
					uri.indexOf("json/checkNickname") != -1 || uri.indexOf("json/checkUserId") != -1||
					uri.indexOf("kakaoLogin") != -1 ||  uri.indexOf("json/getUser") != -1){
				System.out.println("[로그인 시도 상태 .... ]");
				System.out.println("[ LogonCheckInterceptor end........]\n");
				return true;
			}
			
			//request.getRequestDispatcher("/index.jsp").forward(request, response);
			request.getRequestDispatcher("/user/login").forward(request, response);
			System.out.println("[ 로그인 이전... ]");
			System.out.println("[ LogonCheckInterceptor end........]\n");
			return false;
		}
	}
}//end of class