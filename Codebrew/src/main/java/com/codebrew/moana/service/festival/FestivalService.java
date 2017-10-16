package com.codebrew.moana.service.festival;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;

public interface FestivalService {
	
	public Festival getFestival(int festivalNo) throws Exception; // db 구축 add
	
	public Map<String,Object> getFestivalList(Search search) throws Exception;
	
	public Map<String,Object> searchKeywordList(Search search) throws Exception;
	
	public void addFestival (Festival festival) throws Exception;
	
	public boolean duplication (int festivalNo) throws Exception;
	
	public Festival getFestivalDB (int festivalNo) throws Exception;
	
	public Map<String,Object> getFestivalListDB(Search search) throws Exception;
	
	

	
}
