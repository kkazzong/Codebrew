package com.codebrew.moana.service.user.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.user.UserDAO;

@Repository("userDAOImpl")
public class UserDAOImpl implements UserDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	public UserDAOImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}
