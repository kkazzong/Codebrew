package com.codebrew.moana.web.statistics;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

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

	
	@RequestMapping(value="json/getStatistics/{statFlag}", method=RequestMethod.GET)
	public List<Statistics> getSatistics(@PathVariable("statFlag") String statFlag) throws Exception {
		
		List<Statistics> list = statisticsService.getStatistic(statFlag);
		
		return list;
	}
	
	@RequestMapping(value="json/getStatistics", method=RequestMethod.POST)
	public List<Statistics> getSatistics(@RequestBody Statistics statistics) throws Exception {
		
		System.out.println(statistics);
		
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
		
		List<Statistics> list = statisticsService.getStatistic(statistics);
		
		return list;
	}
	
	/*@RequestMapping(value="/json/getFestivalZzim", method=RequestMethod.GET)
	public ModelAndView getFestivalZzim() throws Exception {
		
		List<Statistics> list = statisticsService.getFestivalZzim();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", list);
		//modelAndView.addObject("festivalList", map.get("festivalList"));
		modelAndView.setViewName("/view/statistics/getFestivalZzim.jsp");
		return modelAndView;
		
	}*/
}
