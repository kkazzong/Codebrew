package com.codebrew.moana.service.user;

import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonNode;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.User;

public interface UserDAO {
	
	    //회원가입
		public void addUser(User user) throws Exception;
		
		//회원조회, 아이디찾기, 비밀번호 찾기
		public User getUser(String userId)throws Exception;
		
		//회원리스트
		public List<User> getUserList(Search search)throws Exception;
		
		//회원정보수정,위치정보동의, 타계정회원가입, 코코넛지급
		public void updateUser(User user)throws Exception;
		
		//회원탈퇴
		public void deleteUser(User user)throws Exception;

		//닉네임 중복체크
		public User checkNickname(String nickname)throws Exception;
		
		//아이디찾기
		public User findUserId(User user)throws Exception;
	    
		//토탈카운트
		public int getTotalCount (Search search)throws Exception;
       
		//랜덤 비밀번호 생성
		public String randomNumber(int number) throws Exception;
        
		//카카오로그인
		public User getCode(String authorize_code) throws Exception;
		
}