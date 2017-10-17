package com.codebrew.moana.service.user;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.User;

public interface UserService {
	
	//회원가입
	public void addUser(User user) throws Exception;
	
	//회원조회, 아이디찾기, 비밀번호 찾기
	public User getUser(String userId)throws Exception;
	
	//회원리스트
	public Map<String,Object> getUserList(Search search)throws Exception;
	
	//회원정보수정, 위치정보동의, 타계정 회원가입, 코코넛지급
	public void updateUser(User user)throws Exception;
	
	//회원탈퇴
	public void deleteUser(User user)throws Exception;
	
	//닉네임 중복체크
	public boolean checkNickname(String nickname)throws Exception;
	
    //아이디 중복체크
	public boolean checkUserId(String userId)throws Exception;
	
	//아이디찾기
	public User findUserId(User user)throws Exception;
	
	//비밀번호찾기, 인증번호
	public String randomNumber(int number)throws Exception;
	

		
	}
