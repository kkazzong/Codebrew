package com.codebrew.moana.service.statistics.impl;

import org.springframework.stereotype.Service;

import com.codebrew.moana.service.statistics.StatisticsService;

@Service("statisticsServiceImpl")
public class StatisticsServiceImpl implements StatisticsService {

	public StatisticsServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}
