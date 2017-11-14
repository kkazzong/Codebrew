package com.codebrew.moana.service.festival;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Contents;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Weather;
import com.codebrew.moana.service.domain.Zzim;

public interface FestivalService {
	
	public Festival getFestival(int festivalNo) throws Exception; // db 구축 add
	
	public Map<String,Object> getFestivalList(Search search) throws Exception;
	
	public Map<String,Object> searchKeywordList(Search search) throws Exception;
	
	public void addFestival (Festival festival) throws Exception;
	
	public boolean duplication (int festivalNo) throws Exception;
	
	public Festival getFestivalDB (int festivalNo) throws Exception;
	
	public Map<String,Object> getFestivalListDB(Search search) throws Exception;
	
	public void addZzim(Zzim zzim) throws Exception;
	
	public void deleteZzim(Zzim zzim) throws Exception;
	
	public Zzim getZzim(Zzim zzim) throws Exception;
	
	public Map<String,Object> getMyZzimList(Search search , String userId) throws Exception;
	
	public void updateFestival(Festival festival) throws Exception;
	
	public void appendReadCount(Festival festival) throws Exception;
	
	public void deleteFestival(Festival fesitval) throws Exception;
	
	public void writeFestival (Festival festival) throws Exception;
	
	public Weather weather (String festivalLat, String festivalLon) throws Exception;
	
	public Map<String,Object> getAreaCode() throws Exception;
	
	public Map<String,Object> getSigunguCode(String areaCode) throws Exception;
	
	public Map<String,Object> getInitListDB() throws Exception;
	
	public Contents kakaoWeb(String festivalName0) throws Exception;
	
	public Contents kakaoWeb(String festivalName0,String festivalName1,String festivalName2) throws Exception;
	
	public int getTotalZzim(int festivalNo) throws Exception;
	
}
