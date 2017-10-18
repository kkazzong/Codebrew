package com.codebrew.moana.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.purchase.PurchaseDAO;
import com.codebrew.moana.service.purchase.PurchaseService;
import com.codebrew.moana.service.ticket.TicketDAO;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	//Field
	@Autowired
	@Qualifier("purchaseDAOImpl")
	private PurchaseDAO purchaseDAO;
	
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
	public Purchase approvePayment(String pgToken, String path) {
		Purchase purchase = purchaseDAO.approvePayment(pgToken);
		return this.addPurchase(purchase, path);
	}

	@Override
	public Purchase addPurchase(Purchase purchase, String path) {
		int result = purchaseDAO.addPurchase(purchase, path);
		if(result == 1) {
			return purchaseDAO.getPurchase(purchase.getPurchaseNo());
		} else {
			return null;
		}
	}
	
	@Override
	public Map<String, Object> getPurchaseList(String userId, String purchaseFlag, Search search) {
		List<Purchase> list = purchaseDAO.getPurchaseList(userId, purchaseFlag, search);
		int totalCount = purchaseDAO.getTotalCount(userId, search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		return map;
	}
	
	@Override
	public Map<String, Object> getSaleList(Search search) {
		List<Purchase> list = purchaseDAO.getSaleList(search);
		int totalCount = purchaseDAO.getTotalCount(null, search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		return map;
	}
	
	@Override
	public Purchase getPurchase(int purchaseNo) {
		return purchaseDAO.getPurchase(purchaseNo);
	}
	
	@Override
	public int cancelPayment(int purchaseNo) {
		Purchase purchase = purchaseDAO.getPurchase(purchaseNo);
		int result = purchaseDAO.cancelPayment(purchase);
		if(result == 1) {
			return 1;
		} else {
			return 0;
		}
	}

	//getter, setter
	public void setPurchaseDAO(PurchaseDAO purchaseDAO) {
		this.purchaseDAO = purchaseDAO;
	}
}
