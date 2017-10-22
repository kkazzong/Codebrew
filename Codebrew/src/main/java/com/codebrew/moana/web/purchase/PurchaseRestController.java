package com.codebrew.moana.web.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.domain.User;
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
	
	@Value("#{commonProperties['pageSize']}")
	private int pageSize;
	
	@Value("#{commonProperties['pageUnit']}")
	private int pageUnit;
	
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping("/json/addPurchase/{purchaseFlag}/{referNo}")
	public Purchase addPurchase(@PathVariable("purchaseFlag") String purchaseFlag,
													  @PathVariable("referNo") int referNo) {
		
		switch(purchaseFlag) {
			case "1" :
		}
		return null;
	}
	
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
	
	@RequestMapping("/json/getSaleList")
	public List<Purchase> getSaleList(@RequestBody Search search) {
		
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		return (List<Purchase>)map.get("list");
	}
}
