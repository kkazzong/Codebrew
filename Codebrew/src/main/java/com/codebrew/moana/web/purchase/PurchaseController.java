package com.codebrew.moana.web.purchase;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.purchase.PurchaseService;
import com.codebrew.moana.service.ticket.TicketService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("ticketServiceImpl")
	TicketService ticketService;
	
	/*@Autowired
	@Qualifier("partyServiceImpl")
	PartyService partyService;*/
	
	@Autowired
	@Qualifier("festivalServiceImpl")
	FestivalService festivalService;
	
	/*@Autowired
	@Qualifier("userServiceImpl")
	UserService userService;*/
	
	@Value("#{commonProperties['pageUnit']}")
	private int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	private int pageSize;
	
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public ModelAndView addPurchase(@RequestParam(value="festivalNo", required=false) String festivalNo,
																@RequestParam(value="partyNo", required=false) String partyNo) throws Exception {
		
		User user = new User();
		//user.setUserId("user04@naver.com");
		//user.setNickname("까종");
		user.setUserId("user03@naver.com");
		user.setNickname("썽경");
		
		System.out.println("축제라면 : "+festivalNo+" 파티라면 : "+partyNo);
		ModelAndView modelAndView = new ModelAndView();
		if(festivalNo != null) {
			System.out.println("디즈이즈 축제");
			/*Festival festival = new Festival();
			festival.setFestivalNo(2510101);
			festival.setFestivalName("예술로 산책로 2017");
			festival.setAddr("서울특별시 종로구 효자로13길 45");
			festival.setStartDate("20170930");
			festival.setEndDate("20171118");
			festival.setFestivalImage("http://tong.visitkorea.or.kr/cms/resource/97/2510097_image2_1.jpg");
			festival.setTicketCount(30);
			festival.setTicketPrice(1000);*/
			Festival festival = festivalService.getFestival(Integer.parseInt(festivalNo));
			
			Ticket ticket = ticketService.getTicket(festival.getFestivalNo(), "1");
			
			modelAndView.addObject("ticket", ticket);
			modelAndView.addObject("festival", festival);
			modelAndView.addObject("purchaseFlag", "1");
		} else {
			System.out.println("아모루파티");
			Party party = new Party();
			party.setPartyNo(10000);
			party.setPartyName("할로윈 파티");
			party.setPartyImage("1507724033981_party1.jpg");
			party.setPartyPlace("서울특별시 서초구 강남대로53길 8 비트아카데미빌딩");
			party.setPartyTime("20시00분");
			party.setTicketCount(50);
			party.setTicketPrice(500);
			
			//Party party = partyService.getParty(partyNo);
			
			Ticket ticket = ticketService.getTicket(party.getPartyNo(), "2");
			
			modelAndView.addObject("ticket", ticket);
			modelAndView.addObject("party", party);
			modelAndView.addObject("purchaseFlag", "2");
		}
		modelAndView.addObject("user", user);
		modelAndView.setViewName("/view/purchase/addPurchase.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase) {
		
		Ticket ticket = ticketService.getTicketByTicketNo(purchase.getTicket().getTicketNo());
		
		if(ticket.getFestival() != null) {
			purchase.setItemName(ticket.getFestival().getFestivalName());
		} else if(ticket.getParty() != null) {
			purchase.setItemName(ticket.getParty().getPartyName());
		}
		
		System.out.println("@@@@controller purchase : "+purchase);
		purchaseService.addPurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/purchase/getPurchaseList");
		
		return modelAndView;
	}
	
	@RequestMapping(value="approvePayment")
	public ModelAndView approvePurchase(@RequestParam("pg_token") String pgToken) {
		
		System.out.println(pgToken);
		
		Purchase purchase = purchaseService.approvePayment(pgToken);
		purchase = purchaseService.addPurchase(purchase);
		System.out.println(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/view/purchase/approvePayment.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="getPurchaseList")
	public ModelAndView getPurchaseList(@RequestParam("userId") String userId,
																	@ModelAttribute("search") Search search,
																	@RequestParam(value="purchaseFlag", required=false) String purchaseFlag) {
		
		System.out.println(userId);
		User user = new User();
		//user.setUserId(userId);
		//user.setNickname("�����");
		
		/*if(purchaseFlag == null) {
			purchaseFlag = "1"; //default is festival
		} */
		System.out.println(purchaseFlag);
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getPurchaseList(userId, purchaseFlag, search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)(map.get("totalCount"))).intValue(), pageUnit, pageSize);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("/view/purchase/getPurchaseList.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getSaleList")
	public ModelAndView getSaleList(@ModelAttribute("search") Search search) {

		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)(map.get("totalCount"))).intValue(), pageUnit, pageSize);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("/view/purchase/getSaleList.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public ModelAndView getPurchase(@RequestParam("purchaseNo") int purchaseNo) {
		
		System.out.println(purchaseNo);
		
		Purchase purchase = purchaseService.getPurchase(purchaseNo);
		Ticket ticket = ticketService.getTicketByTicketNo(purchase.getTicket().getTicketNo());
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.addObject("ticket", ticket);
		modelAndView.setViewName("/view/purchase/getPurchase.jsp");
		
		return modelAndView;
		
	}
	
	
	
	/*public ModelAndView addFestival(@ModelAttribute("festival") Festival festival) {
		
		System.out.println("Festival ������ : "+festival);
		
		festivalService.addFestival(festival); //���� ���� insert
		
		 Ticket �����ο� setting�� ���ֽø� �ʴ�
		Ticket ticket = new Ticket();
		ticket.setFestival(festival);
		ticket.setTicketPrice(festival.getTicketPrice());
		ticket.setTicketCount(festival.getTicketCount());
		
		�׷��� ���� addTicket()ȣ�� ���ּ�����
		ticketService.addTicket(ticket);
		
		
	}
	
	
	public ModelAndView getFestival(@RequestParam("festivalNo") int festivalNo) {
		
		Ƽ�ϼ���, Ƽ�ϰ��� get�ϰ� ������ ��ȣ�� �÷��� �����ּ���
		Ticket ticket = ticketService.getTicket(festivalNo, "1");
		
		System.out.println("Ƽ�ϵ����� : "+ticket);
		System.out.println("����  = "+ticket.getTicketCount()+", ���� = "+ticket.getTicketPrice());
		
	}
	
	public ModelAndView updateFestival(@ModelAttribute("festival") Festival festival) {
		
		partyService.updateParty(~~~); //��Ƽ���� update
		
		Ƽ�ϼ����� ������ Ƽ�ϵ����ο� ��Ƽ� ��������~
		Ticket ticket = new Ticket();
		ticket.setFestival(festival);
		ticket.setTicketPrice(festival.getTicketPrice());
		ticket.setTicketCount(festival.getTicketCount());
		
		Ticket ticket = ticketService.updateTicket(ticket);
		
		System.out.println("Ƽ�ϵ����� : "+ticket);
		System.out.println("����  = "+ticket.getTicketCount()+", ���� = "+ticket.getTicketPrice());
		
	}
	
	public ModelAndView addParty(@ModelAttribute("party") Party party) {
		
		System.out.println("Festival ������ : "+party);
		
		partyService.addParty(party); //��Ƽ ���� insert
		
		 Ticket �����ο� setting�� ���ֽø� �ʴ�
		Ticket ticket = new Ticket();
		ticket.setParty(party);
		ticket.setTicketPrice(party.getTicketPrice());
		ticket.setTicketCount(party.getTicketCount());
		
		�׷��� ���� addTicket()ȣ�� ���ּ�����
		ticketService.addTicket(ticket);
		
	}
	
	public ModelAndView getParty(@RequestParam("partyNo") int partyNo) {
		
		Ƽ�ϼ���, Ƽ�ϰ��� get�ϰ� ������ ��ȣ�� �÷��� �����ּ���
		Ticket ticket = ticketService.getTicket(partyNo, "2");
		
		System.out.println("Ƽ�ϵ����� : "+ticket);
		System.out.println("����  = "+ticket.getTicketCount()+", ���� = "+ticket.getTicketPrice());
	}	
	
	
	public ModelAndView updateParty(@ModelAttribute("party") Party party) {
		
		partyService.updateParty(~~~); //��Ƽ���� update
		
		Ƽ�ϼ����� ������ Ƽ�ϵ����ο� ��Ƽ� ��������~
		Ticket ticket = new Ticket();
		ticket.setParty(party);
		ticket.setTicketPrice(party.getTicketPrice());
		ticket.setTicketCount(party.getTicketCount());
		
		Ticket ticket = ticketService.updateTicket(ticket);
		
		System.out.println("Ƽ�ϵ����� : "+ticket);
		System.out.println("����  = "+ticket.getTicketCount()+", ���� = "+ticket.getTicketPrice());
		
	}*/
}
