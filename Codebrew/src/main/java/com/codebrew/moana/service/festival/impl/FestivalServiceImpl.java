package com.codebrew.moana.service.festival.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.festival.FestivalDAO;
import com.codebrew.moana.service.festival.FestivalService;


@Service("festivalServiceImpl")
public class FestivalServiceImpl implements FestivalService{
	
	///Field
	@Autowired
	@Qualifier("festivalDAOImpl")
	private FestivalDAO festivalDAO;
	
	
	public void setFestivalDAO(FestivalDAO festivalDAO) {
		this.festivalDAO = festivalDAO;
	}
	
	///Constructor
	public FestivalServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Festival getFestival(int festivalNo) throws Exception {
		// TODO Auto-generated method stub
		
		return festivalDAO.getFestival(festivalNo);
		
	}
	
	@Override
	public Map<String,Object> getFestivalList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return festivalDAO.getFestivalList(search);
	}

	@Override
	public Map<String, Object> searchKeywordList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return festivalDAO.searchKeywordList(search);
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
	
	
}
