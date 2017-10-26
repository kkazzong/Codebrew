package com.codebrew.moana.web.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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

@RestController
@RequestMapping("/purchaseRest/*")
public class PurchaseRestController {

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
	
	@Value("#{commonProperties['pageSize']}")
	private int pageSize;
	
	@Value("#{commonProperties['pageUnit']}")
	private int pageUnit;
	
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping("/json/addPurchase/{purchaseFlag}/{referNo}")
	public Purchase addPurchase(@PathVariable("purchaseFlag") String purchaseFlag,
													  @PathVariable("referNo") int referNo) throws Exception {
		
		Ticket ticket = null;
		switch(purchaseFlag) {
			case "1" : //축제티켓
				Festival festival = festivalService.getFestivalDB(referNo);
				ticket = ticketService.getTicket(festival.getFestivalNo(), purchaseFlag);
				break;
			case "2" : //파티티켓
				Party party = partyService.getParty(referNo, "1"); //아모르파티
				ticket = ticketService.getTicket(party.getPartyNo(), purchaseFlag);
				break;
		}
		Purchase purchase = new Purchase();
		purchase.setTicket(ticket);
		return purchase;
	}
	
	@RequestMapping("/json/addPurchase")
	public Purchase addPurchase(HttpSession session,
														@RequestBody Purchase purchase) throws Exception {
		
		Ticket ticket = ticketService.getTicketByTicketNo(purchase.getTicket().getTicketNo());

		if (ticket.getFestival() != null) {
			purchase.setItemName(ticket.getFestival().getFestivalName());
		} else if (ticket.getParty() != null) {
			purchase.setItemName(ticket.getParty().getPartyName());
		}
		
		String path = session.getServletContext().getRealPath("/");
		purchase.setTicket(ticket);
		//purchase.setUser((User)session.getAttribute("user"));
		purchase = purchaseService.addPurchase(purchase, path);
		
		return purchase;
		
	}
	
	@RequestMapping("/json/getPurchase/{purchaseNo}")
	public Purchase getPurchase(@PathVariable("purchaseNo") int purchaseNo) {
		Purchase purchase = purchaseService.getPurchase(purchaseNo);
		Ticket ticket = ticketService.getTicketByTicketNo(purchase.getTicket().getTicketNo());
		purchase.setTicket(ticket);
		return purchase;
	}
	
	@RequestMapping(value="/json/getPurchaseList/{userId}/{purchaseFlag}", method=RequestMethod.POST)
	public List<Purchase> getPurchaseList(@PathVariable(value="purchaseFlag") String purchaseFlag, 
																		@PathVariable(value="userId") String userId,
																		@RequestBody Search search) {
		System.out.println("getPurchaseLis REST");
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		Map<String, Object> map = purchaseService.getPurchaseList(userId, purchaseFlag, search);
		return (List<Purchase>)map.get("list");
	}
	
	@RequestMapping(value="/json/getPurchaseList/{userId}/{purchaseFlag}", method=RequestMethod.GET)
	public List<Purchase> getPurchaseList(@PathVariable(value="purchaseFlag") String purchaseFlag, 
																		@PathVariable(value="userId") String userId) {
		System.out.println("getPurchaseLis REST");
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		Map<String, Object> map = purchaseService.getPurchaseList(userId, purchaseFlag, search);
		return (List<Purchase>)map.get("list");
	}
	
	@RequestMapping(value="/json/getSaleList", method=RequestMethod.POST)
	public List<Purchase> getSaleList(@RequestBody Search search) {
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		return (List<Purchase>)map.get("list");
	}
	
	@RequestMapping(value="/json/getSaleList", method=RequestMethod.GET)
	public List<Purchase> getSaleList() {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		return (List<Purchase>)map.get("list");
	}
	
