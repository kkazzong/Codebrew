package com.codebrew.moana.service.statistics.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.service.domain.Statistics;
import com.codebrew.moana.service.statistics.StatisticsDAO;
import com.codebrew.moana.service.statistics.StatisticsService;

@Service("statisticsServiceImpl")
public class StatisticsServiceImpl implements StatisticsService {

	@Autowired
	@Qualifier("statisticsDAOImpl")
	StatisticsDAO statisticsDAO;
	
	public StatisticsServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public List<Statistics> getStatistic(String statFlag) {
		
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

}
