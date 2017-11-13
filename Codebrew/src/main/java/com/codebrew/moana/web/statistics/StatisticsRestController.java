package com.codebrew.moana.web.statistics;

import java.util.Date;
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.common.CommonUtil;
import com.codebrew.moana.common.Search;
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
	public List<Statistics> getSatistics(@PathVariable("statFlag") String statFlag
																) throws Exception {
		
		List<Statistics> list = statisticsService.getStatistic(statFlag);
		
		return list;
	}
	
	@RequestMapping(value="json/getMonthlyStatistics", method=RequestMethod.GET)
	public Map getSatistics() throws Exception {
		
		List<Statistics> list = statisticsService.getStatistic("2");
		List<Statistics> current = new ArrayList<Statistics>();
		List<Statistics> last = new ArrayList<Statistics>();
		String curYear = new GregorianCalendar(Locale.KOREA).get(Calendar.YEAR)+"";
		curYear = curYear.trim();
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(curYear);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		for(Statistics stat : list) {
			String date = CommonUtil.toDateStr(stat.getStatDate());
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			date = date.substring(0, 4);
			System.out.println(date);
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			if(date.equals(curYear) ) {
				current.add(stat);
			} else {
				last.add(stat);
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("current", current);
		map.put("last", last);
		return map;
	}
	
	@RequestMapping(value="json/getMonthlyStatistics", method=RequestMethod.POST)
	public Map getMonthlySatistics(@RequestBody Statistics statistics) throws Exception {
		
		List<Statistics> list = statisticsService.getStatistic(statistics);
		List<Statistics> current = new ArrayList<Statistics>();
		List<Statistics> last = new ArrayList<Statistics>();
		String curYear = new GregorianCalendar(Locale.KOREA).get(Calendar.YEAR)+"";
		curYear = curYear.trim();
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(curYear);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		for(Statistics stat : list) {
			String date = CommonUtil.toDateStr(stat.getStatDate());
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			date = date.substring(0, 4);
			System.out.println(date);
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			if(date.equals(curYear) ) {
				current.add(stat);
			} else {
				last.add(stat);
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("current", current);
		map.put("last", last);
		return map;
	}
	
	/*@RequestMapping(value="json/getStatistics/{searchCondition}", method=RequestMethod.POST)
	public List<Statistics> getSatistics(@RequestBody Statistics statistics,
																@PathVariable String searchCondition) throws Exception {
		
		System.out.println(statistics);
		
		Search search = null;
		if(searchCondition != null) {
			search = new Search();
			search.setSearchCondition(searchCondition);
		}
		
		List<Statistics> list = statisticsService.getStatistic(statistics, search);
		
		return list;
	}*/
	
	@RequestMapping(value="json/getStatistics", method=RequestMethod.POST)
	public List<Statistics> getSatistics(@RequestBody Statistics statistics
																/*@PathVariable String searchCondition*/) throws Exception {
		
		System.out.println(statistics);
		
		Search search = null;
		
		List<Statistics> list = statisticsService.getStatistic(statistics);
		
		return list;
	}
	
	@RequestMapping(value="json/getPartyCount", method=RequestMethod.GET)
	public List<Statistics> getPartyCount() throws Exception {
		
		List<Statistics> list = statisticsService.getPartyCount();
		
		/*int index = 0;
		List<Statistics> returnList = new ArrayList<Statistics>();
		while(index < 4) {
			returnList.add(list.get(index));
			index++;
		}*/
		
		return list;
		//ModelAndView modelAndView = new ModelAndView();
		//modelAndView.addObject("list", list);
		//modelAndView.addObject("festivalList", map.get("festivalList"));
		//modelAndView.setViewName("/view/statistics/getPartyCount.jsp");
		//return modelAndView;
		
	}
	
	
	@RequestMapping(value="json/getTotalCount", method=RequestMethod.GET)
	public List<Statistics> getTotalCount() throws Exception {
		
		List<Statistics> list = statisticsService.getTotalCount();
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