	@RequestMapping(value="/json/cancelPurchase", method=RequestMethod.POST)
	public Map cancelPurchase(@RequestBody Purchase purchase) throws Exception {
		purchase = purchaseService.getPurchase(purchase.getPurchaseNo());
		purchase.setTranCode("2");
		int result = purchaseService.cancelPurchase(purchase);
		if(result == 1) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("message", "성공적으로 삭제되었습니다.");
			map.put("redirect", "/purchase/getPurchaseList");
			return map;
		} else {
			return null;
		}
	}
	
	@RequestMapping("json/deletePurchase/{purchaseNo}")
	public Map<String, String> deletePurchase(@PathVariable("purchaseNo") int purchaseNo) {
		int result = purchaseService.deletePurchase(purchaseNo);
		if(result == 1) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("message", "성공적으로 삭제되었습니다.");
			return map;
		} else {
			return null;
		}
	}
	
	//////////////////////////////////////////////////////KakaoPay///////////////////////////////////////////////////////////////
	
	@RequestMapping("/json/readyPayment/{ticketNo}")
	public Purchase readyPayment(HttpSession session,
														@RequestBody Purchase purchase,
														@PathVariable("ticketNo") int ticketNo) {
		
		System.out.println(ticketNo);
		System.out.println(purchase);
		
		Ticket ticket = ticketService.getTicketByTicketNo(ticketNo);
		purchase.setTicket(ticket);
		purchase.setUser((User)session.getAttribute("user"));

		switch(purchase.getPurchaseFlag()) {
			case "1" : //축제티켓
				purchase.setItemName(ticket.getFestival().getFestivalName());
				break;
			case "2" : //파티티켓
				purchase.setItemName(ticket.getParty().getPartyName());
				break;
		}
		
		return purchaseService.readyPayment(purchase);
	}
	
	@RequestMapping("json/cancelPayment/{purchaseNo}")
	public void cancelPayment(@PathVariable("purchaseNo") int purchaseNo) {
		purchaseService.cancelPayment(purchaseNo);
	}
	
	//////////////////////////////////////////////////////iamport///////////////////////////////////////////////////////////////
	
	@RequestMapping(value="/json/iamport/approvePayment", method=RequestMethod.POST)
	public Purchase approvePayment(HttpSession session,
																@RequestBody Purchase purchase) throws Exception {
		String path = session.getServletContext().getRealPath("/");
		Map<String, Object> map = new HashMap<String, Object>();
		purchase.setUser((User)session.getAttribute("user"));
		map.put("purchase", purchase);
		map.put("path", path);
		map.put("token", "token");
		return purchaseService.approvePayment(map);
		
	}
	
	//////////////////////////////////////////////////////KFTC 계좌이체///////////////////////////////////////////////////////////////
	
	@RequestMapping(value="/json/transfer/readyTransfer", method=RequestMethod.POST)
	public Map readyTransfer(HttpSession session,
															@RequestBody Purchase purchase) throws Exception {
		
		String path = session.getServletContext().getRealPath("/");
		purchase = purchaseService.readyTransfer(purchase);
		Map<String, Object> map = new HashMap<String, Object>();
		purchase.setUser((User)session.getAttribute("user"));
		map.put("purchase", purchase);
		//map.put("bank", bank);
		map.put("path", path);
		map.put("token", "token");
		return map;
		
	}
	
	@RequestMapping(value="/json/transfer/transferMoney", method=RequestMethod.POST)
	public Map transferMoney(HttpSession session,
													@RequestBody Purchase purchase) throws Exception {
		
		String path = session.getServletContext().getRealPath("/");
		//Bank bank = purchaseService.readyTransfer(purchase);
		Map<String, Object> map = new HashMap<String, Object>();
		purchase.setUser((User)session.getAttribute("user"));
		Bank bank = new Bank();
		bank.setBankName(purchase.getAid());
		bank.setBankAccount(purchase.getCid());
		bank.setUserName(purchase.getTid());
		bank.setUserAccount(purchase.getPartnetOrderId());
		bank.setUserBankName(purchase.getPartnerUserId());
		bank.setToken(purchase.getToken());
		map.put("purchase", purchase);
		map.put("bank", bank);
		map.put("path", path);
		map.put("token", "token");
		purchase = purchaseService.transferMoney(map);
		map.put("bank", bank);
		return map;
		
	}
	
	@RequestMapping(value="/json/transfer/getTransferResult", method=RequestMethod.POST)
	public Map getTransferResult(HttpSession session,
													@RequestBody Purchase purchase) throws Exception {
		
		String path = session.getServletContext().getRealPath("/");
		//Bank bank = purchaseService.readyTransfer(purchase);
		Map<String, Object> map = new HashMap<String, Object>();
		purchase.setUser((User)session.getAttribute("user"));
		Bank bank = new Bank();
		bank.setBankName(purchase.getAid());
		bank.setBankAccount(purchase.getCid());
		bank.setUserName(purchase.getTid());
		bank.setUserAccount(purchase.getPartnetOrderId());
		bank.setUserBankName(purchase.getPartnerUserId());
		bank.setToken(purchase.getToken());
		map.put("purchase", purchase);
		map.put("bank", bank);
		map.put("path", path);
		map.put("token", "token");
		//bank = purchaseService.transferMoney(map);
		map = purchaseService.getTransferResult(map);
		
		return map;
		
	}
	
}
