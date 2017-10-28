package com.codebrew.moana.web.purchase;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Bank;
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

			Festival festival = festivalService.getFestivalDB(Integer.parseInt(festivalNo));
			ticket = ticketService.getTicket(festival.getFestivalNo(), "1");

			//redirectAttributes.addFlashAttribute("festival", festival.getClass());
			modelAndView.addObject("festival", festival);
			modelAndView.addObject("purchaseFlag", "1");

		} else {

			System.out.println("아모루파티");

			//Party party = partyService.getParty(Integer.parseInt(partyNo));
			//ticket = ticketService.getTicket(party.getPartyNo(), "2");

			//modelAndView.addObject("party", party);
			Party party = partyService.getParty(Integer.parseInt(partyNo),"1");
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
		path += "\\resources\\image\\QRCodeImage";
		purchase.setTicket(ticket);
		purchase.setUser((User)session.getAttribute("user"));
		purchase = purchaseService.addPurchase(purchase, path);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("redirect:/purchase/getPurchase?purchaseNo="+purchase.getPurchaseNo());

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
		//modelAndView.setViewName("/view/purchase/getPurchase.jsp");
		modelAndView.setViewName("/view/purchase/getPurchaseTest.jsp");
		return modelAndView;

	}
	
	@RequestMapping(value = "getPurchaseList")
	public ModelAndView getPurchaseList(HttpSession session,
																	@ModelAttribute("search") Search search,
																	@RequestParam(value = "purchaseFlag", required = false) String purchaseFlag) {

		User user = (User) session.getAttribute("user");

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
		modelAndView.addObject("purchaseFlag", purchaseFlag);

		modelAndView.setViewName("/view/purchase/getPurchaseList.jsp");

		return modelAndView;
	}
	
	@RequestMapping(value = "getSaleList")
	public ModelAndView getSaleList(@ModelAttribute("search") Search search) {

		System.out.println(search);
		
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
	
	@RequestMapping(value = "cancelPurchase", method = RequestMethod.GET)
	public ModelAndView cancelPurchase(HttpSession session, RedirectAttributes redirectAttributes) {
		
		System.out.println("cancel GET");
		User user = (User) session.getAttribute("user");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/getPurchaseList");

		return modelAndView;
	}
	
	@RequestMapping(value = "cancelPurchase", method = RequestMethod.POST)
	public ModelAndView cancelPurchase(HttpSession session,
																		@ModelAttribute("purchase") Purchase purchase) throws Exception {
		System.out.println("cancel POST");
		User user = (User) session.getAttribute("user");
		purchase = purchaseService.getPurchase(purchase.getPurchaseNo());
		purchase.setTranCode("2");
		purchaseService.cancelPurchase(purchase);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/getPurchaseList");

		return modelAndView;
	}
	
	@RequestMapping(value = "deletePurchase", method=RequestMethod.POST)
	public ModelAndView deletePurchase(HttpSession session,
																	@RequestParam("purchaseNo") int purchaseNo,
																	RedirectAttributes redirectAttributes) {
		
		int result = purchaseService.deletePurchase(purchaseNo);
		if(result == 1) {
		
			System.out.println("deletePurchase");
			User user = (User) session.getAttribute("user");
			ModelAndView modelAndView = new ModelAndView();
			//modelAndView.setViewName("redirect:/purchase/getPurchaseList");
			
			modelAndView.setViewName("/view/purchase/deletePurchase.jsp");
			return modelAndView;

		} else {
			return null;
		}
		
	}

	////////////////////////////////////////////////////////////////KakaoPay///////////////////////////////////////////////////////////////////////////
	
	@RequestMapping(value = "approvePayment")
	public ModelAndView approvePayment(HttpSession session,
																		 @RequestParam(value="pg_token", required=false) String pgToken,
																		 @RequestParam(value="purchaseNo", required=false) String purchaseNo) throws Exception {

		System.out.println(pgToken);
		
		Purchase purchase = null;
		if(pgToken != null) { //kakaoPay
			
			String path = session.getServletContext().getRealPath("/");
			path += "\\resources\\image\\QRCodeImage";
			System.out.println(path);
			purchase = purchaseService.approvePayment(pgToken, path);

		} else {
			purchase = purchaseService.getPurchase(Integer.parseInt(purchaseNo));
		}
		
		//kakaoPay, iamport(phone결제)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/view/purchase/approvePayment.jsp");
		
		return modelAndView;

	}

	@RequestMapping(value = "cancelPayment")
	public ModelAndView cancelPayment() throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/view/purchase/cancelPayment.jsp");

		return modelAndView;
	}
	
	
	////////////////////////////////////////////////////////////////KFTC 계좌이체///////////////////////////////////////////////////////////////////////////
	/*@RequestMapping(value = "readyTransfer", method = RequestMethod.GET) 
	public ModelAndView readyTransfer(@RequestParam("token") String token) {
		
		//String path = session.getServletContext().getRealPath("/");
		Purchase purchase = new Purchase();
		Bank bank = purchaseService.readyTransfer(purchase);
		Map<String, Object> map = new HashMap<String, Object>();
		//.setUser((User)session.getAttribute("user"));
		map.put("purchase", purchase);
		map.put("bank", bank);
		//map.put("path", path);
		map.put("token", "token");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/view/purchase/transferMoney.jsp");

		return modelAndView;
		
	}*/
	
	
	@RequestMapping(value = "readyTransfer", method = RequestMethod.POST) 
	public ModelAndView readyTransfer(HttpSession session,
																	@ModelAttribute Purchase purchase) {
		
		String path = session.getServletContext().getRealPath("/");
		purchase = purchaseService.readyTransfer(purchase);
		Map<String, Object> map = new HashMap<String, Object>();
		purchase.setUser((User)session.getAttribute("user"));
		map.put("purchase", purchase);
		//map.put("bank", bank);
		map.put("path", path);
		map.put("token", "token");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		//modelAndView.addObject("bank", bank);
		modelAndView.setViewName("/view/purchase/transferMoney.jsp");

		return modelAndView;
		
	}
	
	@RequestMapping(value = "getTransferResult", method = RequestMethod.POST) 
	public ModelAndView getTransferResult(HttpSession session,
																	@ModelAttribute Purchase purchase) {
		
		String path = session.getServletContext().getRealPath("/");
		//Bank bank = purchaseService.readyTransfer(purchase);
		purchase.setUser((User)session.getAttribute("user"));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		//modelAndView.addObject("bank", bank);
		modelAndView.setViewName("/view/purchase/getTransferResult.jsp");

		return modelAndView;
		
	}
	
}
