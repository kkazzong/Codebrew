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

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	@Qualifier("purchaseDAOImpl")
	private PurchaseDAO purchaseDAO;
	
	public PurchaseServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

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
