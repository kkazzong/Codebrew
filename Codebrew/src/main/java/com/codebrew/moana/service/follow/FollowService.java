package com.codebrew.moana.service.follow;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Follow;

public interface FollowService {
	
	public void addFollow(String responseId, String requestId)throws Exception;
	
	
	public void deleteFollow(String responseId, String requestId)throws Exception;
	
	
	public Follow getFollow(String responseId, String requestId)throws Exception;
	
	
	public Map<String, Object> getFollowingList(Search search,String requestId)throws Exception;
	
	
	public Map<String, Object> getFollowerList(Search search,String responseId)throws Exception;

}
