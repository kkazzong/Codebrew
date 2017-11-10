package com.codebrew.moana.web.statistics;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.service.domain.Statistics;
import com.codebrew.moana.service.domain.User;
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
	public ModelAndView getStatistics(@RequestParam(value="statFlag",  required=false) String statFlag, HttpSession session) {
		
		ModelAndView modelAndView = new ModelAndView();
		
		User user = (User)session.getAttribute("user");
		if(!user.getRole().equals("a")) {
			modelAndView.setViewName("/index.jsp");
			return modelAndView;
		}
		
		System.out.println("statFlag => "+statFlag);
		
		if(statFlag == null) {
			statFlag = "1";
		}
		
		Statistics statistics = new Statistics();
		statistics.setStatFlag(statFlag);
		
		modelAndView.addObject("statistics", statistics);
		modelAndView.setViewName("/view/statistics/getStatistics.jsp");
		//modelAndView.setView(new RedirectView("/view/statistics/getStatistics.jsp"));
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="getFestivalZzim", method=RequestMethod.GET)
	public ModelAndView getFestivalZzim() throws Exception {
		
		List<Statistics> list = statisticsService.getFestivalZzim();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("statList", list);
		//modelAndView.addObject("festivalList", map.get("festivalList"));
		modelAndView.setViewName("/view/statistics/getFestivalZzim.jsp");
		return modelAndView;
		
	}
	
	@RequestMapping(value="getFestivalRating", method=RequestMethod.GET)
	public ModelAndView getFestivalRating() throws Exception {
		
		List<Statistics> list = statisticsService.getFestivalRating();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", list);
		//modelAndView.addObject("festivalList", map.get("festivalList"));
		modelAndView.setViewName("/view/statistics/getFestivalRating.jsp");
		return modelAndView;
		
	}
	
	@RequestMapping(value="getPartyCount", method=RequestMethod.GET)
	public ModelAndView getPartyCount() throws Exception {
		
		List<Statistics> list = statisticsService.getPartyCount();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", list);
		//modelAndView.addObject("festivalList", map.get("festivalList"));
		modelAndView.setViewName("/view/statistics/getPartyCount.jsp");
		return modelAndView;
		
	}

}

