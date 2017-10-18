package com.codebrew.moana.web.statistics;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.service.domain.Statistics;
import com.codebrew.moana.service.statistics.StatisticsService;

@RestController
@RequestMapping("/statisticsRest/*")
public class StatisticsRestController {

	@Autowired
	@Qualifier("statisticsServiceImpl")
	StatisticsService statisticsService;
	
	public StatisticsRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value="json/getStatistics/{statFlag}")
	public List<Statistics> getSatistics(@PathVariable("statFlag") String statFlag) throws Exception {
		
		List<Statistics> list = statisticsService.getStatistic(statFlag);
		
		return list;
	}
}
