package com.codebrew.moana.service.statistics.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Statistics;
import com.codebrew.moana.service.festival.FestivalDAO;
import com.codebrew.moana.service.party.PartyDAO;
import com.codebrew.moana.service.statistics.StatisticsDAO;
import com.codebrew.moana.service.statistics.StatisticsService;

@Service("statisticsServiceImpl")
public class StatisticsServiceImpl implements StatisticsService {

	@Autowired
	@Qualifier("statisticsDAOImpl")
	StatisticsDAO statisticsDAO;
	
	@Autowired
	@Qualifier("festivalDAOImpl")
	FestivalDAO festivalDAO;
	
	@Autowired
	@Qualifier("partyDAOImpl")
	PartyDAO partyDAO;
	
	public StatisticsServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public List<Statistics> getStatistic(String statFlag) throws Exception {
		
		List<Statistics> list = new ArrayList<Statistics>();
		
		switch(statFlag) {
			case "1" : //일단위
				list = statisticsDAO.getDailyTotalSaleAmountStat();
				break;
			case "2" : //월단위
				list = statisticsDAO.getMonthlyTotalSaleAmountStat();
				break;
			case "3" : //분기단위
				list = statisticsDAO.getQuarterTotalSaleAmountStat();
				break;
		}
		return list;
	}

	@Override
	public List<Statistics> getStatistic(Statistics statistics) throws Exception {
		List<Statistics> list = new ArrayList<Statistics>();
		
		switch(statistics.getStatFlag()) {
			case "1" : //일단위
				//list = statisticsDAO.getDailyTotalSaleAmountStat();
				list = statisticsDAO.getDailyTotalSaleAmountStat(statistics);
				break;
			case "2" : //월단위
				//list = statisticsDAO.getMonthlyTotalSaleAmountStat();
				list = statisticsDAO.getMonthlyTotalSaleAmountStat(statistics);
				break;
			case "3" : //분기단위
				//list = statisticsDAO.getQuarterTotalSaleAmountStat();
				list = statisticsDAO.getQuarterTotalSaleAmountStat(statistics);
				break;
		}

		return list;
	}

	@Override
	public List<Statistics> getFestivalZzim() throws Exception {
		
		/*Map<String, Object> map = new HashMap<String, Object>();
		List<Statistics> list =  statisticsDAO.getFestivalZzim();
		List<Festival> festivalList = new ArrayList<Festival>(); 
	
		for(Statistics stat : list) {
			festivalList.add(festivalDAO.getFestivalDB(Integer.parseInt(stat.getStatDate())));
		}
		map.put("list", list);
		map.put("festivalList", festivalList);
		
		return map;*/
		return statisticsDAO.getFestivalZzim();
	}

	@Override
	public List<Statistics> getFestivalRating() throws Exception {
		return statisticsDAO.getFestivalRating();
	}

	@Override
	public List<Statistics> getPartyCount() throws Exception {
		return statisticsDAO.getPartyCount();
	}
	
	

}
