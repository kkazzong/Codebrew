package com.codebrew.moana.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.user.UserDAO;

@Repository("userDAOImpl")
public class UserDAOImpl implements UserDAO {

//field (has a)
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	
	public UserDAOImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("UserMapper.addUser",user);
	}
	
	
	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}

	@Override
	public List<User> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getUserList",search);
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.updateUser", user);
	}

	@Override
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.deleteUser", user);
	}

	@Override
	public User checkNickname(String nickname) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.checkNickname", nickname);
	}
	

	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		/*Map<String, Object> map = new HashMap<String, Object>();
		map.put("userName", userName);
		map.put("phone", phone);*/
		return sqlSession.selectOne("UserMapper.findUserId", user);
	}

	
    @Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}
    
    
	@Override
	public String randomNumber(int number) throws Exception {
		// TODO Auto-generated method stub
		String uuid="";
		
		for(int i=0; i<number ; i++) {//i가 횟수 random넘버가 되는건 uuid
			//UUID uuid = UUID.randomUUID(); // UUID 자체는 오브젝트 타입
			//String uuid= UUID.randomUUID().toString();//스트링타입으로 바꿔줌
			uuid= UUID.randomUUID().toString().replaceAll("-", "");//특수문자 지우고 null로 바꿈
			uuid.substring(0, 4);//4번째에서 자름

		}
		
	return uuid;//괄호 밖이라서 마지막 결과만 나옴
	
	}

	//카카오로그인
	public User getCode(String authorize_code) throws Exception{
		
	  return null;
	}


	
	
}