package com.codebrew.moana.service.follow.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Follow;
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

	@Override
	public void addFollow(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FollowMapper.addFollow", map);
	}

	@Override
	public void deleteFollow(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("FollowMapper.deleteFollow", map);
	}

	@Override
	public void updateFollow(Follow follow) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FollowMapper.updateFollow", follow);
	}

	@Override
	public Follow getFollow(String responseId, String requestId) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("responseId", responseId);
		map.put("requestId", requestId);
		
		return sqlSession.selectOne("FollowMapper.getFollow", map);
	}

	@Override
	public List<Follow> getFollowingList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("search??????"+search);
		return sqlSession.selectList("FollowMapper.getFollowingList", search);
	}

	@Override
	public List<Follow> getFollowerList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("search는????????"+search);
		return sqlSession.selectList("FollowMapper.getFollowerList", search);
	}

	@Override
	public int getFollowingTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		
		return sqlSession.selectOne("FollowMapper.getFollowingTotalCount", search);
	}

	@Override
	public int getFollowerTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("followMapper가기 전 getFollowerTotalCount에서 써~~치는?"+search);
		return sqlSession.selectOne("FollowMapper.getFollowerTotalCount", search);
	}

 
	
	
}
