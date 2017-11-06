package com.codebrew.moana.service.follow.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Follow;
import com.codebrew.moana.service.follow.FollowDAO;
import com.codebrew.moana.service.follow.FollowService;

@Service("followServiceImpl")
public class FollowServiceImpl implements FollowService {

	
	//field
	@Autowired
	@Qualifier("followDAOImpl")
	private FollowDAO followDAO;
	public void setFollowDAO(FollowDAO followDAO) {
		this.followDAO=followDAO;
	}
	
	
	
	public FollowServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@Override
	public void addFollow(String responseId, String requestId) throws Exception {
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("responseId", responseId);
		map.put("requestId", requestId);//(주영,주현)
		
		String check=requestId;
		requestId=responseId;
		responseId=check;
		
		Follow follow = followDAO.getFollow(responseId, requestId);//(주현,주현)
		
		if(follow !=null) {//맞팔이 되면
			
			follow.setF4f("1");
			
			followDAO.updateFollow(follow);
			
			followDAO.addFollow(map);
			
		}else {
			
			followDAO.addFollow(map);
			
		}
			
	}

	@Override
	public void deleteFollow(String responseId, String requestId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("responseId", responseId);
		map.put("requestId", requestId);
		
		String check=requestId;
		requestId=responseId;
		responseId=check;
		
		
		Follow follow=followDAO.getFollow(responseId, requestId);
		
		if(follow !=null) {
			
			follow.setF4f("0");
			
			followDAO.updateFollow(follow);
			
			followDAO.deleteFollow(map);
			
		}
		
		followDAO.deleteFollow(map);
	}

	
	@Override
	public Follow getFollow(String responseId, String requestId) throws Exception {
		// TODO Auto-generated method stub
		return followDAO.getFollow(responseId, requestId);
	}

	@Override
	public Map<String, Object> getFollowingList(Search search, String requestId) throws Exception {
		// TODO Auto-generated method stub
		
		
		search.setSearchKeyword(requestId);//내가 리퀘스트한 아디를 서치 컨디션에 넣기
		
		List<Follow> list= followDAO.getFollowingList(search);
		int totalCount=followDAO.getFollowingTotalCount(search);
		
		
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}

	@Override
	public Map<String, Object> getFollwerList(Search search, String responseId) throws Exception {
		// TODO Auto-generated method stub
		
		search.setSearchKeyword(responseId);//나를 response 하는 목록
		
		List<Follow> list= followDAO.getFollowerList(search);
		int totalCount=followDAO.getFollowerTotalCount(search);
		
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}

}
