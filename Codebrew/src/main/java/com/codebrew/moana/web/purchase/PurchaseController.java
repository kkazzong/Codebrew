package com.codebrew.moana.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.party.PartyService;
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

	@Autowired
	@Qualifier("partyServiceImpl")
	PartyService partyService;

	@Autowired
	@Qualifier("festivalServiceImpl")
	FestivalService festivalService;

	/*
	 * @Autowired
	 * 
	 * @Qualifier("userServiceImpl") UserService userService;
	 */

	@Value("#{commonProperties['pageUnit']}")
	private int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	private int pageSize;

	public PurchaseController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "addPurchase", method = RequestMethod.GET)
	public ModelAndView addPurchase(HttpSession session, RedirectAttributes redirectAttributes,
			@RequestParam(value = "festivalNo", required = false) String festivalNo,
			@RequestParam(value = "partyNo", required = false) String partyNo) throws Exception {

		System.out.println("축제라면 : " + festivalNo + " 파티라면 : " + partyNo);

		// 세션체크
		User user = (User) session.getAttribute("user");

		ModelAndView modelAndView = new ModelAndView();
		Ticket ticket = null;

		if (festivalNo != null) {

			System.out.println("디즈이즈 축제");

			Festival festival = festivalService.getFestival(Integer.parseInt(festivalNo));
			ticket = ticketService.getTicket(festival.getFestivalNo(), "1");

			//redirectAttributes.addFlashAttribute("festival", festival.getClass());
			modelAndView.addObject("festival", festival);
			modelAndView.addObject("purchaseFlag", "1");

		} else {

			System.out.println("아모루파티");

			Party party = partyService.getParty(Integer.parseInt(partyNo));
			ticket = ticketService.getTicket(party.getPartyNo(), "2");

			modelAndView.addObject("party", party);
			modelAndView.addObject("purchaseFlag", "2");

		}
		modelAndView.addObject("ticket", ticket);
		modelAndView.addObject("user", user);
		

		modelAndView.setViewName("/view/purchase/addPurchase.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "addPurchase", method = RequestMethod.POST)
	public ModelAndView addPurchase(HttpSession session, @ModelAttribute("purchase") Purchase purchase) throws Exception {

		Ticket ticket = ticketService.getTicketByTicketNo(purchase.getTicket().getTicketNo());

		if (ticket.getFestival() != null) {
			purchase.setItemName(ticket.getFestival().getFestivalName());
		} else if (ticket.getParty() != null) {
			purchase.setItemName(ticket.getParty().getPartyName());
		}

		String path = session.getServletContext().getRealPath("/");
		purchaseService.addPurchase(purchase, path);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/purchase/getPurchaseList");

		return modelAndView;
	}

	@RequestMapping(value = "approvePayment")
	public ModelAndView approvePurchase(HttpSession session, @RequestParam("pg_token") String pgToken) throws Exception {

		System.out.println(pgToken);
		String path = session.getServletContext().getRealPath("/");
		path += "\\resources\\image\\QRCodeImage";
		System.out.println(path);
		Purchase purchase = purchaseService.approvePayment(pgToken, path);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/view/purchase/approvePayment.jsp");

		return modelAndView;

	}

	@RequestMapping(value = "getPurchaseList")
	public ModelAndView getPurchaseList(HttpSession session,
																	@ModelAttribute("search") Search search,
																	@RequestParam(value = "purchaseFlag", required = false) String purchaseFlag) {

		// System.out.println(session.getAttribute("user"));
		User user = (User) session.getAttribute("user");
		// user.setUserId(userId);
		// user.setNickname("�����");

		/*
		 * if(purchaseFlag == null) { purchaseFlag = "1"; //default is festival }
		 */
		System.out.println(purchaseFlag);

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println(search);
		Map<String, Object> map = purchaseService.getPurchaseList(user.getUserId(), purchaseFlag, search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) (map.get("totalCount"))).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		modelAndView.setViewName("/view/purchase/getPurchaseList.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "deletePurchase")
	public ModelAndView deletePurchaseList(HttpSession session, RedirectAttributes redirectAttributes) {

		User user = (User) session.getAttribute("user");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/getPurchaseList");

		return modelAndView;
	}

	@RequestMapping(value = "getSaleList")
	public ModelAndView getSaleList(@ModelAttribute("search") Search search) {

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = purchaseService.getSaleList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) (map.get("totalCount"))).intValue(), pageUnit,
				pageSize);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("/view/purchase/getSaleList.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "getPurchase", method = RequestMethod.GET)
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

	/*
	 * public ModelAndView addFestival(@ModelAttribute("festival") Festival
	 * festival) {
	 * 
	 * System.out.println("Festival ������ : "+festival);
	 * 
	 * festivalService.addFestival(festival); //���� ���� insert
	 * 
	 * Ticket �����ο� setting�� ���ֽø� �ʴ� Ticket ticket = new Ticket();
	 * ticket.setFestival(festival);
	 * ticket.setTicketPrice(festival.getTicketPrice());
	 * ticket.setTicketCount(festival.getTicketCount());
	 * 
	 * �׷��� ���� addTicket()ȣ�� ���ּ����� ticketService.addTicket(ticket);
	 * 
	 * 
	 * }
	 * 
	 * 
	 * public ModelAndView getFestival(@RequestParam("festivalNo") int festivalNo) {
	 * 
	 * Ƽ�ϼ���, Ƽ�ϰ��� get�ϰ� ������ ��ȣ�� �÷��� �����ּ��� Ticket ticket =
	 * ticketService.getTicket(festivalNo, "1");
	 * 
	 * System.out.println("Ƽ�ϵ����� : "+ticket);
	 * System.out.println("����  = "+ticket.getTicketCount()+", ���� = "+ticket.
	 * getTicketPrice());
	 * 
	 * }
	 * 
	 * public ModelAndView updateFestival(@ModelAttribute("festival") Festival
	 * festival) {
	 * 
	 * partyService.updateParty(~~~); //��Ƽ���� update
	 * 
	 * Ƽ�ϼ����� ������ Ƽ�ϵ����ο� ��Ƽ� ��������~ Ticket ticket = new Ticket();
	 * ticket.setFestival(festival);
	 * ticket.setTicketPrice(festival.getTicketPrice());
	 * ticket.setTicketCount(festival.getTicketCount());
	 * 
	 * Ticket ticket = ticketService.updateTicket(ticket);
	 * 
	 * System.out.println("Ƽ�ϵ����� : "+ticket);
	 * System.out.println("����  = "+ticket.getTicketCount()+", ���� = "+ticket.
	 * getTicketPrice());
	 * 
	 * }
	 * 
	 * public ModelAndView addParty(@ModelAttribute("party") Party party) {
	 * 
	 * System.out.println("Festival ������ : "+party);
	 * 
	 * partyService.addParty(party); //��Ƽ ���� insert
	 * 
	 * Ticket �����ο� setting�� ���ֽø� �ʴ� Ticket ticket = new Ticket();
	 * ticket.setParty(party); ticket.setTicketPrice(party.getTicketPrice());
	 * ticket.setTicketCount(party.getTicketCount());
	 * 
	 * �׷��� ���� addTicket()ȣ�� ���ּ����� ticketService.addTicket(ticket);
	 * 
	 * }
	 * 
	 * public ModelAndView getParty(@RequestParam("partyNo") int partyNo) {
	 * 
	 * Ƽ�ϼ���, Ƽ�ϰ��� get�ϰ� ������ ��ȣ�� �÷��� �����ּ��� Ticket ticket =
	 * ticketService.getTicket(partyNo, "2");
	 * 
	 * System.out.println("Ƽ�ϵ����� : "+ticket);
	 * System.out.println("����  = "+ticket.getTicketCount()+", ���� = "+ticket.
	 * getTicketPrice()); }
	 * 
	 * 
	 * public ModelAndView updateParty(@ModelAttribute("party") Party party) {
	 * 
	 * partyService.updateParty(~~~); //��Ƽ���� update
	 * 
	 * Ƽ�ϼ����� ������ Ƽ�ϵ����ο� ��Ƽ� ��������~ Ticket ticket = new Ticket();
	 * ticket.setParty(party); ticket.setTicketPrice(party.getTicketPrice());
	 * ticket.setTicketCount(party.getTicketCount());
	 * 
	 * Ticket ticket = ticketService.updateTicket(ticket);
	 * 
	 * System.out.println("Ƽ�ϵ����� : "+ticket);
	 * System.out.println("����  = "+ticket.getTicketCount()+", ���� = "+ticket.
	 * getTicketPrice());
	 * 
	 * }
	 */
}
