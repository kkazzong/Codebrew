package com.codebrew.moana.web.purchase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
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
	public Purchase readyPayment(@RequestBody Purchase purchase, @PathVariable int ticketNo) {
		
		System.out.println(ticketNo);
		System.out.println(purchase);
		
		Ticket ticket = null;
		switch(purchase.getPurchaseFlag()) {
			case "1" : //축제티켓
				Festival festival = new Festival();
				festival.setFestivalNo(2510101);
				festival.setFestivalName("예술로 산책로 2017");
				festival.setAddr("서울특별시 종로구 효자로13길 45");
				festival.setStartDate("20170930");
				festival.setEndDate("20171118");
				festival.setFestivalImage("http://tong.visitkorea.or.kr/cms/resource/97/2510097_image2_1.jpg");
				festival.setTicketCount(30);
				festival.setTicketPrice(1000);
				
				ticket = ticketService.getTicketByTicketNo(ticketNo);
				//festival = festivalService.getFestival(festival.getFestivalNo());
				//purchase.setFestival(festival);
				purchase.setTicket(ticket);
				purchase.setItemName(ticket.getFestival().getFestivalName());
				break;
			case "2" : //파티티켓
				Party party = new Party();
				party.setPartyNo(ticketNo);
				party.setPartyName("����������Ƽ");
				party.setPartyImage("http://tong.visitkorea.or.kr/cms/resource/18/1999118_image2_1.jpg");
				party.setPartyPlace("�����κ��� ����");
				party.setTicketCount(35);
				party.setTicketPrice(50000);
				
				ticket = ticketService.getTicketByTicketNo(ticketNo);
				//party = partyService.getParty(party.getPartyNo());
				//purchase.setParty(party);
				purchase.setTicket(ticket);
				purchase.setItemName(ticket.getParty().getPartyName());
				break;
		}
		
		User user = new User();
		//user.setUserId("lgj1522@gmail.com");
		//user.setNickname("�����");
		
		purchase.setUser(user);
		return purchaseService.readyPayment(purchase);
	}
	
	@RequestMapping("json/cancelPayment/{purchaseNo}")
	public void cancelPayment(@PathVariable("purchaseNo") int purchaseNo) {
		purchaseService.cancelPayment(purchaseNo);
	}
}
