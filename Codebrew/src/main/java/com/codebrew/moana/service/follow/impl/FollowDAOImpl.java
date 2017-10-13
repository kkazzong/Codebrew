package com.codebrew.moana.service.follow.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.follow.FollowDAO;

@Repository("followDAOImpl")
public class FollowDAOImpl implements FollowDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;

	public FollowDAOImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}
