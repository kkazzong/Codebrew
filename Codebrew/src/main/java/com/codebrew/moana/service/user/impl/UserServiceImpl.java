package com.codebrew.moana.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.user.UserDAO;
import com.codebrew.moana.service.user.UserService;

@Service("userServiceImpl")//Qualifiler로 di될 이름 지정
public class UserServiceImpl implements UserService{

	@Autowired
	@Qualifier("userDAOImpl")//UserDAO userDAO=new UserDAOImpl();
	private UserDAO userDAO;
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO=userDAO;
	}
	
		
	public UserServiceImpl() {
		System.out.println(this.getClass());
		
	}

	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.addUser(user);
		
	}

	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUser(userId);
	}

	@Override
	public Map<String,Object> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<User> list=userDAO.getUserList(search);
		int totalCount=userDAO.getTotalCount(search);
		
		Map<String, Object> map=new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.updateUser(user);
		
	}

	@Override
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.deleteUser(user);
		
	}

	@Override
	public boolean checkNickname(String nickname) throws Exception {
		// TODO Auto-generated method stub
		
		boolean result=true;
		
		User user=userDAO.checkNickname(nickname);
		
		if(user !=null) {//존재하는 닉네임이 있으니깐 쓰면 안되서 false
		return false;
	}
		
		return result;
	}
		

	@Override
	public boolean checkUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		
		boolean result=true;
		
		User user=userDAO.getUser(userId);
		
		if(user != null) { //존재하는 아이디가 있는거니깐 false
		return false;
	}

		return result;
	}
		
	
	
	@Override
	public String randomNumber(int number) throws Exception {
		// TODO Auto-generated method stub
		String uuid="";
		
		for(int i=0; i<number ; i++) {//i가 횟수 random넘버가 되는건 uuid
			//UUID uuid = UUID.randomUUID(); // UUID 자체는 오브젝트 타입
			//String uuid= UUID.randomUUID().toString();//스트링타입으로 바꿔줌
			uuid= UUID.randomUUID().toString().replaceAll("-", "");//특수문자 지우고 null로 바꿈
			uuid.substring(0, 7);//7번째에서 자름

		}
		
	return uuid;//괄호 밖이라서 마지막 결과만 나옴
	
	}


	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.findUserId(user);
	}

	
}
