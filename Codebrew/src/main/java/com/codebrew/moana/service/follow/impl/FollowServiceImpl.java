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
	public Map<String, Object> getFollowingList(Search search, String responseId) throws Exception {
		// TODO Auto-generated method stub
		
		
		search.setSearchKeyword(responseId);//내 아디가 reponseId가 되서 내가 request 하는 사람들 목록을 본다. 
		
		List<Follow> list= followDAO.getFollowingList(search);
		int totalCount=followDAO.getFollowingTotalCount(search);
		
		
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}

	@Override
	public Map<String, Object> getFollwerList(Search search, String requestId) throws Exception {
		// TODO Auto-generated method stub
		
		search.setSearchKeyword(requestId);//내 아디가 requestId가 되서 나를 response 하고 있는 사람들의 목록을 본다
		
		List<Follow> list= followDAO.getFollowerList(search);
		int totalCount=followDAO.getFollowerTotalCount(search);
		
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}

}
