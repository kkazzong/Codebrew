package com.codebrew.moana.service.festival.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Location;
import com.codebrew.moana.service.domain.Weather;
import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalDAO;
import com.codebrew.moana.service.festival.FestivalService;


@Service("festivalServiceImpl")
public class FestivalServiceImpl implements FestivalService{
	
	///Field
	@Autowired
	@Qualifier("festivalDAOImpl")
	private FestivalDAO festivalDAO;
	
	@Autowired
	@Qualifier("tourAPIDAOImpl")
	private FestivalDAO tourAPIDAO;
	
	
	public void setFestivalDAO(FestivalDAO festivalDAO) {
		this.festivalDAO = festivalDAO;
	}
	
	public void setTourAPIDAO(FestivalDAO tourAPIDAO) {
		this.tourAPIDAO = tourAPIDAO;
	}
	
	///Constructor
	public FestivalServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Festival getFestival(int festivalNo) throws Exception {
		// TODO Auto-generated method stub
		
		return tourAPIDAO.getFestival(festivalNo);
		
	}
	
	@Override
	public Map<String,Object> getFestivalList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return tourAPIDAO.getFestivalList(search);
	}

	@Override
	public Map<String, Object> searchKeywordList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return tourAPIDAO.searchKeywordList(search);
	}

	@Override
	public void addFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub
		festivalDAO.addFestival(festival);
	}

	@Override
	public boolean duplication(int festivalNo) throws Exception {
		// TODO Auto-generated method stub
		boolean duplication = true;
		Festival festival  = festivalDAO.getFestivalDB(festivalNo);
		if(festival != null){
			duplication=false;
		}
		return  duplication;
		
		
	}

	@Override
	public Festival getFestivalDB(int festivalNo) throws Exception {
		// TODO Auto-generated method stub
		
		return festivalDAO.getFestivalDB(festivalNo);
		
	}

	@Override
	public Map<String, Object> getFestivalListDB(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		List<Festival> list = festivalDAO.getFestivalListDB(search);
		int totalCount = festivalDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void addZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		festivalDAO.addZzim(zzim);
	}

	@Override
	public Zzim getZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		
		return festivalDAO.getZzim(zzim);
		
	}

	@Override
	public void deleteZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		festivalDAO.deleteZzim(zzim);
		
	}

	@Override
	public void updateFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub
			festivalDAO.updateFestival(festival);
	}

	@Override
	public void appendReadCount(Festival festival) throws Exception {
		// TODO Auto-generated method stub
		festivalDAO.appendReadCount(festival);
	}

	@Override
	public void deleteFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub
		festivalDAO.deleteFestival(festival);
		
	}

	@Override
	public void writeFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub
		festivalDAO.writeFestival(festival);
		
	}

	@Override
	public Weather weather(String festivalLat, String festivalLon) throws Exception {
		// TODO Auto-generated method stub
		return tourAPIDAO.weather(festivalLat,festivalLon);
		
	}

	@Override
	public Map<String,Object> getMyZzimList(Search search,String userId) throws Exception {
		// TODO Auto-generated method stub
		
		List<Zzim> list = festivalDAO.getMyZzimList(search,userId);
		int totalCount = festivalDAO.getTotalCountZzim(search,userId);
		
		System.out.println("서비스임플에서 list......" + list);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public Map<String,Object> getAreaCode() throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = tourAPIDAO.getAreaCode();
		
		return map;
	}
	
}
