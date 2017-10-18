package com.codebrew.moana.web.statistics;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.service.domain.Statistics;
import com.codebrew.moana.service.statistics.StatisticsService;

@Controller
@RequestMapping("/statistics/*")
public class StatisticsController {

	@Autowired
	@Qualifier("statisticsServiceImpl")
	StatisticsService statisticsService;
	
	public StatisticsController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="getStatistics", method=RequestMethod.GET)
	public ModelAndView getStatistics(@RequestParam(value="statFlag",  required=false) String statFlag) {
		
		System.out.println("statFlag => "+statFlag);
		
		if(statFlag == null) {
			statFlag = "1";
		}
		
		Statistics statistics = new Statistics();
		statistics.setStatFlag(statFlag);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("statistics", statistics);
		modelAndView.setViewName("/view/statistics/getStatistics.jsp");
		//modelAndView.setView(new RedirectView("/view/statistics/getStatistics.jsp"));
		
		return modelAndView;
		
	}

}

