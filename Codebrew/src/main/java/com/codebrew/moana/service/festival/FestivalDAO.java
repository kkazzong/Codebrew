package com.codebrew.moana.service.festival;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Contents;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Weather;
import com.codebrew.moana.service.domain.Zzim;

public interface FestivalDAO {
	
	
	public Festival getFestival(int festivalNo) throws Exception ;
	
	public void addFestival(Festival festival) throws Exception ;

	public int getTotalCount(Search search) throws Exception ;
	
	public Map<String,Object> getFestivalList(Search search) throws Exception;
	
	public Map<String,Object> searchKeywordList(Search search) throws Exception;
	
	public Festival getFestivalDB(int festivalNo) throws Exception;
	
	public List<Festival> getFestivalListDB(Search search) throws Exception;
	
	public void addZzim(Zzim zzim) throws Exception;
	
	public void deleteZzim(Zzim zzim) throws Exception;
	
	public Zzim getZzim(Zzim zzim) throws Exception;
	
	public List<Zzim> getMyZzimList(Search search,String userId) throws Exception;
	
	public void updateFestival(Festival festival) throws Exception;
	
	public void appendReadCount(Festival festival) throws Exception;
	
	public void deleteFestival(Festival festival) throws Exception;
	
	public void writeFestival(Festival festival) throws Exception ;
	
	public Weather weather(String festivalLat, String festivalLong) throws Exception ;
	
	public int getTotalCountZzim(Search search,String userId) throws Exception ;
	
	public Map<String,Object> getAreaCode() throws Exception;
	
	public Map<String,Object> getSigunguCode(String areaCode) throws Exception;
	
	public List<Festival> getInitListDB() throws Exception;
	
	public Contents kakaoWeb(String festivalName0) throws Exception;
	
	public Contents kakaoWeb(String festivalName0,String festivalName1,String festivalName2) throws Exception;
	
	public int getTotalZzim(int festivalNo) throws Exception;
}
