package com.codebrew.moana.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.purchase.PurchaseDAO;
import com.codebrew.moana.service.purchase.PurchaseService;
import com.codebrew.moana.service.ticket.TicketDAO;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	//Field
	@Autowired
	@Qualifier("purchaseDAOImpl")
	private PurchaseDAO purchaseDAO;
	
	@Autowired
	@Qualifier("ticketDAOImpl")
	private TicketDAO ticketDAO;
	
	//Constructor
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}

	//Mehtod
	@Override
	public Purchase readyPayment(Purchase purchase) {
		return purchaseDAO.readyPayment(purchase);
	}

	@Override
	public Purchase approvePayment(String pgToken) {
		return purchaseDAO.approvePayment(pgToken);
	}

	@Override
	public Purchase addPurchase(Purchase purchase) {
		
		//원래 티켓 수량
		int originTicketCount = purchase.getTicket().getTicketCount();
		
		//구매할 티켓 수량
		int purchaseTicketCount = purchase.getPurchaseCount();
		
		//원래수량 - 구매수량 으로 티켓수량 업데이트
		purchase.getTicket().setTicketCount(originTicketCount - purchaseTicketCount);
		ticketDAO.updateTicketCount(purchase.getTicket());
		
		//구매테이블 insert
		int result = purchaseDAO.addPurchase(purchase);
		if(result == 1) {
			return purchaseDAO.getPurchase(purchase.getPurchaseNo());
		} else {
			return null;
		}
	}
	
	@Override
	public Map<String, Object> getPurchaseList(String userId, String purchaseFlag) {
		List<Purchase> list = purchaseDAO.getPurchaseList(userId, purchaseFlag);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	
	@Override
	public Map<String, Object> getSaleList() {
		List<Purchase> list = purchaseDAO.getSaleList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	
	@Override
	public Purchase getPurchase(int purchaseNo) {
		return purchaseDAO.getPurchase(purchaseNo);
	}
	
	@Override
	public void cancelPayment(int purchaseNo) {
		Purchase purchase = purchaseDAO.getPurchase(purchaseNo);
		purchaseDAO.cancelPayment(purchase);
	}

	//getter, setter
	public void setPurchaseDAO(PurchaseDAO purchaseDAO) {
		this.purchaseDAO = purchaseDAO;
	}
}
