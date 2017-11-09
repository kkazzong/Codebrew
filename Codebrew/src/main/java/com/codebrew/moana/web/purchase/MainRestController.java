package com.codebrew.moana.web.purchase;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.party.PartyService;
import com.codebrew.moana.service.purchase.PurchaseService;
import com.codebrew.moana.service.statistics.StatisticsService;
import com.codebrew.moana.service.ticket.TicketService;

@RestController
@RequestMapping("/mainRest/*")
public class MainRestController {

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
	@Qualifier("statisticsServiceImpl")
	StatisticsService statisticsService;
	
	@Value("#{commonProperties['pageSize']}")
	private int pageSize;
	
	@Value("#{commonProperties['pageUnit']}")
	private int pageUnit;
	
	public MainRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value = "json/getFestivalListDB/{menu}")
	public List getFestivalListDB(@ModelAttribute("search") Search search,
														@ModelAttribute("page") Page page,
														@PathVariable("menu") String menu) throws Exception {
		
		System.out.println("search 확인 : " + search);
		
		System.out.println("menu 확인........" + menu);

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = festivalService.getFestivalListDB(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		//ModelAndView modelAndView = new ModelAndView();
		List<Festival> list = (List<Festival>)map.get("list");
		int index = 0;
		List<Festival> returnList = new ArrayList<Festival>();
		while(index < 3) {
			returnList.add(list.get(index));
			index++;
		}
		
		return returnList;
	}
	
	@RequestMapping( value="json/getPartyList/{partyFlag}", method=RequestMethod.GET)
	public List<Party> getPartyList( @RequestParam(value="festivalNo", required=false) String festivalNo, 
																	@PathVariable(value="partyFlag") String partyFlag ) throws Exception {
		
		System.out.println("\n>>> /party/getPartyList :: GET start <<<");
		
		Search search = new Search();
		
		if( festivalNo != null) {
			//festivalNo 파라미터 출력
			System.out.println(">>> /party/getPartyList :: GET :: festivalNo 파라미터 \n"+festivalNo); 
			search.setSearchCondition("5");
			search.setSearchKeyword(festivalNo);
		}else if( partyFlag != null && partyFlag.equals("1") ){
			search.setSearchCondition("1");
		}else if(partyFlag != null && partyFlag.equals("2") ) {
			search.setSearchCondition("2");
		}
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("\n<<< /party/getPartyList :: GET :: search 도메인\n"+search);
		
		
		//Business Logic
		Map<String, Object> map = partyService.getPartyList(search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
	
		List<Party> list = (List<Party>)map.get("list");
		int index = 0;
		List<Party> returnList = new ArrayList<Party>();
		while(index < 3) {
			returnList.add(list.get(index));
			index++;
		}
		
		//Model(data) & View(jsp)
		/*ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/view/party/getPartyList.jsp");*/
		
		return returnList;
		
	}
}
