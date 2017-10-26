package com.codebrew.moana.service.purchase.impl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Bank;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.purchase.PurchaseDAO;
import com.codebrew.moana.service.purchase.PurchaseService;
import com.codebrew.moana.service.ticket.TicketDAO;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	//Field
	@Autowired
	@Qualifier("purchaseDAOImpl")
	private PurchaseDAO purchaseDAO;
	
	@Autowired
	@Qualifier("kakaoAPIDAOImpl")
	private PurchaseDAO kakaoDAO;
	
	@Autowired
	@Qualifier("iamportAPIDAOImpl")
	private PurchaseDAO impDAO;
	
	@Autowired
	@Qualifier("kftcAPIDAOImpl")
	private PurchaseDAO kftcDAO;
	
	
	//Constructor
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}

	//Mehtod
	@Override
	public Purchase readyPayment(Purchase purchase) {
		return kakaoDAO.readyPayment(purchase);
	}

	@Override
	public Purchase approvePayment(String pgToken, String path) throws Exception {
		Purchase purchase = kakaoDAO.approvePayment(pgToken);
		return this.addPurchase(purchase, path);
	}
	
	@Override
	public int cancelPayment(int purchaseNo) {
		Purchase purchase = purchaseDAO.getPurchase(purchaseNo);
		//int result = purchaseDAO.cancelPayment(purchase);
		int result = kakaoDAO.cancelPayment(purchase);
		if(result == 1) {
			return 1;
		} else {
			return 0;
		}
	}
	
	@Override
	public Purchase approvePayment(Map<String, Object> map) throws Exception {
		Purchase purchase = impDAO.approvePayment((Purchase)map.get("purchase"), map.get("token").toString());
		return this.addPurchase(purchase, map.get("path").toString());
	}
	
	@Override
	public Bank readyTransfer(Purchase purchase) {
		return kftcDAO.readyTransfer(purchase);
	}

	@Override
	public Bank transferMoney(Map<String, Object> map) {
		Purchase purchase = (Purchase)map.get("purchase");
		//String token = kftcDAO.readyTransfer(purchase);
		Bank bank = (Bank)map.get("bank");
		//bank.setToken(token);
		return null;
	}

	@Override
	public Map<String, Object> getTransferResult(Map<String, Object> map) {
		return null;
	}
	
	@Override
	public Purchase addPurchase(Purchase purchase, String path) throws Exception{
		int result = purchaseDAO.addPurchase(purchase, path);
		if(result == 1) {
			return purchaseDAO.getPurchase(purchase.getPurchaseNo());
		} else {
			return null;
		}
	}
	
	@Override
	public Map<String, Object> getPurchaseList(String userId, String purchaseFlag, Search search) {
		System.out.println(search);
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
	public int cancelPurchase(Purchase purchase) throws Exception {
		return purchaseDAO.updatePurchaseTranCode(purchase);
	}

	@Override
	public int deletePurchase(int purchaseNo) {
		return purchaseDAO.deletePurchase(purchaseNo);
	}
	
	//getter, setter
	public void setPurchaseDAO(PurchaseDAO purchaseDAO) {
		this.purchaseDAO = purchaseDAO;
	}

}
