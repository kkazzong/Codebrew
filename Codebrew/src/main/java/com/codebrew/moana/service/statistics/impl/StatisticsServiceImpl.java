package com.codebrew.moana.service.statistics.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
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
		
		if(statistics.getStatDate() != null && statistics.getStatDate() != "") {
			
			String date = statistics.getStatDate();
			System.out.println("date->"+date);
			String[] dates = date.split(" - ");
			System.out.println("date->"+dates);
			
			switch(statistics.getStatFlag()) {
			
			case "1" :
				//어제 혹은 오늘
				if(dates[0].equals(dates[1])) {
					statistics.setStartDate(dates[0]);
				} else {
					statistics.setStartDate(dates[0]);
					statistics.setEndDate(dates[1]);
				}
				break;
				
			case "2" :
				System.out.println(dates[0].substring(0, 7));
				System.out.println(dates[1].substring(0, 7));
				if((dates[0].substring(0, 7)).compareTo(dates[1].substring(0, 7)) == 0) {
					System.out.println("이번달이네유");
					statistics.setStartDate(dates[0].substring(0, 7));
				} else {
					statistics.setStartDate(dates[0].substring(0, 7));
					statistics.setEndDate(dates[1].substring(0, 7));
				}
				break;
				
			case "3" :
				statistics.setStartDate(dates[0]);
				break;
			}
			
		}
		
		List<Statistics> list = new ArrayList<Statistics>();
		
		switch(statistics.getStatFlag()) {
			case "1" : //일단위
				//list = statisticsDAO.getDailyTotalSaleAmountStat();
				list = statisticsDAO.getDailyTotalSaleAmountStat(statistics);
				break;
			case "2" : //월단위
				list = statisticsDAO.getMonthlyTotalSaleAmountStat(statistics);
				/*Map<String, Object> map = new HashMap<String, Object>();
				map.put("statistics", statistics);
				map.put("search", search);
				list = statisticsDAO.getMonthlyTotalSaleAmountStat(map);*/
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

	@Override
	public List<Statistics> getTotalCount() throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAO.getTotalCount();
	}

	

}
