package com.codebrew.moana.service.follow;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Follow;

public interface FollowDAO {
	
	
	 public void addFollow(Map<String, Object> map)throws Exception;

	 
	 public void deleteFollow(Map<String, Object> map)throws Exception;
	 
	 
	 public void updateFollow(Follow follow)throws Exception;
	 
	 
	 public Follow getFollow(String responseId, String requestId)throws Exception;
	 
	 
	 public List<Follow> getFollowingList(Search search)throws Exception;
	 
	 
	 public List<Follow> getFollowerList(Search search) throws Exception;
	 
	 
	 public int getFollowingTotalCount(Search search)throws Exception;
	 
	 
	 public int getFollowerTotalCount(Search search)throws Exception;
	 
	 
	 
}
