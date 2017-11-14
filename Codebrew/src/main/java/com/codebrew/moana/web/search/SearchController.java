package com.codebrew.moana.web.search;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.party.PartyService;
import com.codebrew.moana.service.purchase.PurchaseService;
import com.codebrew.moana.service.review.ReviewService;
import com.codebrew.moana.service.ticket.TicketService;
import com.codebrew.moana.service.user.UserService;

@Controller
@RequestMapping("/search/*")
public class SearchController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	PurchaseService purchaseService;

	@Autowired
	@Qualifier("ticketServiceImpl")
	TicketService ticketService;

	@Autowired
	@Qualifier("partyServiceImpl")
	PartyService partyService;

	@Autowired
	@Qualifier("festivalServiceImpl")
	FestivalService festivalService;
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	ReviewService reviewService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	UserService userService;
	 

	@Value("#{commonProperties['pageUnit']}")
	private int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	private int pageSize;

	public SearchController() {
		System.out.println(this.getClass());
	}

	
	@RequestMapping(value = "getSearchList", method=RequestMethod.POST)
	public ModelAndView getSearchList(HttpSession session,
																	@ModelAttribute("search") Search mainSearch) throws Exception {

		System.out.println("[[MAIN SEARCH]]"+mainSearch);
		
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView modelAndView = new ModelAndView();
		
		if (mainSearch.getCurrentPage() == 0) {
			mainSearch.setCurrentPage(1);
		}
		mainSearch.setPageSize(pageSize);
		
		Page resultPage = null;
		
		switch(mainSearch.getSearchCondition()) {
		
			case "1" :
				System.out.println("회원검색");
				mainSearch.setSearchCondition("2");
				map = userService.getUserList(mainSearch);
				resultPage = new Page(mainSearch.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageSize,pageUnit);
				//modelAndView.setViewName("/view/user/getUserList.jsp");
				modelAndView.setViewName("/view/purchase/getUserList.jsp");
				break;
			case "2" :
				System.out.println("축제검색");
				mainSearch.setSearchCondition("");
				map = festivalService.getFestivalListDB(mainSearch);
				resultPage = new Page(mainSearch.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
				modelAndView.setViewName("/view/festival/getFestivalListDB.jsp");
				break;
			case "3" :
				System.out.println("파티검색");
				mainSearch.setSearchCondition("");
				map = partyService.getPartyList(mainSearch);
				resultPage = new Page(mainSearch.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
				modelAndView.setViewName("/view/party/getPartyList.jsp");
				break;
			case "4" :
				System.out.println("후기검색");
				mainSearch.setSearchCondition("0");
				map = reviewService.getReviewList(mainSearch);
				resultPage = new Page(mainSearch.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
				modelAndView.setViewName("/view/review/getReviewList.jsp");
				break;
		
		}
		
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("search", mainSearch);
		modelAndView.addObject("resultPage", resultPage);
		
		return modelAndView;
	}
	
}
