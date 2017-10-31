package com.codebrew.moana.web.festival;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.ticket.TicketService;

@RestController
@RequestMapping("/festivalRest/*")
public class FestivalRestController {

	@Autowired
	@Qualifier("festivalServiceImpl")
	private FestivalService festivalService;

	@Autowired
	@Qualifier("ticketServiceImpl")
	private TicketService ticketService;

	public FestivalRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{imageRepositoryProperties['fileRoot']}")
	String fileRoot;
	
	@RequestMapping(value = "/json/getAreaCode")
	public Map<String, Object> getAreaCode () throws Exception {

		System.out.println("json/getAreaCode........");
		
		Map<String,Object> map = new HashMap<String,Object>();
		
			map = festivalService.getAreaCode();
			
			System.out.println("레스트에서 map....." + map);
			
			return map;


		}



	@RequestMapping(value = "/json/addZzim/{userId}/{festivalNo}")
	public Zzim addZzim(@PathVariable("userId") String userId, @PathVariable("festivalNo") int festivalNo)
			throws Exception {

		System.out.println("json/addZzim........");
		System.out.println("festivalNo : " + festivalNo);
		System.out.println("userId : " + userId);

		Zzim returnZzim = new Zzim(userId, festivalNo);

		if (festivalService.getZzim(returnZzim) == null) {

			System.out.println("addZzim 댐");

			festivalService.addZzim(returnZzim);

			return returnZzim;

		} else {

			System.out.println("deleteZzim~~~~~~~~~~~");

			festivalService.deleteZzim(returnZzim);

			returnZzim = null;

			return returnZzim;

		}

	}

	@RequestMapping(value = "/json/deleteZzim/{userId}/{festivalNo}")
	public Zzim deleteZzim(@PathVariable("userId") String userId, @PathVariable("festivalNo") int festivalNo)
			throws Exception {

		System.out.println("json/deleteZzim........");

		System.out.println("deleteZzim userId........." + userId + "," + festivalNo);

		Zzim returnZzim = new Zzim(userId, festivalNo);

		festivalService.deleteZzim(returnZzim);

		// returnZzim=null;

		System.out.println("returnZzim 확인 : " + returnZzim);

		return returnZzim;

	}

	@RequestMapping(value = "json/getZzim", method = RequestMethod.GET)
	public Zzim getZzim(@RequestParam String userId, @RequestParam int festivalNo) throws Exception {

		System.out.println("getZzim........");

		Zzim zzim = new Zzim();

		zzim.setUserId(userId);
		zzim.setFestivalNo(festivalNo);

		Zzim returnZzim = festivalService.getZzim(zzim);

		return returnZzim;

	}

	@RequestMapping(value = "json/getFestivalDB/{festivalNo}")
	public Festival getFestivalDB(@PathVariable ("festivalNo") int festivalNo) throws Exception {
		
		System.out.println("rest getFDB............." + festivalNo);

		Festival festival = festivalService.getFestivalDB(festivalNo);
		
		System.out.println("restful getFestivalDB Check..." + festival);

		return festival;

	}

}
