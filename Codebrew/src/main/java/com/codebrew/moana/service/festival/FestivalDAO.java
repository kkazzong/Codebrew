package com.codebrew.moana.service.festival;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;

public interface FestivalDAO {
	
	
	public Festival getFestival(int festivalNo) throws Exception ;
	
	public void addFestival(Festival festival) throws Exception ;

	public int getTotalCount(Search search) throws Exception ;
	
	public Map<String,Object> getFestivalList(Search search) throws Exception;
	
	public Map<String,Object> searchKeywordList(Search search) throws Exception;
	
	public Festival getFestivalDB(int festivalNo) throws Exception;
	
	public List<Festival> getFestivalListDB(Search search) throws Exception;
	
}
